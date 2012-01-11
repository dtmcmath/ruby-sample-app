require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => 'Example User', :email => 'user@example.com', :password => 'foobar', :password_confirmation => 'foobar' }
  end
  
  it 'should reject duplicate email addresses with caveat' do
  A = User.new( @attr ) 
  A.should be_valid          # always valid

  B = User.new( @attr )
  B.should be_valid          # always valid, as expected

  A.save.should be_true      # save always works fine

  B.should_not be_valid
  lambda { B.save(:validate => false ) }.should raise_exception(ActiveRecord::RecordNotUnique)     # this is the problem case
  # B.should_not be_valid    # ...same results as "save.should"
end

  it 'should reject duplicate email addresses with caveat and case' # do
    # u1 = User.new( @attr.merge( :email => @attr[:email].upcase ) ) 
    # u1.should be_valid
# 
    # user_with_duplicate_email = User.new( @attr )
    # user_with_duplicate_email.should be_valid
#     
    # u1.save.should be_true
    # user_with_duplicate_email.save(:validate => false).should raise_exception
  # end
end
