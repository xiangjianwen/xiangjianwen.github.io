---
title: 简单理解lapply,sapply,vapply
author: 王诗翔
categories: 极客R
tags:
  - R
  - lapply
  - sapply
  - vapply
  - 迭代计算
date: 2018-02-10 15:04:57
---

在我之前转载的文章[apply,lapply,sapply用法探索](https://www.jianshu.com/p/9bca3555b06c)中已经对R中`apply`家族函数进行了比较详细地说明，这篇文章基于我在data campus中对`lapply`、`sapply`、`vapply`几个函数的学习，以更为简单的实例来了解这几个以列表对输入的迭代函数。

<!-- more -->

使用的是一组温度数据，每天测5次，连续测量一个星期。

我们先将其输入R:

```R
temp <- list(c(3, 7, 9, 6, -1), c(6, 9, 12, 13, 5), c(4, 8, 3, -1, -3
), c(1, 4, 7, 2, -2), c(5, 7, 9, 4, 2), c(-3, 5, 8, 9, 4), c(3,
                                                             6, 9, 4, 1))
```

我们进行迭代计算的函数是`basics`，它计算每一天温度的最小、最大值、平均值以及中位数。

```
# Definition of the basics() function
basics <- function(x) {
  c(min = min(x), mean = mean(x), median = median(x), max = max(x))
}
```

`lapply`最为常见，以列表为输入，以列表为输出。

```R

> lapply(temp, basics)
[[1]]
   min   mean median    max
  -1.0    4.8    6.0    9.0

[[2]]
   min   mean median    max
     5      9      9     13

[[3]]
   min   mean median    max
  -3.0    2.2    3.0    8.0

[[4]]
   min   mean median    max
  -2.0    2.4    2.0    7.0

[[5]]
   min   mean median    max
   2.0    5.4    5.0    9.0

[[6]]
   min   mean median    max
  -3.0    4.6    5.0    9.0

[[7]]
   min   mean median    max
   1.0    4.6    4.0    9.0
```

可以看出，如果迭代次数够大，结果会非常冗长，但我们所需要的结果其实可以以比较紧凑的数组（矩阵）展示出来。因此，我们可以使用`sapply`函数，`s`前缀即简化之意。

```R
> sapply(temp, basics)
       [,1] [,2] [,3] [,4] [,5] [,6] [,7]
min    -1.0    5 -3.0 -2.0  2.0 -3.0  1.0
mean    4.8    9  2.2  2.4  5.4  4.6  4.6
median  6.0    9  3.0  2.0  5.0  5.0  4.0
max     9.0   13  8.0  7.0  9.0  9.0  9.0
```

是否已经足够紧凑？

最后想要介绍的函数`vapply`其实是为`sapply`加了一层验证选项:

```R
> vapply(temp, basics, numeric(4))
       [,1] [,2] [,3] [,4] [,5] [,6] [,7]
min    -1.0    5 -3.0 -2.0  2.0 -3.0  1.0
mean    4.8    9  2.2  2.4  5.4  4.6  4.6
median  6.0    9  3.0  2.0  5.0  5.0  4.0
max     9.0   13  8.0  7.0  9.0  9.0  9.0
> vapply(temp, basics, numeric(3))
Error in vapply(temp, basics, numeric(3)) : 值的长度必需为3，
 但FUN(X[[1]])结果的长度却是4
 ```

 读者可以发现，当第三个参数其实就是验证选项，命名为`FUN.VALUE`。

 ```R
 > args(vapply)
function (X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE)
NULL
```

我们知道每次迭代计算应该返回4个数值型结果，所以当我们设置为`numeric(3)`时它会报错。这个函数及其选项的设定在我们编写比较大型的迭代计算和整合函数代码时非常有用，可以帮助我们快速检验结果的有效性，尽量避免调试bug带来的苦恼。
