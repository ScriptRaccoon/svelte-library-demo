import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { BookListSchema } from '$lib/schemas'
import { handle_error, handle_validation } from '$lib/server/utils'

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

	const books = handle_validation(rows, BookListSchema)

	return json(books)
}
