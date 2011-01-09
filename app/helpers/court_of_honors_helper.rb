module CourtOfHonorsHelper
  def format_counts(scout_counts)
    formatted = []
    scout_counts.keys.sort!.each do |scout|
      count = scout_counts[scout]
      name_link = link_to h(scout.name), scout
      formatted << (count == 1 ? name_link : "#{name_link} (#{count})")
    end
    formatted
  end
end

