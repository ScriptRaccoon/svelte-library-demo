import { db } from '$lib/server/db'
import { json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'

export const GET: RequestHandler = async () => {
	const { rows: genres } = await db.execute('SELECT id, name FROM genres')
	return json(genres)
}
