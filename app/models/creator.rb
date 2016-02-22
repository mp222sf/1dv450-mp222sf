class Creator < ActiveRecord::Base
    validates   :firstName,
                :presence => {:message => "Du måste ange ett förnamn."},
                :length => {:minimum => 1, :maximum => 30, :message => "Ditt förnamn måste vara mellan 1-30 tecken långt."}
                
    validates   :lastName,
                :presence => {:message => "Du måste ange ett efternamn."},
                :length => {:minimum => 1, :maximum => 30, :message => "Ditt efternamn måste vara mellan 1-30 tecken långt."}
end
