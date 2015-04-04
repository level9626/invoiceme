class EnableHstore < ActiveRecord::Migration
  def self.up
    enable_extension "hstore" if
  end
  def self.down
    disable_extension "hstore" if
  end
end