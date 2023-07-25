require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user1) { User.create(name: 'John Doe', email: 'john@gmail.com', password: '11111111') }
  let(:user2) { User.create(name: 'Jane Smith', email: 'jane@gmail.com', password: '22222222') }

  let(:service1) do
    Service.create(
      name: 'Bugatti',
      details: 'test details',
      image: 'https://imageio.forbes.com/specials-images/imageserve/5f962df3991e5636a2f68758/0x0.jpg?format=jpg&crop=812,457,x89,y103,safe&width=1200'
    )
  end

  it 'should belong to a user and a service' do
    reservation1 = Reservation.create(date: '2020-02-02', city: 'test', user: user1, service: service1)
    reservation2 = Reservation.create(date: '2020-02-03', city: 'test', user: user2, service: service1)

    expect(reservation1.user).to eq(user1)
    expect(reservation1.service).to eq(service1)

    expect(reservation2.user).to eq(user2)
    expect(reservation2.service).to eq(service1)

    expect(reservation1.user).not_to eq(user2)
    expect(reservation2.user).not_to eq(user1)
  end
end
