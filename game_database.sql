-- Active: 1740637116347@@127.0.0.1@3306@Game

create DATABASE Game;

CREATE table players(
   email varchar(50),
   player_id varchar(20) PRIMARY KEY,
   user_name varchar(50) NOT null,
   gender char(1) NOT NULL,
   birth_date date NOT null,
   registion_date date NOT NULL
  
);

desc `Player`;

create table characters(
   char_id varchar(20) PRIMARY KEY,
   name varchar(20) NOT NULL,
   type varchar(10) NOT NULL,
   release_date date NOT NULL
); 

desc `Characters`;

create table skills(
   skill_id varchar(20) PRIMARY KEY,
   name varchar(20) NOT NULL,
   description text NOT NULL
);

desc `Skill`


create table char_skills(
   char_id varchar(20) NOT NULL,
   char_level int NOT NULL,
   skill_id varchar(20) NOT NULL,
   PRIMARY KEY(char_id,char_level),
   FOREIGN KEY(char_id) REFERENCES characters(char_id),
   FOREIGN KEY(skill_id) REFERENCES skills(skill_id)
);

create table char_skill_default(
      char_id varchar(20) PRIMARY KEY,
      default_skill boolean NOT NULL,
      FOREIGN KEY (char_id) REFERENCES characters(char_id)
);

create table own_char(
   player_id varchar(20),
   char_id varchar(20),
   own_char_level int NOT NULL,
   acquire_date date NOT NULL,
   PRIMARY KEY(player_id,char_id),
   FOREIGN key(player_id) REFERENCES players(player_id),
   FOREIGN key(char_id,own_char_level) REFERENCES char_skills(char_id,char_level)
);

create table login_activity(
     login_activity_id varchar(20) PRIMARY KEY,
     player_id varchar(20) NOT NULL,
     ip_address varchar(50) NOT NULL,
     device text NOT NULL,
     login_time time NOT NULL,
     logout_time time NOT NULL,
     FOREIGN KEY (player_id) REFERENCES players(player_id)
);

create table inventory_item(
       item_id varchar(20) PRIMARY KEY,
       name varchar(20) NOT NULL,
       description text NOT NULL,
       category text NOT NULL
);

create table orders(
      order_id varchar(20) PRIMARY KEY,
      player_id varchar(20) NOT NULL,
      order_date date NOT NULL,
      FOREIGN KEY (player_id) REFERENCES players(player_id)
);

create table order_detail(
      order_id varchar(20) PRIMARY KEY,
      item_id varchar(20) NOT NULL,
      amount int NOT NULL,
      FOREIGN KEY (order_id) REFERENCES orders(order_id),
      FOREIGN KEY (item_id) REFERENCES inventory_item(item_id)

);
create table own_inventory_item(
   player_id varchar(20),
   item_id varchar(20),
   amount int,
   PRIMARY KEY(player_id,item_id)
);

create table level(
    level_id varchar(20) PRIMARY KEY,
    name varchar(20) NOT NULL,
    difficulty text NOT NULL
);

create table attempt_level(
     attempt_id varchar(20) PRIMARY KEY,
     player_id varchar(20) NOT NULL,
     level_id varchar(20) NOT NULL,
     is_win boolean NOT NULL,
     start_time time NOT NULL,
     end_time time NOT NULL,
     FOREIGN KEY (player_id)REFERENCES players(player_id),
     FOREIGN KEY(level_id) REFERENCES levels(level_id)
);

create table next_level(
     player_id varchar(20) PRIMARY KEY,
     next_level_id varchar(20) NOT NULL,
     FOREIGN KEY(player_id) REFERENCES players(player_id),
     FOREIGN KEY(next_level_id) REFERENCES levels(level_id)
);

create table level_rewards(
    level_id varchar(20),
    item_id varchar(20),
    amount int NOT NULL,
    PRIMARY KEY(level_id,item_id),
    FOREIGN KEY(level_id) REFERENCES levels(level_id),
    FOREIGN KEY(item_id) REFERENCES inventory_item(item_id)
);

create table events(
   event_id varchar(20) PRIMARY KEY,
   name varchar(10) NOT NULL,
   start_date date NOT NULL,
   end_date date NOT NULL

);

create table participate_events(
     player_id varchar(20) PRIMARY KEY,
     event_id varchar(20) PRIMARY KEY,
     complete_status BOOLEAN NOT NULL,
     join_date date NOT NULL,
     rank int NOT NULL,
     reward_status boolean NOT NULL,
     PRIMARY KEY (player_id,event_id),
     FOREIGN KEY(player_id) REFERENCES players(player_id),
     FOREIGN KEY(event_id) REFERENCES events(event_id)

);

create table event_rewards(
     event_id varchar(20),
     item_id varchar(20),
     amount int,
     PRIMARY KEY(event_id,item_id),
     FOREIGN KEY (event_id) REFERENCES events(event_id),
     Foreign Key (item_id) REFERENCES inventory_item(item_id)
     
);

create table bug_reports(
    report_id varchar(20) PRIMARY KEY,
    player_id varchar(20),
    submit_date date NOT NULL,
    description text NOT NULL,
    Foreign Key (player_id) REFERENCES players(player_id)
)

create table inventory_store(
   package_id varchar(20) PRIMARY KEY,
   price int
);
ALTER TABLE inventory_store ADD COLUMN package_name;

 create table package_detail(
   package_id varchar(20),
   item_id varchar(20),
   amount int,
   FOREIGN KEY(package_id) REFERENCES inventory_store(package_id),
   FOREIGN KEY(item_id) REFERENCES inventory_item(item_id)
 );

 create table orders(
   order_id varchar(20) PRIMARY KEY,
   player_id varchar(20),
   package_id varchar(20),
   amount int,
   total_price DOUBLE,
   order_date date,
   FOREIGN KEY (player_id) REFERENCES players(player_id),
   Foreign Key (package_id) REFERENCES inventory_store(package_id)
 )
