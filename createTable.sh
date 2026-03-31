#!/bin/bash
declare -a list
regex_num='0-9'
regex_col_name='A-Za-z'

col_name(){
    read  -p "enter coiumn name: " col_name  
    
    if [[ ! $col_name =~ ^[$regex_col_name]+$ ]];
    then
        echo "column have charaters [A-Za-z] only "
        rm $table_name $table_name.meta
        exit 0
    else
       
        list=( ${list[@]} $col_name)   
        echo -n "$col_name" >> "$table_name"
     fi              
}

clo_PK(){
        read  -p "this column is primary key or not [yes/no] :"  PK
        case $PK in 
             Yes|Y|yes|y) list=(${list[@]}':yes')
             col_type;;
             NO|N|no|n) list=(${list[@]}':no')
             col_type;;
             *)echo 'error[must be yes or No]';rm $table_name $table_name.rows; exit 0
             ;;
        esac
}

col_type(){
    read -p "what is column type [int/i ,varchar/vch] : " column_type
        case $column_type in 
             int|i) list=(${list[@]}":int")
             ;;
             varchar|vch) list=(${list[@]}":varchar")
             ;;
              *)echo "error[must be int/str]";rm $table_name $table_name.rows; exit 0  
             ;;
        esac

}

createTable(){

regex_num='0-9'

while true
do
  echo -e "\nCreate Table\n"
  read -r -p "Please enter the name of the table (must start with alphabetic character): " table_name
  
  if [ -z "$table_name" ]; then
        echo -e "\nPlease enter a correct name, name can not be empty\n"
        continue
  fi

  if [[ "$table_name" = *[[:space:]]* ]]; then
        echo -e "\nTable name cannot contain spaces\n"
        continue
  fi

  if [ -f "$table_name.table" ]; then
        echo -e "\nThis table name already exists\n"
        continue
  fi

  if [[ "$table_name" == [a-zA-Z]* ]]; then
        
        read -r -p "Please enter your columns number: " col_num
        
        if [[ ! $col_num =~ ^[0-9]+$ ]]; then
              echo "Column number must be numeric only"
              continue
        fi

        touch "$table_name" "$table_name.meta"
        echo -e "\nTable created successfully\n"
        

        i=0
        
        while (( i < col_num ))
        do
              col_name   # يفترض أنها function تأخذ اسم العمود
              if [[ $i -ne $((col_num - 1)) ]]; then
              	      echo -n ":" >> "$table_name"
              fi
	      col_type
              if [[ $i -eq 0 ]]; then
                    list=(${list[@]}":pk")
              fi

              i=$(( i + 1 ))
        done

        echo ${list[@]} | tr " " "\n" > "$table_name.meta"
        break
  else
        echo "Table name must start with a letter"
  fi

done
}

createTable
