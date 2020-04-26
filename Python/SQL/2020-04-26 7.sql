/* In 7.sql, write a SQL query to list all movies released in 2010 and their ratings, in descending order by rating. 
For movies with the same rating, order them alphabetically by title. */

/* Don't have to create a new table from scratch, just specify the table and column*/
SELECT movies.title, ratings.rating
FROM movies JOIN ratings 
WHERE movies.id = ratings.movie_id

/* Set the order by rating descending, then for same rating, alphabetically by title*/
ORDER BY rating DESC, title;
