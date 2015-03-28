gulp         = require 'gulp'
gutil        = require 'gulp-util'
gulpif       = require 'gulp-if'
sass         = require 'gulp-ruby-sass'
coffee       = require 'gulp-coffee'
concat       = require 'gulp-concat'
sourcemaps   = require 'gulp-sourcemaps'
autoprefixer = require 'gulp-autoprefixer'

gulp.task 'templates', ->
  gulp.src('src/index.html')
    .pipe(gulp.dest('release'))

gulp.task 'css', ->
  sass('src/css', { sourcemap: true })
    .on('error', gutil.log)
    .pipe(autoprefixer(
      browsers: ['last 2 versions']
      cascade: false
    ))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('release/css'))

gulp.task 'js', ->
  gulp.src(['src/js/vendor/**', 'src/js/**'])
    .pipe(sourcemaps.init())
    .pipe(gulpif(/.+\.coffee$/, coffee().on('error', gutil.log)))
    .pipe(concat('application.js'))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('release/js'))

gulp.task 'images', ->
  gulp.src('src/images/**')
    .pipe(gulp.dest('release/images'))

gulp.task 'video', ->
  gulp.src('src/video/**')
    .pipe(gulp.dest('release/video'))

gulp.task 'watch', ->
  gulp.watch 'src/index.html', ['templates']
  gulp.watch 'src/css/**', ['css']
  gulp.watch 'src/js/**', ['js']
  gulp.watch 'src/images/**', ['images']
  gulp.watch 'src/video/**', ['video']

gulp.task 'default', ['css', 'js', 'templates', 'images', 'video']
