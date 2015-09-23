gulp = require 'tempgulp4'

{cyan, green, red, bgRed} = gulp.colors or {}
unless gulp.colors? then cyan = green = red = bgRed = (text) -> text

task = global.task
global.task = module.exports = (name, description, tasks...) ->
  gulp.task name, tasks...
  task name, description, (options) ->
    global.options = gulp.options = options
    invoker = gulp.series name
    invoker (error) -> if error then gulp.log? red "#{name} #{error.message or "#{error}"} \n\n#{error.stack}\n"
