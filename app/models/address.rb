class Address < ApplicationRecord
    validates_presence_of :address, :longitude, :latitude

    def to_json
        self.as_json.with_indifferent_access.except! :created_at, :updated_at, :id
    end
end
