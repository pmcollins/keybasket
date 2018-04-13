class VirtualColumn
  attr_reader :name, :type, :meth
  def initialize(h)
    h.each do |n, v|
      self.instance_variable_set("@#{n}".to_sym, v)
    end
  end
end
