<script lang="ts">
	let { data } = $props()
</script>

<svelte:head>
	<title>Authors</title>
</svelte:head>

<h2>Authors</h2>

<ul class="list">
	{#each data.authors as author (author.id)}
		<li>
			<a href="/author/{author.id}">
				{author.name}
			</a>
		</li>
	{/each}
</ul>
