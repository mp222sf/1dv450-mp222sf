class Dish < ActiveRecord::Base
    validates   :name,
                :presence => {:message => "Du måste ange ett namn för rätten."},
                :length => {:minimum => 1, :maximum => 30, :message => "Rättens namn måste vara mellan 1-30 tecken långt."}
                
    validates   :ingredients,
                :presence => {:message => "Du måste ange ingredienser."},
                :length => {:minimum => 1, :maximum => 150, :message => "Ingredienser måste vara mellan 1-150 tecken långt."}
                
    validates   :price, 
                :numericality => { :greater_than_or_equal_to => 1 }
    
    validates   :menu_id,
                :presence => {:message => "Du måste ange vilken meny rätten är kopplad till."}
end