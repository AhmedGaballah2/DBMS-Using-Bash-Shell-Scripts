#!/bin/bash

selectFromTable() {
	while true; do
		read -p "Enter the name of the table you want to select from (Or type 'back' to return): " table_name
		echo

		# Back option
                if [[ "${table_name,,}" = "back" ]]; then
                        return
                fi

                # Empty check
                if [[ -z "$table_name" ]]; then
                        echo "Table's name can't be empty! ❌"
                        echo
                        continue
                fi

                # Existance check
                if [[ ! -f "$table_name" ]]; then
                        echo "Table '$table_name' doesn't exist! ❌"
                        echo
                        continue
                fi

                # Meta file existance check
                meta_file="$table_name.meta"
                if [[ ! -f "$meta_file" ]]; then
                        echo "Meta file '$meta_file' doesn't exist! ❌"
                        continue
                fi

		# How to select
		echo "Select options"
		echo
		echo "1) Select all rows"
		echo "2) Select by primary key"
		echo

		while true; do
			read -p "Choose an option (1/2): " ans
			echo

			if [[ "$ans" == "1" ]]; then
				echo "All rows in $table_name"
				echo
				cat "$table_name"
				echo
				break
			elif [[ "$ans" == "2" ]]; then

				# Entering primary key
				while true; do
	
					pk_type=$(awk -F: 'NR==1 {print $2}' "$meta_file")
					read -p "Enter the primary key value (Type: $pk_type): " pk
					echo
	
					if [[ -z "$pk" ]]; then
						echo "Primary key can't be empty! ❌"
						echo
						continue
					fi
	
					if [[ "$pk_type" == "int" ]]; then
	
		                                if ! [[ "$pk" =~ ^[0-9]+$ ]]; then
        		                                echo "Invalid primary key type! Expected integer. ❌"
        	        	                        echo
        	                	                continue
        	                        	fi
					elif [[ "$pk_type" == "varchar" ]]; then
        	                        	        if [[ "$pk" =~ ^[0-9]+$ ]]; then
        	                                	        echo "Invalid value type! Expected string. ❌"
        	                                        	echo
        	                                        	continue
        	                                	fi
        	                	fi
	
					# Primary validation check
					if ! awk -F: -v pk="$pk" '$1==pk {found=1} END{exit !found}' "$table_name"; then
        	                        	echo "Primary key is not found! ❌"
        	                        	echo
        	                        	continue
        	                	fi
	
					echo "Row with 'PK = $pk'"
					echo
					awk -F: -v pk="$pk" '$1==pk' "$table_name"
					echo
					break 2
				done
				else
					echo "Invalid choice! ❌"
					echo
					continue
				fi
		done
	done
}

selectFromTable
