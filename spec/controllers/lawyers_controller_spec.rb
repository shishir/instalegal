require 'spec_helper'

describe LawyersController do
  render_views

  context '#new' do
    it "should render signup template from laywers" do
      get :new
      response.should be_success
      response.should render_template('new')
      assert_select ".registration .registration-form"
    end
  end

  context '#create' do
    it "should create a new lawyer" do
      lambda {
        post :create, :lawyer => {
                          :name => 'Foo',
                          :email => 'foo@bar.com',
                          :password => 'xyz',
                          :phone_number => '312 212 5555',
                          :description => 'blah'}
      }.should change(Lawyer, :count).by(1)

      response.should be_redirect
    end

    it "should show errors if creation fails" do
      lambda {
        post :create, :lawyer => {}
      }.should_not change(Lawyer, :count)

      response.should render_template('new')
      assert_select "#error_explanation"
    end
  end

  context '#index' do
    it "should list details the lawyers" do
      lawyer_one = FactoryGirl.create(:lawyer)

      get :index

      response.should render_template('index')
      assert_select '#lawyer-index .thumbnail' do |elements|
        elements.each do |element|
          assert_select element, "h3", {:text => lawyer_one.name}
          assert_select element, "p" , {:text => lawyer_one.description}
        end
      end
    end
  end

  context '#busy' do
    it "should change status of a lawyer from available to busy" do
      lawyer_one = FactoryGirl.create(:lawyer)
      lawyer_one.should_not be_busy

      post :busy, :id => lawyer_one.id

      lawyer_one.reload
      lawyer_one.should be_busy
    end
  end

  context '#available' do
    it "should change status of a lawyer from busy to available" do
      lawyer_one = FactoryGirl.create(:lawyer, :busy => true)
      lawyer_one.should be_busy

      post :available, :id => lawyer_one.id

      lawyer_one.reload
      lawyer_one.should_not be_busy

    end
  end
end