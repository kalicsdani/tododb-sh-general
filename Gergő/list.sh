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
   ssh ubuntu@localhost psql -d tododb <<EOF
SELECT * FROM "user";
EOF
}

list_todos() {
  ssh ubuntu@localhost psql -d tododb <<EOF
SELECT * FROM "todo";
EOF
}


list_user_todos() {
 ssh ubuntu@localhost psql -d tododb <<EOF
select * from todo
join "user" on "user".id= todo.user_id
where "user".name = '$1';
EOF
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
