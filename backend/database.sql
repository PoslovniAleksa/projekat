CREATE TABLE News (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date TIMESTAMP NOT NULL,
    author VARCHAR(100),
    website_link VARCHAR(255)
);

CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(200) NOT NULL
);

INSERT INTO News (name, date, author, website_link) 
VALUES 
    ('Breaking News 1', '2024-07-11 10:00:00', 'John Doe', 'http://example.com/news1'),
    ('Important Update', '2024-07-10 15:30:00', 'Jane Smith', 'http://example.com/update'),
    ('Exclusive Interview', '2024-07-09 14:00:00', 'Mike Johnson', 'http://example.com/interview'),
    ('Latest Development', '2024-07-08 12:00:00', 'Emily Brown', 'http://example.com/development'),
    ('Special Report', '2024-07-07 09:45:00', 'Chris Lee', 'http://example.com/report'),
    ('GitHub', '2024-07-07 09:45:00', 'Aleksa', 'https://github.com');

-- Sample rows
INSERT INTO News (name, date, author, website_link) VALUES
    ('Breaking News', '2024-07-12 09:00:00', 'John Doe', 'https://example.com/news/breaking'),
    ('Tech Update', '2024-07-11 15:30:00', 'Jane Smith', 'https://example.com/news/tech-update'),
    ('Sports Report', '2024-07-10 18:45:00', 'Mike Johnson', 'https://example.com/news/sports-report'),
    ('World Affairs', '2024-07-09 12:00:00', 'Emily White', 'https://example.com/news/world-affairs'),
    ('Finance News', '2024-07-08 10:15:00', 'David Brown', 'https://example.com/news/finance'),
    ('Health Watch', '2024-07-07 11:20:00', 'Sarah Green', 'https://example.com/news/health-watch'),
    ('Entertainment Buzz', '2024-07-06 14:00:00', 'Michael Lee', 'https://example.com/news/entertainment-buzz'),
    ('Local Events', '2024-07-05 16:30:00', 'Jessica Taylor', 'https://example.com/news/local-events'),
    ('Science Update', '2024-07-04 09:45:00', 'Andrew Clark', 'https://example.com/news/science-update'),
    ('Opinion Piece', '2024-07-03 13:10:00', 'Rachel Adams', 'https://example.com/news/opinion-piece');


