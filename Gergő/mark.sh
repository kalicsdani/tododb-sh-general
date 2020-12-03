#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#
<<<<<<< HEAD
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

=======

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
>>>>>>> 8035fab1cb5c468001611bef82aaec8860a8e0e5
Echo "Marked as *not* done"
}



main() {
 if [[ "$1" == "mark-todo" ]]
    then
<<<<<<< HEAD
        mark_todo "$2"
    elif [[ "$1" == "unmark-todo" ]]
    then
        unmark_todo "$2"
=======
        marktodo "$2"
    elif [[ "$1" == "unmark-todo" ]]
    then
        unmarktodo "$2"
>>>>>>> 8035fab1cb5c468001611bef82aaec8860a8e0e5
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
