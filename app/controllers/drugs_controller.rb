# frozen_string_literal: true

# Allows users to search a list of drug codes.
class DrugsController < ApplicationController
  before_action :set_drug, only: [:show]

  # GET /drugs
  # GET /drugs.json
  def index
    @order = scrub_order(Drug, params[:order], "drugs.product_ndc")
    @drugs = Drug.all.search_any_order(params[:search]).order(@order).page(params[:page]).per(40)
  end

  # # GET /drugs/1
  # # GET /drugs/1.json
  # def show
  # end

  private

  def set_drug
    @drug = Drug.find(params[:id])
  end
end
