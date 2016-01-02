## Introduction

This is a [hexo](https://github.com/tommy351/hexo)
tag plugin which allows you to use vim syntax highlight to highlight code inside markdown.

Hexo is a static blogging system written in Node.js, it uses [highlight.js](http://softwaremaniacs.org/soft/highlight/en/)
by default to render code.
But lots of languages are not supported by highlight.js (but always supported by vim with proper plugins).
In that case, you can use this instead.

See an [example page](http://ppwwyyxx.com/2013/Explode-Tuple-in-C++11/).
Note that the actual appearance depends on how you config your vim.

## Installation

You need to have vim properly installed and configured, since this program will directly run vim.

To install, run the following command in the root directory of hexo:
```
npm install hexo-tag-vimhighlight --save
```

And add this plugin in your ``_config.yml``.

## Usage

Specify the code filetype, and whether to show line number, in
the common format of tag plugins:

	{% vimhl python true %}
	import sys
	sys.stdout.write("Hello World!")
	{% endvimhl %}

By default, line number will not be displayed, you can use ``{% vimhl python %}`` for short.

It runs vim to highlight the code, so site-generation will probably take much longer at
the first time. But then the highlighted code will be cached in ``your_hexo_root/data/vimHighlight``.
After changing your vim colorscheme, you'll need to remove the cache folder manually.
