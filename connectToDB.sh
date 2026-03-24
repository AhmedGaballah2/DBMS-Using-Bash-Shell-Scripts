#!/bin/bash

connect_to_DB() {
	read -p "Enter Database Name: " db_name

	if [ -d "$db_name" ]; then
		cd "$db_name" || return
		echo "Connected to $db_name"
		echo ""

		table_menu

		cd .. # if you are connected to DB, you Can't get back, so I used (cd ..)

	else
		echo ""
		echo "Database doesn't exist!"
		echo ""
	fi
}

table_menu() {
	echo ""
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

		read -p "Choose: " choice

		case $choice in
			1) echo "1" ;;
			2) echo "2" ;;
			3) echo "3" ;;
			4) echo "4" ;;
			5) echo "5" ;;
			6) echo "6" ;;
			7) echo "7" ;;
			8) break ;; # To go a step back..
			*) echo "Invalid Choice!" ;;
		esac
	done
}


connect_to_DB
