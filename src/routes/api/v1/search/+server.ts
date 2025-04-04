import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { BookListSchema } from '$lib/schemas'

export const GET: RequestHandler = async (event) => {
	const query = event.url.searchParams.get('q')
	if (!query) {
		error(400, 'Missing query parameter')
	}
	try {
		const { rows } = await db.execute(
			'SELECT id, title FROM books WHERE title LIKE ? OR description LIKE ?',
			[`%${query}%`, `%${query}%`],
		)
		const { data: books, success } = BookListSchema.safeParse(rows)
		if (!success) {
			error(500, 'Invalid books data')
		}
		return json(books)
	} catch (err) {
		console.error(err)
		error(500, 'Search failed')
	}
}
