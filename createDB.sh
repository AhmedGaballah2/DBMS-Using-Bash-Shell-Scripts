#!/bin/bash

create_DB() {
	reserved_keywords=("select" "create" "drop" "delete" "insert" "update" "where" "table" "database")

	while true; do
		echo ""
		read -p "Enter a name for the data base (Or type 'back' to return): " db_name

		# Exit option
		if [[ "${db_name,,}" = "back" ]]; then
			return
		fi

		# Empty name check
		if [ -z "$db_name" ]; then
			echo ""
			echo "Database name can't be empty! ❌"
			continue
		fi

		# Existance check
		if [ -d "Databases/$db_name" ]; then
			echo ""
			echo "Database already exists! ❌"
			continue
		fi

		# Name validation check
		if ! [[ $db_name =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
			echo ""
			echo "Invalid database name! ❌"
			continue
		fi

		# Reserved keywords check
		is_reserved=false

		for keyword in "${reserved_keywords[@]}"; do
			if [ "$db_name" == "$keyword" ]; then
				is_reserved=true
				break
			fi
		done

		if [ "$is_reserved" == true ]; then
			echo ""
			echo "Invalid database name! ❌   Reserved Keyword"
			continue
		fi

		# Database creation
		mkdir "Databases/$db_name"
		echo ""
		echo "Databse '$db_name' is created successfully! ✅"
		echo ""
		break

	done
}

create_DB
