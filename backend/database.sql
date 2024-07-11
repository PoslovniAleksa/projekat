CREATE DATABASE Test;

CREATE TABLE News (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date TIMESTAMP NOT NULL,
    author VARCHAR(100),
    website_link VARCHAR(255)
);




