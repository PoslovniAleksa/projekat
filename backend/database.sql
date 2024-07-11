CREATE TABLE News (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date TIMESTAMP NOT NULL,
    author VARCHAR(100),
    website_link VARCHAR(255)
);

-- INSERT INTO News (name, date, author, website_link) 
-- VALUES 
--     ('Breaking News 1', '2024-07-11 10:00:00', 'John Doe', 'http://example.com/news1'),
--     ('Important Update', '2024-07-10 15:30:00', 'Jane Smith', 'http://example.com/update'),
--     ('Exclusive Interview', '2024-07-09 14:00:00', 'Mike Johnson', 'http://example.com/interview'),
--     ('Latest Development', '2024-07-08 12:00:00', 'Emily Brown', 'http://example.com/development'),
--     ('Special Report', '2024-07-07 09:45:00', 'Chris Lee', 'http://example.com/report'),
--     ('GitHub', '2024-07-07 09:45:00', 'Aleksa', 'https://github.com');


