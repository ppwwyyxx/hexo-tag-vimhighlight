# File: test.coffee
# Date: Sat Dec 21 12:49:17 2013 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>


vimhl = require('./vimhl').vimHighlight

test = """
void f(tuple<int, string> x) { /* ...*/  }
f(make_tuple(1, "hah"));     // Copy!
f(forward_as_tuple(1, "hah"));  // Perfect
// f({1, "hah"});       // ERROR, cannot use initialization list
"""

console.log(vimhl test, 'cpp')
