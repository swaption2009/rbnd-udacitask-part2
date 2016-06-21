class UdaciList
  include UdaciListErrors
  attr_reader :title, :items

  EntryType = {
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
    model = EntryType[type.to_sym]
    @items.push eval(model).new(description, options) if type == type.to_s
  end

  def delete(index)
    @items.delete_at(index - 1)
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def validate_entry(type)
    unless EntryType.key?(type.downcase.to_sym)
      raise InvalidItemType, "#{type} is an invalid entry."
    end
 end
end
