#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

connect_to_DB() {
	echo
	read -p "Enter Database Name: " db_name

	DB_PATH="$BASE_DIR/Databases/$db_name"

	if [ -d "$DB_PATH" ]; then
		cd "$DB_PATH" || return
		echo
		echo "Connected to $db_name! ✅"

		table_menu "$DB_PATH"

	else
		echo
		echo "Database doesn't exist! ❌"
		echo
	fi
}

table_menu() {
DB_PATH="$1"
	echo
	echo "Database Menu:"
	while true; do
		echo "1) Create Table"
		echo "2) List Tables"
		echo "3) Drop Table"
		echo "4) Insert Into Table"
		echo "5) Select From Table"
		echo "6) Delete From Table"
		echo "7) Update Table"
		echo "8) Back To Main Menu"
		echo "9) Exit"
		echo
		read -p "Choose: " choice
		echo
		case $choice in
			1) . "$BASE_DIR/createTable.sh" "$DB_PATH";;
			2) . "$BASE_DIR/listTables.sh" "$DB_PATH" ;;
			3) . "$BASE_DIR/dropTable.sh" "$DB_PATH" ;;
			4) . "$BASE_DIR/insertIntoTable.sh" "$DB_PATH";;
			5) . "$BASE_DIR/selectFromTable.sh" "$DB_PATH" ;;
			6) . "$BASE_DIR/deleteFromTable.sh" "$DB_PATH" ;;
			7) . "$BASE_DIR/updateTable.sh" "$DB_PATH" ;;
			8) break ;; # To go a step back..
			9) echo "Exiting DBMS... 👋"; echo; exit 0 ;;
			*) echo
			echo "Invalid Choice! ❌"
			echo ;;
		esac
	done
}


connect_to_DB
