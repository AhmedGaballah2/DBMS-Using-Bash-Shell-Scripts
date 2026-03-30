#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -n "
#########################################################
#		      				        #
#               Bash Shell Script Project               #
#              Database Managaement System              #
#						        #
#########################################################
"

echo
echo "Welcome to DBMS using Bash"
echo

main_menu() {
	while true; do
		echo "Main Menu:"
		echo "1) Create Database"
		echo "2) List Database"
		echo "3) Connect to Database"
		echo "4) Drop Database"
		echo "5) Exit"

		echo
		read -p "choose: " choice
		echo
		case $choice in 
			1) . "$BASE_DIR/createDB.sh" ;;
			2) . "$BASE_DIR/listDB.sh" ;;
			3) . "$BASE_DIR/connectToDB.sh" ;;
			4) . "$BASE_DIR/dropDB.sh" ;;
			5) echo "Exiting DBMS... 👋"; echo; exit 0 ;;
			*) echo
			echo "Invalid Choice! ❌"
			echo ;;
		esac
	done
}

main_menu
