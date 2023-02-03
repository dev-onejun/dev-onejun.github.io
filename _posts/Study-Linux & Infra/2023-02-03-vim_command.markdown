---
layout: post
title: "[VIM] My Personalized List of VIM Commands"
subtitle: ""
categories: [Study/Linux & Infra]
tags: [Linux, ubuntu, ubuntu server, VIM]
comments: true
---

## VIM Commands

### To replace the words

```
:s/<search_phrase>/<replace_phrase>/options
```

- __In a single line__

```
:s/article/tutorial/g
```

- __In a whole lines in file__

```
:%s/article/tutorial/g
```

## Reference

- [Replace the words](https://www.baeldung.com/linux/vim-search-replace#search-and-replace-using-the-substitute-command)
