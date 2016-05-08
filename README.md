# Know Your Masteries

This is the repository for our entry in the RIOT API Challenge 2016, hope you enjoy.

### What is it about?

Know Your Masteries is a web application that aims to understand if there's a clear relation in the player performance for a champion he mains and his performance  with that champion in Ranked matches. We compare the mastery stats with the ranked data in the players accounts.

The goal of this project is to understand if players who main a champion (have that champion on top of their mastery score) perform better than players who doesn't main that champion. 

The application stores the data for a player that has been searched, that way we can create a database of summoners data, as there's no way of getting a list of active summoners to get, and displays the aggregated stats of this data.

### Technologies used in this project

- Ruby and Ruby on Rails for the backend
- Bootstrap, ReactJS, JQuery and SASS for the frontend
- HighCharts with KickCharts for charting
- PostgreSQL to store the data
- Heroku to host the demo
- Lots of automated patience because of the daily 4 hours blackouts in Venezuela (and a lot of swears)

### Want to run this project?

```
fork
git clone
rake db:create
rake db:setup
rails server Puma
```