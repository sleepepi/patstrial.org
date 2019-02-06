# frozen_string_literal: true

# Helper functions for application emails.
module EmailHelper
  def emphasis_color
    "#404040" # $p200-black
  end

  def muted_color
    "#989ea6"
  end

  def text_color
    "#3a3b3c"
  end

  def background_color
    "#512da8" # $p700-deep-purple
  end

  def banner_color
    emphasis_color
  end

  def link_color
    "#673ab7" # $p500-deep-purple
  end

  def center_style
    hash_to_css_string(
      font_size: "17px",
      line_height: "24px",
      margin: "0 0 16px",
      text_align: "center"
    )
  end

  def link_style
    hash_to_css_string(
      color: link_color,
      font_weight: "bold",
      word_break: "break-word"
    )
  end

  def p_style
    hash_to_css_string(
      font_size: "17px",
      line_height: "24px",
      margin: "0 0 16px"
    )
  end

  def image_style
    hash_to_css_string(
      text_align: "center",
      max_width: "100%"
    )
  end

  def blockquote_style
    hash_to_css_string(
      font_size: "17px",
      font_style: "italic",
      line_height: "24px",
      margin: "0 0 16px"
    )
  end

  def default_style
    hash_to_css_string(
      font_weight: "bold",
      word_break: "break-word"
    )
  end

  def emphasis_style
    hash_to_css_string(
      color: emphasis_color,
      font_weight: "bold",
      word_break: "break-word"
    )
  end

  def regular_style
    hash_to_css_string(
      color: text_color,
      word_break: "break-word"
    )
  end

  def muted_style
    hash_to_css_string(
      color: muted_color,
      word_break: "break-word"
    )
  end

  protected

  def hash_to_css_string(hash)
    array = hash.collect do |key, value|
      "#{key.to_s.dasherize}:#{value}"
    end
    array.join(";")
  end
end
