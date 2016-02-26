# frozen_string_literal: true

# Provides methods that can be used across all views
module ApplicationHelper
  def th_sort_field(order, sort_field, display_name, extra_class: '')
    sort_field_order = (order == sort_field) ? "#{sort_field} DESC" : sort_field
    if order == sort_field
      css_class = 'sort-up'
      selected_class = 'sort-selected'
    elsif order == sort_field + ' DESC'
      css_class = 'sort-down'
      selected_class = 'sort-selected'
    end
    content_tag(:th, class: [selected_class, extra_class]) do
      link_to url_for(params.merge(order: sort_field_order)), style: 'text-decoration:none', class: css_class do
        display_name.to_s.html_safe
      end
    end.html_safe
  end

  def simple_check(checked)
    if checked
      content_tag :span, nil, class: %w(glyphicon glyphicon-ok text-success)
    else
      content_tag :span, nil, class: %w(glyphicon glyphicon-remove text-danger)
    end
  end
end
