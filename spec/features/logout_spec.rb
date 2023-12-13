require 'rails_helper'

RSpec.describe "User Logout" do
  describe "Part 1: Sessions Challenge" do
    before :each do
      @user1 = User.create(name: "User One", email: "user1@test.com", password: "1234", password_confirmation: "1234")
      visit login_path
  
      fill_in :email, with: @user1.email
      fill_in :password, with: @user1.password
      
      click_button "Log In"
  
      expect(current_path).to eq(dashboard_path)
  
      visit root_path
    end

    it 'has a link to log out' do
      expect(current_path).to eq(root_path)
      expect(page).to have_link("Log Out")
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_button("Create New User")
    end

    it 'can log out a user' do
      click_link("Log Out")

      expect(current_path).to eq(root_path)
      expect(page).to_not have_link("Log Out")
      expect(page).to have_link("Log In")
      expect(page).to have_button("Create New User")
    end
  end
end