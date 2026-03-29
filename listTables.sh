#!/bin/bash

listTables() {
	tables=(*)

	if [ ${#tables[@]} -gt 0 ]; then
		echo "List of Tables:"
		echo

    		for t in "${tables[@]}"; do
        		if [[ "$t" != *.meta ]]; then
				echo "$t"
			fi
		done
		echo
	else
    		echo "No tables found! ❌"
	fi
}

listTables
