import type { RequestHandler } from './$types'
import { json } from '@sveltejs/kit'
import { db } from '$lib/server/db'

export const GET: RequestHandler = async () => {
	const { rows: books } = await db.execute('SELECT id, title FROM books')
	return json(books)
}
