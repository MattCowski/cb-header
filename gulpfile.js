var gulp = require('gulp');
var sass = require('gulp-sass');

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

gulp.task('default', ['express'], function() {
	gulp.watch('src/**/*.scss',['styles']);
});





