#!/bin/bash

./decompressor ../testsuite.tar.xz > /dev/null
echo $? | grep -Fx "0"
