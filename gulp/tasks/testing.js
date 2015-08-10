// Use the gulp-help plugin which defines a default gulp task
// which lists what tasks are available.
var gulp = require('gulp-help')(require('gulp'));

// Process and file manipulation to capture stdout
// from the Cucumber tests.
var spawn = require('child_process').spawn;
var fs = require('fs');

// Sequential Gulp tasks
var runSequence = require('run-sequence').use(gulp);

var projectPaths = require('../../package.json')['paths'];
var path = require('path');

var cucumber = require('gulp-cucumber');

var jasmine = require('gulp-jasmine');
var jasmineReporters = require('jasmine-reporters');

// Parse any command line arguments ignoring
// Node and the name of the calling script.
var argv = require('minimist')(process.argv.slice(2));

// Extract arguments for the Cucumber tasks.
var tags = argv.tags || false;

// Create the reporters for Jamsine.
var terminalReporter = new jasmineReporters.TerminalReporter({
  color: true,
  verbosity: 3
});
var jUnitXmlReporter = new jasmineReporters.JUnitXmlReporter({
  savePath: path.normalize(projectPaths['test-output-dir']),
  filePrefix: 'unitTests',
  consolidateAll: true
});

function createCucumberOptions(reporter) {
  return {
      support: projectPaths['cucumber-support-js'],
      tags: tags,
      format: reporter || 'summary'
    }
}

// Run all the Cucumber features, doesn't start server
gulp.task('test:cucumber', 'Run Cucumber alone.', function() {
  return gulp.src(projectPaths['feature-files'])
    .pipe(cucumber(createCucumberOptions()));
}, {
  options: {'tags': 'Supports optional tags argument e.g.\n\t\t\t--tags @parsing\n\t\t\t--tags @tag1,orTag2\n\t\t\t--tags @tag1 --tags @andTag2\n\t\t\t--tags @tag1 --tags ~@andNotTag2'}
});

gulp.task('test:cucumber:fileoutput', 'Run Cucumber and capture stdout to file.', function(done) {
    var baseEncoding = 'utf8';
    var fileStream = fs.createWriteStream('cucumber-result.txt', {
        encoding: baseEncoding
    });

    // The command args to run.
    var commandArgs = ['test:cucumber'];

    // Pass through any tags arguments.
    // Can be string or array so use
    // concat to gaurantee array.
    if (tags) {
      tags = [].concat(tags);
      commandArgs = tags.reduce(function(previous, current) {
        return previous.concat(['--tags', current]);
      }, commandArgs);
    }

    var stream = spawn('gulp', commandArgs);

    stream.stdout.setEncoding(baseEncoding);
    stream.stderr.setEncoding(baseEncoding);
    stream.stderr.pipe(fileStream);
    stream.stdout.pipe(fileStream);
    stream.on('close', function(e) {
        fileStream.end();
        done(e);
    });
}, {
  options: {'tags': 'Supports same optional tags arguments as \'test:cucumber\' task.'}
});

// The default Cucumber test run requires server to be running.
gulp.task('test:features', 'Everything necessesary to test the features.', function(done) {
  runSequence('set-envs:test',
              'server:start',
              'test:cucumber',
              'server:stop',
              done);
}, {
  options: {'tags': 'Supports same optional tags arguments as \'test:cucumber\' task.'}
});

// Run the unit tests, report to terminal and disk.
gulp.task('test:unit', 'Run the unit tests.', function () {
    return gulp.src(projectPaths['unit-test-js'])
        .pipe(jasmine({
          reporter: [
            terminalReporter,
            jUnitXmlReporter
          ]
        }));
});
