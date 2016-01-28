class Authentication < ActiveRecord::Base
    has_secure_password validations: true
    
    validates   :username,
                :presence => {:message => "Du måste ange ett användarnamn."},
                :length => {:minimum => 5, :maximum => 30, :message => "Ditt användarnamn måste vara mellan 5-30 tecken långt."},
                :uniqueness => {:message => "Det finns en registrerad användare med angivet användarnamn."}
                
    validates   :email,
                :presence => {:message => "Du måste ange en e-mail."},
                :uniqueness => {:message => "Det finns en registrerad användare med angiven email-adress."}
                
    validates   :password,
                :length => {:minimum => 6, :maximum => 30, :message => "Ditt lösenord måste vara mellan 5-30 tecken långt."}
                
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                        :presence => {:message => "Felaktig e-postadress."}
                
    validates   :rights,
                :presence => {:message => "Du måste ange en rättighet."},
                :numericality => { :only_integer => true }
    
    has_many :apiKeys
end