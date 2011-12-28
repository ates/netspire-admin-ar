module Admin::ServiceLinksHelper
  def service_links_fields(form)
    form.fields_for(:service_links) do |f|
      concat(service_link_row(f, f.object))
    end
  end

  def service_link_row_template(form)
    form.fields_for(:service_links, ServiceLink.new, :child_index => "NEW_ROW") do |f|
      concat(service_link_fields_row_template(f))
    end
  end

  def service_link_row(form, service_link)
    service = service_link.assigned_service.service
    plan = service_link.assigned_service.plan
    html = service_link_summary_row(form, service_link, service, plan)
    html << service_link_fields_row(form, service_link, service, plan)
    html
  end

  def service_link_summary_row(form, service_link, service, plan)
    content_tag(:tr, :id => dom_id(service_link)) do
      [
        content_tag(:th, :scope => "row") do
          link_to(service.title, edit_admin_plan_path(plan), :target => "_blank")
        end,
        content_tag(:td) do
          plan.name
        end,
        content_tag(:td) do
          tick_or_cross(service_link.scheduled?)
        end,
        content_tag(:td) do
          tick_or_cross(service_link.expiring?)
        end,
        content_tag(:td) do
          if service_link.new_record?
            link_to("Remove", "#", :class => "remove")
          else
            form.check_box(:_destroy, :title => "Mark for deletion", :class => "tooltipped")
          end
        end
      ].join.html_safe
    end
  end

  def service_link_fields_row(form, service_link, service, plan)
    content_tag(:tr) do
      content_tag(:td, :colspan => 5) do
        render :partial => "service_link", :locals => { :form => form }
      end
    end
  end

  def service_link_fields_row_template(form)
    content_tag(:tr, :class => "template", 'data-name' => "service_links") do
      content_tag(:td, :colspan => 5, :style => "background: #f5fafa; border-top: 3px solid #ccc") do
        [
          render(:partial => "service_link", :locals => { :form => form }),
          link_to("Remove", "#", :class => "remove")
        ].join.html_safe
      end
    end
  end
end
