
class User
  attr_accessor :account_id,
                :pan
end

FactoryGirl.define do
     factory :user1, class:User do
        account_id '00000042265'
        pan '4775967118729461'
     end  
end