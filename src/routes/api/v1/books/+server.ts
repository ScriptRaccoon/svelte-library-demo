import type { RequestHandler } from './$types'
import { error, json } from '@sveltejs/kit'
import { db } from '$lib/server/db'
import { BookListSchema } from '$lib/schemas'

function query_books(genre_id: string | null, author_id: string | null) {
	if (genre_id && author_id) {
		return db.execute(
			'SELECT id, title FROM books WHERE genre_id = :genre_id AND author_id = :author_id',
			{ genre_id, author_id },
		)
	} else if (genre_id && !author_id) {
		return db.execute('SELECT id, title FROM books WHERE genre_id = :genre_id', {
			genre_id,
		})
	} else if (!genre_id && author_id) {
		return db.execute('SELECT id, title FROM books WHERE author_id = :author_id', {
			author_id,
		})
	}
	return db.execute('SELECT id, title FROM books')
}

export const GET: RequestHandler = async (event) => {
	const genre_id = event.url.searchParams.get('genre_id')
	const author_id = event.url.searchParams.get('author_id')
	try {
		const { rows } = await query_books(genre_id, author_id)
		const { data: books, success } = BookListSchema.safeParse(rows)
		if (!success) {
			error(500, 'Invalid books data')
		}
		return json(books)
	} catch (err) {
		console.error(err)
		error(500, 'Cannot fetch books')
	}
}
