var gulp = require('gulp');
var sass = require('gulp-sass');
var coffee = require('gulp-coffee');
var gutil = require('gulp-util');


gulp.task('express', function() {
  var express = require('express');
  var app = express();
  app.use(express.static(__dirname));
  app.listen(4000, '0.0.0.0');
});


gulp.task('styles', function() {
    gulp.src('src/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./public/css/'))
});

gulp.task('coffee', function() {
  gulp.src('./src/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./public/'));
});

gulp.task('default', ['express'], function() {
	gulp.watch('src/**/*.scss',['styles']);
	gulp.watch('src/**/*.coffee',['coffee']);
});





