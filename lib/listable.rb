module Listable
  def format_description
    "#{@description}".ljust(25)
  end

  def print_data(position, item)
    puts "#{position + 1}) #{item.details}"
  end

  def all
    puts "-".blue * @title.length
    puts @title.blue

    puts "-".blue * @title.length
    @items.each_with_index do |item, position|
      case item.class.to_s
        when "TodoItem"
          def format_date
            @due ? @due.strftime("%D") : "No due date"
          end
          def format_priority
            value = " ⇧".colorize(:red) if @priority == "high"
            value = " ⇨".colorize(:yellow) if @priority == "medium"
            value = " ⇩".colorize(:blue) if @priority == "low"
            value = "" if !@priority
            return value
          end
          def details
            format_description.colorize(:green) + "due: " +
            format_date.colorize(:yellow) +
            format_priority
          end
          print_data(position, item)

        when "EventItem"
          def format_date
            dates = @start_date.strftime("%D") if @start_date
            dates << " -- " + @end_date.strftime("%D") if @end_date
            dates = "N/A" if !dates
            return dates
          end
          def details
            format_description.colorize(:green) + "event dates: " + format_date.colorize(:yellow)
          end
          print_data(position, item)

        when "LinkItem"
          def format_name
            @site_name ? @site_name : ""
          end
          def details
            format_description.colorize(:green) + "site name: " + format_name.colorize(:yellow)
          end
          print_data(position, item)
        end
      end
    end
end