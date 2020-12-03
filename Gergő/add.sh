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
<<<<<<< HEAD
psql() {
ssh ubuntu@localhost psql -q -t -d tododb <<EOF
$1
EOF
}

add_user() {
psql "insert into \"user\" (name)
      values ('$1');"

=======

add_user() {
ssh ubuntu@localhost psql -q -d tododb <<EOF
insert into "user" (name)
values ('$1');
EOF
>>>>>>> 8035fab1cb5c468001611bef82aaec8860a8e0e5
echo "User added"
}

add_todo() {
<<<<<<< HEAD
result=$(psql "select id from \"user\"
               where name='$1';")

psql "insert into \"todo\" (user_id, task)
      values ($result,'$2');"

=======
result=$(ssh ubuntu@localhost psql -t -A -d tododb <<EOF
select id from "user"
where name='$1';
EOF
)
ssh ubuntu@localhost psql -d tododb <<EOF
insert into "todo" (user_id,task)
values ($result,'$2');
EOF
>>>>>>> 8035fab1cb5c468001611bef82aaec8860a8e0e5
echo "Todo added"
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
