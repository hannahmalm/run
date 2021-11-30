class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.date :date
      t.decimal :distance
      t.string :pace
      t.integer :avg_heart_rate
      t.string :notes
      t.integer :user_id
    end 
  end
end


#Use decimal when numbers need to be precise
#Use integer when only allowing whole numbers 