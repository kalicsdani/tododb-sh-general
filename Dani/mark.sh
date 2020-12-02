#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#
set -e

mark_todo() {
a=$(psql -d ubuntu -tqA -v ON_ERROR_STOP=on<<EOF
SELECT done
FROM todo
WHERE id='$1';
EOF
echo "$a"
)
if [[ "$a" = 't' ]]; then #[ "$a" -n ] && 
    echo "Task #$1 is already set to done..."&& exit 0 
fi
    psql -d ubuntu -tq -v ON_ERROR_STOP=on<<EOF
UPDATE todo
SET done=true
WHERE id='$1';
EOF
marktodooutput=$?
if [ "$marktodooutput" -eq 0 ]; then
  echo "Task #$1 marked as done!"
fi
}

unmark_todo() {
a=$(psql -d ubuntu -tqA -v ON_ERROR_STOP=on<<EOF
SELECT done
FROM todo
WHERE id='$1';
EOF
)
if [[ "$a" == 'f' ]]; then
    echo "Task #$1 is already set to undone..."&& exit 0
fi
    psql -d ubuntu -tq -v ON_ERROR_STOP=on<<EOF
UPDATE todo
SET done=false
WHERE id='$1';
EOF
marktodooutput=$?
if [ "$marktodooutput" -eq 0 ]; then
  echo "Task #$1 marked as undone!"
fi
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
