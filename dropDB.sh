#!/bin/bash

drop_DB() {
	echo ""
	read -p "Enter database name to delete: " db_name

	if [ -z "$db_name" ]; then
		echo "Name cannot be empty"
		return
	fi

	if [ -d "$db_name" ]; then
		read -p "Are you sure you want to delete $db_name? [y/n]: " ans

		if [ "$ans" = "y" -o "$ans" = "Y" ]; then
			rm -r "$db_name"
			echo "$db_name is deleted successfully!"
			echo ""
		else
			echo "$db_name is not deleted"
		fi

	else
		echo "Database not found"
	fi
}

drop_DB
