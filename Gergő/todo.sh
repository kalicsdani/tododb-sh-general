#!/bin/bash

psql() {
ssh ubuntu@localhost psql -q -t -d tododb <<EOF
$1
EOF

if [ $? -eq 0 ]
then
    echo "A kérést sikeresen teljesítettem."
else 
    echo "Nem teljesült a kérésed!"
fi
}

##############################################
list_users() {
    psql 'SELECT * FROM "user";'
}

list_todos() {
    psql 'SELECT * FROM "todo";'
}

list_user_todos() {
    psql "SELECT * FROM todo
          JOIN \"user\" ON \"user\".id= todo.user_id
          WHERE \"user\".name = '$1';"
}

#############
add_user() {
    psql "INSERT INTO \"user\" (name)
          VALUES ('$1');"

    echo "User added"
}

add_todo() {
    result=$(psql "SELECT id FROM \"user\"
                   WHERE name='$1';")

    psql "INSERT INTO \"todo\" (user_id, task)
          VALUES ($result,'$2');"

    echo "Todo added"
}
#############
delete_todo() {
    psql "DELETE FROM \"todo\" 
          WHERE id="$1";"

    echo "Todo removed"
}

delete_done() {
    psql 'DELETE FROM "todo" 
          WHERE done=True;'

    echo "Done todos removed"
}
##############
mark_todo() {
    psql "UPDATE \"todo\"
          SET done=true
          WHERE id='$1';"

    Echo "Marked as done"
}

unmark_todo() {
    psql "UPDATE \"todo\"
          SET done=false
          WHERE id='$1';"

    Echo "Marked as *not* done"
}


##############################################
main() {
  case $1 in

    list-users)
        list_users
        ;;

    list-todos)
        list_todos
        ;;

    list-user-todos)
        If [ -z $2 ]
        then
            echo "Add meg a lekérdezni kívánt felhasználó nevét!"
        else
            list_user_todos "$2"
        fi
        ;;

    add-user)
        add_user "$2"
        ;;

    add-todo)
        add_todo "$2" "$3"
        ;;

    delete-todo)
        delete_todo "$2"
        ;;
 
    delete-done)
        delete_done
        ;;
    
    mark-todo)
        mark_todo "$2"
        ;;

    unmark-todo)
        unmark_todo "$2"
        ;;    

    *)
    echo -n "Rosszul adtad meg a(z) $1 paramétert!"
    ;;
esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
else 
    echo "Valami nem jó"
fi

