###
Very simple basic rule set

Allows
<i>, <em>, <b>, <strong>, <p>, <div>, <a href="http://foo"></a>, <br>, <span>, <ol>, <ul>, <li>

For a proper documentation of the format check advanced.js
###

wysihtml5ParserRules = tags:
  strong: {}
  b: {}
  i: {}
  em: {}
  br: {}
  p: {}
  div: {}
  span: {}
  ul: {}
  ol: {}
  li: {}
  pre: {}
  img:
    check_attributes:
      src: "url"
  a:
    set_attributes:
      target: "_blank"
      rel: "nofollow"

    check_attributes:
      href: "url" # important to avoid XSS


$ ->
  if $("#wysihtml5-textarea").length > 0
    editor = new wysihtml5.Editor("wysihtml5-textarea", # id of textarea element
      toolbar: "wysihtml5-toolbar" # id of toolbar element
      parserRules: wysihtml5ParserRules # defined in parser rules set
    )
