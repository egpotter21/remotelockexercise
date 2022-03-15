require 'csv'

class CSVReader
  # Reads CSV data and creates an array of hashes.

  def initialize(data:, separator:, date_format:)
    @data = data
    @separator = separator
    @date_format = date_format
  end

  def to_array
    return @to_array if defined? @to_array

    @to_array = []
    CSV.parse(data, col_sep: separator, headers: true).each do |row|
      hash = row.to_h
      hash['birthdate'] = convert_date(hash['birthdate'])
      @to_array << hash
    end
    @to_array
  end

  private

  def convert_date(date)
    Date.strptime(date, date_format)
  end

  attr_reader :separator, :data, :date_format
end
