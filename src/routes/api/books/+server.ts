import type { RequestHandler } from './$types'
import { error, json } from '@sveltejs/kit'
import { db } from '$lib/server/db'
import { BookListSchema, type BookList } from '$lib/schemas'

export const GET: RequestHandler = async (event) => {
	const genre_id = event.url.searchParams.get('genre_id')
	const author_id = event.url.searchParams.get('author_id')
	try {
		const query = get_query(genre_id, author_id)
		const { rows } = await db.execute(query, { genre_id, author_id })
		const books: BookList = BookListSchema.parse(rows)
		return json(books)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch books')
	}
}

function get_query(genre_id: string | null, author_id: string | null): string {
	if (genre_id && author_id) {
		return 'SELECT id, title FROM books WHERE genre_id = :genre_id AND author_id = :author_id'
	}
	if (genre_id && !author_id) {
		return 'SELECT id, title FROM books WHERE genre_id = :genre_id'
	}
	if (author_id && !genre_id) {
		return 'SELECT id, title FROM books WHERE author_id = :author_id'
	}
	return 'SELECT id, title FROM books'
}
