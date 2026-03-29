#!/bin/bash

deleteFromTable() {
	while true; do
		read -p "Enter the name of the table you want to delete from (Or type 'back' to return): " table_name
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

			if ! awk -F: -v pk="$pk" '$1==pk {found=1} END{exit !found}' "$table_name"; then
                                echo "Primary key is not found! ❌"
                                echo
                                continue
                        fi

			# Deletion confirmation
			while true; do
				read -p "Are you sure you want to delete the row 'PK = $pk'? (y/n): " ans
				echo

				if [[ "${ans,,}" = "n" ]]; then
					echo "Row is not deleted! ❌"
					echo
					break 2
				elif [[ "${ans,,}" = "y" ]]; then
					tmp_file=$(mktemp)
					awk -F: -v pk="$pk" '$1!=pk' "$table_name" > "$tmp_file" && mv "$tmp_file" "$table_name"
					echo "Row 'PK = $pk' is deleted successfully! ✅"
					echo
					break 2
				else 
					echo "Invalid choice! ❌"
					echo
					continue
				fi
			done
		done

	done
}

deleteFromTable

