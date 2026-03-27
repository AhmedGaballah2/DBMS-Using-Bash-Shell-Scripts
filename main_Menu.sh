#!/bin/bash

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
		case $choice in 
			1) . ./createDB.sh ;;
			2) . ./listDB.sh ;;
			3) . ./connectToDB.sh ;;
			4) . ./dropDB.sh ;;
			5) break ;;
			*) echo "Invalid Choice!" ;;
		esac
	done
}

main_menu
