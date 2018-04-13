require 'virtual_column'
class ActiveRecord::Base
  include ModelInstanceExtensions
end
ActiveRecord::Base.extend(ModelClassExtensions)
