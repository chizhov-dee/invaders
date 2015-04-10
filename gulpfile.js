var gulp = require('gulp');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var sourcemaps = require('gulp-sourcemaps');
var gutil = require('gulp-util');

var paths = {
  scripts: {
    js: ['www/vendors/js/**/*.js', 'www/build/js/**/*.js'],
    coffee: ["www/js/**/*.coffee"]
  }
};

gulp.task('default', function() {
  // place code for your default task here
});

gulp.task('process-coffee', function() {
  return gulp.src(paths.scripts.coffee)
    .pipe(coffee({ bare: false })).on('error', gutil.log)
    .pipe(gulp.dest('www/build/js'));
});

gulp.task('scripts', ['process-coffee'], function() {
  return gulp.src(paths.scripts.js)
    .pipe(sourcemaps.init())
    .pipe(concat('index.js'))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('www/js'));
});

gulp.task('default', ['scripts']);