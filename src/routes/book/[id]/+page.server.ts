import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import type { Book } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const id = event.params.id
	const res_book = await event.fetch(`/api/book?id=${id}`)

	if (!res_book.ok) {
		return error(res_book.status, 'Failed to fetch book')
	}

	const book: Book = await res_book.json()

	const res_rating = await event.fetch(`/api/rating?book_id=${id}`)
	if (!res_rating.ok) {
		return error(res_rating.status, 'Failed to fetch rating')
	}

	const user_rating: number | null = await res_rating.json()

	return { book, user_rating }
}
