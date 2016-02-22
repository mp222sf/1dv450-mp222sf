class Position < ActiveRecord::Base
    # validates   :latitude, 
    #             :presence => {:message => "Du måste ange latitud."},
    #             :numericality => { :greater_than => -90, :less_than_or_equal_to => 90 }
                
    # validates   :longitude, 
    #             :presence => {:message => "Du måste ange longitud."},
    #             :numericality => { :greater_than => -180, :less_than_or_equal_to => 180 }
                
    geocoded_by :address
    after_validation :geocode
    
    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode
end
