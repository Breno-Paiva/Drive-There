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

    start_d = '2017-07-10'
    end_d = '2017-07-29'
    attrs = { start_day: start_d, end_day: end_d }

    @sub_query = ActiveRecord::Base.connection.exec_query(<<-SQL)
      SELECT *
      FROM vehicles
      JOIN reservations ON vehicles.id = reservations.vehicle_id
      WHERE
        (reservations.start_date > '#{start_d}' AND reservations.start_date < '#{end_d}') OR
        (reservations.end_date > '#{start_d}' And reservations.end_date < '#{end_d}')
    SQL
  
    @query = ActiveRecord::Base.connection.exec_query(<<-SQL)
      SELECT
        *
      FROM
        vehicles
      WHERE
        vehicles.id NOT IN (
          SELECT vehicles.id
          FROM vehicles
          JOIN reservations ON vehicles.id = reservations.vehicle_id
          WHERE
          (reservations.start_date > '#{start_d}' AND reservations.start_date < '#{end_d}') OR
          (reservations.end_date > '#{start_d}' And reservations.end_date < '#{end_d}')
        )
    SQL

  end
end




# WHERE
# reservations.start_date < #{start_d} AND reservations.end_date < #{start_d} AND
# reservations.start_date > #{end_d} And reservations.end_date > #{end_d}
