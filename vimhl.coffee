# File: vimhl.coffee
# Date: Thu May 28 18:23:18 2015 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>

execSync = require('child_process').execSync
fs = require 'fs'
temp = require 'temp'
cheerio = require 'cheerio'

formatFilter = (data) ->
  # trim the extra empty line
  data = data.trim()
  data = data.replace /\n/, ''

  # delete the extra line break between code
  data = data.replace /<br>/gi, ''

  # replace dark color with lighter one
  data = data.replace /0000c0/gi, '2277cc'
  data = data.replace /af5f00/gi, 'd5e617'
  data = data.replace /008080/gi, '0edbcb'
  data = data.replace /008000/gi, '00c000'
  data = data.replace /804000/gi, 'd5e617'
  return data

vimHighlight = (data, ft, useLineN) ->
  if useLineN
    lineOpt = ' +"let g:html_number_lines=1" '
  else
    lineOpt = ' +"let g:html_number_lines=0" '

  info = temp.openSync({suffix: '.' + ft})
  fs.writeSync(info.fd, data)
  fs.closeSync info.fd

  opt = ' +"let g:html_no_progress=1" +"let g:html_ignore_folding=1" +"let g:html_use_css=0" +"let g:html_pre_wrap=0" ' + lineOpt
  execSync 'vim -X -i NONE -f ' + opt + ' +"TOhtml" -cwqa ' + info.path + ' > /dev/null 2>&1'

  htmlPath = info.path + '.html'
  result = fs.readFileSync htmlPath
  result = String result
  fs.unlink htmlPath, (err) ->

  fs.unlink info.path, (err) ->
  $ = cheerio.load result

  ret = $('body')
  ret = formatFilter ret.html()
  return ret

exports.vimHighlight = vimHighlight

