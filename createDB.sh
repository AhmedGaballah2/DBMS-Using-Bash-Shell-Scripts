#!/bin/bash

create_DB() {

	echo ""
	read -p "Enter a name for the data base: " db_name

	if [ -z "$db_name" ]; then
		echo "Database name can't be empty!"
		return
	else
		mkdir $db_name
		echo "Database '$db_name' is Created"
		echo ""
	fi
}

create_DB
