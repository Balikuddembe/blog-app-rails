require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(name: 'balix', photo: 'https://unsplash.com/es/fotos/W5nhsrznVp0', bio: 'coder from Uganda')
    @post = Post.create(author: @user, title: 'My post', text: 'Hello!')
  end

  it 'title presence should be valid' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'comments counter should be valid' do
    @post.comments_counter = nil
    expect(@post).to_not be_valid
  end

  it 'author id should be present' do
    @post.author_id = nil
    expect(@post).to_not be_valid
  end

  it 'comments counter should be an integer' do
    @post.comments_counter = 'hello'
    expect(@post).to_not be_valid
  end

  it 'likes counter should be an integer' do
    @post.likes_counter = 'hello'
    expect(@post).to_not be_valid
  end

  describe 'methods in post' do
    before do
      @user = User.create(name: 'balix', photo: 'https://unsplash.com/es/fotos/W5nhsrznVp0', bio: 'coder from Uganda')
      @post1 = Post.create(author: @user, title: 'My post', text: 'Hello!')
      6.times do
        Comment.create(post: @post1, author: @user, text: 'Hi Tom!')
      end
    end

    it 'should have the recent comments method' do
      expect(@post).to respond_to(:recent_comments)
    end

    it 'should return recent comments count' do
      expect(@post1.recent_comments.count).to eql(5)
    end

    it 'updates the posts_counter of the author' do
      expect { @post.send(:update_post_counter) }.to change { @user.reload.posts_counter }.by(0)
    end
  end
end
