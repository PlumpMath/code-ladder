
detect = require "./detect"

get_indent = (line) ->
  match = line.match /^(\s*)/
  match[0].length

escapeHTML = (string) ->
  string
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")

make_list = (code) ->
  code.split("\n")
    .map((line) -> line.trimRight())
    .filter((line) -> line.length > 0)
    .map(escapeHTML)

make_tree = (lines) ->
  tree = {}

  last = undefined

  lines.forEach (line) ->
    n = get_indent line
    indent = undefined
    # console.log "has", n, "####{line}####"
    if n is 0
      if Array.isArray tree[last]
        tree[last] = make_tree tree[last]
      last = line
      tree[last] = []
      indent = undefined
    else
      unless indent? then indent = n
      tree[last].push line[2..]

  if Array.isArray tree[last]
    tree[last] = make_tree tree[last]

  tree

make_html = (tree) ->
  html = ""
  add = (string) -> html += string

  for key, value of tree
    add "<div class='unit'>"
    add "<div class='line'>"
    add key
    add "</div>"
    add "<div class='block'>"
    add make_html value
    add "</div>"
    add "</div>"

  html

exports.convert = (code) ->
  make_html make_tree make_list code