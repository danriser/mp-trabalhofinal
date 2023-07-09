class Analytic < ApplicationRecord
    after_initialize :init
    validates :title, presence: true, uniqueness: true

    def init
      self.value ||= 0  
      
    end
end
