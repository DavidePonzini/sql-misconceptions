#!/bin/bash -e

# remove schema from sql query
# e.g.	schema.table.column -> table.column

if [ "$#" -lt 1 ]; then
	echo "usage $0 <schema_name>"
	exit 1
fi

find . -type f -exec sed -i "s/$1\.//g" {} +
