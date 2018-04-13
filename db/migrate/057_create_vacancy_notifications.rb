class CreateVacancyNotifications < ActiveRecord::Migration
  def self.up
    create_table :vacancy_notifications do |t|
      t.column :contact_id, :integer
      t.column :property_id, :integer
      t.column :expires_on, :date
    end
  end

  def self.down
    drop_table :vacancy_notifications
  end
end
