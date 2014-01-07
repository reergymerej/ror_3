require 'spec_helper'

describe "UserPages" do
	
	subject { page }
  describe 'profile page' do

    #User FactoryGirl to create a user
    let(:user) { FactoryGirl.create(:user) }

    # user_path is a named route
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe 'signup page' do

    before { visit signup_path }

    let(:submit) { 'Create my account' }

    describe 'with invalid info' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end

      # test the error messages
      describe 'after submission' do

        # click submit
        # before { click_button submit }
        before do
          fill_in 'Name', with: 'asdf'
          fill_in 'Email', with: 'asdf@invalid'
          fill_in 'Password', with: 'short'
          click_button submit
        end

        # view should now have errors
        it { should have_title('Sign up') }
        it { should have_content('error') }
        it { should have_content('What the hell?') }
        it { should have_content('too short') }
      end
    end

    describe 'with valid info' do
      # fill in the form
      # This happens before each test.
      before do
        fill_in 'Name', with: 'Example User'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'foobar'
        fill_in 'Confirmation', with: 'foobar'
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        # submit the form
        before { click_button submit}

        # assign the local user variable to the symbol :user
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end
