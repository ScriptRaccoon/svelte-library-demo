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
    ('Dante Alighieri', 1265),
    ('Stephen Hawking', 1942);

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
    ),
    (
        'The Odyssey',
        15,
        5,
        -700,
        'An epic journey home after the Trojan War.'
    ),
    (
        'Brave New World',
        4,
        3,
        1932,
        'A dystopian vision of a future society.'
    ),
    (
        'Crime and Punishment',
        9,
        5,
        1866,
        'A psychological novel about guilt and redemption.'
    ),
    (
        'Dune',
        6,
        3,
        1965,
        'A sci-fi saga about power and destiny on a desert planet.'
    ),
    (
        'The Catcher in the Rye',
        12,
        1,
        1951,
        'A coming-of-age novel following Holden Caulfield.'
    ),
    (
        'Jane Eyre',
        1,
        7,
        1847,
        'A novel about love, morality, and social criticism.'
    ),
    (
        'The War of the Worlds',
        11,
        3,
        1898,
        'An alien invasion sci-fi novel.'
    ),
    (
        'The Hound of the Baskervilles',
        14,
        4,
        1902,
        'A Sherlock Holmes mystery involving a ghostly hound.'
    ),
    (
        'The Road',
        7,
        6,
        2006,
        'A post-apocalyptic survival novel.'
    ),
    (
        'The Bell Jar',
        19,
        1,
        1963,
        'A semi-autobiographical novel about mental health.'
    ),
    (
        'Meditations',
        18,
        8,
        180,
        'Philosophical reflections by a Roman Emperor.'
    ),
    (
        'Inferno',
        30,
        8,
        1314,
        'The first part of The Divine Comedy.'
    ),
    (
        'Persuasion',
        1,
        7,
        1817,
        'A romantic novel about second chances.'
    ),
    (
        'The Sun Also Rises',
        8,
        1,
        1926,
        'A novel about the Lost Generation after WWI.'
    ),
    (
        'The Alchemist',
        29,
        1,
        1988,
        'A novel about destiny and self-discovery.'
    ),
    (
        'The Brothers Karamazov',
        9,
        5,
        1880,
        'A novel exploring faith, doubt, and morality.'
    ),
    (
        'The Metamorphosis',
        27,
        1,
        1915,
        'A surreal story about a man turning into an insect.'
    ),
    (
        'Dr. Jekyll and Mr. Hyde',
        28,
        6,
        1886,
        'A novella about dual personality and repression.'
    ),
    (
        'The Prince',
        17,
        8,
        1532,
        'A political treatise on power and leadership.'
    ),
    (
        'The Art of War',
        18,
        8,
        -500,
        'An ancient Chinese military strategy guide.'
    ),
    (
        'Slaughterhouse-Five',
        23,
        3,
        1969,
        'A novel about WWII, time travel, and free will.'
    ),
    (
        'A Brief History of Time',
        31,
        9,
        1988,
        'A popular science book on cosmology.'
    ),
    (
        'I, Robot',
        6,
        3,
        1950,
        'A collection of sci-fi stories about AI and robotics.'
    ),
    (
        'Anna Karenina',
        9,
        5,
        1877,
        'A tragic love story set in Russian high society.'
    ),
    (
        'Wuthering Heights',
        1,
        7,
        1847,
        'A gothic romance about obsession and revenge.'
    ),
    (
        'Great Expectations',
        10,
        5,
        1861,
        'A novel about personal growth and ambition.'
    ),
    (
        'The Grapes of Wrath',
        8,
        1,
        1939,
        'A novel about the Great Depression and migration.'
    ),
    (
        'The Three Musketeers',
        25,
        5,
        1844,
        'A swashbuckling adventure about honor and loyalty.'
    ),
    (
        'Siddhartha',
        17,
        8,
        1922,
        'A novel about spiritual enlightenment.'
    ),
    (
        'Macbeth',
        10,
        10,
        1606,
        'A Shakespearean tragedy about ambition and fate.'
    ),
    (
        'The Canterbury Tales',
        15,
        10,
        1400,
        'A collection of stories from medieval England.'
    ),
    (
        'The Name of the Wind',
        20,
        2,
        2007,
        'A fantasy novel about a gifted young man.'
    ),
    (
        'The House of the Spirits',
        29,
        1,
        1982,
        'A family saga with magical realism.'
    ),
    (
        'Atlas Shrugged',
        17,
        1,
        1957,
        'A novel about individualism and capitalism.'
    ),
    (
        'Moby-Dick',
        8,
        5,
        1851,
        'A novel about obsession and revenge on the high seas.'
    ),
    (
        'The Handmaid''s Tale',
        23,
        3,
        1985,
        'A dystopian novel about totalitarian rule and women''s rights.'
    ),
    (
        'The Stranger',
        27,
        1,
        1942,
        'A novel exploring existentialism and absurdity.'
    ),
    (
        'Bleak House',
        10,
        5,
        1853,
        'A critique of the British legal system.'
    ),
    (
        'The Secret Garden',
        19,
        7,
        1911,
        'A children''s novel about healing and nature.'
    ),
    (
        'The Little Prince',
        23,
        1,
        1943,
        'A philosophical novella about childhood and imagination.'
    ),
    (
        'Treasure Island',
        25,
        5,
        1883,
        'A classic adventure novel about pirates and treasure.'
    ),
    (
        'Robinson Crusoe',
        10,
        5,
        1719,
        'A novel about survival and self-reliance.'
    ),
    (
        'A Room of One''s Own',
        22,
        9,
        1929,
        'An essay on women and literature.'
    ),
    (
        'The Book Thief',
        26,
        1,
        2005,
        'A WWII novel narrated by Death.'
    ),
    (
        'The Wind-Up Bird Chronicle',
        29,
        1,
        1994,
        'A surreal novel about self-discovery.'
    ),
    (
        'A Clockwork Orange',
        23,
        3,
        1962,
        'A dystopian novel about free will and crime.'
    ),
    (
        'The Death of Ivan Ilyich',
        9,
        5,
        1886,
        'A novel about mortality and meaning.'
    );

