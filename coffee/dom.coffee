
find = (query) -> document.querySelector query
{EventEmitter} = require "eventemitter"

delay = (t, f) -> setTimeout f, t

exports.rain = rain = new EventEmitter()

elem = find "#paste"
paper = find "#paper"

paper.onclick = (event) ->
  elem = event.target
  if elem.className = "line"
    next = elem.nextElementSibling
    # console.log next.childElementCount
    style = next.style
    if style.display is "none"
      elem.style.background = "hsla(240,80%,90%,0)"
      style.display = "block"
    else if next.childElementCount > 0
      elem.style.background = "hsl(240,80%,90%)"
      style.display = "none"

elem.addEventListener "paste", ->
  delay 0, ->
    rain.emit "paste", elem.value

rain.on "render", (html) ->
  paper.innerHTML = html