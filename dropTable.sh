#!/bin/bash

dropTable() {
    while true; do
        read -p "Enter the name of the table you want to delete (Or type 'back' to return): " table_name
	echo

        # Exit option
        if [[ "${table_name,,}" = "back" ]]; then
		return
	fi


        # Empty name check
        if [ -z "$table_name" ]; then
        	echo ""
        	echo "Table's name can't be empty! ❌"
        	echo
		continue
	fi

	# Existance check
	if [ -f "$table_name" ]; then
		while true; do
			read -p "Are you sure you want to delete $db_name? [y/n]: " ans
			if [[ "${ans,,}" = "y" ]]; then
				rm "$table_name"
				echo "$table_name is deleted successfully! ✅"
				echo
				break
			elif [[ "${ans,,}" = "n" ]]; then
				echo "Table $table_name is not deleted! ❌"
				echo
				break
			else
				echo
				echo "Inavlid answer! ❌"
				continue
			fi
		done
        else
		ls
		echo "$table_name is not found! ❌"
		echo
	fi
    done
}

dropTable
