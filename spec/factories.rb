FactoryBot.define do
  factory :queen do
    
  end
  factory :king do
    
  end
  factory :rook do
    
  end
  factory :knight do
    
  end
  factory :bishop do
    
  end
  factory :pawn do
    
  end
  factory :game do
    
  end
    factory :user do
      sequence :email do |n|
        "dummyEmail#{n}@gmail.com"
      end
      password "secretPassword"
      password_confirmation "secretPassword"
    end
  end