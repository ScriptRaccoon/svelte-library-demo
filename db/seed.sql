PRAGMA foreign_keys = ON;

-- Drop tables if they exist
DROP TABLE IF EXISTS ratings;

DROP TABLE IF EXISTS books;

DROP TABLE IF EXISTS genres;

DROP TABLE IF EXISTS authors;

-- Create tables
CREATE TABLE
    authors (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        birth_year INTEGER
    );

CREATE TABLE
    genres (
        id INTEGER PRIMARY KEY,
        name TEXT UNIQUE NOT NULL,
        description TEXT NOT NULL
    );

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
        user_id TEXT NOT NULL,
        book_id INTEGER NOT NULL,
        rating INTEGER NOT NULL CHECK (
            rating >= 1
            AND rating <= 5
        ),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP,
        FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE CASCADE,
        UNIQUE (user_id, book_id)
    );

-- Create triggers
CREATE TRIGGER update_ratings_timestamp AFTER
UPDATE ON ratings FOR EACH ROW BEGIN
UPDATE ratings
SET
    updated_at = CURRENT_TIMESTAMP
WHERE
    id = OLD.id;

END;

-- Insert genres
INSERT INTO
    genres (name, description)
VALUES
    (
        'Fiction',
        'Narrative prose that is imaginary or invented.'
    ),
    (
        'Fantasy',
        'Fiction involving magical or supernatural elements.'
    ),
    (
        'Science Fiction',
        'Fiction exploring futuristic and scientific concepts.'
    ),
    (
        'Mystery',
        'Fiction centered around solving a crime or uncovering secrets.'
    ),
    (
        'Historical',
        'Fiction set in a past historical era with accurate details.'
    ),
    (
        'Horror',
        'Fiction designed to frighten, scare, or unsettle readers.'
    ),
    (
        'Romance',
        'Fiction focusing on romantic relationships and emotions.'
    ),
    (
        'Philosophy',
        'Literary works discussing fundamental human questions.'
    ),
    (
        'Biography',
        'A detailed account of a person’s life written by someone else.'
    ),
    (
        'Poetry',
        'Literary works written in verse, emphasizing expression and rhythm.'
    );

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
        description,
        author_id,
        genre_id,
        published_year
    )
