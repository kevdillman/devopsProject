#!/bin/bash

./decompressor ../demoMultipleFiles.zip > /dev/null 2>&1 > /dev/null
echo $? | grep -Fx "0"
