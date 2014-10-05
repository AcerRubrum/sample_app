require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      #it { should have_selector('div.alert.alert-error') } # section 8.3.3.o
			it { should have_error_message('Invalid') } # section 8.3.3.n

      describe "after visiting another page" do
        before { click_link "Home" }
        #it { should_not have_selector('div.alert.alert-error') } # section 8.3.3.o
				it { should_not have_error_message('Invalid') } # section 8.3.3.n
      end
    end
    describe "with valid information" do
      #let(:user) { FactoryGirl.create(:user) } # section 8.3.3.so
      #before do
        #fill_in "Email",    with: user.email.upcase
        #fill_in "Password", with: user.password
        #click_button "Sign in"
      #end																			# section 8.3.3.eo
			let(:user) { FactoryGirl.create(:user) }	# section 8.3.3.n
			before { valid_signin(user) }							# section 8.3.3.n

      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end
