# Removes 'null' string if it is the only content in hash
# may be used to build API on resource update
module RemoveNulls
  def remove_nulls
    self.delete_if { |k, v| v == "null" }
    self.each { |k, v| v.remove_nulls if v.is_a? Hash }
  end
end

class ActionController::Parameters; include RemoveNulls; end
class ActiveSupport::HashWithIndifferentAccess; include RemoveNulls; end
class Hash; include RemoveNulls; end