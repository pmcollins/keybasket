namespace :db do
  desc 'Generate fixtures from a database'
  task :fixturize => :environment do
    sql  = 'SELECT * FROM %s'
    ActiveRecord::Base.establish_connection
    table_list = nil
    if ENV.include?('table')
      table_list = [ENV['table']]
    else
      table_list = ActiveRecord::Base.connection.tables - [
        'schema_info', 'photos'
      ]
    end
    table_list.each do |table_name|
      i = '000'
      File.open("#{RAILS_ROOT}/test/fixtures/#{table_name}.yml", 'w') do |file|
        data = ActiveRecord::Base.connection.select_all(sql % table_name)
        stuff = data.inject({}) do |hash, record|
          hash["#{table_name}_#{i.succ!}"] = record
          hash
        end.to_yaml
        file.write stuff
      end
    end
  end
end
