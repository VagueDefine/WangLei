---
title: 4、Git 操作——如何删除本地分支和远程分支
source: https://www.freecodecamp.org/chinese/news/how-to-delete-a-git-branch-both-locally-and-remotely/
author: WangLI
published: 2020-11-30
created: 2026-04-25-星期六
description: 引言 在大多数情况下，删除 Git 分支很简单。这篇文章会介绍如何删除 Git 本地分支和远程分支。 用两行命令删除分支 // 删除本地分支 git branch -d localBranchName // 删除远程分支 git push origin --delete remoteBranchName （译者注：关于 git push 的更多介绍，请阅读《git push 命令的用法》 [https://chinese.freecodecamp.org/news/git-push-to-remote-branch-how-to-push-a-local-branch-to-origin/] ）。 什么时候需要删除分支 一个 Git 仓库常常有不同的分支，开发者可以在各个分支处理不同的特性，或者在不影响主代码库的情况下修复 bug。 仓库常常有一个 master 分支，表示主代码库。开发人员创建其他分支，处理不同的特性。 开发人员完成处理一个特性之后，常常会删除相应的分支。 本地删除分支 如果你还在一个分支上，那么 Git 是不允许你删除这个分支的。所以，请记得退出分支
tags:
  - GitHub教程
aliases:
  - 4、Git 操作——如何删除本地分支和远程分支
draft:
  - "false"
---
## 引言

在大多数情况下，删除 Git 分支很简单。这篇文章会介绍如何删除 Git 本地分支和远程分支。

### 用两行命令删除分支

```bash
// 删除本地分支
git branch -d localBranchName

// 删除远程分支
git push origin --delete remoteBranchName
```

（译者注：关于 `git push` 的更多介绍，请阅读 [《git push 命令的用法》](https://chinese.freecodecamp.org/news/git-push-to-remote-branch-how-to-push-a-local-branch-to-origin/) ）。

## 什么时候需要删除分支

一个 Git 仓库常常有不同的分支，开发者可以在各个分支处理不同的特性，或者在不影响主代码库的情况下修复 bug。

仓库常常有一个 `master` 分支，表示主代码库。开发人员创建其他分支，处理不同的特性。

开发人员完成处理一个特性之后，常常会删除相应的分支。

## 本地删除分支

如果你还在一个分支上，那么 Git 是不允许你删除这个分支的。所以，请记得退出分支： `git checkout master` 。

通过 `git branch -d <branch>` 删除一个分支，比如： `git branch -d fix/authentication` 。

当一个分支被推送并合并到远程分支后， `-d` 才会本地删除该分支。如果一个分支还没有被推送或者合并，那么可以使用 `-D` 强制删除它。

这就是本地删除分支的方法。

## 远程删除分支

使用这个命令可以远程删除分支： `git push <remote> --delete <branch>` 。

比如： `git push origin --delete fix/authentication` ，这个分支就被远程删除了。

你也可以使用这行简短的命令来远程删除分支： `git push <remote> :<branch>` ，比如： `git push origin :fix/authentication` 。

如果你得到以下错误消息，可能是因为其他人已经删除了这个分支。

```bash
error: unable to push to unqualified destination: remoteBranchName The destination refspec neither matches an existing ref on the remote nor begins with refs/, and we are unable to guess a prefix based on the source ref. error: failed to push some refs to 'git@repository_name'
```

使用以下命令同步分支列表：

```bash
git fetch -p
```

`-p` 的意思是“精简”。这样，你的分支列表里就不会显示已远程被删除的分支了。


原文： [How to Delete a Git Branch Both Locally and Remotely](https://www.freecodecamp.org/news/how-to-delete-a-git-branch-both-locally-and-remotely/)

## 清理本地的远程跟踪引用（关键步骤！）

很多时候，你删了远程分支后，本地 Git 还会缓存 `origin/500理论` 这个记录，所以你会一直看到它：让 Git 同步远程仓库状态，清理掉不存在的远程分支引用
```bash
git fetch origin --prune
```
执行完这三步，再运行 `git branch -a`（查看所有本地 + 远程分支）