class AddIncreaseAmountToCurrentRents < ActiveRecord::Migration
  def self.up
    add_column(
      :current_rents,
      :increase_amount,
      :decimal,
      {:precision => 8, :scale => 2}
    )
  end

  def self.down
    remove_column :current_rents, :increase_amount
  end
end
