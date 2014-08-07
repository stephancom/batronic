FactoryGirl.define do
  sequence :player_key do |n|
    "ruthba#{n}"
  end
  sequence :year do |n|
    1949 + 18 + n
  end
  factory :player do
    player_key 
    birth_year 1895
    first_name 'Babe'
    last_name 'Ruth'
  end
  factory :batter do
    player_key 
    birth_year 1949
    first_name 'Bill'
    last_name 'Buckner'
  end
  factory :batting_statistic do
    player_key { create(:batter).player_key }
    year
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