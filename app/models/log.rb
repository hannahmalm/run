class Log < ActiveRecord::Base
    belongs_to :user
    validates :date, presence: true
    # validates :distance, numericality: { greater_than: 0}
    validates :distance, presence: true
    validates :pace, presence: true
    
 
  

  

end 