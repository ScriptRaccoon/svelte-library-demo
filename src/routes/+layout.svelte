<script lang="ts">
	import './app.css'
</script>

<header>
	<h1>Svelte Library Demo</h1>
</header>

<nav>
	<ul>
		<li>
			<a href="/">Books</a>
		</li>
		<li>
			<a href="/genres">Genres</a>
		</li>
	</ul>
</nav>

<main>
	<slot></slot>
</main>

<style>
	header {
		text-align: center;
		padding-top: 1rem;
	}

	nav {
		padding-block: 0.5rem;
	}

	ul {
		display: flex;
		justify-content: center;
		list-style: none;
		gap: 1rem;
	}

	main {
		max-width: 54rem;
		margin-inline: auto;
		padding-inline: 1rem;
	}
</style>
