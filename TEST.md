# Git Commit Message
- feat: 增加了一个新功能或由于需求变更导致的修改
- fix: 修复了一个 Bug
- docs: 更新了文档 (比如改了 README)
- style: 代码的格式美化, 不涉及到功能修改 (比如改了缩进)
- refactor: 一些代码结构上优化, 既不是新特性也不是修复 Bug (比如函数改个名字)
- perf: 优化了性能的代码改动
- test: 新增或者修改已有的测试代码
- build: 影响构建系统或外部依赖的更改 (比如 gulp, grunt, webpack, package.json)
- chore: 其它不修改 src 或测试文件的变更 (比如新增一个文档生成工具)
- ci: 更改 CI 的配置文件或脚本 (比如 GitLab CI)
- revert: 恢复先前的一次提交


# Git Tutorial
## config
```
git config --global user.name "username"
git config --global user.email "example@outlook.com"
git config --global init.defaultBranch <name>
```
## 初始化
```
git init
```
## 查看当前状态
```
git status
```
## 添加到暂存区
```
git add 文件名
git add 文件名 1 文件名 2 …
git add .
```
## 提交至版本库
```
git commit -m "message"
```
## 查看版本
```
git log
git log --pretty=oneline
```