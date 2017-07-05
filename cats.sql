CREATE TABLE cats (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER,

  FOREIGN KEY(owner_id) REFERENCES human(id)
);

CREATE TABLE humans (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  house_id INTEGER,

  FOREIGN KEY(house_id) REFERENCES human(id)
);

CREATE TABLE houses (
  id INTEGER PRIMARY KEY,
  address VARCHAR(255) NOT NULL
);

INSERT INTO
  houses (id, address)
VALUES
  (1, "25 Birchwood Ave"),
  (2, "62 Apple Orchard Hts"),
  (3, "110 Emacho"),
  (4, "90 75th Street"),
  (5, "804 Streep Street"),
  (6, "98 Reni Lane");

INSERT INTO
  humans (id, fname, lname, house_id)
VALUES
  (1, "Priscilla", "Chan", 6),
  (2, "Kathy", "Wadlegger", 1),
  (3, "Joseph", "Vass", 2),
  (4, "Hideo", "Okuda", 3),
  (5, "Meryl", "Streep", 5),
  (6, "George", "Chan", 6),
  (7, "Porky", "Sallins", 5),
  (8, "Santa", "Claus", 3);

INSERT INTO
  cats (id, name, owner_id)
VALUES
  (1, "Cammy", 5),
  (2, "Sammy", 5),
  (3, "Tammy", 5),
  (4, "Markov", 8),
  (5, "Yakov", 8),
  (6, "Vladmir", 8),
  (7, "Homeless Cat", NULL ),
  (8, "Chicha", 3);
