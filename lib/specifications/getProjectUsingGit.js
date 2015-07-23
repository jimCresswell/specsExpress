"use strict";

var git = require("nodegit");
var path = require("path");
var fs = require("q-io/fs"); // https://github.com/kriskowal/q-io

/**
 * Get a copy of the project using Git.
 *
 * @return a PROMISE for the HEAD commit hash of the repo.
 */
module.exports = function getProject(repoUrl, repoName) {

  // TODO get rid of magic knowledge of 'public/feature-files'.
  var localName = path.join(__dirname, "../../public/feature-files", repoName);
  var repository;
  var branchName;

  return fs.exists(localName)
    .then(function(pathExists) {

      // Mac OSX certificate issue http://www.nodegit.org/guides/cloning/
      var copingWithMacCertBug = {
        certificateCheck: function() { return 1; }
      };

      // If there is no matching directory then CLONE the repo.
      if (!pathExists) {
        var cloneOptions = {};
        cloneOptions.remoteCallbacks = copingWithMacCertBug;
        return git.Clone(repoUrl, localName, cloneOptions)
          .then(function(repository) {
            return repository.getHeadCommit();
          });

      // Else the repo probably exists, perform a PULL on it.
      // https://github.com/nodegit/nodegit/issues/341
      // https://github.com/nodegit/nodegit/commit/dc814a45268305e56c99db64efd5d0fe8bbbb8c2
      } else {
        return git.Repository.open(localName)
          .then(function(repo) {
            repository = repo;
            return repository.getCurrentBranch();
          })
          .then(function(branch) {
            branchName = branch.shorthand();
            return repository.fetchAll(copingWithMacCertBug, true);
          })
          .then(function() {
            // Should be a fast-forward merge.
            // Will return the commit hash of merge, hopefully matching remote HEAD.
            return repository.mergeBranches(branchName, "origin/" + branchName);
          });
      }
    });
};