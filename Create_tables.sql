CREATE TABLE IF NOT EXISTS Artist (
    id serial PRIMARY KEY,
    artist_name varchar(20) UNIQUE NOT NULL
);
   
CREATE TABLE IF NOT EXISTS Genre (
    id serial PRIMARY KEY,
    genre_name varchar(80) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS Album (
    id serial PRIMARY KEY,
    album_name varchar(30) UNIQUE NOT NULL,
    release_year integer NOT NULL
);
CREATE TABLE IF NOT EXISTS Genre_Artist (
    artist_id integer REFERENCES Artist(id),
    genre_id integer REFERENCES Genre(id),
    CONSTRAINT pk PRIMARY KEY(artist_id,genre_id)
);

CREATE TABLE IF NOT EXISTS Album_artist(
    artist_id integer REFERENCES Artist(id),
    album_id integer REFERENCES Album(id),
    CONSTRAINT pk1 PRIMARY KEY(artist_id,album_id)
);
CREATE TABLE IF NOT EXISTS Songs (
    id serial PRIMARY KEY,
    duration float NOT NULL,
    song_name varchar(30) UNIQUE NOT NULL,
    album_id integer REFERENCES Album(id) 
);
CREATE TABLE IF NOT EXISTS Compilation(
    id serial PRIMARY KEY,
    compilation_name varchar(30) UNIQUE NOT NULL,
    release_year integer NOT NULL
);

CREATE TABLE IF NOT EXISTS comp_song (
	song_id integer REFERENCES Songs(id),
	comp_id integer REFERENCES Compilation(id),
	CONSTRAINT pk2 PRIMARY KEY(song_id,comp_id)
);

