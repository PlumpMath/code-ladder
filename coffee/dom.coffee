
q = (query) -> document.querySelector query
all = (query) -> document.querySelectorAll query
{EventEmitter} = require "eventemitter"

delay = (t, f) -> setTimeout f, t

exports.rain = rain = new EventEmitter()

paste = q "#paste"
paper = q "#paper"

paper.onclick = (event) ->
  elem = event.target
  if elem.className is "line"
    next = elem.nextElementSibling
    # console.log next.childElementCount
    style = next.style
    if style.opacity is "0"
      elem.style.background = "none"
      style.opacity = "1"
    else if next.childElementCount > 0
      elem.style.background = "hsl(240,80%,93%)"
      style.opacity = "0"

q("#fold").onclick = ->
  Array::map.call all(".block"), (elem) ->
    elem.style.opacity = "1"
    elem.previousElementSibling.click()

q("#expand").onclick = ->
  Array::map.call all(".block"), (elem) ->
    elem.style.opacity = "0"
    elem.previousElementSibling.click()

paste.addEventListener "paste", ->
  delay 0, ->
    rain.emit "paste", paste.value

rain.on "render", (html) ->
  paper.innerHTML = html
  Array::map.call all(".block"), (elem) ->
    elem.style.opacity = "1"
    # elem.style.height = "#{elem.offsetHeight}px"