#!/bin/bash
declare -a list
regex_num='0-9'

col_name() {
	while true
	do
	    read -p "enter column name: " col_name  
	    echo

	    if [ -z "$col_name" ]; then
		echo "Column name can't be empty! ❌"
		echo
		continue
	    fi

	    if [[ ! $col_name =~ ^[A-Za-z]+$ ]]; then
		echo "Invalid column's name! ❌"
		echo
		continue
	    fi

	    # check duplicate
	    for item in "${list[@]}"
	    do
		name_only=$(echo "$item" | cut -d ":" -f1)

		if [[ "$name_only" == "$col_name" ]]; then
		    echo "Column's name already exists! ❌"
		    echo
		    continue 2
		fi
	    done
	    break
	done
}

col_type(){
	while true
	do
	    read -p "what is column type [int/i , varchar/vch] : " column_type
	    echo

	    case $column_type in
		int|i)
		    column_def="$col_name:int"
		    break
		;;
		
		varchar|vch)
		    column_def="$col_name:varchar"
		    break
		;;
		
		*)echo "Invalid type! (int/varchar)! ❌";
		echo
		;;
	    esac
	done

	# add pk to first column
	if [[ $i -eq 0 ]]; then
	    column_def="$column_def:pk"
	fi

	# store full column definition in list
	list+=("$column_def")
}
	
createTable(){
	while true
	do
	  echo -e "\nCreate Table\n"
	  read -r -p "Enter the table's name (Or 'back' to return): " table_name
	  echo
	  
	  if [[ "${table_name,,}" = "back" ]]; then
	  	return
	  fi
	  
	  if [ -z "$table_name" ]; then
		echo -e "\nEnter a correct name, name can not be empty! ❌"
		echo
		continue
	  fi

	  if [[ "$table_name" = *[[:space:]]* ]]; then
		echo -e "\nTable's name cannot contain spaces! ❌"
		echo
		continue
	  fi

	  if [ -f "$table_name" ]; then
		echo -e "\nTable already exists! ❌"
		echo
		continue
	  fi

	  if [[ "$table_name" == [a-zA-Z]* ]]; then
		
		# loop until user enters valid number
		while true
		do
		    read -r -p "Please enter your columns number: " col_num
		    echo
		
		    # empty check
		    if [ -z "$col_num" ]; then
		        echo "Column number can't be empty! ❌"
		        echo
		        continue
		    fi

		    # numeric check
		    if [[ ! $col_num =~ ^[0-9]+$ ]]; then
		        echo "Column number must be numeric only! ❌"
		        echo
		        continue
		    fi

		    # optional: prevent zero
		    if (( col_num == 0 )); then
		        echo "Column number must be greater than 0! ❌"
		        echo
		        continue
		    fi
		    break   # valid input -> exit loop
		done

		touch "$table_name" "$table_name.meta"

		i=0
		
		while (( i < col_num ))
		do
		      col_name
			# write column name
			echo -n "$col_name" >> "$table_name"

			# add : between columns
			if [[ $i -ne $((col_num - 1)) ]]; then
			    echo -n ":" >> "$table_name"
			fi

		      col_type

		      ((i++))
		done

		printf "%s\n" "${list[@]}" > "$table_name.meta"
		echo -e "\nTable created successfully! ✅\n"
		break

	else
		echo "Invalid table's name. Must start with a letter! ❌"
		echo
	fi

	done
}
createTable
