class Menu < ActiveRecord::Base
    validates   :name,
                :presence => {:message => "Du måste ange ett namn på menyn."},
                :length => {:minimum => 1, :maximum => 30, :message => "Namnet måste vara mellan 1-30 tecken långt."}
                
    validates   :pizzeria_id,
                :presence => {:message => "Du måste ange vilken pizzeria menyn är kopplad till."}
end
