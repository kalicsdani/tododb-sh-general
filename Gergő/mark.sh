#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#

marktodo() {
ssh ubuntu@localhost psql -d tododb <<EOF
update "todo"
set done=true
where id=$1;
EOF
Echo "Marked as done"
}

unmarktodo() {
ssh ubuntu@localhost psql -d tododb <<EOF
update "todo"
set done=false
where id=$1;
EOF
Echo "Marked as *not* done"
}



main() {
 if [[ "$1" == "mark-todo" ]]
    then
        marktodo "$2"
    elif [[ "$1" == "unmark-todo" ]]
    then
        unmarktodo "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
