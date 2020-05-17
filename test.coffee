# File: test.coffee
# Date: Wed Mar 26 11:47:28 2014 +0800
# Author: Yuxin Wu


vimhl = require('./vimhl').vimHighlight
fs = require('fs')

test = """
void f(tuple<int, string> x) { /* ...*/  }
f(make_tuple(1, "hah"));     // Copy!
f(forward_as_tuple(1, "hah"));  // Perfect
// f({1, "hah"});       // ERROR, cannot use initialization list
"""

html = vimhl test, 'cpp', false, './cache'
console.log html

test = """
$ wget http://192.168.1.1
"""
html = vimhl test, 'sh', false, './cache'
console.log html
