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
    if  [ -z $1 ]
    then 
        echo "Missing ID!"
    else
        psql -d tododbsh  <<EOF
        delete  FROM todo where id = '$1' ;
EOF
    fi
    echo $1
}

delete_done() {
    psql -d tododbsh  <<EOF
    delete  FROM todo where done = 'true';
EOF
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
