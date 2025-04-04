import { db } from '$lib/server/db'
import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { AuthorListSchema } from '$lib/schemas'
import { handle_error } from '$lib/server/utils'

export const GET: RequestHandler = async () => {
	const { rows } = await handle_error(
		() => db.execute('SELECT id, name FROM authors'),
		'Cannot fetch authors',
	)

	const { data: authors, success } = AuthorListSchema.safeParse(rows)
	if (!success) {
		error(500, 'Invalid authors data')
	}

	return json(authors)
}
