require 'spec_helper'

describe ClientsController do
	render_views

	context '#new' do
		it "should render signup template from clients" do
			get :new
			response.should render_template('new')

			assert_select '.registration-form'
			assert_select '.registration-form label', {:text => 'Name'}
			assert_select '.registration-form label', {:text => 'Email'}
			assert_select '.registration-form label', {:text => 'Password'}
			assert_select '.registration-form label', {:text => 'Phone number'}
		end
	end

	context '#create' do

		it "should create a new client" do
			lambda {
				post :create , :client => {
					:name     => 'foo',
					:email    => 'foo@bar.com',
					:password => 'secret',
					:phone_number => '9234523456'
				}
			}.should change(Client, :count).by(1)
			response.should redirect_to(lawyers_path)
		end

		it "should show errors if creation fails" do
			lambda {
				post :create, :client => {}
				}.should_not change(Client, :count)

				response.should render_template('new')
				assert_select "#error_explanation"
		end
	end
end
