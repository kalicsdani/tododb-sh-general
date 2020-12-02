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
c=$(psql -d ubuntu -tqA -v ON_ERROR_STOP=on 2>&1 <<EOF
SELECT id FROM todo 
WHERE id='$1';
EOF
)
if [ -z "$c" ]; then
    echo -e "Task #$1 is unavailable." && exit 1
fi
psql -d ubuntu -tqA -v ON_ERROR_STOP=on <<EOF
DELETE FROM todo 
WHERE id='$1';
EOF
echo "Task #$c got removed."
}

delete_done() {
d=$(psql -d ubuntu -tqA -v ON_ERROR_STOP=on 2>&1 <<EOF
SELECT count(id)
FROM todo 
WHERE done='t';
EOF
) #megszámolja, hány true van
if [ "$d" = 0 ]; then
    echo -e "All the done-task are removed already." && exit 1
fi
psql -d ubuntu -tqA -v ON_ERROR_STOP=on <<EOF
DELETE FROM todo 
WHERE done='t';
EOF
echo "All the $d done-task(s) got removed."
}

main4() {
    if [[ -z "$1" ]]
    then
        echo "Please add a parameter! Use one of the following: 'mark-todo [task id]', 'unmark-todo [task id]'." && exit 1
    elif [[ "$1" == "delete-done" ]]
    then
        delete_done
    elif [[ -z "$2" ]]
    then
        echo "Need another parameter (task number) for 'delete-todo'."  && exit 1
    elif [[ "$1" == "delete-todo" ]]
    then
        delete_todo "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi

