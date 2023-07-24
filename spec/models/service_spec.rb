require 'rails_helper'

RSpec.describe Service, type: :model do
  subject do
    Service.new(name: 'Car Rental', description: 'Rent a car for your trip')
  end
  it 'should have reservations' do
    service1 = Service.create(name: 'Bugatti', details: 'test details', image: 'https://imageio.forbes.com/specials-images/imageserve/5f962df3991e5636a2f68758/0x0.jpg?format=jpg&crop=812,457,x89,y103,safe&width=1200')
    service2 = Service.create(name: 'Aston Martin', details: 'test details', image: 'https://carwow-uk-wp-3.imgix.net/18015-MC20BluInfinito-scaled-e1666008987698.jpg')
    service3 = Service.create(name: 'BMW', details: 'test details', image: 'https://www.autocar.co.uk/sites/autocar.co.uk/files/images/car-reviews/first-drives/legacy/99-best-luxury-cars-2023-bmw-i7-lead.jpg')

    user1 = User.create(name: 'John Doe', email: 'john@example.com', password: '12345678')
    user2 = User.create(name: 'Jane Smith', email: 'jane@example.com', password: '87654321')
    user3 = User.create(name: 'Bob Johnson', email: 'bob@example.com', password: 'abcd1234')

    Reservation.create(date: '2020-02-02', city: 'test', user: user1, service: service1)
    Reservation.create(date: '2020-02-02', city: 'test', user: user2, service: service2)
    Reservation.create(date: '2020-02-02', city: 'test', user: user2, service: service2)
    Reservation.create(date: '2020-02-02', city: 'test', user: user3, service: service3)

    expect(service1.reservations.count).to eq(1)
    expect(service2.reservations.count).to eq(2)
    expect(service3.reservations.count).to eq(1)
  end
end
