import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import { type BookList } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const res = await event.fetch('/api/books')

	if (!res.ok) {
		return error(res.status, 'Failed to fetch books')
	}

	const books: BookList = await res.json()

	return { books }
}
