module Admin::PlansHelper
  def services_fields(form)
    form.fields_for(:assigned_services) do |f|
      concat(service_row(f, f.object))
    end
  end

  def service_row_template(form)
    object = AssignedService.new
    form.fields_for(:assigned_services, object, :child_index => "NEW_ROW") do |f|
      concat(service_fields_row_template(f))
    end
  end

  def service_row(form, assigned_service)
    html = service_summary_row(form, assigned_service, assigned_service.service)
    html << service_fields_row(form, assigned_service)
    html.html_safe
  end

def service_summary_row(form, assigned_service, service)
  content_tag(:tr, :class => "expandable") do
    [
      content_tag(:th, :scope => "row", :style => "cursor: s-resize") do
        service ? service.title : "&nbsp;"
      end,
      content_tag(:td) do
        assigned_service.setup_fee.to_s
      end,
      content_tag(:td) do
        assigned_service.periodic_fee.to_s
      end,
      content_tag(:td) do
        assigned_service.charge_mode.to_s
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

  def service_fields_row(form, assigned_service)
    content_tag(:tr, :class => "hidden") do
      content_tag(:td, :colspan => 5) do
        render :partial => "assigned_service", :locals => { :form => form }
      end
    end
  end

  def service_fields_row_template(form)
    content_tag(:tr, :class => "template", "data-name" => "services") do
      content_tag(:td, :colspan => 5, :style => "background: #f5fafa; border-top: 3px solid #ccc") do
        [
          render(:partial => "assigned_service", :locals => { :form => form }),
          link_to("Remove", "#", :class => "remove")
        ].join.html_safe
      end
    end
  end

  def properties_fields(form)
    form.object.initialize_properties
      form.fields_for(:properties) do |f|
        concat(properties_rows(f))
      end
  end

  def properties_rows(form)
    content_tag(:tr) do
      [
        content_tag(:td) do
          [
            form.hidden_field(:option_id),
            form.object.option.title
          ].join.html_safe
        end,
        content_tag(:td) do
          [
            form.text_field(:value)
          ].join.html_safe
        end
      ].join.html_safe
    end
  end
end
