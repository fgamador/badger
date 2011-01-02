module ApplicationHelper
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

  def form_submit_buttons(f, use_save_and_new)
    safe_concat "<div class='actions'>"
    safe_concat f.submit "Save", :name => "save"
    if use_save_and_new
      safe_concat f.submit "Save & New", :name => "save_and_new"
    end
    safe_concat f.submit "Cancel", :name => "cancel"
    safe_concat "</div>"
  end
end

