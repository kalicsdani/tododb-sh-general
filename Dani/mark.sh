#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#
#set -e

mark_todo() {
a=$(psql -d ubuntu -tqA -v ON_ERROR_STOP=on<<EOF
SELECT done
FROM todo
WHERE id='$1';
EOF
)
if [[ "$a" = 't' ]]
then    
    echo "Task #$1 is already set to done..." && exit 1 
elif [[ -z "$a" ]]
then
    echo "Task #$1 is not existing...choose another one." && exit 1
fi
    psql -d ubuntu -tq -v ON_ERROR_STOP=on<<EOF
UPDATE todo
SET done=true
WHERE id='$1';
EOF
if [ "$?" -eq 0 ]; then
  echo "Task #$1 marked as done!"
fi
}

unmark_todo() {
b=$(psql -d ubuntu -tqA -v ON_ERROR_STOP=on<<EOF
SELECT done
FROM todo
WHERE id='$1';
EOF
)
if [[ "$b" = 'f' ]]
then    
    echo "Task #$1 is already set to undone..." && exit 1 
elif [[ -z "$b" ]]
then
    echo "Task #$1 is not existing...choose another one." && exit 1
fi
    psql -d ubuntu -tq -v ON_ERROR_STOP=on<<EOF
UPDATE todo
SET done=false
WHERE id='$1';
EOF
if [ "$?" -eq 0 ]; then
  echo "Task #$1 marked as undone!"
fi
}

main3() {
    if [[ -z "$2" ]]
    then
        echo "Please add a parameter! Use one of the following: 'mark-todo [task id]', 'unmark-todo [task id]'." && exit 1
    elif [[ "$1" != "mark-todo" && "$1" != "unmark-todo" ]]
    then
        echo "No such parameter! Use one of the following: 'mark-todo [task id]', 'unmark-todo [task id]'."  && exit 1
    elif [[ "$1" == "mark-todo" ]]
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
