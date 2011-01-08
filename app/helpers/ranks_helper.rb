module RanksHelper
  def td_rank_merit_badge_counts(rank)
    safe_concat "<td title='#{rank.num_merit_badges} total, #{rank.num_eagle_required} eagle-required'>"
    if rank.num_merit_badges > 0
      safe_concat "#{rank.num_merit_badges} (#{rank.num_eagle_required})"
    end
    safe_concat "</td>"
  end
end

