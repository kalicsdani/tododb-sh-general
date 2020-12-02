# TodoDB.sh

## Story

Your boss is breathing on your team's neck to send him a log of what the team was or is working on *daily*.

Not a problem, you said to him and asked if the team could get a subscription for a paid time-tracking service to track your tasks, but as usual he didn't approve due to *lack of available budget*.

*Typical of him!*

So the team and you've decided that post-its won't do it anymore and you're going to build a *Todo App!* to track your activities with.

## What are you going to learn?

- Using Git to collaborate with your team
- Using `psql` from the terminal to interact with a database
- How to build a complex application which depends on other high-level modules (like `psql`)
- Using functions to *decompose* bigger problems into smaller chunks
- Writing modular shell scripts using the `source` command (or `.` for short)

## Tasks

1. Start and configure a VM with a NAT network adapter.
    - Started a VM loaded and configured with an SSH server and PostgreSQL (either an existing one or a fresh one using [this image](https://github.com/CodecoolBase/short-admin-vms/releases/latest/download/ubuntu-18.04-db.ova))
    - The VM's Network settings are configured with a single _NAT_ adapter
    - Port 22 and 5431 is forwarded between the host and the guest in the VM's NAT network adapter's settings
    - The guest VM's OS is reachable via `ssh` using the `ubuntu` user
    - The PostgreSQL server is accessible from outside the guest and the `ubuntu` database superuser exists with the password `ubuntu`

2. Cerate a new database schema to store users and their tasks in two tables which are in one-to-many relationship.
Use the provided dummy data to seed the database for testing.
    - The `user` table looks like this:
```
+------------+-------------------+
| id(serial) | name(varchar(50)) |
+------------+-------------------+
```
    - The `todo` table looks like this:
```
+------------+--------------------+--------------+---------------+
| id(serial) | task(varchar(100)) | user_id(int) | done(boolean) |
+------------+--------------------+--------------+---------------+
```
    - The `user` and `todo` tables are in one-to-many (1:N) relationship
    - The `name` of users must be unique, no duplicates allowed
    - The `done` column's value should be `false` by default, even if it's not specified in an `INSERT` statement
    - The `id` columns are of `serial` datatype in both tables
    - The tables seeded with the given data from `data.sql`

3. Create a script called `list.sh` that can handle listing users and their tasks from the database using functions.
    - The script contains a `list_users` function
    - The script contains a `list_todos` function
    - The script contains a `list_user_todos` function
    - `./list.sh list-users` displays the `user` table's contents
    - `./list.sh list-todos` displays the `todo` table's contents
    - `./list.sh list-user-todos <user>` displays the contents of the specified user's todos from the `todo` table
    - `./list.sh` (without arguments) doesn't do anything

4. Implement the `list_users` function which lists all users in the `user` table.
    - `list_users` function exists and expects no parameters
    - Successful execution of `list_users` prints the contents of the `user` table

5. Implement the `list_todos` function which lists all todos in the `todo` table.
    - `list_todos` function exists and expects no parameters
    - Successful execution of `list_todos` prints the contents of the `todo` table

6. Implement the `list_user_todos` function which lists all todos of a particular user from the `todo` table.
    - `list_user_todos` function exists and expects 1 parameter: `user`
    - Successful execution of `list_user_todos` prints the contents of the specified user's todos from the `todo` table

7. Create a script called `add.sh` that can handle adding a new user or a new task to the database using functions.
    - The script contains an `add_user` function
    - The script contains an `add_todo` function
    - `./add.sh add-user <user>` inserts the specified user and displays `User added`
    - `./add.sh add-todo <user> <todo>` inserts the specified todo for the specified user and displays: `Todo added`
    - `./add.sh` (without arguments) doesn't do anything

8. Implement the `add_user` function which inserts data into the `user` table using the provided parameter.
    - `add_user` function exists and expects 1 parameter: `user`
    - Successful execution of `add_user` inserts a new user to the `user` tablea and prints `User added`

9. Implement the `add_todo` function which inserts data into the `todo` table using the provided parameters.
    - `add_todo` function exists and expects 2 parameters: `user`, `todo`
    - Successful execution of `add_todo` inserts a new todo to the `todo` table, correctly referencing the owning user and prints `Todo added`

10. Create a script called `mark.sh` that can handle changing a todo's status using functions.
    - The script contains an `mark_todo` function
    - The script contains an `unmark_todo` function
    - `./mark.sh mark-todo <todo-id>` changes the specified todo's status to done and displays `Marked as done`
    - `./mark.sh unmark-todo <todo-id>` changes the specified todo's status to *not* done and displays `Marked as *not* done`
    - `./mark.sh` (without arguments) doesn't do anything

11. Implement the `mark_todo` function which changes a todo's status to be done.
    - `mark_todo` function exists and expects 1 parameter: `todo_id`
    - Successful execution of `mark_todo` marks the specified todo as done and prints `Marked as done`

12. Implement the `unmark_todo` function which changes a todo's status to be *not* done.
    - `unmark_todo` function exists and expects 1 parameter: `todo_id`
    - Successful execution of `unmark_todo` marks the specified todo as *not* done and prints `Marked as *not* done`

13. Create a script called `delete.sh` that can handle removing todos from the database.
    - The script contains a `delete_todo` function
    - The script contains a `delete_done` function
    - `./delete.sh delete-todo <todo-id>` removes the specified todo from the `todo` table and displays `Todo removed`
    - `./delete.sh delete-done` removes done todos from the `todo` table and displays `Done todos removed`
    - `./delete.sh` (without arguments) doesn't do anything

14. Implement the `delete_todo` function which removes a todo from the database.
    - `delete_todo` function exists and expects 1 parameter: `todo_id`
    - Successful execution of `delete_todo` deletes the specified todo and prints `Todo removed`

15. Implement the `delete_done` function which removes todos having a done status from the database.
    - `delete_done` function exists and expects no parameter
    - Successful execution of `delete_done` delete all done todos and prints `Done todos removed`

## General requirements

- Do not implement a menu system, do not make the app interactive (e.g. don't ask for user input)
- Scripts displays an error message and immediately terminate with a nonzero exit code if there's a problem during execution, e.g. running the following should fail if user named *John* doesn't exist yet:

```
$ ./add.sh add-todo John "Playing tennis with Kate"`
User doesn't exist: John
$ echo $?
1
```
- A `todo.sh` script exists that is able to run every function from other scripts like `add.sh`, `list.sh`, etc. in the following fashion:

```
./todo.sh add-user Jack
./todo.sh list-users
./todo.sh add-todo Jack "Driving lesson"
./todo.sh list-todos
```
- Handle arguments containing spaces:

```
./add.sh add-user "John Doe"
```

should insert a user named `John Doe` to the `user` table
- `psql` is used in every script to interact with the database so (a) either use `ssh` to run commands on a remote machine, e.g `ssh ubuntulocalhost psql -c "SELECT VERSION()"` or (b) use a *Shared Folder* in VirtualBox to share your code on the host with the guest and run your scripts *directly* on the guest system, the choice is *yours*, but recommend the latter option

## Hints

- Focus on the *green path* when working on tasks, validate inputs and complex edge-cases only after you're done with the basics!
- Watch out, functions are named using `snake_case`, but scripts must handle arguments using `kebab-case`, e.g. `./list.sh list-user-todos John` instead of `./list.sh list_user_todos John`, although the function inside `list.sh` should be `list_user_todos`
- The table name `user` must be double quoted in SQL commands, since it is a [reserved keyword in PostgreSQL](https://www.postgresql.org/docs/current/sql-keywords-appendix.html)!
- [Be careful when using `"` (double quotes) and `'` single quotes in SQL!](https://stackoverflow.com/questions/1992314/what-is-the-difference-between-single-and-double-quotes-in-sql)
- Use *heredocs* for easier quoting of SQL snippets in your shell scripts, e.g.

  ```sh
  user_id="$(psql -qt ubuntu <<EOF
  SELECT id FROM "user" WHERE name = '$user'
  EOF
  )"
  echo $user_id
  ```

- To capture the output of SQL command ran through `psql` take a look at the `--quiet`/`-q` and `--tuples-only`/`-t` flags
- To discard unwanted error information of commands like `psql` redirect the process' `stderr` stream to `/dev/null`, i.e. this command *without* redirection

  ```sh
  psql <<EOF
  SELECT * FROM "user" WHERE id = cat
  EOF
  ```

  displays an error

  ```text
  ERROR:  column "cat" does not exist
  LINE 1: SELECT * FROM "user" WHERE id = cat
  ```

  but when `stderr` is redirected to `/dev/null`

  ```sh
  psql 2> /dev/null <<EOF
  SELECT * FROM "user" WHERE id = cat
  EOF
  ```

  then there's peace and tranquility, use it wisely!
- When running SQL statements through [`psql` by default it exits with exit code 0](https://stackoverflow.com/questions/37072245/check-return-status-of-psql-command-in-unix-shell-scripting), e.g.

  ```sh
  psql <<EOF
  SELECT * FROM "user" WHERE id = cat
  EOF
  ```

  there's an error, but the exit code is 0

  ```text
  ERROR:  column "cat" does not exist
  LINE 1: SELECT * FROM "user" WHERE id = cat
  $ echo $?
  0
  ```

  if you'd like to receive a non-zero exit code use the flag `--variable ON_ERROR_STOP=1`, e.g.

  ```sh
  psql -v ON_ERROR_STOP=1 <<EOF
  SELECT * FROM "user" WHERE id = cat
  EOF
  ```

  the exit code changes in this case

  ```text
  ERROR:  column "cat" does not exist
  LINE 1: SELECT * FROM "user" WHERE id = cat
  $ echo $?
  3
  ```

## Starting your project



## Background materials

- <i class="far fa-exclamation"></i> [Shell Functions](https://www.tutorialspoint.com/unix/unix-shell-functions.htm)
- <i class="far fa-exclamation"></i> [How to `dot` or `source` Scripts/Functions](https://linuxize.com/post/bash-source-command/)
- <i class="far fa-exclamation"></i> [Passing Arguments to Functions](https://bash.cyberciti.biz/guide/Pass_arguments_into_a_function)
- <i class="far fa-exclamation"></i> [Using `psql` from Shell Script](https://www.folkstalk.com/2014/05/connect-to-postgres-database-in-unix-shell-script.html)
- <i class="far fa-book-open"></i> [Another Tutorial about `psql`](http://postgresguide.com/utilities/psql.html)
- <i class="far fa-book-open"></i> [Manual for `psql`](https://www.postgresql.org/docs/current/app-psql.html)
- <i class="far fa-book-open"></i> [PostgreSQL `DEFAULT` Values](https://www.postgresql.org/docs/current/ddl-default.html)
