class CreateFloorPlansVacancyNotifications < ActiveRecord::Migration
  def self.up
    create_table :floor_plans_vacancy_notifications, :id => false do |t|
      t.column :floor_plan_id, :integer, :null => false
      t.column :vacancy_notification_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :floor_plans_vacancy_notifications
  end
end
