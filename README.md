# 🏎️ Drive-There 🏎️
**CAR RENTALS** - A Lifion Developer Case Study by [Breno Paiva](http://www.breno.space "Breno•Space")
******
## Data Modeling

## Querying
```ruby
# ruby
@query = ActiveRecord::Base.connection.exec_query(<<-SQL)
  SELECT *
  FROM vehicles
  WHERE
    vehicles.id NOT IN (
      SELECT vehicles.id
      FROM vehicles
      JOIN reservations ON vehicles.id = reservations.vehicle_id
      WHERE
      (reservations.start_date > '#{request_start_date}' AND reservations.start_date < '#{request_end_date}') OR
      (reservations.end_date > '#{request_start_date}' And reservations.end_date < '#{request_end_date}')
    )
SQL
```

## Algorithm


- list 1
- list 2
- list 3
- list 4
