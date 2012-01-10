require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it 'should hav the right title' do
      get :new
      response.should have_selector('title', :content => 'Sign in')
    end
  end
  
  describe 'POST create' do
    describe 'invalid signin' do
      before(:each) do
        @attr = { :email => 'email@example.com', :password => 'invalid' }
      end
      
      it 'should re-render the new page' do
        post :create, :session => @attr
        response.should render_template('new')
      end
      
      it 'should have he right title' do
        post :create, :session => @attr
        response.should have_selector( 'title', :content => 'Sign in' )
      end
      
      it 'should have a flash.new message' do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end
    
    describe 'with valid email and password' do
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end
      
      it 'should sign the user in' do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      
      it 'should redirect to the user show page' do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end
  end

end
