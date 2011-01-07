module ScoutsHelper
  def td_merit_badge_counts(scout)
    counts = scout.merit_badge_counts
    total_class = counts[:total_satisfied] ? "satisfied" : "unsatisfied"
    required_class = counts[:required_satisfied] ? "satisfied" : "unsatisfied"
    satisfied_msg = counts[:total_satisfied] && counts[:required_satisfied] \
      ? ": satisfies rank requirement" \
      : counts[:total_satisfied] || counts[:required_satisfied] \
        ? ": partially satisfies rank requirement" : ""

    safe_concat "<td title='#{counts[:total]} total, #{counts[:required]} eagle-required#{satisfied_msg}'>"
    safe_concat "<span class='#{total_class}'>#{counts[:total]}</span>"
    safe_concat " <span class='#{required_class}'>(#{counts[:required]})</span>"
    safe_concat "</td>"
  end

  def td_nights_of_camping_counts(scout)
    counts = scout.nights_of_camping_counts
    camping_nights_class = counts[1] >= 20 ? "satisfied" : "unsatisfied"
    satisfied_msg = counts[1] >= 20 ? ": satisfies requirement" : ""

    safe_concat "<td title='#{counts[0]} total, #{counts[1]} for camping merit badge#{satisfied_msg}'>"
    safe_concat "#{counts[0]}"
    safe_concat " <span class='#{camping_nights_class}'>(#{counts[1]})</span>"
    safe_concat "</td>"
  end

  def link_to_name_or_blank(obj)
    obj ? link_to(obj.name, obj) : ""
  end

  def name_or_blank(obj)
    obj ? obj.name : ""
  end
end

