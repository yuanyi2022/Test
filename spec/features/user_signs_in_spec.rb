require 'rails_helper'

RSpec.feature 'User SignIn', type: :feature do
  let(:user) { create(:user) }
  scenario 'User signs in successfully' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'User cannot sign in with wrong password' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong_password'

    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
  scenario 'User cannot sign in with wrong email' do
    visit new_user_session_path
    fill_in 'Email', with: 'admin'
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
end
