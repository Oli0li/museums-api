class Museum < ApplicationRecord
  def self.find_by_param(param, param_value)
    museum = Museum.where(param => param_value)
    museum.empty? ? { message: "Museum not found" } : museum
  end
end
