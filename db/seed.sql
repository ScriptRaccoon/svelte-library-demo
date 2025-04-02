-- Create tables
CREATE TABLE
    authors (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        birth_year INTEGER
    );

CREATE TABLE
    genres (id INTEGER PRIMARY KEY, name TEXT UNIQUE NOT NULL);

CREATE TABLE
    books (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        author_id INTEGER NOT NULL,
        genre_id INTEGER NOT NULL,
        published_year INTEGER,
        description TEXT,
        FOREIGN KEY (author_id) REFERENCES authors (id),
        FOREIGN KEY (genre_id) REFERENCES genres (id)
    );

CREATE TABLE
    ratings (
        id INTEGER PRIMARY KEY,
        book_id INTEGER NOT NULL,
        rating INTEGER NOT NULL CHECK (
            rating >= 1
            AND rating <= 5
        ),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE CASCADE
    );

-- Insert genres
INSERT INTO
    genres (name)
VALUES
    ('Fiction'),
    ('Fantasy'),
    ('Science Fiction'),
    ('Mystery'),
    ('Historical'),
    ('Horror'),
    ('Romance'),
    ('Philosophy'),
    ('Biography'),
    ('Poetry');

-- Insert authors
INSERT INTO
    authors (name, birth_year)
VALUES
    ('Jane Austen', 1775),
    ('Mark Twain', 1835),
    ('J.K. Rowling', 1965),
    ('George Orwell', 1903),
    ('Agatha Christie', 1890),
    ('Isaac Asimov', 1920),
    ('Stephen King', 1947),
    ('Ernest Hemingway', 1899),
    ('Leo Tolstoy', 1828),
    ('Charles Dickens', 1812),
    ('H.G. Wells', 1866),
    ('F. Scott Fitzgerald', 1896),
    ('Edgar Allan Poe', 1809),
    ('Arthur Conan Doyle', 1859),
    ('Homer', NULL),
    ('Mary Shelley', 1797),
    ('Plato', -427),
    ('Aristotle', -384),
    ('Emily Dickinson', 1830),
    ('J.R.R. Tolkien', 1892),
    ('H.P. Lovecraft', 1890),
    ('Oscar Wilde', 1854),
    ('Ray Bradbury', 1920),
    ('Douglas Adams', 1952),
    ('Victor Hugo', 1802),
    ('Harper Lee', 1926),
    ('Franz Kafka', 1883),
    ('Bram Stoker', 1847),
    ('Gabriel Garcia Marquez', 1927),
    ('Dante Alighieri', 1265);

-- Insert books
INSERT INTO
    books (
        title,
        author_id,
        genre_id,
        published_year,
        description
    )
