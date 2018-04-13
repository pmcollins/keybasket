class Date
  def <=> (other)
    case other
      when Numeric; return @ajd <=> other
      when Date;    return @ajd <=> other.ajd
      when Time;    return to_time <=> other
    end
    nil
  end
end
