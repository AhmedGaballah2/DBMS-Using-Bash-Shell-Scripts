#!/bin/bash

updateTable() {
	while true; do
		read -p "Enter the name of the table you want to update (Or type 'back' to return): " table_name
		echo

		# Empty check
		if [ -z "$table_name" ]; then
			echo
			echo "Table's name can't be empty! ❌"
			echo
			continue
		fi

		# Exit option
		if [[ "${table_name,,}" = "back" ]]; then
			return
		fi

		if [ ! -f "$table_name"  ]; then
			echo "Table '$table_name' does not exist! ❌"
			echo
			continue
		fi

		if [ -f "$table_name" ]; then
			read -p "Enter the primary key value: " pk

			read -p "Enter the column number (Starting from 1): " col_num

			if ! [[ "$col_num" =~ ^[0-9]+$ ]]; then
				echo "Invalid column number! ❌"
				echo
				continue
			fi
			read -p "Enter the new value: " new_val

			awk -v pk="$pk" -v col="$col_num" -v new="$new_val" 'BEGIN{FS=OFS=":"} $1==pk{$col=new}1' "$table_name" > tmp && mv tmp "$table_name"

			echo "Table '$table_name' is updated successfully! ✅"
			echo
		fi
	done
}

updateTable
