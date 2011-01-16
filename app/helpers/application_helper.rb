module ApplicationHelper
  # TODO rename as td_toggle_show_inactive
  def toggle_show_inactive_td
    safe_concat "<td class='actions'>"
    if show_inactive?
      safe_concat link_to('Hide inactive', hide_inactive_modes_path)
    else
      safe_concat link_to('Show inactive', show_inactive_modes_path)
    end
    safe_concat "</td>"
  end

  def non_zero_or(num, s)
    num != 0 ? num.to_s : s
  end

  def td_reference_url(label, url_suffix)
    safe_concat "<td class='reference-url'>"
    a_reference_url("MeritBadge.Org", "Boy_Scout_Portal")
    safe_concat ": "
    a_reference_url(label, url_suffix)
    safe_concat "</td>"
  end

  def a_reference_url(label, url_suffix)
    safe_concat "<a href='http://meritbadge.org/wiki/index.php/#{url_suffix}'>#{label}</a>"
  end

  def form_error_messages(entity, label)
    if entity.errors.any?
      safe_concat "<div id='error_explanation'>"
      safe_concat "<h2>#{pluralize(entity.errors.count, 'error')} prohibited this #{label} from being saved:</h2>"
      safe_concat "<ul>"
      entity.errors.full_messages.each do |msg|
        safe_concat"<li>#{msg}</li>"
      end
      safe_concat "</ul>"
      safe_concat "</div>"
    end
  end

  def form_check_box(f, field_symbol)
    safe_concat "<div class='field'>"
    safe_concat f.label(field_symbol)
    safe_concat "<br />"
    safe_concat f.check_box(field_symbol)
    safe_concat "</div>"
  end

  def form_date_select(f, field_symbol, options = {})
    safe_concat "<div class='field'>"
    safe_concat f.label(field_symbol)
    safe_concat "<br />"
    safe_concat f.date_select(field_symbol, options)
    safe_concat "</div>"
  end

  def form_password_field(f, field_symbol)
    safe_concat "<div class='field'>"
    safe_concat f.label(field_symbol)
    safe_concat "<br />"
    safe_concat f.password_field(field_symbol)
    safe_concat "</div>"
  end

  def form_text_field(f, field_symbol)
    safe_concat "<div class='field'>"
    safe_concat f.label(field_symbol)
    safe_concat "<br />"
    safe_concat f.text_field(field_symbol)
    safe_concat "</div>"
  end

  def form_submit_buttons(f, use_save_and_new)
    safe_concat "<div class='actions'>"
    safe_concat f.submit("Save", :name => "save")
    if use_save_and_new
      safe_concat f.submit("Save & New", :name => "save_and_new")
    end
    safe_concat f.submit("Cancel", :name => "cancel")
    safe_concat "</div>"
  end
end

