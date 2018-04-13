class RelationAttribute < ActiveRecord::Base

  TYPE_OVERRIDE = {
    'string' => 'text'
  }

  belongs_to :relation

  has_many :report_boolean_filters
  has_many :report_date_filters
  has_many :report_decimal_filters
  has_many :report_integer_filters
  has_many :report_text_filters

  has_and_belongs_to_many :reports

  def get_filter_table
    "report_#{TYPE_OVERRIDE[attribute_type] || attribute_type}_filters"
  end

  def to_s
    "#{relation} #{name.deunderscore}"
  end

end
