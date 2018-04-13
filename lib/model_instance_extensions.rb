module ModelInstanceExtensions
  def to_s
    self.respond_to?(:name) ? self.name : self.id
  end
  def partial_path
    "/#{self.class.table_name}/#{id}"
  end
end
