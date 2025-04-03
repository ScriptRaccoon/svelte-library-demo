import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import type { Author, BookList } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const id = event.params.id

	const [res_author, res_books] = await Promise.all([
		event.fetch(`/api/v1/author?id=${id}`),
		event.fetch(`/api/v1/books?author_id=${id}`),
	])

	if (!res_author.ok) {
		return error(res_author.status, 'Failed to fetch author')
	}

	if (!res_books.ok) {
		return error(res_books.status, 'Failed to fetch books')
	}

	const author: Author = await res_author.json()
	const books: BookList = await res_books.json()

	return { author, books }
}
