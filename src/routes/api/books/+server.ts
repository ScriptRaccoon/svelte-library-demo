import type { RequestHandler } from './$types'
import { error, json } from '@sveltejs/kit'
import { db } from '$lib/server/db'
import { BookListSchema, type BookList } from '$lib/schemas'

export const GET: RequestHandler = async (event) => {
	const genre_id = event.url.searchParams.get('genre_id')
	try {
		const query = genre_id
			? 'SELECT id, title FROM books WHERE genre_id = :genre_id'
			: 'SELECT id, title FROM books'
		const args = genre_id ? { genre_id } : undefined
		const { rows } = await db.execute(query, args)
		const books: BookList = BookListSchema.parse(rows)
		return json(books)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch books')
	}
}
