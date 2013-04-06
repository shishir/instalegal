require 'spec_helper'

describe Client do
  describe "validations" do
    before { @client = FactoryGirl.build(:client) }
    subject { @client }

    describe "with empty name" do
      before { @client.name = nil}
      it { should_not be_valid }
    end

    describe "with missing email" do
      before { @client.email = nil }
      it { should_not be_valid }
    end

    describe "with missing password" do
      before { @client.password = nil }
      it { should_not be_valid }
    end

    describe "with duplicate email" do
      before(:each) do
        @other_client = FactoryGirl.create(:client)
        @client.email = @other_client.email
      end
      it { should_not be_valid }
    end

    describe "with duplicate email (ignoring case)" do
      before(:each) do
        @other_client = FactoryGirl.create(:client)
        @client.email = @other_client.email.upcase
      end
      it { should_not be_valid }
    end

    describe "with invalid email" do
      before { @client.email = "foo" }
      it { should_not be_valid }
    end
  end

  it "should downcase emails before saving" do
    client = FactoryGirl.create(:client, email: 'FOOBAR@example.org')
    client.email.should == 'foobar@example.org'
  end
end
