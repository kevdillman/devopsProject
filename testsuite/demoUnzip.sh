#!/bin/bash

./decompressor ../demo.zip > /dev/null 2>&1 > /dev/null
echo $? | grep -Fx "0"
