global.gulp = module.exports = require 'gulp'
global.sourcemaps = require 'gulp-sourcemaps'
global.source = require 'vinyl-source-stream'
global.coffee = require 'gulp-coffee'
global.src = gulp.src.bind gulp
global.dest = gulp.dest.bind gulp
global.watch = gulp.watch.bind gulp
global.rename = require 'gulp-rename'
global.del = require 'del'

utilities = require 'gulp-util'
for own utility of utilities
  global[utility] = utilities[utility]

for own color of colors.styles
  global[color] = colors[color]

task = global.task
global.task = (name, description, tasks...) ->
  action = tasks.pop()
  if Array.isArray tasks[0]
    tasks = tasks[0]
  task name, description, (options) ->
    global.options = options
    gulp.start name
  if action.length > 1
    gulp.task name, tasks, (callback) ->
      action options, callback
  else
    gulp.task name, tasks, ->
      action options

# Pretty your paths for logging
# shortens paths to the closest node module folder
# colors the node module name as well as non-word characters
global.fancypath = (filepath) ->
  "#{filepath}"
    .replace /^.*node_modules[\/\\]+/, ''
    .replace /^([^\\\/]+)|\W+/g, (symbols, module) ->
      if module
        green module
      else
        cyan symbols
