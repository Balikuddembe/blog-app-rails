require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'balix', photo: 'https://unsplash.com/es/fotos/W5nhsrznVp0', bio: 'coder from Uganda')
  end

  it 'user name must not be empty' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be an integer' do
    @user.posts_counter = 'balix'
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to: 0' do
    @user.posts_counter = -1
    expect(@user).to_not be_valid
  end

  describe 'methods' do
    before do
      @user1 = User.create(name: 'balix', photo: 'https://unsplash.com/es/fotos/W5nhsrznVp0',
                           bio: 'coder from Uganda')
      5.times do
        Post.create(author: @user1, title: 'Hello!', text: 'This is my first post')
      end
    end

    it 'returns last recent_posts' do
      expect(@user1.recent_posts).to match_array(@user1.posts.last(3))
    end
  end
end
