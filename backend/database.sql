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

-- Generate 50 rows of sample data for the News table

-- Inserting data into the News table
INSERT INTO News (name, date, author, website_link) 
VALUES 
    ('Breaking News 1', '2024-07-01 08:00:00', 'John Doe', 'https://example.com/news1'),
    ('Latest Update', '2024-07-02 12:30:00', 'Jane Smith', 'https://example.com/news2'),
    ('Important Announcement', '2024-07-03 10:15:00', 'Michael Johnson', 'https://example.com/news3'),
    ('Exclusive Interview', '2024-07-04 14:45:00', 'Emily Brown', 'https://example.com/news4'),
    ('Special Report', '2024-07-05 11:20:00', 'David Wilson', 'https://example.com/news5'),
    ('Top Story of the Day', '2024-07-06 09:00:00', 'Jessica Lee', 'https://example.com/news6'),
    ('Major Event Coverage', '2024-07-07 15:00:00', 'Chris Turner', 'https://example.com/news7'),
    ('Local News Update', '2024-07-08 13:10:00', 'Sarah Adams', 'https://example.com/news8'),
    ('Exclusive Feature', '2024-07-09 10:45:00', 'Kevin Clark', 'https://example.com/news9'),
    ('Market Analysis', '2024-07-10 16:30:00', 'Lisa Martinez', 'https://example.com/news10'),
    ('Political Commentary', '2024-07-11 14:00:00', 'Andrew White', 'https://example.com/news11'),
    ('Technology Review', '2024-07-12 12:20:00', 'Rachel Green', 'https://example.com/news12'),
    ('Cultural Insights', '2024-07-13 11:40:00', 'Jason Taylor', 'https://example.com/news13'),
    ('Opinion Piece', '2024-07-14 09:30:00', 'Amanda Carter', 'https://example.com/news14'),
    ('Global Affairs Update', '2024-07-15 08:15:00', 'Eric Hall', 'https://example.com/news15'),
    ('Financial News Brief', '2024-07-16 07:45:00', 'Karen Scott', 'https://example.com/news16'),
    ('Health Report', '2024-07-17 17:00:00', 'Daniel Brown', 'https://example.com/news17'),
    ('Environmental Update', '2024-07-18 16:10:00', 'Michelle Adams', 'https://example.com/news18'),
    ('Sports Recap', '2024-07-19 14:50:00', 'Mark Wilson', 'https://example.com/news19'),
    ('Entertainment Buzz', '2024-07-20 12:00:00', 'Laura Garcia', 'https://example.com/news20'),
    ('Fashion Trends', '2024-07-21 10:30:00', 'Steven Davis', 'https://example.com/news21'),
    ('Science Breakthrough', '2024-07-22 09:20:00', 'Jessica Turner', 'https://example.com/news22'),
    ('Business Update', '2024-07-23 08:40:00', 'Michael Carter', 'https://example.com/news23'),
    ('Educational Feature', '2024-07-24 07:00:00', 'Emily White', 'https://example.com/news24'),
    ('Travel Highlights', '2024-07-25 18:00:00', 'David Adams', 'https://example.com/news25'),
    ('Food and Drink Review', '2024-07-26 16:30:00', 'Julia Johnson', 'https://example.com/news26'),
    ('Technology Trends', '2024-07-27 15:20:00', 'Samuel Wilson', 'https://example.com/news27'),
    ('Political Analysis', '2024-07-28 13:50:00', 'Sophia Clark', 'https://example.com/news28'),
    ('Health and Wellness', '2024-07-29 12:15:00', 'William Taylor', 'https://example.com/news29'),
    ('Environmental Impact', '2024-07-30 10:50:00', 'Olivia Martinez', 'https://example.com/news30'),
    ('Sports Feature', '2024-07-31 09:30:00', 'Daniel Green', 'https://example.com/news31'),
    ('Entertainment Update', '2024-08-01 08:20:00', 'Alex Harris', 'https://example.com/news32'),
    ('Fashion Report', '2024-08-02 07:10:00', 'Sophie Turner', 'https://example.com/news33'),
    ('Science Discovery', '2024-08-03 19:00:00', 'Matthew Baker', 'https://example.com/news34'),
    ('Business Insights', '2024-08-04 17:30:00', 'Anna Davis', 'https://example.com/news35'),
    ('Educational News', '2024-08-05 16:00:00', 'Robert Wilson', 'https://example.com/news36'),
    ('Travel Tips', '2024-08-06 14:40:00', 'Emma Adams', 'https://example.com/news37'),
    ('Food Trends', '2024-08-07 12:50:00', 'Lucas Clark', 'https://example.com/news38'),
    ('Technology Review', '2024-08-08 11:30:00', 'Lily White', 'https://example.com/news39'),
    ('Political Developments', '2024-08-09 10:00:00', 'Noah Taylor', 'https://example.com/news40'),
    ('Health Updates', '2024-08-10 09:15:00', 'Ella Martinez', 'https://example.com/news41'),
    ('Environmental Concerns', '2024-08-11 08:00:00', 'James Harris', 


