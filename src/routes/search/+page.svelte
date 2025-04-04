<script lang="ts">
	import { enhance } from '$app/forms'
	import { navigating } from '$app/state'
	import { faSearch } from '@fortawesome/free-solid-svg-icons'
	import Fa from 'svelte-fa'

	let { data } = $props()
	let books = $derived(data.books)
</script>

<svelte:head>
	<title>Search for Books</title>
</svelte:head>

<h2>Search for Books</h2>

<form action="/search" method="GET" use:enhance>
	<label for="query">Query</label>
	<input
		type="search"
		id="query"
		name="q"
		placeholder="Search..."
		class="input"
		required
		value={data.query ?? ''}
	/>
	<button type="submit" class="button" disabled={!!navigating.from}>
		<Fa icon={faSearch} />
		{#if navigating.from}
			Searching...
		{:else}
			Search
		{/if}
	</button>
</form>

{#if books}
	<section>
		<h3>Results ({books.length})</h3>

		{#if books.length}
			<ul class="list">
				{#each books as book (book.id)}
					<li>
						<a href="/book/{book.id}">
							{book.title}
						</a>
					</li>
				{/each}
			</ul>
		{:else}
			<p>No books matching '{data.query}'</p>
		{/if}
	</section>
{/if}

<style>
	label {
		display: block;
		margin-bottom: 0.25rem;
	}

	input {
		display: block;
		width: 100%;
		margin-bottom: 1rem;
	}

	section {
		margin-block: 2rem;
	}
</style>
