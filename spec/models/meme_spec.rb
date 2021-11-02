require 'rails_helper'

RSpec.describe Meme, type: :model do
  it "should have a valid name" do
    meme = Meme.create(url: 'www.google.com', description: 'Kevin meme')
    expect(meme.errors[:name].first).to eq "can't be blank"
  end
  it 'should have a valid url' do
    meme = Meme.create(name: 'Kevin', description: 'Kevin Meme')
    expect(meme.errors[:url].first).to eq "can't be blank"
  end
  it 'should have a valid description' do
    meme = Meme.create(name: 'Kevin', url: 'www.google.com')
    expect(meme.errors[:description].first).to eq "can't be blank"
  end
  it 'should have a description entry of at least 10 characters' do
    meme = Meme.create(name: 'Kevin', url: 'www.google.com', description:'Kevin')
    expect(meme.errors[:description].first).to eq 'is too short (minimum is 10 characters)'
  end
end
