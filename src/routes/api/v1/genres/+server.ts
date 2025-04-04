import { db } from '$lib/server/db'
import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { GenreListSchema } from '$lib/schemas'

export const GET: RequestHandler = async () => {
	try {
		const { rows } = await db.execute('SELECT id, name FROM genres')
		const { data: genres, success } = GenreListSchema.safeParse(rows)
		if (!success) {
			error(500, 'Invalid genres data')
		}
		return json(genres)
	} catch (err) {
		console.error(err)
		error(500, 'Cannot fetch genres')
	}
}
