## Introduction

This is a [hexo](https://github.com/tommy351/hexo)
tag plugin which allows you to use vim syntax highlight to highlight code inside markdown.

Hexo is a static blogging system written in Node.js, it uses [highlight.js](http://softwaremaniacs.org/soft/highlight/en/)
by default to render code.
But lots of languages are not supported by highlight.js (but always supported by vim with proper plugins).
In that case, you can use this instead.

## Installation

You need to have vim properly installed and configured, since this program will directly call vim.

To install, run the following command in the root directory of hexo:
```
npm install hexo-tag-vimhighlight --save
```

And add this plugin in your ``_config.yml``.

## Usage

Specify the code filetype, and whether to use line number in your markdown source file, in
the common format of tag plugins:

	{% vimhl vim true %}
	if ! has("gui_running")                " fix alt key under terminal
		for i in range(48, 57) + range(65, 90) + range(97, 122)
			exec "set <A-" . nr2char(i) . ">=" . nr2char(i)
		endfor
	endif
	{% endvimhl %}

By default, line number will not be displayed, you can use ``{% vimhl vim %}`` for short.

This program will run vim to highlight the code, therefore the generating of pages
will probably take much longer time. (It seems that hexo doesn't support parallel rendering.)
