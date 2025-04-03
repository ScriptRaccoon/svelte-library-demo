<script lang="ts">
	import { page } from '$app/state'
	let path = $derived(page.url.pathname)
</script>

<header>
	<h1>Svelte Library Demo</h1>

	<nav>
		<ul>
			<li>
				<a class:current={path === '/'} href="/">Home</a>
			</li>
			<li>
				<a class:current={path.includes('book')} href="/books">Books</a>
			</li>
			<li>
				<a class:current={path.includes('genre')} href="/genres">Genres</a>
			</li>
			<li>
				<a class:current={path.includes('author')} href="/authors">Authors</a>
			</li>
			<li>
				<a class:current={path.includes('search')} href="/search">Search</a>
			</li>
		</ul>
	</nav>
</header>

<style>
	header {
		text-align: center;
		padding-block: 1.25rem;
		background-color: var(--primary-color);
	}

	nav {
		margin-top: 0.25rem;
	}

	ul {
		display: flex;
		justify-content: center;
		list-style: none;
		gap: 1rem;
	}

	a.current {
		color: var(--highlight-color);
	}
</style>
