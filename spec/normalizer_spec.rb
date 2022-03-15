
RSpec.describe Normalizer do
  describe '#normalize' do

    let(:data) do
      [
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
        }, {
          "birthdate" => Date.new(1986, 05, 29),
          "city" => "Atlanta",
          "first_name" => "Mckayla",
        }, {
          "birthdate" => Date.new(1947, 05, 04),
          "city" => "New York City",
          "first_name" => "Elliot",
        },
      ]
    end

    let(:params) do
      {
        data: data,
        order: order,
      }
    end
    let(:normalizer) { Normalizer.new(**params) }


    context 'ordering by first_name' do
      let(:order) { 'first_name' }
      it 'normalizes data and orders by first name' do
        array = normalizer.normalize

        expect(array).to eq([
          'Elliot, New York City, 5/4/1947',
          'Mckayla, Atlanta, 5/29/1986',
          'Rhiannon, Los Angeles, 4/30/1974',
          'Rigoberto, New York City, 1/5/1962',
        ])
      end
    end

    context 'ordering by birthdate' do
      let(:order) { 'birthdate' }
      it 'normalizes data and orders by first name' do
        array = normalizer.normalize

        expect(array).to eq([
          'Elliot, New York City, 5/4/1947',
          'Rigoberto, New York City, 1/5/1962',
          'Rhiannon, Los Angeles, 4/30/1974',
          'Mckayla, Atlanta, 5/29/1986',
        ])
      end
    end
  end
end
