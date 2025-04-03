import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { BookListSchema } from '$lib/schemas'

export const GET: RequestHandler = async (event) => {
	const query = event.url.searchParams.get('q')
	if (!query) {
		return error(400, 'Missing query parameter')
	}
	try {
		const { rows } = await db.execute(
			'SELECT id, title FROM books WHERE title LIKE ? OR description LIKE ?',
			[`%${query}%`, `%${query}%`],
		)
		const books = BookListSchema.parse(rows)
		return json(books)
	} catch (err) {
		console.error(err)
		return error(500, 'Search failed')
	}
}
