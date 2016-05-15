class GmapsController < ApplicationController
  def index
  end

  def show
  end

  def save_polygon
  	polygon_shape = params[:polygon]
  	query_string = "POLYGON(("
  	(0..(polygon_shape.length-1)). each do |coordinate|
  		query_string += polygon_shape["#{coordinate}"][0]
  		query_string += " "
  		query_string += polygon_shape["#{coordinate}"][1]
  		query_string += ","
  	end
  	query_string += polygon_shape["0"][0]
  	query_string += " "
  	query_string += polygon_shape["0"][1]
  	query_string += "))"


  	respond_to do |format|
      if RewardLocation.create(polygon: query_string)
        format.js
      end
    end
  end
end
