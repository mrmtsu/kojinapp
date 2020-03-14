class Tagmap < ApplicationRecord
  belongs_to :post_id
  belongs_to :tag_id
end
