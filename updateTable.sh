#!/bin/bash

updateTable() {
	while true; do
		read -p "Enter the name of the table you want to update (Or type 'back' to return): " table_name
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

		# Entering Primary key
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

			# Primary key validation check
			if ! awk -F: -v pk="$pk" '$1==pk {found=1} END{exit !found}' "$table_name"; then
				echo "Primary key is not found! ❌"
				echo
				continue
			fi

			# Entering Column number
			while true; do

				read -p "Enter the column number (Starting from 1): " col_num
				col_name=$(awk -F: "NR==$col_num {print \$1}" "$meta_file")
                                col_type=$(awk -F: "NR==$col_num {print \$2}" "$meta_file")
				echo

				if [[ -z "$col_num" ]]; then
                                	echo "Column number can't be empty! ❌"
                                	echo
                                	continue
                        	fi

				# Column validation check
				if ! [[ "$col_num" =~ ^[0-9]+$ ]]; then
					echo "Invalid column number! ❌"
					echo
					continue
				fi

				# Preventing changing the primary key
				if [[ "$col_num" -eq 1 ]]; then
					echo "Can't update the primary key! ❌"
					echo
					continue
				fi

				# Range of column numbers validation
				col_count=$(awk -F: 'NR==1{print NF}' "$table_name")

				if [[ "$col_num" -gt "$col_count" ]]; then
					echo "Column number is out of range! ❌"
					echo
					continue
				fi

				# Entering the new value
				while true; do

					read -p "Enter the new value for '$col_name' (Type: $col_type): " new_val
					echo

					# Empty check
					if [[ -z "$new_val" ]]; then
                          	        	echo "Value can't be empty! ❌"
                                		echo
                        	        	continue
                        		fi

					if [[ "$col_type" == "int" ]]; then
						if ! [[ "$new_val" =~ ^[0-9]+$ ]]; then
							echo "Invalid value type! Expected integer. ❌"
							echo
							continue
						fi
					elif [[ "$col_type" == "varchar" ]]; then
						if [[ "$new_val" =~ ^[0-9]+$ ]]; then
							echo "Invalid value type! Expected string. ❌"
							echo
							continue
						fi
					fi

					tmp_file=$(mktemp)

					# Updating the table's file
					if awk -v pk="$pk" -v col="$col_num" -v new="$new_val" 'BEGIN{FS=OFS=":"} $1==pk { $col=new }1' "$table_name" > "$tmp_file"; then

						mv "$tmp_file" "$table_name"
						echo "Table $table_name is updated successfully! ✅"
						echo
						break 4
					else
						echo "Update failed! ❌"
						echo
					fi
				done
			done
		done
	done
}

updateTable
