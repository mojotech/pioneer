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
      'src/dill.coffee',
      'src/environment.coffee'
    ])
    .pipe(coffee())
    .pipe(gulp.dest("lib/"))

});
