FactoryGirl.define do
  factory :account do
    to_create { |i| i.save  }
  end
end
