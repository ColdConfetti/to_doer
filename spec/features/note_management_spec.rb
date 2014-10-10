require "spec_helper"
include Warden::Test::Helpers

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

  scenario 'it can then be made complete' do
    @user.notes.first.update(complete: true)
    visit complete_notes_path
    expect(page).to have_content 'This is a test note.'
  end

  after do
    @user.delete
  end
end