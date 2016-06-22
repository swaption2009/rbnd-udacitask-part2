module Listable
  def format_description
    "#{@description}".ljust(25)
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|

      case item.class.to_s

        when "TodoItem"
          def format_date
            @due ? @due.strftime("%D") : "No due date"
          end
          def format_priority
            value = " ⇧" if @priority == "high"
            value = " ⇨" if @priority == "medium"
            value = " ⇩" if @priority == "low"
            value = "" if !@priority
            return value
          end
          def details
            format_description + "due: " +
            format_date +
            format_priority
          end
          puts "#{position + 1}) #{item.details}"

        when "EventItem"
          #EventItem
          def format_date
            dates = @start_date.strftime("%D") if @start_date
            dates << " -- " + @end_date.strftime("%D") if @end_date
            dates = "N/A" if !dates
            return dates
          end
          def details
            format_description + "event dates: " + format_date
          end
          puts "#{position + 1}) #{item.details}"

        when "LinkItem"
          #LinkItem
          def format_name
            @site_name ? @site_name : ""
          end
          def details
            format_description + "site name: " + format_name
          end
          puts "#{position + 1}) #{item.details}"

      end
    end
  end
end