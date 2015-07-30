// Use the gulp-help plugin which defines a default gulp task
// which lists what tasks are available.
var gulp = require('gulp-help')(require('gulp'));

// Sequential Gulp tasks
var runSequence = require('run-sequence').use(gulp);

var cucumber = require('gulp-cucumber');

// Parse any command line arguments ignoring
// Node and the name of the calling script.
// Extract tag arguments.
var argv = require('minimist')(process.argv.slice(2));
var tags = argv.tags || false;

// Run all the Cucumber features, doesn't start server
// Hidden from gulp-help.
gulp.task('cucumber', false, function() {
  var options = {
    support: 'features-support/**/*.js',
    // Tags are optional, falsey values are ignored.
    tags: tags
  }
  return gulp.src('features/**/*.feature').pipe(cucumber(options));
});

gulp.task('test:features', 'Test the features', function(done) {
  runSequence('set-envs:test',
              'server:start',
              'cucumber',
              'server:stop',
              done);
});
