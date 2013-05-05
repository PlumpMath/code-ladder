
use_space = (line) -> line.replace /\t/g, "  "

exports.indent = (code) ->
  code = code.trim()
  indent = 80

  gather_indent = (line) ->
    before = line.length
    after = line.trimLeft().length
    diff = before - after
    if 0 < diff < indent
      indent = diff

  lines = code.split("\n")
    .map(String::trimRight.call)
    .map(use_space)
    .map(gather_indent)

  indent