#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#
mark_todo() {
    if  [ -z $1 ]
    then 
        echo "Missing ID!"
    else
        psql -d tododbsh  <<EOF
        update todo 
        set done = 'true'
        where id = '$1' ;
EOF
    fi
echo $1
}

unmark_todo() {
    if  [ -z $1 ]
    then 
        echo "Missing ID!"
    else
     psql -d tododbsh  <<EOF
    update todo 
    set done = 'false'
    where id = '$1' ;
EOF
    fi
echo $1
}

main() {
    if [[ "$1" == "mark-todo" ]]
    then
        mark_todo "$2"
    elif [[ "$1" == "unmark-todo" ]]
    then
        unmark_todo "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi

