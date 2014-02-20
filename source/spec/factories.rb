require 'spec_helper'

FactoryGirl.define do
  factory :post do
    sequence(:title) { |s| "#{Faker::Lorem.word}#{s}" }
    content Faker::Lorem.sentence
  end
end