var gulp    = require("gulp"),
    include = require('gulp-include'),
    coffee  = require('gulp-coffee');

gulp.task("default", function(done) {
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
    ], { allowEmpty: true })
    .pipe(coffee())
    .pipe(gulp.dest("lib/"))

    gulp.src([
      'src/config.json',
      'src/pioneerformat.js',
      'src/pioneersummaryformat.js'
    ], { allowEmpty: true })
    .pipe(gulp.dest("lib/"))

    gulp.src([
      'src/scaffold/*.{txt,json,js,coffee}'
    ])
    .pipe(gulp.dest("lib/scaffold"))

    done()
});

gulp.task("watch", function() {
  gulp.watch('src/**/*', ['default'])
});
