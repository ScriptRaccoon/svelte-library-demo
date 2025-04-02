<script lang="ts">
	import StarRating from 'svelte-star-rating'
	let { data } = $props()
	let book = $derived(data.book)
</script>

<svelte:head>
	<title>{book.title}</title>
</svelte:head>

<h2>{book.title}</h2>

<section class="rating-container" aria-label="rating">
	<StarRating rating={book.average_rating} />
	<div class="rating-description">
		{book.average_rating} (based on {book.rating_count} ratings)
	</div>
</section>

<p class="year">{book.published_year}</p>

<p class="author">by {book.author}</p>

<div>
	<a class="genre" href="/genre/{book.genre_id}">
		{book.genre}
	</a>
</div>

<p class="description">{book.description}</p>

<style>
	.rating-container {
		display: flex;
		align-items: start;
		gap: 0.25rem;
	}

	.rating-description {
		color: var(--secondary-font-color);
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
