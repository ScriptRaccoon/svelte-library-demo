export const prerender = true

import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import { type AuthorList } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const res = await event.fetch('/api/v1/authors')

	if (!res.ok) {
		error(res.status, 'Failed to fetch authors')
	}

	const authors: AuthorList = await res.json()

	return { authors }
}
