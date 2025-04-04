import { db } from '$lib/server/db'
import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { GenreListSchema } from '$lib/schemas'
import { handle_error } from '$lib/server/utils'

export const GET: RequestHandler = async () => {
	const { rows } = await handle_error(
		() => db.execute('SELECT id, name FROM genres'),
		'Cannot fetch genres',
	)

	const { data: genres, success } = GenreListSchema.safeParse(rows)
	if (!success) {
		error(500, 'Invalid genres data')
	}

	return json(genres)
}
