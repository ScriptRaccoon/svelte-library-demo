<script lang="ts">
	let { data } = $props()
	let book = $derived(data.book)
</script>

<svelte:head>
	<title>{book.title}</title>
</svelte:head>

<h1>{book.title}</h1>

<p>{book.published_year}</p>

<p>{book.author}</p>

<p>{book.genre}</p>

<p>{book.description}</p>
