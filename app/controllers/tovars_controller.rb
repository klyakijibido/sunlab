class TovarsController < ApplicationController
  # в нем три метода - три экшена
  # GET /garments/1
  def show
    @tovar = Tovar.find(params[:id])
  end

  # GET /garments
  def index
    @tovars = Tovar.all
  end

  # GET /garments/current
  def current
  end
end
