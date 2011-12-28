module Admin::ServicesHelper
  def option_value_type(option)
    case option.value_type
    when Option::Type::STRING
      "STRING"
    when Option::Type::BOOLEAN
      "BOOLEAN"
    when Option::Type::NUMERIC
      "NUMERIC"
    else option.value_type end
  end

  def options_fields(form)
    form.fields_for(:options) do |f|
      concat(option_row(f, f.object))
    end
  end

  def option_row_template(form)
    object = Option.new
    form.fields_for(:options, object, :child_index => "NEW_ROW") do |f|
      concat(option_fields_row_template(f))
    end
  end

  def option_row(form, option)
    html = option_summary_row(form, option)
    html << option_fields_row(form, option)
    html.html_safe
  end

  def option_summary_row(form, option)
    content_tag(:tr, :class => "expandable") do
      [
        content_tag(:th, :scope => "row", :style => "cursor: s-resize") do
          option.name
        end,
        content_tag(:td) do
          option.title
        end,
        content_tag(:td) do
          tick_or_cross(option.required)
        end,
        content_tag(:td) do
          tick_or_cross(option.overridable)
        end,
        content_tag(:td) do
          option_value_type(option)
        end,
        content_tag(:td) do
          if form.object.new_record?
            link_to("Remove", "#", :class => "remove")
          else
            form.check_box(:_destroy, :title => "Mark for deletion")
          end
        end
      ].join.html_safe
    end
  end

  def option_fields_row(form, option)
    content_tag(:tr, :class => "hidden") do
      content_tag(:td, :colspan => 5) do
        render :partial => "option", :locals => { :form => form }
      end
    end
  end

  def option_fields_row_template(form)
    content_tag(:tr, :class => "template", "data-name" => "options") do
      content_tag(:td, :colspan => 5, :style => "background: #f5fafa; border-top: 3px solid #ccc") do
        [
          render(:partial => "option", :locals => { :form => form }),
          link_to("Remove", "#", :class => "remove")
        ].join.html_safe
      end
    end
  end
end
