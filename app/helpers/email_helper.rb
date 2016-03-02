# frozen_string_literal: true

# Helper functions for application emails
module EmailHelper
  def success_color
    '#df9cca'
  end

  def warning_color
    '#cca781'
  end

  def danger_color
    '#bf9a74'
  end

  def text_color
    '#3a3b3c'
  end

  def background_color
    '#b295db'
  end

  def link_color
    '#52357b'
  end

  def center_style
    hash_to_css_string(
      font_size: '17px',
      line_height: '24px',
      margin: '0 0 16px',
      text_align: 'center'
    )
  end

  def link_style
    hash_to_css_string(
      color: link_color,
      font_weight: 'bold',
      text_decoration: 'none',
      word_break: 'break-word'
    )
  end

  def p_style
    hash_to_css_string(
      font_size: '17px',
      line_height: '24px',
      margin: '0 0 16px'
    )
  end

  def blockquote_style
    hash_to_css_string(
      font_size: '17px',
      font_style: 'italic',
      line_height: '24px',
      margin: '0 0 16px'
    )
  end

  def default_style
    hash_to_css_string(
      font_weight: 'bold',
      word_break: 'break-word'
    )
  end

  def success_style
    hash_to_css_string(
      color: success_color,
      font_weight: 'bold',
      word_break: 'break-word'
    )
  end

  def warning_style
    hash_to_css_string(
      color: warning_color,
      font_weight: 'bold',
      word_break: 'break-word'
    )
  end

  def danger_style
    hash_to_css_string(
      color: danger_color,
      font_weight: 'bold',
      word_break: 'break-word'
    )
  end

  protected

  def hash_to_css_string(hash)
    array = hash.collect do |key, value|
      "#{key.to_s.dasherize}:#{value}"
    end
    array.join(';')
  end
end
