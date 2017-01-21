FactoryGirl.define do
  factory :point do |f|
    f.latitude '42.87793'
    f.longitude '74.612757'
  end

  factory :invalid_point, parent: :point do |f|
    f.latitude nil
  end
end
