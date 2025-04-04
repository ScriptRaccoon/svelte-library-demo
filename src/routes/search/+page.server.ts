import type { BookList } from '$lib/schemas.js'
import { error } from '@sveltejs/kit'

export const load = async (event) => {
	const query = event.url.searchParams.get('q')
	if (!query) {
		return { query, books: null }
	}

	const res = await event.fetch(`/api/v1/search?q=${encodeURIComponent(query)}`)

	if (!res.ok) {
		error(res.status, 'Search failed')
	}

	const books: BookList = await res.json()

	return { query, books }
}
