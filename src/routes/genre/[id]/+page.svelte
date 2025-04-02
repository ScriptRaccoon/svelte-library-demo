<script lang="ts">
	let { data } = $props()
	let genre = $derived(data.genre)
	let books = $derived(data.books)
</script>

<svelte:head>
	<title>{genre.name}</title>
</svelte:head>

<h2>{genre.name}</h2>

<p>{genre.description}</p>

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
	<p>No books are available within that genre</p>
{/if}
