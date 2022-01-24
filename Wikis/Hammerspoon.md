---
marp: true
---
# Hammerspoon

---
## 1. Hammerspoon 简介

Hammerspoon(以下简写为 hs), 是一个 macOS 下的开源自动化工具, 其核心对一些系统功能进行了封装, 并且支持以 Lua 脚本的方式进行配置和扩展.

hs 最为人所知的功能是作为一个快捷键设置工具, 特别是用作窗口管理, 以取代类似 magnet、moon、spectacle 之类的工具.

官网: http://www.hammerspoon.org/
wiki: https://github.com/Hammerspoon/hammerspoon/wiki
Api: http://www.hammerspoon.org/docs/

---
## 2. Setup (安装)

从官网下载直接安装即可, 启动后会在菜单栏显示图标
配置路径是 ~/.hammerspoon/init.lua

因为默认配置为空, 所以目前还什么功能都没有.

---
## 3. Getting Started Guide (入门教程)

先去 Learn X (X=Lua) in Y minutes 花个 10 分钟了解一下 Lua 语法

这是官网的 “Hello World” 示例 (本节例子均来自官网)
``` lua
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)
```

---
窗口移动的例子
```lua
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "U", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "B", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "N", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  f.y = f.y + 10
  win:setFrame(f)
end)
```
---
## 4. Hotkey & Modal
> 最基础的 api

[hs.hotkey.bind](http://www.hammerspoon.org/docs/hs.hotkey.html#bind)

[hs.hotkey.modal](http://www.hammerspoon.org/docs/hs.hotkey.modal.html): 子模式
- enter: 如果绑定了按键则会自动执行, 作用是激活绑定的快捷键并且禁用上一个 modal 的键绑定
- entered: override
- exit
- exited: override
- bind

官网的例子:
```lua
k = hs.hotkey.modal.new('cmd-shift', 'd')
function k:entered() hs.alert'Entered mode' end
function k:exited()  hs.alert'Exited mode'  end
k:bind('', 'escape', function() k:exit() end)
k:bind('', 'J', 'Pressed J',function() print'let the record show that J was pressed' end)
```

---
## 5. Spoons

一些开源的可插拔的配置文件, zip 格式, 解压后双击会自动移动到 hs.configdir 目录, 其本身是一个以 .spoon 结尾的、内含一个 init.lua 的文件夹.
可通过 hs.loadSpoon 加载, 该方法会调用其 init 方法 (详细配置需参考对应文档接口进一步设定)
文档: https://github.com/Hammerspoon/hammerspoon/blob/master/SPOONS.md

官方库: https://www.hammerspoon.org/Spoons/

---
模版
```lua
local obj={}
obj.__index = obj

obj.name = ''
obj.version = '1.0'
obj.author = ''
obj.homepage = ''
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
    return self
end

function obj:start()
    return self
end

function obj:stop()
    return self
end

function obj:bindHotkeys(mapping)
    return self
end

return obj

```

个人建议, 我们的 init.lua 最好也按照 spoon 的标准来写

---
## 6. 配置参考

https://github.com/Hammerspoon/hammerspoon/wiki/Sample-Configurations

---
### [awesome-hammerspoon](https://github.com/ashfinal/awesome-hammerspoon)

基于 ModalMgr.spoon

[内置 spoon](https://github.com/ashfinal/awesome-hammerspoon/wiki/The-built-in-Spoons) 如下:

- AClock: 可参考后自己实现一个
- BingDaily
- Calendar
- CircleClock
- ClipShow: 显示剪切板内容 (不如 ClipboardTool)
- CountDown: 倒计时
- HCalendar
- HSaria2
- HSearch
- KSheet: 推荐
---
- SpeedMenu
- TimeFlow
- UnsplashZ
- WinWin: 推荐, 参考该配置
- FnMate

---
### 我的配置

https://github.com/DZL1943/geeknotes/blob/main/Dotfiles/init.lua

---
## 7 Api 学习

----
### canvas

type
- arc
- canvas
- circle
- ellipticalArc
- image
- oval
- points
- rectangle
- resetClip
- segments
- text

----
更多属性参考: https://github.com/Hammerspoon/hammerspoon/blob/master/extensions/canvas/canvas.lua#L15

例子: https://github.com/asmagill/hammerspoon/wiki/hs.canvas.examples