#! /bin/bash

listTables() {
	
	tables=($(ls ./tables/))

	if [[ ${#tables[@]} -gt 0 ]]
	then
		echo "List of Tables"
    		for t in "${tables[@]}"
    		do
        		echo "$t"
    		done
	else
    		echo "No tables found"
	fi
}

listTables
	
