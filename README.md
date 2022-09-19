## Introduction

This is a [hexo](https://github.com/hexojs/hexo)
tag plugin which allows you to use vim syntax highlight to highlight code inside markdown.

## Why?
Hexo is a static blogging system written in Node.js, it uses [highlight.js](http://softwaremaniacs.org/soft/highlight/en/)
by default to render code.

However, lots of languages are not supported by highlight.js, but always supported by vim with proper plugins.
Moreover, vim usually supports __more features than highlight.js__, even for common languages.
See the demo below (left: vimhighlight; right: highlight.js).

![demo](demo.jpg)

From the image above, we see that highlight.js cannot recognize C++ keywords "struct", "static";
it also fails to recognize STL functions "forward" and "get". All of these can be handled correctly by vim.

See [this page](http://ppwwyyxx.com/blog/2013/Explode-Tuple-in-C++11/) for more samples.
Note that the actual appearance depends on how you config your vim.

## Installation

You need to have vim properly installed and configured, since this program will directly run vim.

To install, run the following command in the root directory of hexo:
```
npm install hexo-tag-vimhighlight --save
```

## Usage

Specify the code filetype, and whether to show line number, in
the common format of tag plugins:

```
{% vimhl cpp true %}
template <unsigned K, class RET, class F, class Tup>
struct Expander {
  template <class... Ts>
  static RET expand(F&& func, Tup&& t, Ts && ... args) {
    return Expander<K - 1, RET, F, Tup>::expand (
        forward<F>(func),
        forward<Tup>(t),
        get<K - 1>(forward<Tup>(t)),
        forward<Ts>(args)...
    );}
};
{% endvimhl %}
```

By default, line number will not be displayed, you can use ``{% vimhl cpp %}`` for short.

## Speed

This plugin calls `vim` to highlight code, so site-generation may be slow sometimes. The following mechanism are used to speed up rendering:

* The highlighted code will be cached in ``your_hexo_root/cache/vimHighlight`` so that only the first-time rendering will execute `vim`.
  Note that this implies you'll need to remove the cache folder manually if you changed vim colorscheme.
  
To further speed up the first-time rendering:
* This plugin uses async hexo tag. This means the `vimhl` tags between different posts will render concurrently.
* [This hexo patch](https://github.com/hexojs/hexo/pull/4926) further enables concurrent rendering of tags within one post. If you have a single post with many `vimhl` tags, this patch can improve the first-time rendering.

