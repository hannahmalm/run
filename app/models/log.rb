class Log < ActiveRecord::Base
    belongs_to :user
    validates :date, presence: true
    validates :distance, numericality: { greater_than: 0}
    validates :distance, presence: true
    validates :pace, presence: true
    validates :avg_heart_rate, numericality: { greater_than: 30}
    validate :date_cannot_be_in_the_future
 
  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "Date cannot be in the future")
    end
  end

  

end 