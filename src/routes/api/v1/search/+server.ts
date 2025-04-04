import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { BookListSchema } from '$lib/schemas'
import { handle_error } from '$lib/server/utils'

export const GET: RequestHandler = async (event) => {
	const query = event.url.searchParams.get('q')
	if (!query) {
		error(400, 'Missing query parameter')
	}

	const { rows } = await handle_error(
		() =>
			db.execute(
				'SELECT id, title FROM books WHERE title LIKE ? OR description LIKE ?',
				[`%${query}%`, `%${query}%`],
			),
		'Search failed',
	)

	const { data: books, success } = BookListSchema.safeParse(rows)
	if (!success) {
		error(500, 'Invalid books data')
	}

	return json(books)
}
