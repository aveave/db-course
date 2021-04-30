-- create table 'statistic'
CREATE TABLE statistic( 
	player_name VARCHAR(100) NOT NULL, 
	player_id INT NOT NULL, 
	year_game SMALLINT NOT NULL 
	CHECK (year_game > 0), 
	points DECIMAL(12,2) 
	CHECK (points >= 0), 
	PRIMARY KEY (player_name,year_game) 
);


-- insert data into table 'statistic'
INSERT INTO statistic(player_name, player_id, year_game, points) 
VALUES ('Mike',1,2018,18), ('Jack',2,2018,14), ('Jackie',3,2018,30), 
		('Jet',4,2018,30), ('Luke',1,2019,16), ('Mike',2,2019,14), 
		('Jack',3,2019,15), ('Jackie',4,2019,28), ('Jet',5,2019,25), 
		('Luke',1,2020,19), ('Mike',2,2020,17), ('Jack',3,2020,18), 
		('Jackie',4,2020,29), ('Jet',5,2020,27);
		
-- select points by year with sorting		
select year_game, SUM(points) 
from statistic 
group by year_game 
order by year_game;

-- common table expression for the below query
with cte_year_points as (
	select year_game, SUM(points) points
	from statistic 
	group by year_game
	order by year_game
)

-- points on all players for the current and previous year
select year_game, points, LAG(points, 1)
over (
	order by year_game
)
from cte_year_points
where year_game > '2018';

-- common table expression for the below query
with cte_each_player_score as (
	select player_name, points, year_game
	from statistic
)

-- points on each player for the current and previous year
select player_name, year_game, points, LAG(points, 1) 
over (
	partition by player_name
	order by year_game
) previous_year_games
from cte_each_player_score
where year_game > '2018';