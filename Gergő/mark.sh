#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#
psql() {
ssh ubuntu@localhost psql -q -t -d tododb <<EOF
$1
EOF
}

mark_todo() {
psql "update \"todo\"
      set done=true
      where id='$1';"

Echo "Marked as done"
}

unmark_todo() {
psql "update \"todo\"
set done=false
where id='$1';"

Echo "Marked as *not* done"
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
