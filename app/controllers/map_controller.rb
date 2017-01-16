class MapController < ApplicationController
  def index
    @shiros = Shiro.all
    @hash = Gmaps4rails.build_markers(@shiros) do |shiro, marker|
      marker.lat shiro.latitude
      marker.lng shiro.longitude
      #marker.infowindow shiro.description
      marker.json({name: shiro.name})
    end
  end
end
