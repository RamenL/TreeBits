--How to execute these commands
--cd /home/team/spr18/code/servd
--su sysadmin
--sudo -u postgres psql postgres

--Exit postgres with "\q"

--exit sysadmin user with "exit"

--rake db:migrate


CREATE TABLE users(
   username TEXT PRIMARY KEY, -- email of user
   password TEXT NOT NULL,
   salt TEXT NOT NULL,
   is_admin BOOLEAN NOT NULL,
   UNIQUE(username)
);

CREATE TABLE volunteers(
   PRIMARY KEY (username),
   name TEXT NOT NULL
) INHERITS (users);

CREATE TABLE organizations(
   PRIMARY KEY (username),
   name TEXT UNIQUE NOT NULL,
   description TEXT,
   contact_email TEXT,
   phone VARCHAR(14),
   address TEXT,
   city TEXT,
   state TEXT,
   zip TEXT,
   link TEXT,
   approved BOOLEAN NOT NULL DEFAULT FALSE,
   reviewed BOOLEAN  NOT NULL DEFAULT FALSE
) INHERITS (users);


CREATE TABLE events(
   id SERIAL PRIMARY KEY,
   name TEXT NOT NULL,
   time TIME NOT NULL,
   date DATE NOT NULL,
   address TEXT,
   city TEXT,
   state TEXT,
   zip TEXT,
   needsTransportation BOOLEAN,
   link TEXT,
   username TEXT NOT NULL REFERENCES organizations(username),
   UNIQUE(id)
);

CREATE TABLE tags (
   name TEXT PRIMARY KEY,
   UNIQUE(name)
);

CREATE TABLE volunteers_events (
   username TEXT REFERENCES volunteers(username) ON UPDATE CASCADE ON DELETE CASCADE,
   event_id INT REFERENCES events(id) ON UPDATE CASCADE ON DELETE CASCADE,
   PRIMARY KEY (username, event_id)
);

CREATE TABLE organizations_tags (
   username TEXT REFERENCES organizations(username) ON UPDATE CASCADE ON DELETE CASCADE,
   tag_id TEXT REFERENCES tags(name) ON UPDATE CASCADE ON DELETE CASCADE,
   PRIMARY KEY (username, tag_id)
);

CREATE TABLE events_tags (
   id INT REFERENCES events(id) ON UPDATE CASCADE ON DELETE CASCADE,
   tag_id TEXT REFERENCES tags(name) ON UPDATE CASCADE ON DELETE CASCADE,
   PRIMARY KEY (id, tag_id)
);
