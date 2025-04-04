import type { RequestHandler } from './$types'
import { error, json } from '@sveltejs/kit'
import { db } from '$lib/server/db'
import { BookListSchema } from '$lib/schemas'
import { handle_error } from '$lib/server/utils'

export const GET: RequestHandler = async () => {
	const { rows } = await handle_error(
		() => db.execute('SELECT id, title FROM books'),
		'Cannot fetch books',
	)

	const { data: books, success } = BookListSchema.safeParse(rows)
	if (!success) {
		error(500, 'Invalid books data')
	}

	return json(books)
}
