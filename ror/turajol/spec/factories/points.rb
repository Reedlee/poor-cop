FactoryGirl.define do
  factory :point do |f|
    f.latitude '42.87793'
    f.longitude '74.612757'
    f.deleted_at nil
  end

  factory :invalid_point, parent: :point do |f|
    f.latitude nil
  end

  factory :deleted_point, parent: :point do |f|
    f.deleted_at Time.now
  end
end