VALUES
    (
        'Pride and Prejudice',
        'A romantic novel that explores themes of love, class, and societal expectations.',
        1,
        7,
        1813
    ),
    (
        'Adventures of Huckleberry Finn',
        'A coming-of-age novel about the adventures of a young boy along the Mississippi River.',
        2,
        1,
        1884
    ),
    (
        'Harry Potter and the Sorcerer''s Stone',
        'The first book in the Harry Potter series, where a young wizard discovers his magical heritage.',
        3,
        2,
        1997
    ),
    (
        '1984',
        'A dystopian novel exploring totalitarianism, surveillance, and freedom.',
        4,
        3,
        1949
    ),
    (
        'Murder on the Orient Express',
        'A detective novel featuring Hercule Poirot solving a murder on a train.',
        5,
        4,
        1934
    ),
    (
        'Foundation',
        'A sci-fi classic about the fall and rise of civilizations, based on mathematical predictions.',
        6,
        3,
        1951
    ),
    (
        'The Shining',
        'A psychological horror novel set in an isolated hotel haunted by supernatural forces.',
        7,
        6,
        1977
    ),
    (
        'The Old Man and the Sea',
        'A short novel about an aging fisherman and his battle with a giant marlin.',
        8,
        1,
        1952
    ),
    (
        'War and Peace',
        'A historical epic set during the Napoleonic Wars, exploring the lives of Russian aristocracy.',
        9,
        5,
        1869
    ),
    (
        'A Tale of Two Cities',
        'A novel set during the French Revolution, contrasting the cities of London and Paris.',
        10,
        5,
        1859
    ),
    (
        'The Time Machine',
        'A sci-fi story about time travel and humanity''s future evolution.',
        11,
        3,
        1895
    ),
    (
        'The Great Gatsby',
        'A critique of the American Dream, centering on a mysterious millionaire and his lost love.',
        12,
        1,
        1925
    ),
    (
        'The Tell-Tale Heart',
        'A short horror story about guilt and paranoia after committing murder.',
        13,
        6,
        1843
    ),
    (
        'Sherlock Holmes: A Study in Scarlet',
        'The first novel featuring the legendary detective Sherlock Holmes.',
        14,
        4,
        1887
    ),
    (
        'The Iliad',
        'An ancient epic poem about the Trojan War and its heroes.',
        15,
        5,
        -750
    ),
    (
        'Frankenstein',
        'A gothic novel exploring the consequences of playing god and creating life.',
        16,
        6,
        1818
    ),
    (
        'The Republic',
        'A philosophical dialogue by Plato discussing justice and the ideal society.',
        17,
        8,
        -380
    ),
    (
        'Metaphysics',
        'A foundational work in philosophy exploring the nature of reality and existence.',
        18,
        8,
        -350
    ),
    (
        'Collected Poems',
        'A compilation of Emily Dickinson''s poetry exploring themes of nature and death.',
        19,
        10,
        1890
    ),
    (
        'The Lord of the Rings',
        'A fantasy epic following the journey to destroy a powerful ring.',
        20,
        2,
        1954
    ),
    (
        'The Call of Cthulhu',
        'A horror short story introducing the mythos of cosmic horror.',
        21,
        6,
        1928
    ),
    (
        'The Picture of Dorian Gray',
        'A novel about a man whose portrait ages while he remains young and corrupted.',
        22,
        1,
        1890
    ),
    (
        'Fahrenheit 451',
        'A dystopian novel about a future society where books are banned and burned.',
        23,
        3,
        1953
    ),
    (
        'The Hitchhiker''s Guide to the Galaxy',
        'A comedic sci-fi adventure through space and absurdity.',
        24,
        3,
        1979
    ),
    (
        'Les Misérables',
        'A historical novel about redemption, justice, and the struggles of post-revolutionary France.',
        25,
        5,
        1862
    ),
    (
        'To Kill a Mockingbird',
        'A novel exploring racial injustice and moral growth in the American South.',
        26,
        1,
        1960
    ),
    (
        'The Trial',
        'A surreal novel about a man caught in a nightmarish bureaucratic system.',
        27,
        1,
        1925
    ),
    (
        'Dracula',
        'A gothic horror novel introducing the legendary vampire Count Dracula.',
        28,
        6,
        1897
    ),
    (
        'One Hundred Years of Solitude',
        'A magical realist novel chronicling multiple generations of the Buendía family.',
        29,
        1,
        1967
    ),
    (
        'The Divine Comedy',
        'An epic poem describing a journey through Hell, Purgatory, and Paradise.',
        30,
        8,
        1320
    ),
    (
        'The Odyssey',
        'An epic journey home after the Trojan War.',
        15,
        5,
        -700
    ),
    (
        'Brave New World',
        'A dystopian vision of a future society.',
        4,
        3,
        1932
    ),
    (
        'Crime and Punishment',
        'A psychological novel about guilt and redemption.',
        9,
        5,
        1866
    ),
    (
        'Dune',
        'A sci-fi saga about power and destiny on a desert planet.',
        6,
        3,
        1965
    ),
    (
        'The Catcher in the Rye',
        'A coming-of-age novel following Holden Caulfield.',
        12,
        1,
        1951
    ),
    (
        'Jane Eyre',
        'A novel about love, morality, and social criticism.',
        1,
        7,
        1847
    ),
    (
        'The War of the Worlds',
        'An alien invasion sci-fi novel.',
        11,
        3,
        1898
    ),
    (
        'The Hound of the Baskervilles',
        'A Sherlock Holmes mystery involving a ghostly hound.',
        14,
        4,
        1902
    ),
    (
        'The Road',
        'A post-apocalyptic survival novel.',
        7,
        6,
        2006
    ),
    (
        'The Bell Jar',
        'A semi-autobiographical novel about mental health.',
        19,
        1,
        1963
    ),
    (
        'Meditations',
        'Philosophical reflections by a Roman Emperor.',
        18,
        8,
        180
    ),
    (
        'Inferno',
        'The first part of The Divine Comedy.',
        30,
        8,
        1314
    ),
    (
        'Persuasion',
        'A romantic novel about second chances.',
        1,
        7,
        1817
    ),
    (
        'The Sun Also Rises',
        'A novel about the Lost Generation after WWI.',
        8,
        1,
        1926
    ),
    (
        'The Alchemist',
        'A novel about destiny and self-discovery.',
        29,
        1,
        1988
    ),
    (
        'The Brothers Karamazov',
        'A novel exploring faith, doubt, and morality.',
        9,
        5,
        1880
    ),
    (
        'The Metamorphosis',
        'A surreal story about a man turning into an insect.',
        27,
        1,
        1915
    ),
    (
        'Dr. Jekyll and Mr. Hyde',
        'A novella about dual personality and repression.',
        28,
        6,
        1886
    ),
    (
        'The Prince',
        'A political treatise on power and leadership.',
        17,
        8,
        1532
    ),
    (
        'The Art of War',
        'An ancient Chinese military strategy guide.',
        18,
        8,
        -500
    ),
    (
        'Slaughterhouse-Five',
        'A novel about WWII, time travel, and free will.',
        23,
        3,
        1969
    ),
    (
        'A Brief History of Time',
        'A popular science book on cosmology.',
        31,
        9,
        1988
    ),
    (
        'I, Robot',
        'A collection of sci-fi stories about AI and robotics.',
        6,
        3,
        1950
    ),
    (
        'Anna Karenina',
        'A tragic love story set in Russian high society.',
        9,
        5,
        1877
    ),
    (
        'Wuthering Heights',
        'A gothic romance about obsession and revenge.',
        1,
        7,
        1847
    ),
    (
        'Great Expectations',
        'A novel about personal growth and ambition.',
        10,
        5,
        1861
    ),
    (
        'The Grapes of Wrath',
        'A novel about the Great Depression and migration.',
        8,
        1,
        1939
    ),
    (
        'The Three Musketeers',
        'A swashbuckling adventure about honor and loyalty.',
        25,
        5,
        1844
    ),
    (
        'Siddhartha',
        'A novel about spiritual enlightenment.',
        17,
        8,
        1922
    ),
    (
        'Macbeth',
        'A Shakespearean tragedy about ambition and fate.',
        10,
        10,
        1606
    ),
    (
        'The Canterbury Tales',
        'A collection of stories from medieval England.',
        15,
        10,
        1400
    ),
    (
        'The Name of the Wind',
        'A fantasy novel about a gifted young man.',
        20,
        2,
        2007
    ),
    (
        'The House of the Spirits',
        'A family saga with magical realism.',
        29,
        1,
        1982
    ),
    (
        'Atlas Shrugged',
        'A novel about individualism and capitalism.',
        17,
        1,
        1957
    ),
    (
        'Moby-Dick',
        'A novel about obsession and revenge on the high seas.',
        8,
        5,
        1851
    ),
    (
        'The Handmaid''s Tale',
        'A dystopian novel about totalitarian rule and women''s rights.',
        23,
        3,
        1985
    ),
    (
        'The Stranger',
        'A novel exploring existentialism and absurdity.',
        27,
        1,
        1942
    ),
    (
        'Bleak House',
        'A critique of the British legal system.',
        10,
        5,
        1853
    ),
    (
        'The Secret Garden',
        'A children''s novel about healing and nature.',
        19,
        7,
        1911
    ),
    (
        'The Little Prince',
        'A philosophical novella about childhood and imagination.',
        23,
        1,
        1943
    ),
    (
        'Treasure Island',
        'A classic adventure novel about pirates and treasure.',
        25,
        5,
        1883
    ),
    (
        'Robinson Crusoe',
        'A novel about survival and self-reliance.',
        10,
        5,
        1719
    ),
    (
        'A Room of One''s Own',
        'An essay on women and literature.',
        22,
        9,
        1929
    ),
    (
        'The Book Thief',
        'A WWII novel narrated by Death.',
        26,
        1,
        2005
    ),
    (
        'The Wind-Up Bird Chronicle',
        'A surreal novel about self-discovery.',
        29,
        1,
        1994
    ),
    (
        'A Clockwork Orange',
        'A dystopian novel about free will and crime.',
        23,
        3,
        1962
    ),
    (
        'The Death of Ivan Ilyich',
        'A novel about mortality and meaning.',
        9,
        5,
        1886
    );

