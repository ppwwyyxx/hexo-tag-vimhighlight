# File: vimhl.coffee
# Date: Thu May 28 18:23:18 2015 +0800

util = require 'util'
exec = util.promisify require('child_process').exec
fs = require 'fs'
temp = require('temp').track()
cheerio = require 'cheerio'
crypto = require('crypto')
wrench = require('wrench')

formatFilter = (data) ->
  # trim the extra empty line
  data = data.trim()
  data = data.replace '\n', ''

  # delete the extra line break between code
  data = data.replace /<br>/gi, ''

  # replace dark color with lighter one
  data = data.replace /#0000c0/gi, '#2277cc'
  data = data.replace /#af5f00/gi, '#d5e617'
  data = data.replace /#008080/gi, '#0edbcb'
  data = data.replace /#008000/gi, '#00c000'
  data = data.replace /#804000/gi, '#d5e617'
  data = data.replace /#c00000/gi, '#ff4040'
  # https://stackoverflow.com/questions/2083754/why-shouldnt-apos-be-used-to-escape-single-quotes
  data = data.replace /&apos;/gi, '&#27;'
  return data

vimHighlight = (data, ft, useLineN, cacheDir) ->
  cacheFileHash = crypto.createHash('md5');
  cacheFileHash.update(data);
  cacheFileHash.update(ft);
  if (useLineN)
    cacheFileHash.update("show line numbers");
  else
    cacheFileHash.update("no line numbers");

  cacheFileName = cacheFileHash.digest('hex') + '.html';

  if (!fs.existsSync(cacheDir))
    wrench.mkdirSyncRecursive(cacheDir, '0777');

  if (!fs.existsSync(cacheDir + '/' + cacheFileName))
    if useLineN
      lineOpt = ' +"let g:html_number_lines=1" '
    else
      lineOpt = ' +"let g:html_number_lines=0" '

    info = await temp.open({suffix: '.' + ft})
    await fs.promises.writeFile(info.path, data)

    # https://bitbucket.org/fritzophrenic/vim-tohtml/issues/25/cannot-recognize-urls-with-ip-address
    opt = '
    +"let g:html_no_progress=1"
    +"let g:html_ignore_folding=1"
    +"let g:html_use_css=0"
    +"let g:html_pre_wrap=0"
    +"hi clear Constant"' + lineOpt
    await exec 'vim -X -i NONE -f ' + opt + ' +"TOhtml" -ncwqa ' + info.path + ' > /dev/null 2>&1'

    htmlPath = info.path + '.html'
    result = await fs.promises.readFile htmlPath
    result = String result
    fs.unlink htmlPath, (err) ->

    fs.unlink info.path, (err) ->
    $ = cheerio.load result

    ret = $('body')
    ret = formatFilter ret.html()

    await fs.promises.writeFile(cacheDir + '/' + cacheFileName, ret)
  else
    result = await fs.promises.readFile(cacheDir + '/' + cacheFileName);
    ret = String(result);

  return ret

exports.vimHighlight = vimHighlight

