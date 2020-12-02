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

set -e #megálltja a scriptet ha hiba van

add_user() {
    psql -d ubuntu -tq -v ON_ERROR_STOP=on<<EOF
INSERT INTO "user" (name) VALUES ('$1');
EOF
adduseroutput=$?
if [ "$adduseroutput" -eq 0 ]; then
  echo "Name successfully added!"
fi
}

add_todo() {
psql -d ubuntu -tq -v ON_ERROR_STOP=on<<EOF
INSERT INTO "user" (name) VALUES ('$1');
EOF
#addusertodooutput=$?

newuserid=$(psql -d ubuntu -tq <<EOF
SELECT id FROM "user" WHERE name = '$1';
EOF
)
psql -d ubuntu -tq -v ON_ERROR_STOP=on<<EOF
INSERT INTO "todo" (task,user_id) VALUES ('$2','$newuserid');
EOF
#addusertodooutput=$?

#if [ "$addusertodooutput" -eq 0 ]; then
  echo "Success! :)"
#fi
}

main() {
    if [[ "$1" == "add-user" ]]
    then
        add_user "$2"
    elif [[ "$1" == "add-todo" ]]
    then
        add_todo "$2" "$3"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
