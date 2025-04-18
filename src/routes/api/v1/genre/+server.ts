import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { GenreSchema } from '$lib/schemas'
import { handle_error, handle_validation } from '$lib/server/utils'

export const GET: RequestHandler = async (event) => {
	const id = event.url.searchParams.get('id')
	if (!id) {
		error(400, 'Missing id')
	}

	const { rows } = await handle_error(
		() =>
			db.execute('SELECT id, name, description FROM genres WHERE id = :id', { id }),
		'Cannot fetch genre',
	)

	if (rows.length === 0) {
		error(404, 'Genre not found')
	}

	const genre = handle_validation(rows[0], GenreSchema)

	return json(genre)
}
