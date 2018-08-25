#!/bin/bash

# Let's run inside the directory we actually care about
pushd "$(dirname "$0")" > /dev/null

echo "Backing up previous build..."

if [ -d "build_old" ]; then
	rm -r build_old -f
fi

if [ -d "build" ]; then
	mv build build_old
fi

mkdir build

echo "Compiling source files..."

for f in *.c
do
	if [ -f $f ]; then
		if ! gcc -c -o build/${f}.o ${f} -ggdb -Wall -std=c11
		then
			echo "Build failed while building ${f}"
			rm -r -f build
			mv build_old build
			popd > /dev/null
			exit
		fi
	fi
done

for f in *.cpp *.cxx *.cc *.c++
do
	if [ -f $f ]; then
		if ! g++ -c -o build/${f}.o ${f} -ggdb -Wall
		then
			echo "Build failed while building ${f}"
			rm -r -f build
			mv build_old build
			popd > /dev/null
			exit
		fi
	fi
done

echo "Linking final executable..."

if ! gcc build/*.o -o build/bin
then
	echo "Build failed while linking executable"
	rm -r -f build
	mv build_old build
	popd > /dev/null
	exit
fi

if [ -f "bin" ];
then
	rm bin
fi

ln -s build/bin bin

echo "Cleaning up..."

if [ -d "build_old" ]; then
	rm -r build_old -f
fi

popd > /dev/null
