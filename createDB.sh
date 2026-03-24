createDatabase(){
reserved_words=("select" "create" "drop" "delete" "insert" "update" "where" "table" "database")


while true
do
    read -p "Enter database name: " dbname

    if ! [[ $dbname =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]
    then
        echo "Invalid name ❌"
        continue
    fi

    is_reserved=false

    for word in "${reserved_words[@]}"
    do
        if [[ "$dbname" == "$word" ]]
        then
            is_reserved=true
            break
        fi
    done

    if [[ $is_reserved == true ]]
    then
        echo "Invalid name ❌ reserved keyword"
        continue
    fi

    if [[ -d "databases/$dbname" ]]
    then
        echo "Database already exists ❌"
        continue
    fi

    mkdir "databases/$dbname"
    echo "Database created successfully ✅"
    break

done
}

createDatabase
