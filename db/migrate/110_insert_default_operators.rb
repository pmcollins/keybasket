class InsertDefaultOperators < ActiveRecord::Migration
  def self.up
    down
    Operator.create([
      {:name => 'eq', :description => 'equal to', :method_name => '=='},
      {:name => 'ne', :description => 'not equal to', :method_name => '!='},
      {:name => 'lt', :description => 'less than', :method_name => '<'},
      {:name => 'le', :description => 'less than or equal to', :method_name => '<='},
      {:name => 'gt', :description => 'greater than', :method_name => '>'},
      {:name => 'ge', :description => 'greater than or equal to', :method_name => '>='},
      {:name => 'bt', :description => 'between', :method_name => 'between?'},
      {:name => 'nb', :description => 'not between', :method_name => 'not_between?'}
    ])
  end

  def self.down
    Operator.delete_all
  end
end
