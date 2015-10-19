# npm i -save require-cson@latest tempgulp4@latest gulp-util@latest gulp-coffee@latest gulp-sourcemaps@latest gulp-git@latest gulp-debug@latest gulp-size@latest gulp-rename@latest gulp-uglify@latest gulp-concat@latest gulp-gzip@latest del@latest gulp-changed@latest gulp-cached@latest gulp-remember@latest gulp-newer@latest gulp-duration@latest gulp-if@latest gulp-foreach@latest merge-stream@latest vinyl-source-stream@latest vinyl-buffer@latest

# Gulp 4+
global.gulp = module.exports = require 'tempgulp4'
for key, value of gulp when typeof value is 'function'
  gulp[key] = value.bind gulp

# Coffeescript and Sourcemaps:
global.CSON = require 'require-cson'
gulp.sourcemaps = require 'gulp-sourcemaps'
gulp.coffee = require 'gulp-coffee'
gulp.uglify = require 'gulp-uglify'

# File Manipulation:
gulp.rename = require 'gulp-rename'
gulp.concat = require 'gulp-concat'
gulp.gzip = require 'gulp-gzip'
gulp.delete = gulp.del = require 'del'
gulp.git = require 'gulp-git'

# Incrimental Builds:
gulp.changed = require 'gulp-changed'
gulp.cached = require 'gulp-cached'
gulp.remember = require 'gulp-remember'
gulp.newer = require 'gulp-newer'

# Stream Flow Control:
# Gulp4 already comes with gulp.series and gulp.parallel
gulp.if = gulp.upon = require 'gulp-if'
gulp.foreach = require 'gulp-foreach'
gulp.merge = require 'merge-stream'
gulp.combine = require 'multipipe'
gulp.source = require 'vinyl-source-stream'
gulp.buffer = require 'vinyl-buffer'

# Utility and Logging:
gulp.logger = require 'glogg'
gulp.log = gulp.logger('gulp').info
gulp.colors = require 'chalk'
gulp.debug = require 'gulp-debug'
gulp.size = require 'gulp-size'
gulp.duration = require 'gulp-duration'

# Intigrate Task Runner:
global.task = require './task.coffee'
