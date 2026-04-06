#!/bin/bash
regex='A-Za-z'
regex_num='0-9'

add_record(){
    while true
    do
        read -r -p "Enter the table's name : " tname 
        echo
        
        if [[ -e $tname ]]; then
            
            col_num=$(awk 'END{print NR}' "$tname.meta")
            declare -a record   
            
            i=1
            while (( i <= col_num ))
            do
                checkcolname=$(awk -F: -v row="$i" 'NR==row {print $1}' "$tname.meta")
                checkcoltype=$(awk -F: -v row="$i" 'NR==row {print $2}' "$tname.meta")
                checkcolPK=$(awk -F: -v row="$i" 'NR==row {print $3}' "$tname.meta")

                while true
                do
                    read -r -p "Enter your $checkcolname: " record_
                    echo

                    # check type
                    if [[ $checkcoltype == 'int' ]]; then
                        if [[ ! $record_ =~ ^[$regex_num]+$ ]]; then
                            echo "Invalid $checkcolname. Integer expected! ❌"
                            echo
                            continue
                        fi
                    elif [[ $checkcoltype == 'varchar' ]]; then
                        if [[ ! $record_ =~ ^[$regex]+$ ]]; then
                            echo "Invalid $checkcolname. String expected! ❌"
                            echo
                            continue
                        fi
                    fi

                    # check primary key
                    if [[ $checkcolPK == 'pk' ]]; then
                        values=$(awk -v var="$i" -F: '{print $var}' "$tname")
                        found=0

                        for item in $values
                        do 
                            if [[ "$item" == "$record_" ]]; then 
                            echo
                                echo "Primary key must be unique! ❌"
                                found=1
                                break
                            fi
                        done 


                        if [[ $found -eq 1 ]]; then
                            continue
                        fi
                    fi  

                  
                    break
                done

                record+=("$record_")
                i=$((i + 1))
            done

            (IFS=:; echo "${record[*]}") >> "$tname"
            echo "Record inserted successfully! ✅"
            echo
            
            break	    
        else
            echo "Table doesn't exist! ❌"
            echo
            continue
        fi
    done       
}

add_record
