#!/bin/bash
#
# add.sh add-user <user>
# add.sh add-todo <user> <todo>
#
# Usage:
#    add.sh add-user John
#    add.sh add-user Paul
#    add.sh add-todo John Meeting
#    add.sh add-todo Paul "Make breakfast"
#

add_user() {
     if [ -z $1 ]
     then 
        echo "Missing name!"
     else  
        add_user_result=$(psql 2> /dev/null -d tododbsh -q -t -v ON_ERROR_STOP=1 <<EOF
        INSERT INTO "user" (name) VALUES ('$1');
EOF
)   
         
        if [ $? -eq 0 ]  
        then 
            echo "$1 user is added" 
        else
            echo  "$1 user already exist!"
        fi           
    fi
}

add_todo() {
    todo_user_result=$(psql -d tododbsh -q -t -A <<EOF
    SELECT id  FROM "user"
    where name = '$1';
EOF
)
    if [ -z $todo_user_result ]
    then 
        echo "$1 user doesn't exist!"
    else
        if [ -z $2 ]
        then 
            echo "Missing task!"
        else
            psql -d tododbsh -q -t <<EOF
            INSERT INTO "todo" (task,user_id) VALUES ('$2','$todo_user_result'); 
EOF

        echo "$2 todo is added to $1"
        fi
    fi

}

main() {
    if [[ "$1" == "add-user" ]]
    then
        add_user "$2"
    elif [[ "$1" == "add-todo" ]]
    then
        add_todo "$2" "$3"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
