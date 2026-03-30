#!/bin/bash

drop_DB() {
	while true; do
		echo
		read -p "Enter database name to delete (Or 'back' to return): " db_name

		# Exit option
		if [[ "${db_name,,}" = "back" ]]; then
			return
		fi

		# Empty name check
        	if [ -z "$db_name" ]; then
                	echo "Name cannot be empty! ❌"
                	continue
        	fi

		# Existance check
		if ! [ -d "Databases/$db_name" ]; then
			echo "Database '$db_name' not found! ❌"
			continue
		fi

		# Confirmation check
		while true; do
			echo
			read -p "Are you sure you want to delete $db_name? [y/n]: " ans

			if [[ "${ans,,}" = "y" ]]; then
				rm -r "Databases/$db_name"
				echo
				echo "Database '$db_name' is deleted successfully! ✅"
				break
			elif [[ "${ans,,}" = "n" ]]; then
				echo
				echo "Database '$db_name' is not deleted! ❌"
				break
			else
				echo
				echo "Invalid answer! ❌"
				continue
			fi
		done
	done
}
drop_DB
