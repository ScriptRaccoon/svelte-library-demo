export const prerender = true

import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import { type BookList } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const res = await event.fetch('/api/v1/books/all')

	if (!res.ok) {
		error(res.status, 'Failed to fetch books')
	}

	const books: BookList = await res.json()

	return { books }
}
