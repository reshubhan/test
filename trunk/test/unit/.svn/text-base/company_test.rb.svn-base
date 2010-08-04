require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # Replace this with your real tests.

    fixtures :companies

  

  def test_user_login=(aaron)

    @user=User.find_by_login(aaron)
    if @user.login =="aaron"
      assert( true,'assertion passed')
    else
      assert(false, 'assertion failed' )
    end

  end

     def test_type_sell
       @company=Company.find_by_id(953125641)
      returnval=@company.type_sell
      if  returnval=='sell'
          assert( true,'assertion passed')
      else

       assert(false, 'assertion failed' )

      end
    end

end
