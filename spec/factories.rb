FactoryGirl.define do
  sequence :player_key do |n|
    "ruthba#{n}"
  end
  factory :player do
    player_key 
    birth_year 1895
    first_name 'Babe'
    last_name 'Ruth'
  end
  factory :batter, parent: :player do
    
  end
end