<script lang="ts">
	import StarRating from 'svelte-star-rating'
	let { data } = $props()
	let book = $derived(data.book)

	const rating_texts = ['Terrible', 'Bad', 'Okay', 'Good', 'Excellent']

	let user_rating = $state<null | number>(null)
	let form_status = $state('')

	async function handle_submit(e: SubmitEvent) {
		e.preventDefault()
		form_status = ''
		const res = await fetch('/api/rating', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				book_id: book.id,
				rating: user_rating,
			}),
		})
		form_status = res.ok ? 'Rating submitted!' : 'Error submitting rating'
	}
</script>

<svelte:head>
	<title>{book.title}</title>
</svelte:head>

<h2>{book.title}</h2>

<section class="rating-container" aria-label="rating">
	<StarRating rating={book.average_rating} />
	<div class="rating-description">
		{book.average_rating.toFixed(1)} (based on {book.rating_count} ratings)
	</div>
</section>

<section aria-label="book details">
	<p class="year">{book.published_year}</p>

	<p class="author">by {book.author}</p>

	<div>
		<a class="genre" href="/genre/{book.genre_id}">
			{book.genre}
		</a>
	</div>

	<p class="description">{book.description}</p>
</section>

<section>
	<h3>Rate the book</h3>

	<form class="rating-form" onsubmit={handle_submit}>
		<select bind:value={user_rating} class="select" required>
			{#each { length: 5 } as _, i}
				<option value={i + 1}>{i + 1} &ndash; {rating_texts[i]}</option>
			{/each}
		</select>
		<button class="button" type="submit">Submit rating</button>
	</form>

	<div class="form_status" aria-live="polite">
		{form_status}
	</div>
</section>

<style>
	.rating-container {
		display: flex;
		align-items: start;
		gap: 0.25rem;
	}

	.rating-description {
		color: var(--secondary-font-color);
	}

	.rating-form {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
		margin-block: 0.5rem;

		@media (min-width: 600px) {
			flex-direction: row;
			gap: 1rem;
		}
	}

	.year {
		color: var(--secondary-font-color);
		font-size: 1.25rem;
	}

	.author {
		font-style: italic;
		font-size: 1.25rem;
	}

	.genre {
		display: inline-block;
		text-decoration: none;
		background-color: var(--primary-color);
		padding: 0.15rem 0.8rem;
		border-radius: 100vw;
		font-weight: bold;
		font-size: 0.825rem;
		text-transform: uppercase;
	}

	.description {
		font-size: 1.25rem;
	}
</style>
