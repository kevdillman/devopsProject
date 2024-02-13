# Decompressor Build

.PHONY: all
all : decompressor

decompressor : decompressor.o
	g++ -Wall --std=c++17 decompressor.cpp -larchive -O3 -o decompressor

decompressor.o : decompressor.cpp
	g++ -c -O3 decompressor.cpp

.PHONY: run
run : decompressor
	./decompressor ./demo.zip

.PHONY: check
check : decompressor
	./decompressor ./demo.zip | tee ./compare.cpp
	diff $(TEST)./decompressor.cpp $(TEST)./compare.cpp
	rm -f compare.cpp

.PHONY: clean
clean :
	rm -f decompressor.o decompressor
