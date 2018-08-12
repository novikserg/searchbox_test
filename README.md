# README

Searchbox analytics app I once wrote for an interview.

Imagine that a user is sending us search request via your asynchronous frontend framework (I'm looking at you, React), so we want to provide real-time autosuggestions,
and we also want to save the search queries for the analytics. BUT we only want to keep the final ones, so if the user searches for:
- "what"
- "what is"
- "what is love"

we only want to count the "what is love" query and don't count intermediate once into the analytics.

The app ignores further concepts such as full-text search, caching, fuzzy searching and etc. The code is not even running in a background job.
The sole purpose here is to show a simple OOP-oriented approach to the problem.

Heroku demo link: https://dry-reef-81307.herokuapp.com   
