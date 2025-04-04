# Svelte Library Demo

This is a demo on how to work with a SQLite database (hosted on [Turso](https://turso.tech/)) and [SvelteKit](https://svelte.dev/).

## Database structure

```mermaid
erDiagram
    authors {
        INTEGER id PK
        TEXT name
        INTEGER birth_year
    }

    genres {
        INTEGER id PK
        TEXT name
        TEXT description
    }

    books {
        INTEGER id PK
        TEXT title
        INTEGER author_id FK
        INTEGER genre_id FK
        INTEGER published_year
        TEXT description
    }

    ratings {
        INTEGER id PK
        TEXT user_id
        INTEGER book_id FK
        INTEGER rating
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    authors ||--o{ books : writes
    genres ||--o{ books : includes
    books ||--o{ ratings : receives

```

## Features of the app

1. View list of books
2. View list of authors
3. View list of genres
4. Search within books (title and description)
5. View details of a book (title, description, author, genre, year, ratings)
6. View details of an author (birth year, list of their books)
7. View details of a genre (description, list of books within that genre)
8. Rate a book
9. Update a rating

## Setup of the repository

### Prerequisites

Node.js, pnpm, Turso account

### Steps

- Create the `.env` file based on `.env.example` with the connection details of a Turso database
- Seed the local database with `pnpm:seed` (this uses `seed.sql`)
- Install the dependencies: `pnpm install`
- Run the development server: `pnpm dev`

Notice that `seed.sql` contains a lot of fake ratings for the purpose of displaying some data.
