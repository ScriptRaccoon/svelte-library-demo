<script lang="ts">
	import Header from '$lib/components/Header.svelte'
	import './app.css'
</script>

<Header />

<main>
	<slot></slot>
</main>

<style>
	main {
		max-width: 42rem;
		margin-inline: auto;
		padding: 1rem;
		margin-bottom: 1rem;
	}
</style>
