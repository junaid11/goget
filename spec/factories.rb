# FactoryBot.define do
#     service_array = ["Test Service", "Test Service Two"]
#     letter = ["a", "b", "c", "d"]
#   factory :user, class: User do
#       name { Faker::Name.name }
#       email { Faker::Internet.email }
#       password { service_array.sample }
#     end
# end