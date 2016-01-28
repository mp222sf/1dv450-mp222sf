class ApiKey < ActiveRecord::Base
    belongs_to :authentication
    validates :key, :appName, :appURL, presence: true
    
    validates   :key,
                :uniqueness => {:message => "Det finns en registrerad API-nyckel med angivet nyckelvärde."}
end
