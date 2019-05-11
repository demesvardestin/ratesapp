class Comment < ApplicationRecord
    belongs_to :brand, :dependent => :destroy
end
