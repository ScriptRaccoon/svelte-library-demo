import type { RequestHandler } from './$types'
import { error, json } from '@sveltejs/kit'
import { db } from '$lib/server/db'
import { BookListSchema } from '$lib/schemas'

export const GET: RequestHandler = async () => {
	try {
		const { rows } = await db.execute('SELECT id, title FROM books')
		const books = BookListSchema.parse(rows)
		return json(books)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch books')
	}
}
