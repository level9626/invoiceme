class StateMachines::Transition
  def to_h
    {event: event, from: from, to: to}
  end
end