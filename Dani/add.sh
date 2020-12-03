#!/bin/bash
#
# add.sh add-user <user>
# add.sh add-todo <user> <todo>
#
# Usage:
#    add.sh add-user John
#    add.sh add-user Paul
#    add.sh add-todo John Meeting
#    add.sh add-todo Paul "Make breakfast"
#


# ON_ERROR_STOP=on https://stackoverflow.com/questions/58944395/reading-errors-returned-from-psql-in-a-bash-script
# szemét volt, nem kaptam vissza a hibaüzenetet a változóba csak üresen
# muszáj megállítani, különben 

#set -e #megálltja a scriptet ha hiba van

add_user() {

adduseroutput=$(psql -d ubuntu -tq -v ON_ERROR_STOP=on 2>&1 <<EOF
INSERT INTO "user" (name) VALUES ('$1');
EOF
)
if [ -z "$adduseroutput" ]; then
    echo "Name '$1' successfully added!" && exit 0
else
    echo -e "Something went wrong, see details:\n$adduseroutput" && exit 1 # echo -e a newline miatt, különben megjeleníti
fi

}

add_todo() { 
    
useridoutput=$(psql -d ubuntu -tA <<EOF
SELECT id from "user"
WHERE name='$1';
EOF
)

if [ -z "$useridoutput" ]; then
    echo -e "No such user as '$1' available." && exit 1
fi
psql -d ubuntu -tq -v ON_ERROR_STOP=on 2>&1 <<EOF
INSERT INTO "todo" (task,user_id) VALUES ('$2',$useridoutput);
EOF
if [ "$?" = 0 ]; then
    echo "Task '$2' for '$1' successfully added!" && exit 0
fi
}

main2() {
    if [[ -z "$1" ]]
    then
        echo "Please add a parameter! Use one of the following: 'add-user [name]', 'add-todo [name] [task]'." && exit 1
    elif [[ "$1" != "add-user" && "$1" != "add-todo" ]]
    then
        echo "No such parameter! Use one of the following: 'add-user [name]', 'add-todo [name] [task]'."  && exit 1
    elif [[ "$1" == "add-user" ]]
    then
        add_user "$2"
    elif [[ -z "$3" ]]
    then
        echo "Need another parameter (task) for 'add-todo'."  && exit 1
    elif [[ "$1" == "add-todo" ]]
    then
        add_todo "$2" "$3"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
