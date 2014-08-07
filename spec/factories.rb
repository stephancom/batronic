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
  factory :batting_statistics do
    player_key
    year 1968
    league 'AL'
    team 'XYZ'
    at_bats 100
    hits    50
    doubles 25
    triples 10
    homers  5
    rbi     20
  end
end