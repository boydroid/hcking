module ApplicationHelper

  def weekday_select_option
    daynames = t("date.day_names").collect.with_index {|x,i| [x,i]}
    daynames << daynames.delete_at(0)
    options_for_select(daynames)
  end

  def day_output_helper(date)
      date = date.to_date
      today = Date.today
      case
        when date == today then "Heute"
        when date == (today + 1) then "Morgen"
        else I18n.localize(date, :format => :long)
      end.html_safe
  end

  def truncate_html(html, length, opts)
    HTML_Truncator.truncate(html, length, opts).html_safe
  end

end
