var vimHighlight = require('./vimhl').vimHighlight;
var pathFn = require('path');

hexo.extend.tag.register('vimhl', function(args, content){
	var file_ext = args[0];
	var useLineN = args[1];
  var cacheDir = pathFn.join(hexo.source_dir, '..', 'cache', 'vimHighlight')

  return vimHighlight(content, file_ext, useLineN, cacheDir).then(function(x) {
	  return '<figure class="highlight vimhl"><pre>' + x + '</pre></figure>';
  });
}, {ends: true, async: true} )
