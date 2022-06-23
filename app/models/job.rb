class Job < ApplicationRecord
    enum status: [:open, :claimed, :completed]

    belongs_to :pickup_address, foreign_key: :pickup_address_id, class_name: 'Address', dependent: :destroy
    belongs_to :drop_address, foreign_key: :drop_address_id, class_name: 'Address', dependent: :destroy
    belongs_to :creator, foreign_key: :created_by, class_name: 'User'
    belongs_to :executer, foreign_key: :executed_by, class_name: 'User', optional: true

    validates_presence_of :pickup_address_id, :drop_address_id, :created_by

end
