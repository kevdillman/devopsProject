# Decompressor Build

decompressor : decompressor.o
	g++ -Wall --std=c++17 decompressor.cpp -larchive -o decompressor

decompressor.o : decompressor.cpp
	g++ -c decompressor.cpp
