class Vehicle < ApplicationRecord
  has_many :reservations
  has_many :users, through: :reservations

  validates :name, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
                    numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :image, presence: true
  validates :visible, inclusion: [true, false]

  def self.vehicles(role)
    if role == 'admin'
      vehicles = Vehicle.all
    elsif role == 'user'
      vehicles = Vehicle.where(visible: true)
    end
    { vehicles: vehicles }
  end

  def allreservations
    reservations.where('date >= ?', Date.today.to_s)
  end
end
