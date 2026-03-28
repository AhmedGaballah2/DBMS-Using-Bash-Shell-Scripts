#!/bin/bash

listTables() {
	tables=(*)

	if [ ${#tables[@]} -gt 0 ]; then
		echo "List of Tables:"
		echo

    		for t in "${tables[@]}"; do
        		echo "$t"
		done
		echo
	else
    		echo "No tables found! ❌"
	fi
}

listTables
