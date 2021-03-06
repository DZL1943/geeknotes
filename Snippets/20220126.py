# 用 python 处理命令输出的一个例子
# date: 20220126

import os

def _f():
    r = os.popen("grep -o 'hs\.[a-zA-Z]*' ~/.hammerspoon/init.lua | sort|uniq")
    lines = r.read().splitlines()
    return lines


lines = [
    'hs.alert',
    'hs.application',
    'hs.canvas',
    'hs.configdir',
    'hs.eventtap',
    'hs.fnutils',
    'hs.hints',
    'hs.hotkey',
    'hs.inspect',
    'hs.loadSpoon',
    'hs.logger',
    'hs.mouse',
    'hs.notify',
    'hs.pathwatcher',
    'hs.reload',
    'hs.screen',
    'hs.spoons',
    'hs.timer'
]

# 目标是处理成 local x = require('hs.x')
dlines = []
for line in lines:
    dline = "local %s = require('%s')" %(line.split('.')[1], line)
    dlines.append(dline)


print('\n'.join(dlines))