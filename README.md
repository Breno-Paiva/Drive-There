# 🏎️ Drive-There 🏎️
**CAR RENTALS** - A Lifion Developer Case Study by [Breno Paiva](http://www.breno.space "Breno•Space")
******
## Data Modeling
ERD model for DriveThere database.
![erd]

## Querying
Query using ruby on rails to get all rental vehicles which are available on a given start and end date.
```ruby
# ruby
@query = ActiveRecord::Base.connection.exec_query(<<-SQL)
  SELECT *
    FROM vehicles
   WHERE vehicles.id NOT IN
         (SELECT vehicles.id
            FROM vehicles
            JOIN reservations ON vehicles.id = reservations.vehicle_id
           WHERE
                 (reservations.start_date > '#{request_start_date}'
                 AND reservations.start_date < '#{request_end_date}')
              OR (reservations.end_date > '#{request_start_date}'
                 And reservations.end_date < '#{request_end_date}'))
SQL
```

## Algorithm
A SQL query would be the best way to get the top 5 categories and make/models of most frequently rented out cars.
```sql
  -- sql
  SELECT car_type,
         make,
         model,
         SUM((JulianDay(end_date) - JulianDay(start_date))) AS days_rented
    FROM vehicles
    JOIN reservations ON vehicles.id = reservations.vehicle_id
GROUP BY car_type, make, model
ORDER BY days_rented DESC
   LIMIT 5
```
- count the number of days for each reservation
- organize data in groups based on the category and make/model
- add the the number of days in reach reservation for the total number of days a car has been rented
- organize the results in descending order and return the top 5 results

[erd]: ./drive_there_erd.png