VALUES
    (
        'Pride and Prejudice',
        1,
        7,
        1813,
        'A romantic novel that explores themes of love, class, and societal expectations.'
    ),
    (
        'Adventures of Huckleberry Finn',
        2,
        1,
        1884,
        'A coming-of-age novel about the adventures of a young boy along the Mississippi River.'
    ),
    (
        'Harry Potter and the Sorcerer''s Stone',
        3,
        2,
        1997,
        'The first book in the Harry Potter series, where a young wizard discovers his magical heritage.'
    ),
    (
        '1984',
        4,
        3,
        1949,
        'A dystopian novel exploring totalitarianism, surveillance, and freedom.'
    ),
    (
        'Murder on the Orient Express',
        5,
        4,
        1934,
        'A detective novel featuring Hercule Poirot solving a murder on a train.'
    ),
    (
        'Foundation',
        6,
        3,
        1951,
        'A sci-fi classic about the fall and rise of civilizations, based on mathematical predictions.'
    ),
    (
        'The Shining',
        7,
        6,
        1977,
        'A psychological horror novel set in an isolated hotel haunted by supernatural forces.'
    ),
    (
        'The Old Man and the Sea',
        8,
        1,
        1952,
        'A short novel about an aging fisherman and his battle with a giant marlin.'
    ),
    (
        'War and Peace',
        9,
        5,
        1869,
        'A historical epic set during the Napoleonic Wars, exploring the lives of Russian aristocracy.'
    ),
    (
        'A Tale of Two Cities',
        10,
        5,
        1859,
        'A novel set during the French Revolution, contrasting the cities of London and Paris.'
    ),
    (
        'The Time Machine',
        11,
        3,
        1895,
        'A sci-fi story about time travel and humanity''s future evolution.'
    ),
    (
        'The Great Gatsby',
        12,
        1,
        1925,
        'A critique of the American Dream, centering on a mysterious millionaire and his lost love.'
    ),
    (
        'The Tell-Tale Heart',
        13,
        6,
        1843,
        'A short horror story about guilt and paranoia after committing murder.'
    ),
    (
        'Sherlock Holmes: A Study in Scarlet',
        14,
        4,
        1887,
        'The first novel featuring the legendary detective Sherlock Holmes.'
    ),
    (
        'The Iliad',
        15,
        5,
        -750,
        'An ancient epic poem about the Trojan War and its heroes.'
    ),
    (
        'Frankenstein',
        16,
        6,
        1818,
        'A gothic novel exploring the consequences of playing god and creating life.'
    ),
    (
        'The Republic',
        17,
        8,
        -380,
        'A philosophical dialogue by Plato discussing justice and the ideal society.'
    ),
    (
        'Metaphysics',
        18,
        8,
        -350,
        'A foundational work in philosophy exploring the nature of reality and existence.'
    ),
    (
        'Collected Poems',
        19,
        10,
        1890,
        'A compilation of Emily Dickinson''s poetry exploring themes of nature and death.'
    ),
    (
        'The Lord of the Rings',
        20,
        2,
        1954,
        'A fantasy epic following the journey to destroy a powerful ring.'
    ),
    (
        'The Call of Cthulhu',
        21,
        6,
        1928,
        'A horror short story introducing the mythos of cosmic horror.'
    ),
    (
        'The Picture of Dorian Gray',
        22,
        1,
        1890,
        'A novel about a man whose portrait ages while he remains young and corrupted.'
    ),
    (
        'Fahrenheit 451',
        23,
        3,
        1953,
        'A dystopian novel about a future society where books are banned and burned.'
    ),
    (
        'The Hitchhiker''s Guide to the Galaxy',
        24,
        3,
        1979,
        'A comedic sci-fi adventure through space and absurdity.'
    ),
    (
        'Les Misérables',
        25,
        5,
        1862,
        'A historical novel about redemption, justice, and the struggles of post-revolutionary France.'
    ),
    (
        'To Kill a Mockingbird',
        26,
        1,
        1960,
        'A novel exploring racial injustice and moral growth in the American South.'
    ),
    (
        'The Trial',
        27,
        1,
        1925,
        'A surreal novel about a man caught in a nightmarish bureaucratic system.'
    ),
    (
        'Dracula',
        28,
        6,
        1897,
        'A gothic horror novel introducing the legendary vampire Count Dracula.'
    ),
    (
        'One Hundred Years of Solitude',
        29,
        1,
        1967,
        'A magical realist novel chronicling multiple generations of the Buendía family.'
    ),
    (
        'The Divine Comedy',
        30,
        8,
        1320,
        'An epic poem describing a journey through Hell, Purgatory, and Paradise.'
    );

-- Insert ratings
INSERT INTO
    ratings (book_id, rating)
VALUES
    (1, 5),
    (1, 4),
    (1, 5),
    (1, 3),
    (1, 4),
    (2, 4),
    (2, 3),
    (2, 5),
    (2, 4),
    (2, 5),
    (3, 5),
    (3, 5),
    (3, 4),
    (3, 5),
    (3, 5),
    (4, 5),
    (4, 4),
    (4, 3),
    (4, 2),
    (4, 4),
    (5, 4),
    (5, 3),
    (5, 5),
    (5, 4),
    (5, 4),
    (6, 5),
    (6, 5),
    (6, 4),
    (6, 4),
    (6, 5),
    (7, 5),
    (7, 4),
    (7, 5),
    (7, 3),
    (7, 4),
    (8, 4),
    (8, 3),
    (8, 5),
    (8, 4),
    (8, 4),
    (9, 5),
    (9, 5),
    (9, 4),
    (9, 3),
    (9, 4),
    (10, 4),
    (10, 4),
    (10, 5),
    (10, 3),
    (10, 5);