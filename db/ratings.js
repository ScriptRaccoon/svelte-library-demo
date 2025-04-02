// generate random ratings

import fs from 'fs'

let output = ''

for (let book_id = 1; book_id <= 77; book_id++) {
	const number_ratings = Math.floor(Math.random() * 10)
	for (let j = 1; j <= number_ratings; j++) {
		const rating = Math.floor(Math.random() * 5) + 1
		const user_id = crypto.randomUUID()
		const entry = `("${user_id}", ${book_id}, ${rating}),\n`
		output += entry
	}
}

fs.writeFileSync('ratings.txt', output, 'utf8')
