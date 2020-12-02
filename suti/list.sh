#!/bin/bash
#
# list.sh list-users
# list.sh list-todos
# list.sh list-user-todos
#
# Usage:
#    list.sh list-users
#    list.sh list-todos Paul
#    list.sh list-user-todos John
#    list.sh list-user-todos "John Doe"
#

list_users() { 
    user_result=$(psql -d tododbsh  -q -t <<EOF
    SELECT * FROM "user"
EOF
)
echo "$user_result"
}

list_todos()  { 
    todo_result=$(psql -d tododbsh -q -t <<EOF
    SELECT * FROM todo;
EOF
)
echo "$todo_result"
}

list_user_todos() {
    todo_user_result=$(psql -d tododbsh -q -t <<EOF
    SELECT "user".name , task , done FROM todo
    JOIN "user" on "user".id = todo.user_id
    where "user".name = '$1';
EOF
)
    if 
    [ -z "$todo_user_result" ]
    then 
        echo " $1 doesn't exist!"
    else
        echo "$todo_user_result"
    fi
}

main() {
    if [[ "$1" == "list-users" ]]
    then
        list_users
    elif [[ "$1" == "list-todos" ]]
    then
        list_todos
    elif [[ "$1" == "list-user-todos" ]]
    then
        list_user_todos "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
