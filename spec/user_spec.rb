require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    # VALID USER
    @user = User.create 
    @user.name = "Sally" 
    @user.email = 'sally@email.com' 
    @user.password = '12345' 
    @user.password_confirmation = '12345'
    @user.save

    # INVALID CASES
    @user_without_password = User.create 
    @user_without_password.name = "Jo"
    @user_without_password.email = 'jo@email.com' 
    @user_without_password.password = nil 
    @user_without_password.password_confirmation = '12345'

    @user_without_password_confirmation = User.create 
    @user_without_password_confirmation.name = "Jo" 
    @user_without_password_confirmation.email = 'jo@email.com' 
    @user_without_password_confirmation.password = '123dssa'
    @user_without_password_confirmation.password_confirmation = nil
    
    @user_with_notmatching_password = User.create 
    @user_with_notmatching_password.name = "Jo" 
    @user_with_notmatching_password.email = 'jo@email.com' 
    @user_with_notmatching_password.password = '12345' 
    @user_with_notmatching_password.password_confirmation = '54321'

    @user_with_same_email = User.create 
    @user_with_same_email.name = "Joe" 
    @user_with_same_email.email = 'jo@email.com' 
    @user_with_same_email.password = '12345' 
    @user_with_same_email.password_confirmation = '12345'

    @user_with_same_case_insensitive_email = User.create 
    @user_with_same_case_insensitive_email.name = "Jenna Olson" 
    @user_with_same_case_insensitive_email.email = 'JO@EMAIL.COM'
    @user_with_same_case_insensitive_email.password = '12345'
    @user_with_same_case_insensitive_email.password_confirmation = '12345'

    @user_without_name = User.create 
    @user_without_name.name = nil 
    @user_without_name.email = 'jo@email.com'
    @user_without_name.password = '12345' 
    @user_without_name.password_confirmation = '12345'

    @user_without_email = User.create 
    @user_without_email.name = 'Jo' 
    @user_without_email.email = nil 
    @user_without_email.password = '12345' 
    @user_without_email.password_confirmation = '12345'

    @user_with_short_password = User.create
    @user_with_short_password.name = 'Jo' 
    @user_with_short_password.email = nil 
    @user_with_short_password.password = '12' 
    @user_with_short_password.password_confirmation = '12'
  end

  describe 'Validations' do
    it "should validate name" do
      expect(@user_without_name).to be_invalid
      expect(@user_without_name.errors.messages[:name]).to include("can't be blank")
    end

    it "should validate email" do
      expect(@user_without_email).to be_invalid
      expect(@user_without_email.errors.messages[:email]).to include("can't be blank")
    end
    
    it "should have a password" do
      expect(@user_without_password).to be_invalid
      expect(@user_without_password.errors.messages[:password]).to include("can't be blank")
    end

    it "should have a password_confirmation" do
      expect(@user_without_password_confirmation).to be_invalid
      expect(@user_without_password_confirmation.errors.messages[:password_confirmation]).to include("can't be blank")
    end
    
    it "should have matching passwords" do
      expect(@user).to be_valid
      expect(@user_with_notmatching_password).to be_invalid
    end

    it "should validate password minimum length" do
      expect(@user_with_short_password).to be_invalid
      expect(@user_with_short_password.errors.messages[:password]).to include("is too short (minimum is 5 characters)")
    end

    it "should have a unique email" do
      expect(@user_with_same_email).to be_invalid
    end

    it "should validate insensitive-case email" do
      expect(@user_with_same_case_insensitive_email).to be_invalid
    end
  end

  describe '.authenticate_with_credentials' do
    it "should create @user with an arg email and password" do
      user = User.authenticate_with_credentials('sally@email.com', '12345')
      expect(user).to eq(@user)
    end

    it "should create @user with whitespaces in email" do
      user = User.authenticate_with_credentials(' sally@email.com ', '12345')
      expect(user).to eq(@user)
    end

    it "should create @user with a wrong case email" do
      user = User.authenticate_with_credentials('SALLy@EMAIL.CoM', '12345')
      expect(user).to eq(@user)
    end

    it "should not create @user with wrong email" do
      user = User.authenticate_with_credentials('test@email.com', '12345')
      expect(user).to be_nil
    end

    it "should not create @user with wrong email" do
      user = User.authenticate_with_credentials('test@email.com', '1')
      expect(user).to be_nil
    end

    it "should not create @user with wrong email" do
      user = User.authenticate_with_credentials('', '')
      expect(user).to be_nil
    end
  end
end