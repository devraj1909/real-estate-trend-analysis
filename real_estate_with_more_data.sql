CREATE DATABASE IF NOT EXISTS real_estate;
USE real_estate;

DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Location VARCHAR(100),
    Area INT,
    Price DECIMAL(12,2),
    Bedrooms INT,
    Bathrooms INT,
    Distance DECIMAL(6,2),
    YearBuilt INT,
    Category VARCHAR(100),
    Temperature DECIMAL(5,2),
    Humidity DECIMAL(5,2),
    Rainfall DECIMAL(6,2),
    pH DECIMAL(3,2)
);

-- Beach Side
INSERT INTO properties (Location, Area, Price, Bedrooms, Bathrooms, Distance, YearBuilt, Category, Temperature, Humidity, Rainfall, pH) VALUES
('Juhu Beach', 950, 4500000, 2, 1, 2.5, 2010, 'Beach Side', 28.5, 82.0, 210, 6.8),
('Juhu Beach', 1000, 5000000, 2, 2, 2.5, 2012, 'Beach Side', 29.0, 80.0, 220, 6.9),
('Juhu Beach', 1100, 5200000, 3, 2, 2.7, 2014, 'Beach Side', 28.8, 78.0, 200, 7.0),
('Juhu Beach', 1200, 5500000, 3, 2, 2.8, 2018, 'Beach Side', 28.0, 76.0, 190, 7.1),

('Marine Drive', 1800, 9000000, 3, 2, 1.0, 2011, 'Beach Side', 27.5, 68.0, 95, 7.1),
('Marine Drive', 1900, 9500000, 3, 2, 1.1, 2015, 'Beach Side', 27.0, 65.0, 90, 7.2),
('Marine Drive', 2000, 9800000, 3, 3, 1.2, 2019, 'Beach Side', 26.8, 63.0, 85, 7.3);

-- Downtown
INSERT INTO properties (Location, Area, Price, Bedrooms, Bathrooms, Distance, YearBuilt, Category, Temperature, Humidity, Rainfall, pH) VALUES
('Pune Central', 2200, 12000000, 4, 3, 3.5, 2010, 'Downtown', 29.0, 60.0, 130, 7.0),
('Pune Central', 2300, 12500000, 4, 3, 3.6, 2012, 'Downtown', 29.5, 58.0, 125, 7.1),
('Pune Central', 2400, 13000000, 4, 3, 3.8, 2016, 'Downtown', 30.0, 57.0, 120, 7.2),
('Pune Central', 2500, 13500000, 5, 4, 4.0, 2020, 'Downtown', 30.2, 55.0, 115, 7.3),

('Times Square', 2500, 15000000, 4, 3, 1.5, 2011, 'Downtown', 29.5, 60.0, 110, 7.2),
('Times Square', 2600, 15500000, 4, 3, 1.6, 2015, 'Downtown', 30.0, 58.0, 105, 7.3),
('Times Square', 2700, 16000000, 5, 4, 1.8, 2019, 'Downtown', 30.5, 57.0, 100, 7.4);

-- Park Side
INSERT INTO properties (Location, Area, Price, Bedrooms, Bathrooms, Distance, YearBuilt, Category, Temperature, Humidity, Rainfall, pH) VALUES
('Shivaji Park', 1300, 6000000, 2, 2, 4.0, 2012, 'Park Side', 27.0, 62.0, 155, 6.9),
('Shivaji Park', 1400, 6500000, 3, 2, 4.2, 2015, 'Park Side', 26.8, 61.0, 152, 7.0),
('Shivaji Park', 1500, 7000000, 3, 2, 4.4, 2018, 'Park Side', 26.5, 60.0, 150, 7.1),
('Shivaji Park', 1600, 7500000, 3, 2, 4.5, 2020, 'Park Side', 26.3, 59.0, 148, 7.2);

-- Hill Side
INSERT INTO properties (Location, Area, Price, Bedrooms, Bathrooms, Distance, YearBuilt, Category, Temperature, Humidity, Rainfall, pH) VALUES
('Lonavala', 3000, 20000000, 5, 4, 6.0, 2008, 'Hill Side', 22.0, 78.0, 320, 6.5),
('Lonavala', 3100, 20500000, 5, 4, 6.2, 2012, 'Hill Side', 22.5, 77.0, 310, 6.6),
('Lonavala', 3200, 21000000, 5, 4, 6.3, 2016, 'Hill Side', 23.0, 76.0, 300, 6.7),
('Lonavala', 3300, 21500000, 5, 4, 6.5, 2020, 'Hill Side', 23.2, 75.0, 295, 6.8),

('Manali', 1500, 7000000, 3, 2, 7.0, 2010, 'Hill Side', 18.5, 74.0, 285, 6.3),
('Manali', 1600, 7500000, 3, 2, 7.2, 2014, 'Hill Side', 18.2, 73.0, 282, 6.4),
('Manali', 1700, 8000000, 3, 2, 7.4, 2016, 'Hill Side', 18.0, 72.0, 280, 6.4),
('Manali', 1800, 8500000, 3, 2, 7.5, 2019, 'Hill Side', 17.8, 71.0, 278, 6.5);
