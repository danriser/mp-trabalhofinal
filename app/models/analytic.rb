# 
# Model {Analytic} 
#
# Modelo que representa um dado de analytics 
#
# @return [Int] valor armazendado pelo dado
#
#
class Analytic < ApplicationRecord
    after_initialize :init

    # @return [String] titulo do dado
    validates :title, presence: true, uniqueness: true

    def init
      self.value ||= 0  
    end
end
