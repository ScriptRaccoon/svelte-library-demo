import type { RequestHandler } from './$types'
import { error, json } from '@sveltejs/kit'
import { db } from '$lib/server/db'

export const GET: RequestHandler = async () => {
	try {
		const { rows: books } = await db.execute('SELECT id, title FROM books')
		return json(books)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch books')
	}
}
