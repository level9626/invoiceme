require 'erb'

class SafeInterpolator
  attr_reader :interpolator_errors, :interpolator_model_name, :string

  def initialize(string, model_obj)
    @string = string
    @interpolator_errors = []
    @interpolator_model_name = model_obj.class.to_s.downcase
    _get_name(model_obj)
  end

  def safe_interpolate(binding)
    _interpolator_parse
    ERB.new(string).result(binding) if interpolator_valid?
  end

  def interpolator_valid?
    !@interpolator_errors.any?
  end

  private

  def _interpolator_parse
    @interpolator_errors = []
  end

  def _get_name(model_obj)
    self.class.send(:attr_accessor, interpolator_model_name.to_sym)
    send(interpolator_model_name + '=', model_obj)
  end
end
