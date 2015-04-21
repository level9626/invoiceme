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
end