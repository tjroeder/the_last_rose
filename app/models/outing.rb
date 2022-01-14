class Outing < ApplicationRecord
  has_many :contestant_outings
  has_many :contestants, through: :contestant_outings
  has_many :bachelorettes, through: :contestants

  validates_presence_of :name, :location, :date

  def date_formatter
    date.strftime("%m/%d/%Y")
  end

  def contestant_count
    contestants.count
  end
end
