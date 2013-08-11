var vimHighlight = require('./vimhl').vimHighlight;

hexo.extend.tag.register('vimhl', function(args, content){
	var file_ext = args[0];
	var useLineN = args[1];

	return '<pre><code><figure class="highlight"><pre>' + vimHighlight(content, file_ext, useLineN) + '</pre></figure></code></pre>';
}, true)
