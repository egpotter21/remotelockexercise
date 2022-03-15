require_relative 'cities'

class Normalizer
  # Received an array of hashes, that must contain first name, city and
  # birthdate.

  DATE_OUTPUT_FORMAT = '%-m/%-d/%Y'.freeze
  OUTPUT_COLUMNS = ['first_name', 'city', 'birthdate'].freeze

  def initialize(data:, order:)
    @data = data
    @order = order.to_s
  end

  def normalize
    return @normalize if defined? @normalize

    @normalize = ""
    @data.each do |row| end

    data.each { |row| row['city'] = normalize_city(row['city']) }
    sorted = data.sort_by { |row| row[order]}
    @normalized = sorted.map do |row|
      "#{row['first_name']}, #{row['city']}, #{normalize_date(
        row['birthdate'])}"
    end
  end

  private

  def normalize_date(date)
    date.strftime(DATE_OUTPUT_FORMAT)
  end

  def normalize_city(city)
    CITIES[city] ? CITIES[city] : city
  end

  attr_reader :data, :order
end
