#!/bin/bash
regex='A-Za-z'
regex_num='1-9'

add_record(){
    while true
    do
    
	    read -r -p "enter table name : " tname 
	    
	    if [[ -e $tname ]]; then
		    col_num=`awk "END{print NR}" $tname.rows`
		    
		    i=1
		    while (( i <= $col_num ))
		    do
		    declare -a record
		    checkcolname=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $1 }' $tname.rows`
		    checkcolPK=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $2 }' $tname.rows`
		    checkcoltype=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $3 }' $tname.rows`
		    echo "enter your record $checkcolname :"
		    read -r record_
		    if [[ $checkcoltype == 'int' ]] ;
		    then
		     while [[ ! $record_ =~ ^[$regex_num]+$ ]];
		     do
			echo " error [you must enter numbers only] "
			echo "enter your record again"
			read -r record_
			
		    done
		    elif [[ $checkcoltype == 'str' ]];
		    then
		       while  [[ ! $record_ =~ ^[$regex]+$ ]];
		       do
			echo " error [you must enter english char only] "
			echo "enter your record again"
			read -r record_
			
			done
		    fi
		    if [[ $checkcolPK == 'yes' ]];
		    then
		    values=`awk -v var=$i -F : 'BEGIN{ORS=" "} {print $var}' $tname`
		    for item in $values
		    do 
			if  [ $item = $record_ ];
			 then 
			    echo 'primary key must be uniqe '
			    exit
			fi
		    done 
		    fi  
		    record=(${record[@]} $record_ ':')
		    i=$(( $i + 1 ))
		    done
		    echo ${record[@]} >> $tname
		    echo "Record inserted successfully ✔️"

		    break	    
	   else
	   	    echo "table don't exist "
	   	    continue
	   fi
	done       
}


add_record
