import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { AuthorSchema } from '$lib/schemas'

export const GET: RequestHandler = async (event) => {
	const id = event.url.searchParams.get('id')
	if (!id) {
		return error(400, 'Missing id')
	}
	try {
		const sql = 'SELECT id, name, birth_year FROM authors WHERE id = :id'
		const { rows } = await db.execute(sql, { id })
		if (rows.length === 0) {
			return error(404, 'Author not found')
		}
		const { data: author, success } = AuthorSchema.safeParse(rows[0])
		if (!success) {
			return error(500, 'Invalid author data')
		}
		return json(author)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch author')
	}
}
