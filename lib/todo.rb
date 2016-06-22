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

  # def format_date
  #   @due ? @due.strftime("%D") : "No due date"
  # end
  # def format_priority
  #   value = " ⇧" if @priority == "high"
  #   value = " ⇨" if @priority == "medium"
  #   value = " ⇩" if @priority == "low"
  #   value = "" if !@priority
  #   return value
  # end
  # def details
  #   format_description + "due: " +
  #   format_date +
  #   format_priority
  # end

  private

  def validate_priority(priority)
    if @@priorities.include? priority
      @priority = priority
    else
      raise InvalidPriorityValue, "#{priority} is not a valid entry."
    end
  end
end
