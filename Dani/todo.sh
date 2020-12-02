#!/bin/bash

source list.sh
source add.sh
source mark.sh
source delete.sh


if [[ "$1" == "list-users" || "$1" == "list-todos" || "$1" == "list-user-todos" ]]
then
    main1 "$1" "$2"
elif [[ "$1" == "add-user" || "$1" == "add-todo" ]]
then
    main2 "$1" "$2"
elif [[ "$1" == "mark-todo" || "$1" == "unmark-todo" ]]
then
    main3 "$1" "$2"
elif [[ "$1" == "delete-todo" || "$1" == "delete-done" ]]
then
    main4 "$1" "$2"
fi
