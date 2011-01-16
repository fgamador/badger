module MeritBadgesHelper
  def th_merit_badge_eagle_required(merit_badge)
    return unless merit_badge.eagle_required

    safe_concat "<th>Eagle-required"
    if merit_badge.group_number
      names = MeritBadge.find_group(merit_badge.group_number).collect {|mb| mb.name }
      if names.size == 2
      	concat " (either #{names[0]} or #{names[1]})"
      else
      	concat " (any one of "
      	names[names.size - 1] = "or " + names[names.size - 1]
        concat names.join(", ")
        concat ")"
      end
    end
    safe_concat "</th>"
  end
end

