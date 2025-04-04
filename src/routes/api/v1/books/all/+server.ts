import type { RequestHandler } from './$types'
import { json } from '@sveltejs/kit'
import { db } from '$lib/server/db'
import { BookListSchema } from '$lib/schemas'
import { handle_error, handle_validation } from '$lib/server/utils'

export const GET: RequestHandler = async () => {
	const { rows } = await handle_error(
		() => db.execute('SELECT id, title FROM books'),
		'Cannot fetch books',
	)

	const books = handle_validation(rows, BookListSchema)

	return json(books)
}
