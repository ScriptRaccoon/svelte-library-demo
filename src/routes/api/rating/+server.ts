import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { z } from 'zod'

const RequestSchema = z.object({
	book_id: z.number(),
	rating: z.number().min(1).max(5),
})

export const POST: RequestHandler = async (event) => {
	try {
		const body = await event.request.json()
		const { book_id, rating } = RequestSchema.parse(body)
		const sql = 'INSERT INTO ratings (book_id, rating) VALUES (:book_id, :rating)'
		await db.execute(sql, { book_id, rating })
		return json({ message: 'Rating received' })
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot save rating')
	}
}
