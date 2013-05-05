
{exec} = require "child_process"
delay = (t, f) -> setTimeout f, t

require("calabash").run [
  "pkill -f doodle"
  "jade -o build/ -wP layout/index.jade"
  "stylus -o build/ -w layout/"
  "coffee -o lib/ -wbc coffee/"
  "doodle build/ delay:1000"
]

watcher = require("chokidar").watch "./lib"
watcher.on "change", (path) ->
  console.log path, "::: changed"
  exec "browserify -o build/build.js -d lib/main.js"