require 'spec_helper'

describe Lawyer do
  context "validations" do
     before { @lawyer = FactoryGirl.build(:lawyer) }
     subject { @lawyer }

     describe "with empty name" do
       before { @lawyer.name = nil}
       it { should_not be_valid }
     end

     describe "with missing email" do
       before { @lawyer.email = nil }
       it { should_not be_valid }
     end

     describe "with missing password" do
       before { @lawyer.password = nil }
       it { should_not be_valid }
     end

     describe "with duplicate email" do
       before(:each) do
         @other_lawyer = FactoryGirl.create(:lawyer)
         @lawyer.email = @other_lawyer.email
       end
       it { should_not be_valid }
     end

     describe "with duplicate email (ignoring case)" do
       before(:each) do
         @other_lawyer = FactoryGirl.create(:lawyer)
         @lawyer.email = @other_lawyer.email.upcase
       end
       it { should_not be_valid }
     end

     describe "with invalid email" do
       before { @lawyer.email = "foo" }
       it { should_not be_valid }
     end
   end

   it "should downcase emails before saving" do
     lawyer = FactoryGirl.create(:lawyer, email: 'FOOBAR@example.org')
     lawyer.email.should == 'foobar@example.org'
   end
end
