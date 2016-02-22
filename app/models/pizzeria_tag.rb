class PizzeriaTag < ActiveRecord::Base
    validates   :pizzeria_id, uniqueness: {scope: :tag_id},
                :presence => {:message => "Du måste ange ett Pizzeria-ID."}
                
    validates   :tag_id,
                :presence => {:message => "Du måste ange ett Tag-ID."}
end
