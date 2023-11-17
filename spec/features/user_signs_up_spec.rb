require 'rails_helper'

RSpec.feature 'User SignUp', type: :feature do
  # 创建一个普通用户实例，但不保存到数据库中
  let(:user_attributes) { attributes_for(:user) }
  scenario 'Welcome! You have signed up successfully.' do
    visit new_user_registration_path

    fill_in 'Email', with: 'newuser@example.com' # 用一个新的邮箱地址以避免冲突
    fill_in 'Password', with: user_attributes[:password]
    fill_in 'Password confirmation', with: user_attributes[:password_confirmation]
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
  scenario 'Password is too short (minimum is 6 characters)' do
    visit new_user_registration_path
    fill_in 'Email', with: 'shortpassword@example.com' # 使用新的邮箱以避免冲突
    fill_in 'Password', with: '123' # 故意使用过短的密码
    fill_in 'Password confirmation', with: '123'
    click_button 'Sign up'
    expect(page).to have_content('Password is too short (minimum is 6 characters)')
  end

  scenario "Password confirmation doesn't match Password" do
    visit new_user_registration_path
    fill_in 'Email', with: 'mismatch@example.com' # 使用新的邮箱以避免冲突
    fill_in 'Password', with: user_attributes[:password]
    fill_in 'Password confirmation', with: 'wrongconfirmation' # 故意不匹配的密码确认
    click_button 'Sign up'
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'Email has already been taken' do
    # 创建并保存一个用户到数据库中，以模拟邮箱已经被注册的情况
    create(:user, email: 'takenemail@example.com')
    visit new_user_registration_path

    fill_in 'Email', with: 'takenemail@example.com' # 使用已被创建的邮箱
    fill_in 'Password', with: user_attributes[:password]
    fill_in 'Password confirmation', with: user_attributes[:password_confirmation]
    click_button 'Sign up'
    expect(page).to have_content('Email has already been taken')
  end
end
