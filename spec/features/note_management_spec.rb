require "spec_helper"
include Warden::Test::Helpers

module RequestHelpers
  def create_logged_in_user
    user = User.create(email: "bob@bob.com", password: "bobbobbob", password_confirmation: "bobbobbob")
    login(user)
    user
  end

  def login(user)
    login_as user, scope: :user
  end
end

feature 'When a user creates a note' do

  #there must be a better way... use factorygirl to create users
  before do
    @user = User.create(email: "test@test.com", password: "testtest", password_confirmation: "testtest")
    login_as @user, scope: :user
    visit notes_path
    fill_in('main_content', :with => 'This is a test note.')
    click_button 'Create Note'
  end

  scenario 'it appears immediately on the page' do
    expect(page).to have_content 'This is a test note.'
  end

  scenario 'it is part of its note data' do
    expect(@user.notes.first.content).to eq 'This is a test note.'
  end

  scenario 'it can then be marked as complete', js: true do
    check('complete_checkbox')
    visit complete_notes_path
    expect(page).to have_content 'This is a test note.'
  end

  after :each do
    @user.delete
  end
end