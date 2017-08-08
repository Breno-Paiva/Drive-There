class VehiclesController < ApplicationController
  def index
    @vehicles = ActiveRecord::Base.connection.exec_query(<<-SQL)
      SELECT
        *
      FROM
        vehicles
    SQL

    @reservations = ActiveRecord::Base.connection.exec_query(<<-SQL)
      SELECT
        *
      FROM
        reservations
    SQL

    #test cases
    request_start_date = '2017-07-10'
    request_end_date = '2017-07-29'

    @sub_query = ActiveRecord::Base.connection.exec_query(<<-SQL)
      SELECT *
         FROM vehicles
         JOIN reservations ON vehicles.id = reservations.vehicle_id
        WHERE
              (reservations.start_date > '#{request_start_date}'
              AND reservations.start_date < '#{request_end_date}')
           OR (reservations.end_date > '#{request_start_date}'
              And reservations.end_date < '#{request_end_date}')
    SQL

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

    @algorithm = ActiveRecord::Base.connection.exec_query(<<-SQL)
      SELECT car_type,
            make,
            model,
            SUM((JulianDay(end_date) - JulianDay(start_date))) AS days_rented
        FROM vehicles
        JOIN reservations ON vehicles.id = reservations.vehicle_id
    GROUP BY car_type, make, model
    ORDER BY days_rented DESC
       LIMIT 5
    SQL
  end
end
