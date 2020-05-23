IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'PhoneBook' AND xtype = 'U')
CREATE TABLE PhoneBook
(
	PersonName VARCHAR(150) NOT NULL,
	PhoneNumber VARCHAR(50) NOT NULL
);
