var gulp    = require("gulp"),
    include = require('gulp-include'),
    coffee  = require('gulp-coffee');

gulp.task("default", function() {
    gulp.src([
      'src/widgets/build/widgets.coffee',
      'src/support/index.coffee'
    ])
    .pipe(include())
    .pipe(coffee())
    .pipe(gulp.dest("lib/support"))

    gulp.src([
      'src/pioneer.coffee',
      'src/environment.coffee',
      'src/errorformat.coffee',
      'src/custom_formatter.coffee',
      'src/config_builder.coffee',
      'src/scaffold_builder.coffee'
    ])
    .pipe(coffee())
    .pipe(gulp.dest("lib/"))

    gulp.src([
      'src/config.json',
      'src/pioneerformat.js',
      'src/pioneersummaryformat.js'
    ])
    .pipe(gulp.dest("lib/"))

    gulp.src([
      'src/scaffold/simple.txt',
      'src/scaffold/simple.js',
      'src/scaffold/example.json'
    ])
    .pipe(gulp.dest("lib/scaffold"))
});

gulp.task("watch", function() {
  gulp.watch('src/**/*', ['default'])
});
