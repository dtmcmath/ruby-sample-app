require 'spec_helper'

describe 'Relationships' do
    
  describe 'manage follower/ing' do
    before(:each) do
      @user = Factory(:user)
      @followed = Factory(:user, :email => Factory.next(:email))
    end
    
    describe 'for a signed-in user' do
      before(:each) do
        integration_sign_in(@user)
      end
      
      it 'should increase following after follow action' do
        visit user_path(@followed)
        click_button 'Follow'
        response.should be_success
        @user.following?(@followed).should be_true
      end
      
      it 'should decrease following after unfollow action' do
        @user.follow!(@followed)
        visit user_path(@followed)
        click_button 'relationship_submit'
        response.should be_success
        @user.following?(@followed).should be_false
      end
    end
  end

end
