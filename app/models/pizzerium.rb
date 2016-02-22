class Pizzerium < ActiveRecord::Base
    validates   :name,
                :presence => {:message => "Du måste ange ett namn."},
                :length => {:minimum => 1, :maximum => 50, :message => "Namnet måste vara mellan 1-50 tecken långt."}
                
    validates   :position_id,
                :presence => {:message => "Du måste ange en vilken position pizzerian är kopplad till."}
    
    validates   :creator_id,
                :presence => {:message => "Du måste ange en vem skaparen till pizzerian är."}
end
