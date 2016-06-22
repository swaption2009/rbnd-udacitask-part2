class TodoItem
  require 'chronic'
  include Listable
  include UdaciListErrors

  attr_reader :description, :due, :priority

  @@priorities = [nil, "low", "medium", "high"]

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    validate_priority(options[:priority])
  end

  private

  def validate_priority(priority)
    if @@priorities.include? priority
      @priority = priority
    else
      raise UdaciListErrors::InvalidPriorityValue, "#{priority} is not a valid entry."
    end
  end
end
