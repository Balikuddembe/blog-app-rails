require 'rails_helper'

RSpec.describe 'User show', type: :feature do
  before :each do
    @user = User.create(
      name: 'Balix',
      photo: 'https://cdn-icons-png.flaticon.com/512/3220/3220315.png',
      bio: 'Coder'
    )
    @user1 = User.create(
      name: 'Balix1',
      photo: 'https://cdn-icons-png.flaticon.com/512/3220/3220315.png',
      bio: 'Coder and commenter'
    )
    @post1 = Post.create(author: @user, title: 'Hello1', text: 'This is my first post!')
    @post2 = Post.create(author: @user, title: 'Hello2', text: 'This is my second post!')
    @post3 = Post.create(author: @user, title: 'Hello3', text: 'This is my third post!')
    # visit user_path(@user.id)

    @comment1 = Comment.create(text: 'First comment', author: @user, post: @post1)
    @comment2 = Comment.create(text: 'Second comment', author: @user, post: @post1)
    @comment3 = Comment.create(text: 'Third comment', author: @user, post: @post1)

    @like1 = Like.create(author: @user, post: @post1)
    @like1 = Like.create(author: @user1, post: @post1)

    visit user_post_path(@user.id, @post1.id)
  end

  scenario "show post's title" do
    expect(page).to have_selector('h2', text: 'Hello1')
  end

  scenario "show post's author" do
    expect(page).to have_selector('h2', text: 'Balix')
  end

  scenario 'Show the number of comments for a post' do
    expect(page).to have_content('Comments: 3')
  end

  scenario 'Show the number of likes for a post' do
    expect(page).to have_content('Likes: 2')
  end

  scenario 'Show the content of a post' do
    expect(page).to have_selector('.post-text', text: 'This is my first post!')
  end

  scenario 'Show the username of all commenters' do
    expect(page).to have_selector('.commenter-identifier', text: 'Balix', count: 3)
  end

  scenario 'Show the comment of all commenter' do
    expect(page).to have_selector('.commenter-identifier', text: 'Balix' && 'First comment')
    expect(page).to have_selector('.commenter-identifier', text: 'Balix' && 'Second comment')
    expect(page).to have_selector('.commenter-identifier', text: 'Balix' && 'Third comment')
  end
end
