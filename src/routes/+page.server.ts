import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import { z } from 'zod'

const BookListSchema = z.array(
	z.object({
		id: z.number(),
		title: z.string(),
	}),
)

export const load: PageServerLoad = async ({ fetch }) => {
	const res = await fetch('/api/books')

	if (!res.ok) {
		return error(res.status, 'Failed to fetch books')
	}

	const books = await res.json()

	const { success, data } = BookListSchema.safeParse(books)
	if (!success) {
		return error(500, 'Invalid books data')
	}

	return { books: data }
}
