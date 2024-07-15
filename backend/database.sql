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

INSERT INTO News (name, date, author, website_link) VALUES
    ('Latest Updates on COVID-19', '2024-07-15 08:00:00', 'Health News Team', 'https://example.com/news1'),
    ('Tech Innovations in AI', '2024-07-14 15:30:00', 'Tech Insider', 'https://example.com/news2'),
    ('Global Economy Report', '2024-07-14 12:45:00', 'Economic Times', 'https://example.com/news3'),
    ('Political Unrest in Eastern Europe', '2024-07-13 18:20:00', 'World News Network', 'https://example.com/news4'),
    ('New Discoveries in Space Exploration', '2024-07-12 10:00:00', 'Space News Weekly', 'https://example.com/news5'),
    ('Breaking: Market Crash Analysis', '2024-07-11 16:50:00', 'Finance Today', 'https://example.com/news6'),
    ('Interview with Nobel Prize Winner', '2024-07-10 09:15:00', 'Science Journal', 'https://example.com/news7'),
    ('Sports Highlights of the Week', '2024-07-09 14:00:00', 'Sports News HQ', 'https://example.com/news8'),
    ('Artificial Intelligence Ethics Debate', '2024-07-08 11:30:00', 'Ethics Watch', 'https://example.com/news9'),
    ('Health Tips for Summer Season', '2024-07-07 07:00:00', 'Health & Wellness', 'https://example.com/news10');

INSERT INTO News (name, date, author, website_link) VALUES
    ('Latest Updates on COVID-19', '2024-07-14 08:00:00', 'Health News Team', 'https://example.com/news1'),
    ('Tech Innovations in AI', '2024-07-13 15:30:00', 'Tech Insider', 'https://example.com/news2'),
    ('Global Economy Report', '2024-07-12 12:45:00', 'Economic Times', 'https://example.com/news3'),
    ('Political Unrest in Eastern Europe', '2024-07-11 18:20:00', 'World News Network', 'https://example.com/news4'),
    ('New Discoveries in Space Exploration', '2024-07-10 10:00:00', 'Space News Weekly', 'https://example.com/news5'),
    ('Breaking: Market Crash Analysis', '2024-07-09 16:50:00', 'Finance Today', 'https://example.com/news6'),
    ('Interview with Nobel Prize Winner', '2024-07-08 09:15:00', 'Science Journal', 'https://example.com/news7'),
    ('Sports Highlights of the Week', '2024-07-07 14:00:00', 'Sports News HQ', 'https://example.com/news8'),
    ('Artificial Intelligence Ethics Debate', '2024-07-06 11:30:00', 'Ethics Watch', 'https://example.com/news9'),
    ('Health Tips for Summer Season', '2024-07-05 07:00:00', 'Health & Wellness', 'https://example.com/news10');

INSERT INTO News (name, date, author, website_link) VALUES
    ('COVID-19 Vaccine Rollout Progress', '2024-07-15 08:00:00', 'Health Watch Team', 'https://example.com/news1'),
    ('Advancements in Quantum Computing', '2024-07-14 15:30:00', 'Tech Buzz', 'https://example.com/news2'),
    ('Impact of Global Trade Policies', '2024-07-13 12:45:00', 'Global Insights', 'https://example.com/news3'),
    ('Environmental Policies in Europe', '2024-07-12 18:20:00', 'Environmental News Network', 'https://example.com/news4'),
    ('Mars Rover Latest Discoveries', '2024-07-11 10:00:00', 'Space Exploration Today', 'https://example.com/news5'),
    ('Stock Market Analysis: Trends and Predictions', '2024-07-10 16:50:00', 'Market Insights', 'https://example.com/news6'),
    ('Breakthroughs in Medical Research', '2024-07-09 09:15:00', 'Medical News Now', 'https://example.com/news7'),
    ('Football Championship Highlights', '2024-07-08 14:00:00', 'Sports Recap', 'https://example.com/news8'),
    ('Ethical Implications of AI Technology', '2024-07-07 11:30:00', 'Ethics Forum', 'https://example.com/news9'),
    ('Healthy Eating Tips for Summer', '2024-07-06 07:00:00', 'Nutrition Matters', 'https://example.com/news10');

INSERT INTO News (name, date, author, website_link) VALUES
    ('COVID-19 Vaccine Rollout Progress', '2024-07-15 08:00:00', 'Health Watch Team', 'https://example.com/news1'),
    ('Advancements in Quantum Computing', '2024-07-14 15:30:00', 'Tech Buzz', 'https://example.com/news2'),
    ('Impact of Global Trade Policies', '2024-07-13 12:45:00', 'Global Insights', 'https://example.com/news3'),
    ('Environmental Policies in Europe', '2024-07-12 18:20:00', 'Environmental News Network', 'https://example.com/news4'),
    ('Mars Rover Latest Discoveries', '2024-07-11 10:00:00', 'Space Exploration Today', 'https://example.com/news5'),
    ('Stock Market Analysis: Trends and Predictions', '2024-07-10 16:50:00', 'Market Insights', 'https://example.com/news6'),
    ('Breakthroughs in Medical Research', '2024-07-09 09:15:00', 'Medical News Now', 'https://example.com/news7'),
    ('Football Championship Highlights', '2024-07-08 14:00:00', 'Sports Recap', 'https://example.com/news8'),
    ('Ethical Implications of AI Technology', '2024-07-07 11:30:00', 'Ethics Forum', 'https://example.com/news9'),
    ('Healthy Eating Tips for Summer', '2024-07-06 07:00:00', 'Nutrition Matters', 'https://example.com/news10');

INSERT INTO News (name, date, author, website_link) VALUES
    ('Breakthrough in Renewable Energy', '2023-11-25 09:30:00', 'Energy Innovations Team', 'https://example.com/news1'),
    ('New Trends in Smartphone Technology', '2023-12-03 14:45:00', 'Tech Trends', 'https://example.com/news2'),
    ('Global Health Crisis Management Strategies', '2023-12-11 11:00:00', 'Health Strategies Group', 'https://example.com/news3'),
    ('Political Developments in South America', '2023-12-20 17:20:00', 'World Affairs Insight', 'https://example.com/news4'),
    ('Space Exploration: Mars Mission Updates', '2023-12-28 08:00:00', 'Space Exploration Updates', 'https://example.com/news5'),
    ('Financial Market Analysis: Year-end Review', '2024-01-05 16:30:00', 'Financial Insights', 'https://example.com/news6'),
    ('Interview with Nobel Prize Winner in Physics', '2024-01-14 10:15:00', 'Science Today', 'https://example.com/news7'),
    ('Highlights from the Soccer World Cup', '2024-01-22 13:00:00', 'Sports Coverage', 'https://example.com/news8'),
    ('Ethics Debate: AI and Privacy Concerns', '2024-01-30 15:45:00', 'Ethics in Technology', 'https://example.com/news9'),
    ('Healthy Living Tips for the New Year', '2024-02-08 07:45:00', 'Health Insights', 'https://example.com/news10');



