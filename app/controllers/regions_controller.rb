class RegionsController < ApplicationController
  def cities
    @regions = Region.where(level: 2)
    render :index
  end

  def municipalities
    @regions = Region.where(level: 1)
    render :index
  end
end
