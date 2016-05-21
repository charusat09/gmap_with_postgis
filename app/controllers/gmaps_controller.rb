class GmapsController < ApplicationController
  def index
  end

  def show_map
  	
  end

  def show_polygon
  	lat = params[:lat]
  	lng = params[:lng]
  	query = "SELECT ST_Intersects('POINT("+ lng + " " + lat + ")'::geometry, polygon)"
  	puts query
  	polygon_obj = RewardLocation.where(query).first
  	if polygon_obj.present?
  		polygon = polygon_obj.polygon 
			polygon_coordinates = RGeo::GeoJSON.encode(polygon)["coordinates"][0]
	  	hash = []
			polygon_coordinates.each do |coordinate|	
				x = {lat: coordinate[1], lng: coordinate[0]}
				hash << x
			end
			@hash_json = hash.to_json
  		respond_to do |format|
      	format.js
    	end
    elsif
    	render plain: "Not Found"
    end
		

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

  def save_updated_polygon
    puts "got it"
  end
end
