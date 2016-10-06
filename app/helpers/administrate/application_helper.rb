module Administrate
  module ApplicationHelper
    def render_field(field, locals = {})
      locals.merge!(field: field)
      render locals: locals, partial: field.to_partial_path
    end

    def resource_dashboard(resource)
      dashboard = resource.classify + "Dashboard"
      current_dashboard = dashboard.safe_constantize
    end

    def display_resource_name(resource_class)
      resource_class.
        model_name.
        human.
        split('/').
        last
    end

    def svg_tag(asset, svg_id, options = {})
      svg_attributes = {
        "xlink:href".freeze => "#{asset_url(asset)}##{svg_id}",
        height: options[:height],
        width: options[:width],
      }.delete_if { |_key, value| value.nil? }
      xml_attributes = {
        "xmlns".freeze => "http://www.w3.org/2000/svg".freeze,
        "xmlns:xlink".freeze => "http://www.w3.org/1999/xlink".freeze,
      }

      content_tag :svg, xml_attributes do
        content_tag :use, nil, svg_attributes
      end
    end

    def collection_partial_path(field)
      if File.exist?("#{field.resources[0].class.to_s.underscore}/collection")
        "#{field.resources[0].class.to_s.underscore}/collection"
      else
        'administrate/application/collection'
      end
    end
  end
end
