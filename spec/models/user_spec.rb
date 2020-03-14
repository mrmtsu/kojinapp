require 'rails_helper'

describe User do
  describe '#create' do

    it "is valid with a name, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it "is invalid without a name that has more than 7 characters" do
      user = build(:user, name: "aaaaaaa")
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 6 characters)")
    end

    it "is invalid without a name that has less than 6 characters" do
      user = build(:user, name: "aaaaaa")
      expect(user).to be_valid
    end

    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has alredy been taken")
    end

    it "is valid with a password than has more 8 characters" do
      user = build(:user, password: "11111111", password_confirmation: "11111111")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a password that has less than 7 characters" do
      user = build(:user, password: "1111111", password_confirmation: "1111111")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

  end
end