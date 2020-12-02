#!/bin/bash
#
# delete.sh delete-todo <todo-id>
# delete.sh delete-done
#
# Usage:
#    delete.sh delete-todo 99
#    delete.sh delete-done
#


delete_todo() {
ssh ubuntu@localhost psql -d tododb <<EOF
delete from "todo" 
where id=$1;
EOF
echo "Todo removed"
}

delete_done() {
ssh ubuntu@localhost psql -d tododb <<EOF
delete from "todo" 
where done=True;
EOF
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
