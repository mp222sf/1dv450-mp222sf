class Tag < ActiveRecord::Base
    validates   :name,
                :presence => {:message => "Du måste ange ett namn för taggen."},
                :length => {:minimum => 1, :maximum => 30, :message => "Taggens namn måste vara mellan 1-30 tecken långt."}
end
