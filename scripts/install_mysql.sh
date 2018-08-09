#!/usr/bin/env bash

# check if mysql is install
type mysql >/dev/null 2>&1 && echo "MySQL present." || echo "MySQL not present."

: '
> is for redirect

/dev/null is a black hole where any data sent, will be discarded

2 is the file descriptor for Standard Error

> is for redirect

& is the symbol for file descriptor (without it, the following 1 would be considered a filename)

1 is the file descriptor for Standard Out

Therefore >/dev/null 2>&1 is redirect the output of your program to /dev/null. Include both the  Standard Error and Standard Out.

'

# if mysql is not installed install mysql


# check if user is created 
# if user is not created create user

# test user and password
 exit 0


