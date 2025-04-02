import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import { z } from 'zod'

const BookSchema = z.object({
	id: z.number(),
	title: z.string(),
	author: z.string(),
	description: z.string().nullable(),
	genre: z.string(),
	genre_id: z.number(),
	published_year: z.number().nullable(),
	rating_count: z.number().min(0),
	average_rating: z.number().min(0).max(5),
})

export const load: PageServerLoad = async (event) => {
	const id = event.params.id
	const res = await event.fetch(`/api/book?id=${id}`)

	if (!res.ok) {
		return error(res.status, 'Failed to fetch book')
	}

	const book = await res.json()

	const { success, data } = BookSchema.safeParse(book)
	if (!success) {
		return error(500, 'Invalid book data')
	}

	return { book: data }
}
