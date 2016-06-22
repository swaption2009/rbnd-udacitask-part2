class UdaciList
  include UdaciListErrors

  attr_reader :title, :items

  @@entry_type = {
      todo: "TodoItem",
      event: "EventItem",
      link: "LinkItem"
    }

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    validate_entry(type)
    model = @@entry_type[type.to_sym]
    @items.push eval(model).new(description, options) if type == type.to_s
  end

  def delete(index)
    if @items.length > index - 1
      @items.delete_at(index - 1)
    else
      raise IndexExceedsListSize, "#{index} exceeds list size of #{@items.length}."
    end
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def filter(type)
    type_class = type.capitalize + "Item"
    @items.select { |item| puts item.description if item.class.to_s == type_class }
  end

  private

  def validate_entry(type)
    unless @@entry_type.key?(type.downcase.to_sym)
      raise InvalidItemType, "#{type} is an invalid entry."
    end
 end

end
