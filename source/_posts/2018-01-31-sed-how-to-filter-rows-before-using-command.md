---
title: sed如何在执行命令前过滤特定文本行
author: 王诗翔
categories: Linux杂烩
date: 2018-01-31 21:19:40
tags:
- sed
- 生物信息学
- 文本处理
- fasta
---

有人在微信群里问到这样一个问题：
>请问我想把参考基因组中所有的A和C替换成C和A，小写也按照这样的规则替换，该怎么实现呢，tr可以做到，但是我想保证>后面的染色体名字不会被替换?
>![](http://upload-images.jianshu.io/upload_images/3884693-da7fbb654d3f7bc1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<!-- more -->

[`tr`](http://man.linuxde.net/tr)命令确实可以完成文本字符替换一对一的映射，但很显然，这样的功能想要解决这个问题是不够的，它把不想要改变的文本也改变了。

解决问题的思路在于如何实现带>标志的文本直接输出，而DNA字符行被执行转换命令。这个问题其实使用sed命令就可以快速解决，不少朋友对于`sed`的使用可能记忆为我在[笔记](https://shixiangwang.github.io/2017/09/03/Linux-data-analysis-tools/#用Sed进行流编辑)中写的：

```shell
command/pattern/replacement/flag
```
`command`是一些命令，比如`s`,`d`等，`flag`是一些标记，`i`,`g`等等。

这样认识sed命令其实不是很全面，sed允许指定文本模式来过滤出命令要作用的行，格式如下：

```shell
/pattern/command
```

所以整理起来，sed格式其实（除了一些选项）为

```shell
/pattern/command/pattern/replacement/flag
```

第一个`pattern`用来过滤出要处理的文本行，第二个`pattern`是sed命令要作用的模式。

那么利用这个特定，一开始的问题可以利用正则表达式非常简单地解决了：

先用`/^[^>]/`找到不以`>`开始的行，然后执行`sed`字符转换命令。

```shell

# 随便写一个测试文本
$ cat test
> CAACCA
acgtACGTACTGagct
tacgactNNNNNNNNNNNNNNNN

$ cat test | sed '/^[^>]/y/ACac/CAca/'
> CAACCA
cagtCAGTCATGcgat
tcagcatNNNNNNNNNNNNNNNN

```


***

有兴趣的可以看看[初识sed与awk](https://shixiangwang.github.io/2017/12/25/sed-and-gawk/)这篇笔记。
