<script lang="ts">
	let { data } = $props()
	let author = $derived(data.author)
	let books = $derived(data.books)
</script>

<svelte:head>
	<title>{author.name}</title>
</svelte:head>

<h2>{author.name}</h2>

{#if author.birth_year}
	<p>Born in {author.birth_year}</p>
{/if}

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
