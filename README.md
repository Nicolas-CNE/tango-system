# tango-packages
Official Roger package repository

# The roger package manager

A simple, zypper-like package manager written in C++ that implements MiniSAT to resolve dependencies

# NEEDED PACKAGES

--g++
--zstd
--C++17

i think thats all

# HOW TO COMPILE

when cloning the repository, go to src/ (tango-packages/src) and run:

 ```bash
g++ -std=c++17 main.cpp -lzstd -lminisat -o roger
