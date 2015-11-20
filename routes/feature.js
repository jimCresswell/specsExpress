'use strict';
/* eslint new-cap: 0 */

var path = require('path');
var url = require('url');

var express = require('express');
var router = express.Router();

var markdown = require('markdown').markdown;
var getProjectData = require('../lib/specifications/project').getData;
var getFileContents = require('../lib/specifications/project').getFileContents;
var appConfig = require('../lib/configuration').get();

var Gherkin = require('gherkin');
var Parser = new Gherkin.Parser();

/**
 * Given a feature data structure and a scenario id mark a particular scenario as requested.
 * @param  Object feature              Feature data structure.
 * @param  String targetedScenarioId   The id of the targeted scenario (URI encoded scenario name)
 * @return Object                      Modified feature data structure.
 */
function markTargetedFeature(feature, targetedScenarioName) {
  var scenarios = feature.scenarioDefinitions;
  scenarios.forEach(function(scenario) {
    if (scenario.name === targetedScenarioName) {
      scenario.requested = true;
      scenario.defaultOpen = true;
    }
  });

  return feature;
}


// Display an individual feature in a project.
// htpp://host/<project name>/<root/to/file>
router.get(/([^\/]+)\/([\w\W]+)/, function (req, res, next) {
  var projectName = req.params[0];
  var filePath = req.params[1];

  var ref = req.query.ref;
  var commit = req.query.commit;

  // If a specific commit is defined don't try and use the branch.
  if (commit) {
    ref = undefined;
  }

  var projectData = {
    name: projectName,
    localPath: path.join(appConfig.projectsPath, projectName),
    currentBranchName: ref
  };

  // Skip the rendering for query param ?plain=true ?plain=1 etc.
  var renderPlainFile = req.query.plain === 'true' || !!parseInt(req.query.plain);

  // Optional name of a particular scenario.
  var targetedScenarioName = req.query.scenario || false;

  getProjectData(projectData, ref)
  .then(function (projectData) {
    return getFileContents(projectData, filePath);
  })
  .then(function (file) {
    var fileContents = file.content;
    var commitPromises = file.commits;
    var feature = {};
    var isFeatureFile = /.*\.feature/.test(filePath);
    var isMarkdownFile = /.*\.md/.test(filePath);
    var originalUrl;

    return Promise.all(commitPromises.values())
      .then(function (commits) {

        // Map and sort the commit info.
        commits = commits
                  .map(c => ({
                    id: c.sha(),
                    shortId: c.sha().substring(0, 7),
                    time: c.date().getTime(),
                    timeStamp: c.date().toUTCString()
                  }))
                  .sort((a, b) => a.time - b.time);

        if (isFeatureFile && !renderPlainFile) {
          try {
            feature = Parser.parse(fileContents);
          } catch (err) {
            originalUrl = url.parse(req.originalUrl);
            originalUrl.search = originalUrl.search.length ? originalUrl.search + '&plain=true' : '?plain=true';
            feature.plainFileUrl = url.format(originalUrl);
            feature.error = err;
          }

          // Determine if a particular scenario was targeted and mark
          // it so that it can be rendered accordingly.
          if (targetedScenarioName) {
            feature = markTargetedFeature(feature, targetedScenarioName);
          }
          res.render('feature', {feature: feature, commits: commits});

        } else if (isMarkdownFile && !renderPlainFile) {
          res.render('markdown-file', {markdownHtml: markdown.toHTML(fileContents)});
        } else {
          res.render('general-file', {contents: fileContents});
        }
      });
  })
  .catch(function (err) {
    // Pass on to the error handling route.
    if (!err.status && err.code === 'ENOENT') {
      err.status = 404;
    }
    next(err);
  });
});

module.exports = router;
