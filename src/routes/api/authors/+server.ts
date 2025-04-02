import { db } from '$lib/server/db'
import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { AuthorListSchema } from '$lib/schemas'

export const GET: RequestHandler = async () => {
	try {
		const { rows } = await db.execute('SELECT id, name FROM authors')
		const authors = AuthorListSchema.parse(rows)
		return json(authors)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch authors')
	}
}
