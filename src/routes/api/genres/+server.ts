import { db } from '$lib/server/db'
import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'

export const GET: RequestHandler = async () => {
	try {
		const { rows: genres } = await db.execute('SELECT id, name FROM genres')
		return json(genres)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch genres')
	}
}
