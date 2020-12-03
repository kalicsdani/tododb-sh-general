#!/bin/bash
#
# delete.sh delete-todo <todo-id>
# delete.sh delete-done
#
# Usage:
#    delete.sh delete-todo 99
#    delete.sh delete-done
#
<<<<<<< HEAD
psql() {
ssh ubuntu@localhost psql -q -t -d tododb <<EOF
$1
EOF
}

delete_todo() {
psql "delete from \"todo\" 
      where id="$1";"

=======


delete_todo() {
ssh ubuntu@localhost psql -d tododb <<EOF
delete from "todo" 
where id=$1;
EOF
>>>>>>> 8035fab1cb5c468001611bef82aaec8860a8e0e5
echo "Todo removed"
}

delete_done() {
<<<<<<< HEAD
psql 'delete from "todo" 
where done=True;'

=======
ssh ubuntu@localhost psql -d tododb <<EOF
delete from "todo" 
where done=True;
EOF
>>>>>>> 8035fab1cb5c468001611bef82aaec8860a8e0e5
echo "Done todos removed"
}

main() {
    if [[ "$1" == "delete-todo" ]]
    then
        delete_todo "$2"
    elif [[ "$1" == "delete-done" ]]
    then
        delete_done
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
