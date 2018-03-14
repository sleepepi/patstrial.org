# frozen_string_literal: true

# Displays publicly available pages.
class ExternalController < ApplicationController
  # # GET /contact
  # def contact
  # end

  # GET /landing
  def landing
    render layout: "layouts/full_page"
  end

  # # GET /participate
  # def participate
  # end

  # # GET /sites
  # def sites
  # end
end
