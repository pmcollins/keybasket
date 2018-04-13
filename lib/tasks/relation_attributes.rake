namespace :db do
  desc 'Insert relation attributes from model introspections'
  task :relation_attributes => :environment do
    ActiveRecord::Base.establish_connection
    RelationAttribute.delete_all
    Relation.find(:all).each do |relation|
      relation.get_searchable_columns.each do |column|
        name = column.name
        type = column.type.to_s
        print '.'
        relation.relation_attributes.create(
          :name => name,
          :attribute_type => type
        )
      end
    end
    puts
  end
end
