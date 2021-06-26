class Shopping < ApplicationRecord
  belongs_to :user
  belongs_to :claim, optional: true
end
