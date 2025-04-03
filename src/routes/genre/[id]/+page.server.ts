import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import type { BookList, Genre } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const id = event.params.id

	const [res_genre, res_books] = await Promise.all([
		event.fetch(`/api/v1/genre?id=${id}`),
		event.fetch(`/api/v1/books?genre_id=${id}`),
	])

	if (!res_genre.ok) {
		return error(res_genre.status, 'Failed to fetch genre')
	}

	if (!res_books.ok) {
		return error(res_books.status, 'Failed to fetch books')
	}

	const genre: Genre = await res_genre.json()
	const books: BookList = await res_books.json()

	return { genre, books }
}
