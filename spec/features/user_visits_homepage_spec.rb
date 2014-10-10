require "spec_helper"

feature 'When a new user visits the website' do
  before :each do
    visit root_path
  end
  scenario 'they see the login page' do
    expect(page).to have_content "View My Notes"
  end
  scenario 'they can visit the sign up page' do
    click_link 'Sign up'
    visit new_user_registration_path
    expect(page).to have_content "Password confirmation"
  end
  scenario 'they can visit the login page' do
    click_link 'Login'
    visit new_user_session_path
    expect(page).to have_content "Password"
  end
  scenario 'they can view the to-do page as guest' do
    click_link 'View My Notes'
    visit notes_path
    expect(page).to have_content "signed in as a guest"
  end
end