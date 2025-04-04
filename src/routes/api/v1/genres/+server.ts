import { db } from '$lib/server/db'
import { json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { GenreListSchema } from '$lib/schemas'
import { handle_error, handle_validation } from '$lib/server/utils'

export const GET: RequestHandler = async () => {
	const { rows } = await handle_error(
		() => db.execute('SELECT id, name FROM genres'),
		'Cannot fetch genres',
	)

	const genres = handle_validation(rows, GenreListSchema)

	return json(genres)
}
