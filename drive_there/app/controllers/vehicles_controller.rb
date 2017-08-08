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

    request_start_date = '2017-07-10'
    request_end_date = '2017-07-29'

    @sub_query = ActiveRecord::Base.connection.exec_query(<<-SQL)
      SELECT *
      FROM vehicles
      JOIN reservations ON vehicles.id = reservations.vehicle_id
      WHERE
        (reservations.start_date > '#{request_start_date}' AND reservations.start_date < '#{request_end_date}') OR
        (reservations.end_date > '#{request_start_date}' And reservations.end_date < '#{request_end_date}')
    SQL

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
  end
end




# WHERE
# reservations.start_date < #{start_d} AND reservations.end_date < #{start_d} AND
# reservations.start_date > #{end_d} And reservations.end_date > #{end_d}
