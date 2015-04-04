class EnableHstore < ActiveRecord::Migration
  def self.up
    enable_extension "hstore" if Rails.env.development?
  end
  def self.down
    disable_extension "hstore" if Rails.env.development?
  end
end