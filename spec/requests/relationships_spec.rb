require 'spec_helper'

describe 'Relationships' do
    
  describe 'manage follower/ing' do
    describe 'for an un-signed-in user' do
      pending 'should redirect on follow action'
      pending 'should redirect on unfollow action'
    end
    
    describe 'for a signed-in user' do
      before(:each) do
        @user = Factory(:user)
        integration_sign_in(@user)
        @followed = Factory(:user, :email => Factory.next(:email))
      end
      
      it 'should increase following after follow action' do
        visit user_path(@followed)
        click_button 'Follow'
        response.should redirect_to(user_path(@followed))
        @user.following?(@followed).should be_true
      end
      
      it 'should decrease following after unfollow action' do
        @user.follow!(@followed)
        @user.following?(@followed).should be_true
        visit user_path(assigns(@followed))
        click_button 'relationship_submit'
        response.should redirect_to(user_path(@followed))
        @user.following?(@followed).should be_false
      end
    end
  end

end
