class RegionsController < ApplicationController
  def cities
    @regions = Region.where(level: 2)
    render :index
  end

  def cities_for_municipalities
    @regions = Region.where(level: 2, parent_id: params[:municipality_id])
    render :index
  end

  def municipalities
    @regions = Region.where(level: 1)
    render :index
  end

  def municipalities_for_county
    @regions = Region.where(level: 1, parent_id: params[:county_id])
    render :index
  end

  def county
    @regions = Region.where(level: 0)
    render :index
  end
end
