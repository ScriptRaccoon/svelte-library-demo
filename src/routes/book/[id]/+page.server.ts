import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import type { Book } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const id = event.params.id

	const [res_book, res_rating] = await Promise.all([
		event.fetch(`/api/v1/book?id=${id}`),
		event.fetch(`/api/v1/userrating?book_id=${id}`),
	])

	if (!res_book.ok) {
		error(res_book.status, 'Failed to fetch book')
	}

	const book: Book = await res_book.json()

	if (!res_rating.ok) {
		error(res_rating.status, 'Failed to fetch rating')
	}

	const user_rating: number | null = await res_rating.json()

	return { book, user_rating }
}
