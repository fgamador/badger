module ScoutsHelper
  def td_merit_badge_counts(scout)
    counts = scout.merit_badge_counts
    if counts[:required_for_rank]
      total_class = counts[:total_remaining] > 0 ? "unsatisfied" : "satisfied"
      eagle_required_class = counts[:eagle_required_remaining] > 0 ? "unsatisfied" : "satisfied"
    else
      total_class = eagle_required_class = "not-required"
    end

    if counts[:required_for_rank]
      status_msg = counts[:total_remaining] <= 0 && counts[:eagle_required_remaining] <= 0 \
      	? ": enough for next rank" \
        : ": #{counts[:total_remaining]} more needed for next rank (#{counts[:eagle_required_remaining]} of them eagle-required)"
    else
      status_msg = ": not required for next rank"
    end

    safe_concat "<td title='#{counts[:total]} total, #{counts[:eagle_required]} eagle-required#{status_msg}'>"
    safe_concat "<span class='#{total_class}'>#{counts[:total]}</span>"
    safe_concat " <span class='#{eagle_required_class}'>(#{counts[:eagle_required]})</span>"
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

  def td_age(scout)
    safe_concat "<td>"
    if scout.birthday
      concat scout.age
    else
      concat "-"
    end
    safe_concat "</td>"
  end

  def link_to_name_or_blank(obj)
    obj ? link_to(obj.name, obj) : ""
  end

  def name_or_blank(obj)
    obj ? obj.name : ""
  end
end

