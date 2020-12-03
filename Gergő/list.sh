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
<<<<<<< HEAD
psql() {
result=$(ssh ubuntu@localhost psql -q -t -d tododb -v ON_ERROR_STOP=1 2>&1<<EOF
$1
EOF
)


if [ -z $result ]
then
    echo "Nem sikerült az adatbázis-lekérdezés!"
else 
    echo $result
fi

if [ $? -eq 0 ]
then
    echo "A kérést sikeresen teljesítettem."
else 
    echo "Nem teljesült a kérésed!"
fi
}

list_users() {
psql 'SELECT * FROM "usera";'
}

list_todos() {
psql 'SELECT * FROM "todo";'
}

list_user_todos() {
psql "select * from todo
          join \"user\" on \"user\".id= todo.user_id
          where \"user\".name = '$1';"
=======

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
>>>>>>> 8035fab1cb5c468001611bef82aaec8860a8e0e5
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
<<<<<<< HEAD
    else 
    echo "Hibás a $1 paraméter!"
=======
>>>>>>> 8035fab1cb5c468001611bef82aaec8860a8e0e5
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
<<<<<<< HEAD
else 
    echo "Hibás paramétereket adtál meg!"
=======
>>>>>>> 8035fab1cb5c468001611bef82aaec8860a8e0e5
fi
