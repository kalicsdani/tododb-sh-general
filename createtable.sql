create table "user"(
id serial primary key,
name varchar(50) not null unique
)
;
create table "todo"(
id serial primary key,
task varchar(100),
user_id int,
done boolean default 'false',
foreign key (user_id) references "user"(id)
);