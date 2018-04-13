class Date
  def to_default_s
    to_s(:rfc822)
  end
end
