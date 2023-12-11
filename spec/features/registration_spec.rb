require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "1234"
    fill_in :user_password_confirmation, with: "1234"
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: "1234")

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with: "1234"
    fill_in :user_password_confirmation, with: "1234"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  describe "Authentication Challenge" do
    it "can register a user" do
      visit '/register'
    
      fill_in :user_name, with: "Janet Love"
      fill_in :user_email, with: "janetlovescooking@aol.com"
      fill_in :user_password, with: "1234"
      fill_in :user_password_confirmation, with: "1234"
      click_button "Create New User"

      user = User.last

      expect(current_path).to eq(user_path(user))
    end

    describe "registration sad path" do
      it "must have a password" do
        visit '/register'
    
        fill_in :user_name, with: "Janet Love"
        fill_in :user_email, with: "janetlovescooking@aol.com"
        click_button "Create New User"

        expect(page).to have_content("Password can't be blank")
        expect(current_path).to eq(register_path)
      end

      it "must have an email" do
        visit '/register'
    
        fill_in :user_name, with: "Janet Love"
        fill_in :user_password, with: "1234"
        fill_in :user_password_confirmation, with: "1234"
        click_button "Create New User"

        expect(page).to have_content("Email can't be blank")
        expect(current_path).to eq(register_path)
      end

      it "must have matching passwords" do
        visit '/register'
    
        fill_in :user_name, with: "Janet Love"
        fill_in :user_email, with: "janetlovescooking@aol.com"
        fill_in :user_password, with: "1234"
        fill_in :user_password_confirmation, with: "2345"
        click_button "Create New User"

        expect(page).to have_content("Error: Passwords do not match")
        expect(current_path).to eq(register_path)
      end
    end
  end
end
