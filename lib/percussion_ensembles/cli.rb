class PercussionEnsembles::CLI

    @@site1 = "https://www.tapspace.com/percussion-ensemble/"
    @@site2 = "https://www.tapspace.com/chamber-music/"
    @@site3 = "https://www.tapspace.com/steel-band/"
    @@site4 = "https://www.tapspace.com/new-releases/"

    def call
        puts "----------------------------------------------".green
        puts "       Welcome to Percussion Ensembles!".yellow
        puts "----------------------------------------------".green
        puts "            Finding pieces now....".red
        puts "----------------------------------------------".green
        make_ensembles(@@site1)
        make_ensembles(@@site2)
        make_ensembles(@@site3)
        make_ensembles(@@site4)
        display_ensembles
        menu
    end

    def make_ensembles(site)
        ensembles_array = PercussionEnsembles::Scraper.new.scrape(site)
        PercussionEnsembles::Ensemble.create_from_collection(ensembles_array)
    end

    def display_ensembles(ensembles = PercussionEnsembles::Ensemble.all)
        ensembles.each do |ensemble|
            puts "#{ensemble.name.upcase}".magenta
            puts "#{ensemble.composer.name}".yellow
            puts "#{ensemble.level}".blue
            puts "#{ensemble.personnel}".cyan
            puts "#{ensemble.duration}".white
            puts "----------------------------------------------".green
        end
    end

    def menu
        input = ""

        while input!= "exit"
            puts "To search by composer, enter '".cyan + "composer".white + "'.".cyan
            puts "To search by difficulty, enter '".cyan + "difficulty".white + "'.".cyan
            puts "To search by number of players, enter '".cyan + "players".white + "'.".cyan
            puts "To search by difficulty and number of players, enter '".cyan + "both".white + "'.".cyan
            puts "To quit, type '".cyan + "exit".red + "'.".cyan
            puts "What would you like to do?".yellow

            input = gets.strip

            case input
            when "composer"
                composer
            when "difficulty"
                difficulty
            when "players"
                players
            when "both"
                both
            end
        end
    end

    def composer(ensembles = PercussionEnsembles::Ensemble.all)
        input = ""

        while input != "exit"    
            sorted_composers = PercussionEnsembles::Composer.all.sort_by {|composer| composer.name}
            sorted_composers.each_with_index {|composer, i| puts "#{i+1}. #{composer.name}".cyan}
            puts "----------------------------------------------".green
            puts "   To return to the main menu, type '".cyan + "exit".red + "'.".cyan
            puts "     Select a composer by typing a number".yellow
            puts "----------------------------------------------".green
            puts " Results will be above the list of composers!".white
            puts "----------------------------------------------".green

            input = gets.strip
            puts "----------------------------------------------".green
            
            if input != "exit"
                input = input.to_i - 1
                if input.between?(0, sorted_composers.count)
                    display_ensembles(sorted_composers[input].songs)
                else
                    puts "NOT A VALID INPUT...Type a number from the list above.".red
                end
            end
        end
    end

    def difficulty(ensembles = PercussionEnsembles::Ensemble.all)
        input = ""

        while input != "exit"   
            puts "1. Easy".cyan
            puts "2. Med-Easy".cyan
            puts "3. Medium".cyan
            puts "4. Med-Advanced".cyan
            puts "5. Advanced".cyan
            puts "----------------------------------------------".green
            puts "To return to the main menu, type '".cyan + "exit".red + "'.".cyan
            puts "Select a difficulty by typing its number.".yellow

            puts "----------------------------------------------".green

            input = gets.strip

            case input
            when "1"
                display = difficulty_select("Easy", ensembles)
            when "2"
                display = difficulty_select("Med-Easy", ensembles)
            when "3"
                display = difficulty_select("Medium", ensembles)
            when "4"
                display = difficulty_select("Med-Advanced", ensembles)
            when "5"
                display = difficulty_select("Advanced", ensembles)
            end
        end
    end

    def players(ensembles = PercussionEnsembles::Ensemble.all)
        input = ""
       
        while input != "exit"   
            puts "To return to the previous menu, type 'exit'.".red
            puts "Type the number of players you would like in the ensemble. 0 will give you a list of uncategorized pieces.".yellow
            puts "----------------------------------------------".green
            input = gets.strip
            
            if player_select(input).any?
                display_ensembles(player_select(input))
            else
                puts "NO ENSEMBLES TO DISPLAY".red
            end
        end
    end

    def both(ensembles = PercussionEnsembles::Ensemble.all)
        input = ""
       
        while input != "exit"    
            puts "To return to the main menu, type '".cyan + "exit".red + "'.".cyan
            puts "Type the number of players you would like in the ensemble.".yellow

            input = gets.strip

            puts "----------------------------------------------".green
            
            if player_select(input).any?
                display = display_ensembles(player_select(input))
                difficulty(display)
            else
                puts "NO ENSEMBLES TO DISPLAY".red
            end
        end
    end

    def difficulty_select(difficulty, ensembles = PercussionEnsembles::Ensemble.all)
        display_ensembles(ensembles.select {|ensemble| ensemble.level == difficulty})
    end

    def player_select(players, ensembles = PercussionEnsembles::Ensemble.all)
        ensembles.select {|ensemble| ensemble.personnel.to_i.to_s == players}
    end
end