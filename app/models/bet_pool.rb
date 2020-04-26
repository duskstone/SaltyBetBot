# == Schema Information
#
# Table name: bet_pools
#
#  id          :bigint           not null, primary key
#  user_id     :integer          not null
#  title       :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class BetPool < ApplicationRecord 

    belongs_to :user,
    foreign_key: :user_id,
    class_name: :User 

    has_many :bets, dependent: :destroy,
    foreign_key: :bet_pool_id,
    class_name: :Bet

    has_many :users,
    through: :bets,
    source: :user

    def total_salt  
        #shows the currrent amount of salt
       bets.group('bets.bet_pool_id').pluck('SUM(bets.wager)').first
    end

    def true_false_bet_ratio
    end

    def won
        #will handle when a pot is closed and distrbute the winnnings
    end

    

end
