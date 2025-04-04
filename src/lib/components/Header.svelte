<script lang="ts">
	import { page } from '$app/state'
	import {
		faBookOpen,
		faHomeAlt,
		faLayerGroup,
		faSearch,
		faUsers,
	} from '@fortawesome/free-solid-svg-icons'
	import Fa from 'svelte-fa'
	let path = $derived(page.url.pathname)
</script>

<header>
	<h1>Svelte Library Demo</h1>

	<nav>
		<ul>
			<li class:current={path === '/'}>
				<Fa icon={faHomeAlt} />
				<a href="/">Home</a>
			</li>
			<li class:current={path.includes('book')}>
				<Fa icon={faBookOpen} />
				<a href="/books">Books</a>
			</li>
			<li class:current={path.includes('genre')}>
				<Fa icon={faLayerGroup} />
				<a href="/genres">Genres</a>
			</li>
			<li class:current={path.includes('author')}>
				<Fa icon={faUsers} />
				<a href="/authors">Authors</a>
			</li>
			<li class:current={path.includes('search')}>
				<Fa icon={faSearch} />
				<a href="/search">Search</a>
			</li>
		</ul>
	</nav>
</header>

<style>
	header {
		text-align: center;
		padding-block: 1.25rem;
		background-color: var(--primary-color);
		text-wrap: balance;
	}

	nav {
		margin-top: 0.5rem;
	}

	ul {
		display: flex;
		justify-content: center;
		flex-wrap: wrap;
		list-style: none;
		gap: 0.25rem 1rem;
	}

	li.current {
		color: var(--highlight-color);
	}
</style>
