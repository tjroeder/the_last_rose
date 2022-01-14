class Bachelorette < ApplicationRecord
  has_many :contestants
  has_many :contestant_outings, through: :contestants  
  has_many :outings, through: :contestant_outings

  validates_presence_of :name, :season_number, :desc

  def contestant_avg_age
    return 0 if contestants.count == 0
    contestants.average(:age)
  end

  def contestants_hometowns
    contestants.distinct.pluck(:hometown)
  end
end
