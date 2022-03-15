require_relative 'csv_reader'
require_relative 'normalizer'

class PeopleController
  # In case a new file must be added, the param name, separator and date format
  # must be specified here.

  CSV_ENTRIES = [
    { data: :dollar_format, separator: ' $ ', date_format: '%d-%m-%Y' },
    { data: :percent_format, separator: ' % ', date_format: '%Y-%m-%d' },
  ].freeze

  def initialize(params)
    @params = params
  end

  def normalize
    Normalizer.new(data: merged_data, order: params[:order]).normalize
  end

  private

  def merged_data
    @merged_data ||=  CSV_ENTRIES.map do |csv|
      CSVReader.new(data: params[csv[:data]], separator: csv[:separator],
        date_format: csv[:date_format]).to_array
    end.flatten
  end

  def order
    @order ||= params['order']
  end

  attr_reader :params
end
