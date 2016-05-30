FactoryGirl.define do
  factory :user, aliases: [:owner] do
    provider 'twitter'
    sequence(:uid) { |i| "uid#{i}" }
    sequence(:place) { |i| "nickname#{i}" }
    sequence(:image_url) { |i| "http://example.com/image/#{i}.jpg" }
  end
end
