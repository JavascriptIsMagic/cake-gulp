# cake-gulp
Stuff your face with all those wonderful [Gulp](https://www.npmjs.com/package/tempgulp4) plugins from your Cakefile!

# WARNING: This is a preview release. This branch uses [`tempgulp4`](https://www.npmjs.com/package/tempgulp4) as Gulp 4 has not yet officially released at the time of this writing.

`cake-gulp` integrates `cake`'s descriptive build task system and commandline argument parsing into gulp tasks, allowing for clean descriptive task management.

`cake-gulp` also includes some common gulp plugins that relate directly to coffeescript, file management, or vynil/stream management but do not directly impose any framework or specific build paradigm on you. These plugins are useful for general filesystem manipulation, flow control of streams, information and logging, or incremental builds. These plugins where chosen because of their general usefulness in just about any build process regardless of what you are doing, things that are used so often they are practically a part of Gulp.

# Example:
![Image of the below example Cakefile](http://i.imgur.com/89ITshK.png)
```coffeescript
# This Cakefile incrementally transpiles .coffee files
#  to one combined minified javascript file with sourcemaps
# `npm install -save-dev cake-gulp`
# `cake build`
# `cake -w build` for watching incremental builds

pack = require './package.json'
gulp = require 'cake-gulp'
distDirectory = "#{__dirname}/dist"

task 'build:clean', 'Cleans all generated or temporary files.', ->
  gulp.delete distDirectory

coffeeSources = ["#{__dirname}/src/**/*.coffee"]
task 'build:coffee', 'Transpiles .coffee → .js with sourcemaps', ->
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
    .pipe gulp.dest distDirectory
    .pipe gulp.gzip()
    .pipe gulp.dest distDirectory

option '-w', '--watch', 'Watch for file changes for build tasks.'
task 'build', 'Build all the things! -w to watch for changes.',
  gulp.series 'build:clean', 'build:coffee', (callback) ->
    # `gulp.options` is from cake's option parsing of commandline options
    if gulp.options.watch
      gulp.log "#{gulp.colors.cyan 'watching'} #{coffeeSources}"
      gulp.watch coffeeSources, gulp.series 'build:coffee'
    callback()
```

# Globals from [cake](http://coffeescript.org/#cake)
* `task("name", "description", (callback) -> )`
  `task` has been modified to accept both a string `name` and a string `description`,
    but other then adding the description, task is no different from [undertaker task](https://www.npmjs.com/package/undertaker#task-taskname-fn-function) which is what Gulp4 uses for it's task manager. [`async-done`](https://github.com/phated/async-done#completion-and-error-resolution) is used for the callback function, and it is also fairly common to pass [`gulp.series`](https://www.npmjs.com/package/undertaker#series-taskname-fn-function) or [`gulp.parallel`](https://www.npmjs.com/package/undertaker#parallel-taskname-fn-function) in instead of a `(callback) ->` function to execute tasks in a series, or at the same time. cake's `options` object that would usually get passed in is now `global.options` or `gulp.options` and is only available inside a task function.
* `invoke(name)` runs a single task (by name string only) currently. This only invokes `cake` tasks and currently will not work if you use `gulp.task`
* `option("-a", "--argument [ARG]", "description")` is useful for commandline parsing and is cake's `option` function.
* `global.options` or `gulp.options` is where you access your commandline arguments. Because Gulp/Undertaker does not handle commandline options, these are not passed in to task functions like in cake. Keep in mind that `options` is still only available after a task function is invoked.

# Gulp Plugins and Utilities
`cake-gulp` comes with some common generic gulp plugins that should be useful in just about any build process. All gulp plugins are bound to the `gulp` object.

# Coffeescript and Sourcemaps
* [`CSON`](https://www.npmjs.com/package/cson) is a global like `JSON` but for Coffeescript. You may also wish to use `require("./something.cson")`
* [gulp.sourcemaps](https://www.npmjs.com/package/gulp-sourcemaps) you may wish to [check out this wiki for compatable sourcemap gulp plugins!](https://github.com/floridoo/gulp-sourcemaps/wiki/Plugins-with-gulp-sourcemaps-support)
* [gulp.coffee](https://www.npmjs.com/package/gulp-coffee)
* [gulp.uglify](https://www.npmjs.com/package/gulp-uglify)

# File Manipulation
* [gulp.rename](https://www.npmjs.com/package/gulp-rename)
* [gulp.concat](https://www.npmjs.com/package/gulp-concat)
* [gulp.gzip](https://www.npmjs.com/package/gulp-gzip)
* [gulp.del or gulp.delete](https://www.npmjs.com/package/del)
* [gulp.git](https://www.npmjs.com/package/gulp-git)

# Incrimental Builds
* [gulp.changed](https://www.npmjs.com/package/gulp-changed)
* [gulp.cached](https://www.npmjs.com/package/gulp-cached)
* [gulp.remember](https://www.npmjs.com/package/gulp-remember)
* [gulp.newer](https://www.npmjs.com/package/gulp-newer)

# Stream Flow Control
* [gulp.series](https://www.npmjs.com/package/undertaker#series-taskname-fn-function)
* [gulp.parallel](https://www.npmjs.com/package/undertaker#parallel-taskname-fn-function)
* [gulp.upon or gulp.if](https://www.npmjs.com/package/gulp-if)
* [gulp.foreach](https://www.npmjs.com/package/gulp-foreach)
* [gulp.merge](https://www.npmjs.com/package/merge-stream)
* [gulp.combine](https://www.npmjs.com/package/multipipe)
* [gulp.source](https://www.npmjs.com/package/vinyl-source-stream)
* [gulp.buffer](https://www.npmjs.com/package/vinyl-buffer)

# Logging
* [gulp.size](https://www.npmjs.com/package/gulp-size)
* [gulp.duration](https://www.npmjs.com/package/gulp-duration)
* [gulp.debug](https://www.npmjs.com/package/gulp-debug)
* [gulp.logger](https://www.npmjs.com/package/glogg)
* [gulp.log](https://www.npmjs.com/package/glogg#logger-info-msg)
* [gulp.colors](https://github.com/chalk/chalk)

# License
[Public Domain (Unlicense)](http://unlicense.org/)


![cake-gulp](http://i.imgur.com/X1JMoPF.png)
