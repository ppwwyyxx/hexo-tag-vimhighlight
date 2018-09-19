var vimHighlight = require('./vimhl').vimHighlight;
var pathFn = require('path');

hexo.extend.tag.register('vimhl', function(args, content){
	var file_ext = args[0];
	var useLineN = args[1];
  var cacheDir = pathFn.join(hexo.source_dir, '..', 'cache', 'vimHighlight')

	return '<figure class="highlight"><pre>' + vimHighlight(content, file_ext, useLineN, cacheDir) + '</pre></figure>';
}, {ends: true} )
