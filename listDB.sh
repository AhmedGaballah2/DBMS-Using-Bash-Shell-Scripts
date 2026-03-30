#!/bin/bash

list_DB() {

	path="./Databases"
	count=$(ls -l "$path" | grep "^d" | awk '{print $9}' | wc -l)

	if [ $count -eq 0 ]; then
		echo "There is no Databases"

	else
		echo ""
		echo "Available Databases:"
		echo ""
		ls -l "$path" | grep "^d" | awk '{print $9}'
		echo ""
	fi
}

list_DB
