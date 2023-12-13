require 'rails_helper'

RSpec.describe "User Registration" do
  it 'has a link to log in a registered user' do
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "1234")
    visit root_path

    expect(page).to have_link("Log In")

    click_link("Log In")

    expect(current_path).to eq(login_path)
  end

  it "can log in a user" do
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "1234", password_confirmation: "1234")
    visit login_path

    expect(page).to have_content("Email")
    expect(page).to have_content("Password")

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    
    click_button "Log In"

    expect(current_path).to eq(dashboard_path)
  end

  describe "logging in sad path" do
    it "must have correct password" do
      @user1 = User.create(name: "User One", email: "user1@test.com", password: "1234")
      visit "/login"

      fill_in :email, with: @user1.email
      fill_in :password, with: "2345"

      click_button "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect Email or Password.")
    end

    it "must have correct email" do
      @user1 = User.create(name: "User One", email: "user1@test.com", password: "1234")
      visit "/login"

      fill_in :email, with: "user2@test.com"
      fill_in :password, with: "1234"

      click_button "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect Email or Password.")
    end
  end

end