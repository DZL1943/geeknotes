# zsh

## oh-my-zsh

## 其他碎片设置

- ls 命令显示颜色: `export CLICOLOR=1`
- 一些 alias
  ```shell
  alias ll='ls -l'
  alias cl = 'clear'
  alias emacs=
  alias notebook=
  ```
- 一些环境变量
  ```shell
  export JAVA_HOME=
  export SCALA_HOME=
  export ANACONDA_HOME=
  export PYTHON_HOME=
  ```
- 历史命令补全
  ```shell
  # 这个似乎是 omz 的功能? 并且需要下载个啥?
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down
  ```