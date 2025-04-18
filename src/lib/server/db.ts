import { DB_TOKEN, DB_URL } from '$env/static/private'
import { createClient } from '@libsql/client'

export const db = createClient({
	url: DB_URL,
	authToken: DB_TOKEN,
})
