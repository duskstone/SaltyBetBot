# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  salt       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord

    has_many :bets,
    foreign_key: :user_id,
    class_name: :Bet 

    has_many :bet_pools,
    foreign_key: :user_id,
    class_name: :BetPool

end 
