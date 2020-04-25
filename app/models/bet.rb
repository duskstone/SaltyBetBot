# == Schema Information
#
# Table name: bets
#
#  id          :bigint           not null, primary key
#  wager       :integer          not null
#  user_id     :integer          not null
#  bet_pool_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  action      :boolean
#
class Bet < ApplicationRecord 

    belongs_to :user,
    foreign_key: :user_id,
    class_name: :User 

    belongs_to :bet_pool,
    foreign_key: :bet_pool_id,
    class_name: :BetPool

end 
