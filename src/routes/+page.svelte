<script lang="ts">
	let { data } = $props()
	let books = $derived(data.books)
</script>

<h1>Books</h1>

<ul>
	{#each books as book (book.id)}
		<li>
			<a href="/book/{book.id}">
				{book.title}
			</a>
		</li>
	{/each}
</ul>
