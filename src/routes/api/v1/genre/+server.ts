import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { GenreSchema } from '$lib/schemas'

export const GET: RequestHandler = async (event) => {
	const id = event.url.searchParams.get('id')
	if (!id) {
		error(400, 'Missing id')
	}
	try {
		const sql = 'SELECT id, name, description FROM genres WHERE id = :id'
		const { rows } = await db.execute(sql, { id })
		if (rows.length === 0) {
			error(404, 'Genre not found')
		}
		const { data: genre, success } = GenreSchema.safeParse(rows[0])
		if (!success) {
			error(500, 'Invalid genre data')
		}
		return json(genre)
	} catch (err) {
		console.error(err)
		error(500, 'Cannot fetch genre')
	}
}
