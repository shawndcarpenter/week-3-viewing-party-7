require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "1234", password_confirmation: "1234")
    @user2 = User.create(name: "User Two", email: "user2@test.com", password: "1234", password_confirmation: "1234")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  describe "Authorization Challenge" do
    it "does not show existing users as a visitor" do
      expect(page).to_not have_content(@user1.email)
      expect(page).to_not have_content(@user2.email)
      expect(page).to_not have_content("Existing Users:")
    end

    it "does not show links to show pages for registered users" do
      visit login_path
      fill_in :email, with: @user1.email
      fill_in :password, with: @user1.password    
      click_button "Log In" 
      visit root_path

      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
      expect(page).to_not have_link(@user1.email)
      expect(page).to_not have_link(@user2.email)
    end

    it "will not let visitors view the dashboard" do
      visit "/users/#{@user1.id}"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You must be logged in or registered to access the dashboard.")
    end
  end
end
