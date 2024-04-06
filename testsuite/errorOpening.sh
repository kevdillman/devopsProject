#!/bin/bash

./decompressor "testing" > /dev/null 2>&1 > /dev/null
echo $? | grep -Fx "1"
