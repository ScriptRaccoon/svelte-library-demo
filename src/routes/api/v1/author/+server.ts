import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { AuthorSchema } from '$lib/schemas'
import { handle_error, handle_validation } from '$lib/server/utils'

export const GET: RequestHandler = async (event) => {
	const id = event.url.searchParams.get('id')
	if (!id) {
		error(400, 'Missing id')
	}

	const { rows } = await handle_error(
		() =>
			db.execute('SELECT id, name, birth_year FROM authors WHERE id = :id', { id }),
		'Cannot fetch author',
	)

	if (rows.length === 0) {
		error(404, 'Author not found')
	}

	const author = handle_validation(rows[0], AuthorSchema)

	return json(author)
}
