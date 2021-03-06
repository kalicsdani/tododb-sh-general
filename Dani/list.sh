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
    psql -d ubuntu <<EOF
SELECT * FROM "user"
EOF
}

list_todos() {
    psql -d ubuntu <<EOF
SELECT * FROM "todo"
EOF
}

list_user_todos() {
    psql -d ubuntu <<EOF
SELECT name, task, done
FROM "user"
INNER JOIN todo ON "user".id = todo.user_id
WHERE name = '$1';
EOF
}

main1() {
    if [[ -z "$1" ]]
    then
        echo "Please add a parameter! Use one of the following: 'list-users', 'list-todos', 'list-user-todos [name]'." && exit 1
    elif [[ "$1" != "list-users" && "$1" != "list-todos" && "$1" != "list-user-todos" ]]
    then
        echo "No such parameter! Use one of the following: 'list-users', 'list-todos', 'list-user-todos [name]'." 
    elif [[ "$1" == "list-users" ]]
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
    main1 "$@"
fi
