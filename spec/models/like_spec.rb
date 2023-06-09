require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create(name: 'balix', photo: 'https://unsplash.com/es/fotos/W5nhsrznVp0', bio: 'coder from Uganda')
    @post = Post.create(author: @user, title: 'My post', text: 'Hello emma!')
  end

  it 'like presence should be valid' do
    @like = Like.create(author: @user, post: @post)
    expect(@like).to be_valid
  end

  it 'update_likes_counter should increse likes' do
    Like.create(author: @user, post: @post)
    expect(@post.likes_counter).to eq 1
  end
end