class BookieController < ApplicationController

    def help 
         render json: "NO HELP!"
    end
    #!bet wager "Megan_is still asleep" 3000
    #!bet status "Megan_is still asleep"
    #!bet ...
    #message = 'wager&_&"Megan_is&_&still&_&asleep"&_&3000'
    #/bookie?message='wager&_&"Megan_is&_&still&_&asleep"&_&3000'
    #
    # !bet -> immediately what comes after is the action we want to call (ex. help, wager, etc)
    # depending on the action that is called, specific params also need to be called (ex. wager -> title + amt)
    # each action has a specified number of params required to fill (ex. help -> 0, wager -> 2)

    #http://localhost:3000/bookie?message=[bob's,life,is,great] =>
    #"message"=>"[bob's,life,is,great]"

    
    #http://localhost:3000/bookie?message="bob's_life_is_great"
    #"message"=>"\"bob's_life_is_great\""

    #http://localhost:3000/bookie?bob=1&great=2
    #"bob"=>"1", "great"=>"2"
#http://localhost:3000/bookie?name=bob&life=great
    def help
        # list all commands
    end

    def my_salt 
        #shows the users current salt 
    end
end