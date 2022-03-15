require 'spec_helper'

RSpec.describe CSVReader do
  describe '#to_array' do
    let(:params) do
      {
        data: File.read(filepath),
        separator: separator,
        date_format: date_format ,
      }
    end
    let(:csv_reader) { CSVReader.new(**params) }


    context 'with a dollar separator and %d-%m-%Y date format' do
      let(:date_format) { '%d-%m-%Y' }
      let(:separator) { ' $ ' }
      let(:filepath) { 'spec/fixtures/people_by_dollar.txt' }

      it 'creates an array with needed data' do
        array = csv_reader.to_array

        expect(array).to eq([
          {
            "birthdate" => Date.new(1974, 04, 30),
            "city" => "LA",
            "first_name" => "Rhiannon",
            "last_name" => "Nolan",
          }, {
            "birthdate" => Date.new(1962, 01, 05),
            "city" => "NYC",
            "first_name" => "Rigoberto",
            "last_name" => "Bruen",
          }
        ])
      end
    end

    context 'with a percent separator and %Y-%m-%d date format' do
      let(:date_format) { '%Y-%m-%d' }
      let(:separator) { ' % ' }
      let(:filepath) { 'spec/fixtures/people_by_percent.txt' }

      it 'creates an array with needed data' do
        array = csv_reader.to_array

        expect(array).to eq([
          {
            "birthdate" => Date.new(1986, 05, 29),
            "city" => "Atlanta",
            "first_name" => "Mckayla",
          }, {
            "birthdate" => Date.new(1947, 05, 04),
            "city" => "New York City",
            "first_name" => "Elliot",
          }
        ])
      end
    end
  end
end
