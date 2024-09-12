[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/8M_rpPN8)
Addition Closure
=========

## General Instructions

+ Can you solve the provided question in one hour?
+ Skeleton code can be obtained by cloning this repository.

## Addition Closure

> The skeleton source code for this question is in the package `additionClosure`. You have to implement the methods _isClosed_.

You are given a `List` of `Integer`s, `listInt`, and another integer `n`. We will define *closure under addition* for `listInt` to mean that for two distinct values of `i` and `j`, `(listInt[i]+listInt[j]) % n` is in `listInt` or `k * n + (listInt[i]+listInt[j]) % n` (for some int `k`) is in `listInt`.

Your goal is to determine if a given `List` of `Integer`s is closed under addition for some modulus `n`. You will implement a method, _isClosed_, that will return `true` if a `List` is closed under addition for a given `n` and `false` otherwise.

### Examples

+ input list: [-1, 0, 1]; `n` = 2
	+ Returns: `true`
	+ `(-1 + 0) % 2 = -1; (-1 + 1) % 2 = 0, (0 + 1) % 2 = 1`.

+ input list: [-2, 3]; `n` = 4
	+ Returns: `false`

+ input list: [1, 1, 0]; `n` = 2
	+ Returns: `true`

+ input list: [1, 1]; `n` = 3
	+ Returns: `false`

+ input list: [1, 1, 2]; `n` = 2
	+ Returns: `true`

+ input list: [0, 1, 1, 2]; `n` = 2
	+ Returns: `true`

+ input list: [0, 1, 100, 50, 50], `n` = 100
	+ Return: `false`

+ input list: [0, 1, 100, 50, 50], `n` = 50
	+ Return: `true`