-- Insert ratings (use ratings.js to generate these)
INSERT INTO
    ratings (user_id, book_id, rating)
VALUES
    ("5e13f714-de24-44b8-b261-58fec4967b70", 1, 5),
    ("9f8788ae-69c5-4792-a805-ca7673b9b014", 1, 2),
    ("cfcd1495-02a0-467c-8c18-b3ce289698ad", 1, 1),
    ("18765640-b9ea-40f4-b9aa-6f18014370be", 3, 2),
    ("d6842507-44db-44a7-89ec-c43f9a987715", 3, 5),
    ("13b380d6-5854-4f60-99d3-dae6f7eebf2b", 3, 1),
    ("dfb2c99a-0078-4c2f-8456-b2d2eeddd2cc", 3, 3),
    ("2e32b8f5-58c8-49e8-affb-ec8373c66a0e", 3, 1),
    ("b824f4cb-6da2-4a42-8e54-f3428d96c3a3", 3, 3),
    ("5f60b62e-e9b0-44d3-96e6-73b7380a6ce1", 4, 5),
    ("c35d40bd-5c5f-47df-ab6c-cc4194a92e6e", 5, 5),
    ("e1872a75-983d-40fa-b5c2-a42cd01b7b5e", 5, 1),
    ("79906806-aa34-47a6-b1e9-e899ad193e96", 5, 3),
    ("66d0c7f1-7660-4533-abe5-ebf9b86a6d1e", 5, 4),
    ("a0a323c1-a564-480f-938a-c406f6b51cf1", 5, 2),
    ("677beda8-1b2b-45c0-9ba3-9e07cb6a9a51", 5, 2),
    ("e5c39a3f-8191-4130-a296-3a09d43469a0", 5, 3),
    ("ceb9146e-0fba-4369-912b-f2f7119fb1ca", 5, 4),
    ("86d5d77e-ab73-41fc-a509-6623260c3a21", 5, 5),
    ("340b53d1-3272-4394-8fc9-b8f0dd56a459", 6, 3),
    ("de8e3411-faee-4b5d-aa4c-503c02efebc1", 6, 4),
    ("a71a3ef4-326b-4d48-90f8-498a85e8ea8d", 6, 2),
    ("d86b6014-4072-4261-acce-83ea1aa9bfb2", 6, 1),
    ("8003903c-39f3-4c93-8c0d-66578abee019", 7, 1),
    ("d2850fb7-781a-494b-b74f-d65e6074c5a7", 7, 1),
    ("b3eefc76-175b-42af-859e-5710201e9533", 7, 1),
    ("2c589851-e0a2-412d-8317-0eef088f8a25", 7, 1),
    ("e2761481-485f-4e49-bd68-bd7a3f81be55", 7, 2),
    ("34b3ffdb-2eca-4e5c-8317-9566bb6bd0eb", 7, 1),
    ("8fc5db47-2507-421d-852f-1941b3269582", 7, 1),
    ("9daa38ad-2ce6-4999-9b47-de6397c56584", 7, 2),
    ("46dd23f4-d682-4d01-b20b-c5e7ec726398", 8, 4),
    ("4406154e-2431-4d58-b142-313dac215c64", 8, 1),
    ("72631021-ba0e-4517-8d88-8b5d371ac31f", 8, 2),
    ("94b2e014-f8b5-4708-8a44-6686a44ec912", 8, 1),
    ("198fad7e-ff90-43b0-b5a7-064daf1d7ba6", 9, 4),
    ("40e0dbb4-2b83-416d-89c3-c4e7858419e8", 9, 5),
    ("dd4a5a53-30af-4e67-864f-a696de485d18", 9, 3),
    ("cec85a71-74ca-43a5-b3db-9b1366a0cc2f", 9, 5),
    ("bcb448b0-0132-41ff-9a07-ea4a87584edf", 9, 5),
    ("8ea38104-0f3a-4195-938f-f8c76984adf9", 9, 1),
    ("612ea7ef-46e1-4a5b-b67b-86f378c7eff0", 9, 4),
    ("4e2b1ddf-6d9f-4d44-921a-af805a69b092", 9, 4),
    ("a4f17cc2-0c57-49f0-85fd-4247548e222c", 9, 3),
    ("d8150788-5f0f-41f8-887f-f73be8efe5a3", 11, 1),
    ("8bddb8eb-feed-49d2-b6f7-a46e9d632f82", 13, 5),
    ("6da2b4a5-d505-4794-9972-9a55acd11ca2", 14, 2),
    ("da9798ed-1093-4fdb-84fe-596814536b75", 14, 2),
    ("32a79e89-a336-481e-be78-11d5700636a0", 14, 4),
    ("e545d293-a113-48d4-a69a-9c1f208dc5d3", 15, 3),
    ("4622a988-bec1-4634-bb08-66cf30d6fd0f", 15, 3),
    ("9366d791-4abc-4940-8866-4b38e2453871", 15, 2),
    ("20cb1719-ff45-4ec3-bb19-413b1a4bd518", 15, 3),
    ("cb47f75e-10b0-4ab2-b476-f17212f1e4e5", 15, 4),
    ("a0019171-9524-4ec7-a287-de71b9a0eef8", 16, 1),
    ("34943c39-dc8b-47ac-af83-e242db61e1ae", 16, 3),
    ("f9f53fdb-880f-4f3b-b91e-19210211696f", 16, 5),
    ("df5f2b4a-2f85-485c-9751-62a0df526c8e", 16, 2),
    ("bda46742-c1ab-4bd6-99ae-562a35c9a705", 16, 1),
    ("2f7ef092-ccc0-4024-bce2-6f6203c10e0b", 16, 3),
    ("6b94aba5-24e6-40ff-83ff-868b2eabb35f", 16, 1),
    ("769675d0-19c4-47c2-a89c-910c64db183e", 17, 3),
    ("ef93947a-9536-46eb-97f7-a12a1a1b5dc1", 17, 5),
    ("9fb3e3e2-d34c-40b1-8e21-b7598c9c23ff", 17, 2),
    ("5422c91e-a7da-4880-80e8-73f049bb76db", 17, 3),
    ("6c103d53-74b9-4eca-8e5f-bb4d50443461", 18, 5),
    ("78fd4772-d5c1-4d21-96e1-5ffeb10f3b98", 18, 1),
    ("bf385cee-4cd0-4c4b-a756-e09dc5dbba1f", 18, 1),
    ("3e7cacff-91a7-4918-a0e7-3109f61f97fc", 18, 4),
    ("22144970-1a63-4da5-b558-965cc53e2290", 18, 3),
    ("a58460e8-6935-4994-baaf-43217396df61", 18, 4),
    ("f22f2a7c-cfb8-4566-8b98-97f7bd287372", 18, 4),
    ("53dbdac1-61c4-472d-9bfb-adf11f476d1c", 18, 4),
    ("1f464f31-7d4b-4338-903a-52c4122cf743", 18, 2),
    ("d352c421-e9a4-4ff4-a7c0-3096ad6aa9da", 19, 2),
    ("da5dcfdd-578e-4961-8da0-d4abcdaa2331", 19, 2),
    ("0affb4e8-7b20-4f02-b4e9-17f8ad041410", 20, 2),
    ("3c29c7a7-ee09-4cc2-afac-4b5617d14d94", 20, 4),
    ("c5c7fc22-efdb-44b3-b404-c8790c1d058e", 20, 2),
    ("15a7ad2a-602a-43b2-9fbd-3bb62199f3e2", 20, 1),
    ("6372d4b8-5255-4452-9f19-244fb57e052c", 20, 4),
    ("bcffda78-fd4d-4eef-8450-fdcc8dc342cf", 20, 2),
    ("2ea352d6-7588-4d35-821e-58178bc4b3da", 20, 4),
    ("f21cd382-2a87-4408-b9b6-af9729da5639", 20, 3),
    ("fc99014c-b92c-4acb-9d5f-dce4df87c8dc", 20, 4),
    ("4490f2fc-ed21-44c2-af70-7d1bf9157303", 21, 3),
    ("37cb6364-4074-4dde-8351-f33046d90553", 22, 2),
    ("7c58fa48-3ad2-419d-b389-91b506894263", 22, 3),
    ("56384a2b-4ba7-4675-90a3-78039414a3c6", 22, 3),
    ("d5fdcce7-31e8-4be8-a52e-783835887cc7", 22, 5),
    ("b83282ec-4ad2-4d9a-a504-dcf479b8d6a2", 22, 5),
    ("f0b99ba2-ab96-48b5-8d2d-4c09fd3c9afb", 22, 1),
    ("1feb7364-ceb0-4b7d-b49b-62de3726f964", 23, 2),
    ("e7eea44c-cbb6-4bff-9136-9e5d9bad627a", 23, 5),
    ("0b538e12-0e58-4f47-b02c-048ca0a098bf", 23, 2),
    ("f3be5fd6-d77f-46ba-b9c2-ed3ffd4f6a68", 25, 2),
    ("bf67ca61-5ee7-4155-9f32-5abb5939b959", 25, 1),
    ("0e6e4b0a-137d-49ab-96ae-902ee2e44d35", 25, 4),
    ("e93f3d40-3174-4c6f-8ebc-5c2498082e3a", 25, 1),
    ("74265c24-da50-45a4-b284-5492a32803fa", 25, 5),
    ("e7ae97eb-c26d-4467-a741-e006f453b70b", 25, 3),
    ("95382738-1037-4e65-87c6-a6ea020d7cfb", 25, 3),
    ("4577a082-b336-4acc-bee0-6329d55a2e5f", 25, 2),
    ("f39a91c6-3a20-4a9a-b8ca-5a67e60c39b9", 26, 5),
    ("4d17bb55-8493-4f9c-900e-2ee4ccc756dd", 26, 5),
    ("bed48cc0-a9a4-4ab8-ba7d-8ba02f581cb9", 26, 3),
    ("f9188c6d-7fb8-42ef-87e8-5b67868cb279", 26, 3),
    ("7a12f562-e674-45f4-9bde-55fb87fc9855", 26, 5),
    ("1e1d3e3f-3888-40b5-b2b3-1fffa3dba05a", 26, 2),
    ("6284bb6d-d521-4596-bba4-22eb5065aaf9", 27, 1),
    ("e12ff599-d39a-4561-b9e5-ead476fa5a02", 27, 4),
    ("00ff3a45-fc88-4b15-8756-47eb77bbd6d3", 27, 2),
    ("f69340f9-098f-4db0-a978-42058777a9b8", 28, 3),
    ("d85a5151-ea3e-40da-a01a-d1f8233a36d9", 28, 4),
    ("5ec5201a-093c-405d-ae49-13612651ec3b", 28, 5),
    ("d209f984-81ca-415e-b55b-5ab8e522eb9a", 28, 1),
    ("310b9547-9cb7-463c-b209-ec3aa2347b1a", 28, 4),
    ("7c5d607a-ef7a-4730-b926-28ce93ce5173", 28, 3),
    ("895ed2f5-132b-460a-a845-e0e83ef1cea4", 29, 4),
    ("c73dacd5-46e3-41bc-b1af-6a5cf3a4043c", 29, 3),
    ("cf3ce46c-66e7-452b-9354-764b1663fed2", 29, 3),
    ("6aed9fd6-789c-4955-aacf-6d69e6f8d5ea", 29, 2),
    ("4a169559-0fd5-46bc-b02f-82cf45a3659d", 29, 4),
    ("f7fb4886-2bcd-4901-9335-dcebe8fd6ae4", 29, 3),
    ("b3ed2531-f277-4611-8530-974f6ecf88e1", 29, 3),
    ("70b1003a-d941-4bee-ac2c-f2c8cc90fd80", 29, 1),
    ("238aa803-0b5f-484e-8407-a5380dbb942f", 29, 5),
    ("7a6818e4-b4ff-48f7-8f21-9ca2e72e5175", 30, 5),
    ("4d896f07-cc8f-4b66-8e10-2e584eafb5f5", 30, 4),
    ("edd0f24d-e999-4ed7-b18f-a94d2b26a5b5", 30, 3),
    ("8b3097ee-bf1f-43e6-9d4a-31493b65583c", 30, 2),
    ("216c8d99-0fd0-4ee9-8bd7-9f89eddb7c47", 30, 3),
    ("c28b215c-ca4f-4064-825f-512ebc964ae0", 30, 1),
    ("e2a47466-90e2-4731-a38b-37ddf1299217", 30, 3),
    ("cc4151f6-61ac-418a-aaf2-8913be49da2f", 30, 2),
    ("ead80b09-defb-47e4-9b9e-0141d67d0de5", 31, 4),
    ("a8a54ec8-9440-4a1a-9e98-4c439b6d2146", 31, 4),
    ("e11d6c4b-aa17-4217-b56c-21e61f6365ec", 31, 1),
    ("764d7cb2-dce2-45a2-b9e0-eaf2bdb7ed18", 31, 3),
    ("0055f93d-eefb-4342-9bef-2884e022eec9", 31, 1),
    ("a117a84a-d71d-424b-b71f-613d3eaaa324", 31, 3),
    ("6ac927c7-fb14-454a-a03d-13803b0c8566", 32, 5),
    ("5d09320b-6171-4b04-a3a4-24286d1b9bde", 32, 4),
    ("99d32e75-9c56-4616-b6c7-ae30a174787d", 32, 1),
    ("dfac1056-47bb-425a-abc3-b35204f2fd3d", 32, 3),
    ("f1d6fa09-3740-40c9-ae04-be5fe8c7173e", 32, 3),
    ("df1f8a5b-fe07-4262-b546-279bacbfefd7", 32, 5),
    ("087f4dad-8ea6-4a09-b2b5-f65c2c4f6441", 33, 3),
    ("fa8af9e7-c79e-430d-a238-25dcc88b14b3", 33, 2),
    ("f1779d76-bf6c-47c3-88e6-16b94c5ac431", 33, 3),
    ("2608150b-9e56-44da-b69a-190a8aecb827", 33, 2),
    ("96f2db23-52e0-4820-8ba1-5eba13f05591", 34, 1),
    ("0f38ebe4-6d82-4598-a282-fb363085af0b", 34, 4),
    ("079534db-68ed-476a-b3bc-70d04588b6b4", 34, 3),
    ("e7ef8c25-40bf-4b7d-8077-95ac48c91016", 34, 1),
    ("c3dac37f-d71d-43e5-8ec7-b7944ed6badb", 35, 1),
    ("17d04a4f-07e8-4c05-974d-44558468612d", 35, 4),
    ("db61c8dc-6b89-43f3-941a-b661ac79b2ba", 35, 1),
    ("b59e9f96-aac8-4f96-94dc-3838618e8397", 35, 3),
    ("e69e6ca8-0832-409c-9713-463d0ef1302f", 35, 2),
    ("ca6ed4b6-a490-4063-9c8e-9245731fe739", 35, 5),
    ("47671ad1-1195-405f-8bca-2fb476a12e4d", 36, 3),
    ("9ab0c55b-7c65-4c85-b49f-555ff24e6ff1", 36, 3),
    ("7273e2d5-53af-40f0-bff6-e21a062c9dff", 36, 5),
    ("4c023794-31b9-44ef-8b1c-5549d1adc8f7", 36, 5),
    ("f837fe91-72c7-466a-b073-f208ede24216", 36, 5),
    ("a683f387-ed4d-4ee5-9286-fa73c0f03711", 36, 4),
    ("b7e313a3-225a-4ec4-bde2-b5bef3ff9e44", 36, 5),
    ("63392108-f725-4624-ad5c-410a56004947", 36, 5),
    ("6d5d12ee-e60b-4132-b0ed-d6d4ec471ed2", 36, 3),
    ("78e42127-2bdc-48e8-8846-e48e9dab1907", 37, 4),
    ("9d513a1b-996e-48a2-97ce-287e6904c7ad", 37, 2),
    ("6c391de2-7624-43e5-91d6-3c78c96e8bef", 37, 1),
    ("3bca5a53-2ec4-49d4-8ab2-c1d7e9f82b6b", 38, 2),
    ("3678362c-c0f8-490b-8a6f-ba7f57cc1326", 38, 4),
    ("90bae50b-b7fe-4542-a9f2-0a497439feb4", 38, 1),
    ("36141b6f-014e-4018-ad70-0ba2f59ca909", 38, 3),
    ("6f40e6c7-88b2-4aff-a79f-c6e2f5e30a3c", 38, 3),
    ("cf660d51-492b-4730-a6c1-3870f21ef695", 38, 3),
    ("8e908db9-ea6e-4599-b0b3-8e1d6b99c3a9", 38, 1),
    ("14556df6-80e0-40df-9c16-2878739b9e68", 38, 3),
    ("0b55e0e8-f113-4055-a80d-1c1cbc3458fa", 38, 2),
    ("d04ff029-cc53-48ad-99d1-a700b2b5aa0b", 39, 5),
    ("5477565e-a8ff-4da3-b548-9b14b29ad0a9", 39, 3),
    ("d6b606b0-04e3-4c66-98f8-7a31539942d2", 39, 3),
    ("31ef6070-96c5-4b5d-b8b0-9cc7ab36ec6a", 39, 3),
    ("987195db-0eba-4bf9-aa1e-68c874837118", 39, 5),
    ("0661751b-9a03-42ff-b20a-b1840e6fd98b", 39, 3),
    ("72c0751c-614b-43d4-83cc-32ed6e198732", 39, 3),
    ("9f7d7985-04d0-4c97-bb11-1b897f076ac7", 39, 2),
    ("918edf55-066d-469e-84d6-8c68bb59a6ec", 41, 4),
    ("9dc12e59-959e-47e9-a766-dcd02855d1df", 41, 3),
    ("b9ca0a31-5353-4c12-967c-eaf10447f3b0", 41, 3),
    ("4f06b28d-cefc-4afd-97a9-7571eef84d04", 41, 1),
    ("ea5cbb1f-e6c6-4d1d-a25c-6dd657fa5e7a", 42, 2),
    ("f75a01f0-16f7-40ab-a01c-030e8f1f6220", 42, 4),
    ("8ce6937d-82a9-4016-b8ed-77f024c9ab64", 42, 4),
    ("58e304d8-48c5-43e0-9262-afee9c3e4564", 42, 2),
    ("15f97686-8902-476b-9b6a-c8500e80485f", 42, 2),
    ("e14f2f7c-6680-4139-8a81-bbdc4b61d7ad", 42, 1),
    ("f9e41dbb-23ae-4b28-998a-160da090c529", 43, 3),
    ("96b99ee2-40c7-46b5-bed0-c9fc1328ccae", 43, 1),
    ("74136e91-0a9a-4879-ba37-75655a6e01a7", 43, 4),
    ("a44d31f2-0fb8-43f0-8a30-585b871eff90", 44, 2),
    ("143728eb-bbce-4570-88a9-ba337b55eeb4", 45, 5),
    ("8f25931e-1943-4099-a217-461c8cd0d16e", 46, 5),
    ("c8e8d9ec-3498-415e-b12c-740d47b3dd50", 46, 5),
    ("ac13f0ac-87cd-4c77-b684-c977f8e9ee66", 47, 2),
    ("f96339df-e462-4237-94e9-c6e00942701f", 47, 2),
    ("4718f9a5-17c2-42e5-987d-0d0a31645e21", 47, 2),
    ("e42e9c53-c94f-4927-95ce-adb9390b887a", 47, 2),
    ("ff0758a2-ef3b-403d-ac0d-3e6497410d07", 47, 2),
    ("4da095cd-783c-4119-a9b4-ce88a407c507", 48, 2),
    ("b80c6cdf-6951-46d5-902d-5247f35012b9", 48, 2),
    ("e2adc54e-2112-4277-ad8b-0063b57d940c", 48, 5),
    ("e8c59efd-b051-441e-97a9-2f0658f8c442", 48, 5),
    ("a4b8de8d-73bf-43bd-a635-e5e0143c17a9", 48, 5),
    ("33eff75a-852c-4b0b-af3f-6369ef163eac", 48, 5),
    ("ebc41f40-bcd1-4a07-b878-068cf5008765", 48, 4),
    ("d279d950-c8d4-4154-836e-778e6d294146", 48, 3),
    ("5edbcbaa-b827-4a19-a725-a631564b7a40", 48, 1),
    ("c826b3df-0a1b-46f1-a603-4778fde67f65", 49, 5),
    ("02d2fd39-f5b9-4b2f-a123-1262944cae42", 49, 3),
    ("5d132366-896f-4027-a50b-a0a422e76dc5", 49, 4),
    ("01b69a00-1782-4fe0-968a-edaf7ce3e187", 49, 5),
    ("19ea5a0d-9546-4f5e-849d-35c0e7147a45", 49, 2),
    ("cda9cab2-c7df-4f4a-bd8b-7979d5cf3f29", 50, 3),
    ("d0ff9762-aa36-46e8-8bf6-376dd25e1b19", 50, 3),
    ("6cb8c1ca-7bc9-4ccb-b50e-bc5e579f7130", 50, 4),
    ("32b23158-af2c-4224-a0fa-cb9102e5314b", 50, 3),
    ("d54a0c57-80bc-44c8-af76-3b9775e72aa0", 50, 4),
    ("ebd1c6b6-e5f4-40a7-a568-a6ebcda7cc26", 51, 1),
    ("ca073ca7-ebd4-4a0a-bccb-0198cbe8bc7d", 52, 1),
    ("3157737d-6bac-4721-8583-a3d4e448d2f6", 52, 3),
    ("97f91390-fee0-4e08-a666-8b7de70110a2", 52, 5),
    ("9f3aee1e-629c-49f9-928a-02099fa782f6", 52, 2),
    ("e21523c0-f9dd-4778-8c65-a8609f47bbd0", 52, 4),
    ("157fd4fe-9918-4013-8ae3-8021b5d7a717", 52, 3),
    ("b5380055-1fb2-418c-bbd4-ee45046fd76d", 53, 2),
    ("e32a4c90-a72c-42a5-ab32-0b79507943f5", 53, 3),
    ("556b3611-cad2-4ac0-b16f-b7001fee0595", 53, 1),
    ("9a0e9bd5-d57e-4b10-bab1-7099302fe2e7", 53, 2),
    ("ac584f89-4da6-476e-8e57-0f38ae8c1bdb", 53, 2),
    ("a992de58-193e-4d61-a5dc-224aecf34b9e", 54, 5),
    ("1bbd6b8e-c339-4443-a92a-ee10759bbb39", 54, 5),
    ("4f16d555-bfae-4fb2-8a2f-1e4fb63418cf", 54, 4),
    ("4a97e613-db51-4215-9702-9158c6a8d10d", 56, 1),
    ("c1ad4ecb-f0bf-4312-b085-c95678ecaf02", 56, 3),
    ("38845840-b947-4068-b3fa-046ab67b784a", 57, 2),
    ("83c88b9d-d197-4bdc-981c-7b9744bccf50", 57, 5),
    ("2f0454b7-4a27-4e7d-8ca3-a3bcb2402d75", 57, 1),
    ("507b4caa-30c6-4b59-a6be-5f41936a8aad", 57, 4),
    ("3538808a-9e98-4923-a0a0-d3d3f295a298", 57, 1),
    ("e2b6a0a5-bc5f-4b28-8433-6d1e67572844", 57, 3),
    ("315a07dd-abaa-4eb9-83dc-6389ccb31dc6", 58, 5),
    ("1db23311-f4db-401d-8975-ea2782761c99", 58, 2),
    ("1a2c7cb2-0a1d-460e-aa4f-3e8bda5cd369", 58, 1),
    ("556ef3cf-b76e-4a3f-86b1-be09db404e59", 58, 4),
    ("c6e017f1-9fe5-4028-adc4-16d285743b26", 58, 3),
    ("923bbcd4-9794-44ce-b3eb-e05c7d5627b8", 59, 1),
    ("d76dca6f-ff3b-4eba-9565-908bcca9951d", 59, 5),
    ("5d1da723-93b0-4edf-aaa1-fe8403a7aee6", 59, 4),
    ("0395daf0-bab0-454b-9efb-e333c2fb2a6c", 59, 1),
    ("b43eee50-7808-4ece-b532-279b301bfe7d", 59, 1),
    ("6c049f5d-a2f7-471d-a2b2-40e2c04bfe6a", 59, 4),
    ("721864ba-9787-429b-a61f-f02a76fb1889", 60, 1),
    ("b80b2e9e-1a51-4532-9527-cda6ba0bf312", 60, 1),
    ("49deea71-2ad3-4248-bd50-7addb46a93d9", 60, 1),
    ("6da163be-1b8d-4281-bce7-c3ed7ab525cb", 60, 5),
    ("676487bf-1408-456f-9192-3d23011804c7", 60, 1),
    ("b471cd36-eb6c-42c1-b264-ef350f9b3783", 61, 4),
    ("1fad524e-b7cd-43e1-96bf-dc5273bb5869", 61, 4),
    ("99fd7c2d-3369-4240-bfe1-ecf873b934e0", 61, 4),
    ("3eba96eb-504b-4624-babe-7927c73f9bc9", 61, 5),
    ("8d46a268-9207-468e-9416-1d65439892c3", 61, 4),
    ("cde9dd65-e98e-47bb-9fea-5b4172baffcd", 61, 4),
    ("e3d3d2f6-fd2f-45e3-b8a6-84d8e99cc549", 61, 4),
    ("6480154c-5fb4-4082-878d-486c85003ae2", 62, 2),
    ("c5da75cf-0f29-45e9-85a8-6065f82d6f1c", 62, 4),
    ("b28d4b94-0819-4d07-9b29-38e7ad3ea7c0", 62, 3),
    ("f7118f4b-5c66-42c7-996a-85855c11ce45", 62, 2),
    ("0bfaeda2-b890-46ff-934a-2924b571c8d2", 62, 3),
    ("f18b1453-5e4d-41a9-bf01-41c1d87e5171", 62, 4),
    ("6d234ffd-3b64-422f-a138-52181cb92205", 62, 4),
    ("e340d25e-2811-4ba0-ae2b-485c07ae1512", 62, 1),
    ("96f05803-e766-4a22-832a-78a08e8fcd38", 62, 4),
    ("084a62e8-1655-4fa2-bbc4-73e2c37eafe6", 63, 2),
    ("8a02befd-eb8e-42f0-8066-e2cc2136b39f", 63, 5),
    ("2068bae9-3b87-42b6-bb87-90cd28630f21", 63, 1),
    ("e232879f-29c4-4ce7-b7fa-5807819ac237", 64, 1),
    ("76deda37-4960-4839-83e4-9c70f9bcb3e4", 64, 1),
    ("edb1bb5a-d430-4f95-840c-af8aec342e70", 64, 1),
    ("08fea303-c9a1-4fac-a23d-0ca3cb5cab36", 64, 2),
    ("8c1152b6-351e-4001-8d6f-782d9c8f83c8", 65, 1),
    ("d3b7f290-2069-4261-b47c-82a0a9896f84", 65, 4),
    ("c0f599ca-9770-4ddb-b278-32a3286d8f6c", 65, 5),
    ("f6180a61-93db-4494-9c57-a3669a059caa", 65, 3),
    ("096aedc9-c1ce-4ed2-9dd9-29e5c8941f6e", 65, 4),
    ("eb23c106-e40b-4971-88c9-e403d704416c", 65, 1),
    ("549c3f7a-a1d1-4cbd-8f18-51ab28130226", 65, 5),
    ("3fb37f35-5820-4345-b673-080181ef9744", 66, 2),
    ("1d1c1c40-11a5-4123-bceb-769f7f80610f", 67, 5),
    ("0ab1e50a-f0a8-4bff-a8a5-826ce8eac744", 67, 5),
    ("c0f6a893-4875-46cb-8c18-f089144c8bdf", 67, 4),
    ("1f33fea9-0c8b-4bcf-9a95-dbd5539be7d0", 67, 1),
    ("9a8aa8f2-99a5-4574-8889-5d398fdf8d66", 67, 1),
    ("42a6c071-830b-4815-8e2d-1ad06842cc7a", 67, 1),
    ("29c3a898-6ba3-42db-9035-60bdbf5f469a", 68, 2),
    ("18735456-4ba7-4553-9f0f-ec2af6a5661a", 68, 3),
    ("da094c87-9c6c-47dc-b45c-db1a4d652006", 68, 4),
    ("f9ebc197-6863-439b-b1b6-5fdf1e87dd2c", 68, 5),
    ("a7fe8976-e9a9-4ed6-9539-2ea8325b5d56", 68, 4),
    ("f62e77f7-44bc-4fe0-b663-4e6a323980f6", 68, 1),
    ("f4b74365-fd3a-4ec1-aa2d-368790d5a779", 70, 1),
    ("daa87169-c7c3-4581-a7f9-e0395cbeb7dd", 70, 2),
    ("ab1836b2-e125-4469-a0a3-27faa4741b92", 70, 5),
    ("f19b0465-2770-4ec2-8e6d-432dc2c14e10", 70, 1),
    ("9d87f50b-4abb-42e6-8208-17f0d8edeb28", 70, 4),
    ("1891baba-ca04-4e6f-bad2-fc79664080c2", 71, 4),
    ("f6af60c6-4bec-4720-bdc9-149c0f4fc49a", 71, 5),
    ("57aff8a8-9f41-4461-bb62-1e84d333149e", 71, 5),
    ("7c143dbf-cfe0-48b9-8372-3c98e149016f", 71, 4),
    ("bb248ba4-f00f-4ecc-9384-b9e35039c139", 71, 2),
    ("1a8438b3-a05e-415d-8f59-630cbb3645ba", 71, 2),
    ("99a9fbdc-b012-4396-a093-7df0131b8234", 71, 1),
    ("f9b59790-0c56-484a-a256-5066f982ec0a", 72, 2),
    ("1d987890-9caf-412b-8676-ccaa4b654183", 72, 2),
    ("db7e86b0-4ac6-46f4-8adc-0eaa903fd6e2", 72, 3),
    ("4ee50215-c560-42bb-ac4b-4f557b86f57c", 72, 3),
    ("c5a53523-80eb-4382-a5da-fe19aa0d0a65", 72, 5),
    ("0d81b573-6a00-4697-971c-b5c00977d15b", 72, 4),
    ("6841bf82-00cb-4889-b67a-48db553deac7", 72, 5),
    ("dfd883be-6402-4046-8270-2f1902a7ced9", 72, 1),
    ("01fbc6a2-effc-46e4-963f-801253af6c3d", 73, 5),
    ("c8db5dac-8369-4589-b198-4de39f579b00", 73, 4),
    ("e6cce80f-739a-45a8-a298-d222bfbeb0d7", 73, 5),
    ("d8fc552e-da91-46cc-bdb4-07098be5a16b", 73, 3),
    ("fac49102-6808-4bfa-9d0d-75d0fdd93ef1", 74, 3),
    ("ab07ca9f-43b1-4fe2-a0f2-0f18b5bbb226", 74, 1),
    ("3f0839c0-cdd8-41d3-83e4-1c3fda24aa22", 75, 2),
    ("83241010-3e9d-4f97-bfa8-9e64c4cd70a6", 75, 3),
    ("04ac0059-fabd-4ced-9aed-6ee9b2b8871b", 75, 1),
    ("8beb11a3-0d78-4e11-a0d8-e611437e9b14", 75, 4),
    ("44ccfde0-07f9-4297-8a78-f6e93040e196", 75, 4),
    ("abc16895-0a17-4476-9579-8cddda56c0f2", 75, 1),
    ("f4ce5405-9009-4ab6-aa64-aa894db143ed", 75, 3),
    ("3053acb9-6fd0-4881-97e9-f5dd215c977b", 76, 2),
    ("a2ea4b48-f74f-4500-8003-e840525c991d", 76, 5),
    ("f80e86bc-6e8a-4fcf-b2c7-741f3ababe3c", 76, 2),
    ("acc898cb-dc86-4657-bd92-76cd9dc18e48", 76, 5);