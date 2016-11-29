require 'spec_helper'

describe 'Authentication', type: :feature do
  subject { page }

  describe 'authorization' do
    describe 'for non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'when attempting to visit a protected page' do
        before do
          visit edit_user_path(user)
          sign_in_capy user
        end

        describe 'after signing in' do
          it 'renders the desired protected page' do
            expect(page.title).to eq('Edit User')
          end
        end
      end
    end

    describe 'as wrong user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }
      before { sign_in_capy user }

      describe 'visiting Users#edit page' do
        before { visit edit_user_path(wrong_user) }
        it do
          expect(page.title).not_to eq('Edit user')
        end
      end
    end

    describe 'for non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'when attempting to visit a protected page' do
        before do
          visit edit_user_path(user)
          fill_in 'Email',    with: user.email
          fill_in 'Password', with: user.password
          click_button 'Sign in'
        end

        describe 'after signing in' do
          it 'renders the desired protected page' do
            expect(page.title).to eq('Edit User')
          end

          describe 'when signing in again' do
            before do
              visit signin_path
              fill_in 'Email',    with: user.email
              fill_in 'Password', with: user.password
              click_button 'Sign in'
            end

            it 'renders the default (show user) page' do
              expect(page.title).to eq('User Profile')
            end
          end
        end
      end

      describe 'in the Users controller' do
        describe 'visiting the user index' do
          before { visit users_path }
          it { expect(page.title).to eq('Sign in') }
        end

        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }
          it { expect(page.title).to eq('Sign in') }
        end
      end
    end
  end

  describe 'signin page' do
    before { visit signin_path }

    it { should have_selector('h1', text: 'Sign in') }
    it { expect(page.title).to eq('Sign in') }
  end

  describe 'signin' do
    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign in' }

      it { expect(page.title).to eq('Sign in') }
      it { should_not have_link('Profile') }
      it { should_not have_link('Settings') }

      describe 'after visiting another page' do
        before { click_link 'Home' }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe 'followed by signout' do
        before { click_link 'Sign out' }
        it { should have_link('Sign in') }
      end
    end
  end
end
