import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { GenreSchema } from '$lib/schemas'

export const GET: RequestHandler = async (event) => {
	const id = event.url.searchParams.get('id')
	if (!id) {
		return error(400, 'Missing id')
	}
	try {
		const sql = 'SELECT id, name, description FROM genres WHERE id = :id'
		const { rows } = await db.execute(sql, { id })
		if (rows.length === 0) {
			return error(404, 'Genre not found')
		}
		const genre = GenreSchema.parse(rows[0])
		return json(genre)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch genre')
	}
}
