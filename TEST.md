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
## 回退操作
```
git reset --hard HEAD~
git reset –hard <commit_id>
```
## 回到最新
```
git reflog
git reset –hard <commit_id>
```
## 提取commit之间的差分(参考)
```
git diff 608e120 4abe32e --name-only
git archive -o update.zip HEAD $(git diff --name-only 608e120 4abe32e)
git diff 608e120 4abe32e --name-only | xargs zip update.zip
```
## 撤回push
```
git log
git reset –-soft <commit_id>
git push origin main --force
```
# 分支管理
## 查看分支
```
git branch
```
## 创建分支
```
git branch <branch_name>
```
## 切换分支
```
git checkout <branch_name>
```
## 创建并切换到分支
```
git checkout -b <branch_name>
```
## 删除分支
```
git branch -d <branch_name>
```
## 合并分支
```
git merge 被合并的分支名
```
## 从主分支合并
```
git checkout main
git pull
git checkout current
git merge main
git push
```
# 代理
## 使用代理
```
git config --global https.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'

代理服务器需要鉴权配置
git config --global https.proxy https://username:password@proxy.com:8080
```
## 取消代理
```
git config --global --unset http.proxy
git config --global --unset https.proxy
```