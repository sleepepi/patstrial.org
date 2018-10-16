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

  # # GET /credits
  # def credits
  # end

  # # GET /privacy-policy
  # def privacy_policy
  # end

  # GET /version
  # GET /version.json
  def version
    render layout: "layouts/full_page"
  end
end