-- Insert ratings
INSERT INTO
    ratings (book_id, rating)
VALUES
    (2, 4),
    (2, 4),
    (2, 5),
    (3, 4),
    (3, 4),
    (4, 3),
    (4, 2),
    (5, 4),
    (7, 2),
    (7, 3),
    (7, 1),
    (7, 2),
    (7, 4),
    (7, 1),
    (7, 3),
    (8, 2),
    (10, 4),
    (10, 3),
    (10, 2),
    (10, 1),
    (10, 1),
    (11, 2),
    (11, 2),
    (12, 5),
    (12, 4),
    (12, 2),
    (12, 2),
    (12, 2),
    (12, 2),
    (12, 4),
    (13, 2),
    (13, 3),
    (13, 1),
    (13, 2),
    (13, 4),
    (13, 2),
    (13, 4),
    (13, 1),
    (13, 4),
    (14, 3),
    (14, 4),
    (14, 3),
    (15, 4),
    (15, 1),
    (15, 5),
    (16, 2),
    (16, 5),
    (16, 4),
    (16, 3),
    (17, 5),
    (17, 2),
    (17, 2),
    (17, 4),
    (17, 1),
    (17, 3),
    (18, 3),
    (18, 2),
    (18, 1),
    (18, 1),
    (18, 3),
    (18, 2),
    (18, 3),
    (19, 3),
    (19, 5),
    (19, 5),
    (20, 3),
    (20, 3),
    (20, 3),
    (20, 2),
    (20, 5),
    (20, 5),
    (20, 2),
    (22, 3),
    (22, 4),
    (22, 1),
    (22, 1),
    (22, 1),
    (22, 2),
    (22, 2),
    (23, 1),
    (24, 4),
    (24, 5),
    (24, 4),
    (24, 2),
    (25, 1),
    (25, 3),
    (25, 1),
    (25, 3),
    (25, 1),
    (26, 2),
    (26, 1),
    (26, 3),
    (26, 4),
    (26, 3),
    (26, 2),
    (26, 2),
    (27, 2),
    (27, 5),
    (27, 1),
    (27, 2),
    (27, 5),
    (28, 5),
    (28, 2),
    (28, 1),
    (28, 3),
    (29, 2),
    (29, 3),
    (29, 4),
    (29, 4),
    (29, 1),
    (29, 4),
    (29, 4),
    (29, 2),
    (29, 4),
    (30, 3),
    (30, 3),
    (30, 5),
    (30, 3),
    (31, 5),
    (31, 5),
    (31, 4),
    (31, 1),
    (32, 1),
    (32, 4),
    (33, 3),
    (33, 4),
    (33, 2),
    (33, 5),
    (33, 5),
    (33, 2),
    (33, 1),
    (33, 4),
    (34, 1),
    (34, 1),
    (34, 5),
    (34, 5),
    (34, 4),
    (34, 3),
    (34, 3),
    (35, 1),
    (35, 1),
    (35, 3),
    (35, 2),
    (35, 5),
    (35, 5),
    (35, 5),
    (35, 1),
    (35, 4),
    (36, 3),
    (36, 2),
    (36, 2),
    (36, 4),
    (36, 1),
    (36, 2),
    (36, 5),
    (36, 1),
    (37, 5),
    (37, 1),
    (38, 1),
    (38, 4),
    (38, 2),
    (38, 5),
    (38, 5),
    (38, 5),
    (38, 1),
    (41, 5),
    (41, 3),
    (41, 2),
    (41, 2),
    (41, 1),
    (41, 3),
    (41, 2),
    (41, 4),
    (42, 2),
    (42, 4),
    (42, 2),
    (42, 5),
    (42, 1),
    (42, 4),
    (42, 3),
    (43, 1),
    (43, 5),
    (43, 1),
    (44, 2),
    (44, 5),
    (44, 4),
    (44, 5),
    (44, 3),
    (44, 1),
    (44, 5),
    (44, 5),
    (44, 5),
    (45, 2),
    (45, 3),
    (45, 3),
    (45, 5),
    (45, 1),
    (45, 5),
    (45, 5),
    (47, 4),
    (47, 3),
    (47, 3),
    (47, 5),
    (47, 2),
    (47, 4),
    (48, 4),
    (48, 4),
    (48, 4),
    (48, 2),
    (49, 1),
    (49, 2),
    (50, 2),
    (50, 3),
    (51, 3),
    (51, 1),
    (51, 2),
    (51, 5),
    (52, 1),
    (52, 4),
    (53, 1),
    (53, 5),
    (53, 1),
    (53, 1),
    (53, 3),
    (54, 1),
    (54, 1),
    (54, 4),
    (54, 2),
    (54, 1),
    (54, 1),
    (54, 5),
    (54, 3),
    (55, 5),
    (55, 2),
    (55, 5),
    (55, 2),
    (55, 3),
    (56, 2),
    (56, 3),
    (56, 5),
    (56, 4),
    (56, 3),
    (56, 2),
    (56, 1),
    (56, 2),
    (56, 4),
    (57, 5),
    (57, 4),
    (57, 3),
    (57, 4),
    (57, 3),
    (57, 2),
    (57, 4),
    (57, 4),
    (57, 4),
    (58, 4),
    (58, 1),
    (58, 4),
    (58, 5),
    (58, 4),
    (58, 5),
    (59, 4),
    (59, 5),
    (59, 4),
    (59, 4),
    (59, 5),
    (59, 5),
    (60, 3),
    (61, 1),
    (61, 4),
    (61, 1),
    (61, 4),
    (61, 3),
    (61, 5),
    (62, 2),
    (62, 4),
    (63, 1),
    (63, 3),
    (64, 2),
    (64, 4),
    (64, 5),
    (64, 5),
    (64, 1),
    (65, 3),
    (65, 4),
    (66, 1),
    (66, 5),
    (68, 1),
    (68, 3),
    (69, 1),
    (70, 4),
    (71, 2),
    (71, 5),
    (71, 3),
    (71, 2),
    (71, 3),
    (71, 4),
    (71, 2),
    (72, 1),
    (72, 1),
    (72, 3),
    (72, 4),
    (73, 2),
    (73, 4),
    (73, 3),
    (73, 5),
    (73, 1),
    (74, 2),
    (74, 3),
    (74, 3),
    (74, 3),
    (74, 2),
    (74, 4),
    (74, 2),
    (74, 1),
    (74, 1),
    (75, 3),
    (75, 3),
    (75, 5),
    (75, 3),
    (75, 5),
    (75, 3),
    (75, 4),
    (76, 5),
    (76, 1),
    (76, 4),
    (76, 1),
    (76, 2),
    (77, 5),
    (77, 5);