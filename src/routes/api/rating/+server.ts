import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'

export const POST: RequestHandler = async (event) => {
	try {
		const body = await event.request.json()
		const { book_id, rating } = body
		const sql = 'INSERT INTO ratings (book_id, rating) VALUES (:book_id, :rating)'
		await db.execute(sql, { book_id, rating })
		return json({ message: 'Rating received' })
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot save rating')
	}
}
