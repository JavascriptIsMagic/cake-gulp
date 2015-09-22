# cake-gulp
Stuff your face with all those wonderful Gulp plugins from your Cakefile!

# WARNING: This branch uses `tempgulp4` as Gulp 4 has not yet officially released at the time of this writing.

Gulp plugins that are commonly used that directly relate to coffeescript, file management, and vynil/stream manipulation are included automatically for you. (see list below) The goal with including these plugins is to facilitate better build patterns by including things that are likely to be useful to any build process no matter what you are doing.

# Example:
![Image of the below example Cakefile](http://i.imgur.com/89ITshK.png)
```coffeescript
# This Cakefile incrementally transpiles .coffee files to one combined minified javascript file with sourcemaps
# `npm install -save-dev cake-gulp`
# `cake build`
# `cake -w build` for watching incremental builds

pack = require './package.json'
gulp = require 'cake-gulp'
destDirectory = "#{__dirname}/dest"

task 'build:clean', 'Cleans all generated or temporary files.', ->
  gulp.del destDirectory

coffeeSources = ["#{__dirname}/src/**/*.coffee"]
task 'build:coffee', 'Transpiles .coffee -> .js with sourcemaps', ->
  gulp.src coffeeSources
    .pipe gulp.cached()
    .pipe gulp.size title: 'coffee', showFiles: yes
    .pipe gulp.sourcemaps.init()
      .pipe gulp.coffee()
      .pipe gulp.remember()
      .pipe gulp.concat "#{pack.name}.min.js"
      .pipe gulp.uglify()
    .pipe gulp.sourcemaps.write '.'
    .pipe gulp.size title: 'coffee → javascript', showFiles: yes, gzip: yes
    .pipe gulp.duration 'coffee'
    .pipe gulp.dest destDirectory
    .pipe gulp.gzip()
    .pipe gulp.dest destDirectory

option '-w', '--watch', 'Watch for file changes for build tasks.'
task 'build', 'Build all the things! -w to watch for changes.',
  gulp.series 'build:clean', 'build:coffee', (callback) ->
    # options is a global taken from cake option argv processing
    if options.watch
      gulp.log "#{gulp.colors.cyan 'watching'} ./src/**/*.coffee"
      gulp.watch coffeeSources, gulp.series 'build:coffee'
    callback()

```

Globals from [cake](http://coffeescript.org/#cake)
* task
* invoke
* option
* options

Globals from [gulp](https://github.com/gulpjs/gulp/tree/4.0)
* [gulp](https://www.npmjs.com/package/gulp)
* src
* dest
* watch
* [source](https://www.npmjs.com/package/vinyl-source-stream)
* [sourcemaps](https://www.npmjs.com/package/gulp-sourcemaps)
* [cached](https://www.npmjs.com/package/gulp-cached)
* [coffee](https://www.npmjs.com/package/gulp-coffee)
* [rename](https://www.npmjs.com/package/gulp-rename)
* [debug](https://www.npmjs.com/package/gulp-debug)
* [del](https://www.npmjs.com/package/del)

Globals from [gulp-util](https://www.npmjs.com/package/gulp-util)
* File
* replaceExtension
* colors
* date
* log
* template
* beep
* noop
* isStream
* isBuffer
* isNull
* linefeed
* combine
* PuginError

[Public Domain (Unlicense)](http://unlicense.org/)

![cake-gulp](http://i.imgur.com/X1JMoPF.png)
