# 🏎️ Drive-There 🏎️
**CAR RENTALS** - A Lifion Developer Case Study by [Breno Paiva](http://www.breno.space "Breno•Space")
******
## Data Modeling
![erd]

## Querying
Sample query if application was built with ruby on rails
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
The most practical way to solve this problem would be to make a SQL query that does all the work for you as such:
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

[erd]: "./drive_there_erd.png"
