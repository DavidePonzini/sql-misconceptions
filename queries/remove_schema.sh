#!/bin/bash -e

if [ "$#" -lt 1 ]; then
	echo "usage $0 <schema_name>"
	exit 1
fi

find . -type f -exec sed -i "s/$1\.//g" {} +
