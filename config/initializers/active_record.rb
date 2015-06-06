# Active records patches
class ActiveRecord::Base
  ## Class methods
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |obj|
        csv << obj.attributes.values_at(*column_names)
      end
    end
  end

  # return instance method or, if it is blank, return string the was passed
  def or(method, string)
    send(method).blank? ? string : send(method)
  end
end
