class PercussionEnsembles::CLI

    ## HARDCODED WEBSITES
    @@site = "https://www.tapspace.com/percussion-ensemble/#filter_306_39&CatalogSetSortBy=name&apply_filters=yes"


    def call
        puts "---------------------------------------------".green
        puts "Welcome to Percussion Ensembles!".green
        puts "---------------------------------------------".green
        make_ensembles(@@site)
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
            puts "---------------------------------------------".green
        end
    end

    def menu
        input = ""

        while input!= "exit"
            puts "To search by composer, enter 'composer'.".cyan
            puts "To search by difficulty, enter 'difficulty'.".cyan
            puts "To search by number of players, enter 'players'.".cyan
            puts "To search by difficulty and number of players, enter 'both'.".cyan
            puts "To quit, type 'exit'.".red
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
            PercussionEnsembles::Composer.all.each_with_index {|composer, i| puts "#{i+1}. #{composer.name}".cyan}
            puts "To return to the main menu, type 'exit'.".red
            puts "Type the number of the composer you would like to see.".yellow
            puts "Results will be above the list of composers!".white

            input = gets.strip
            puts "---------------------------------------------".green
            
            if input != "exit"
                input = input.to_i - 1
                if input.between?(0, PercussionEnsembles::Composer.all.count)
                    display_ensembles(PercussionEnsembles::Composer.all[input].songs)
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
            puts "To return to the main menu, type 'exit'.".red
            puts "Type the number of the difficulty you would like to see.".yellow

            input = gets.strip

            puts "---------------------------------------------".green
            
            case input
            when "1"
                display = display_ensembles(ensembles.select {|ensemble| ensemble.level == "Easy"})
            when "2"
                display = display_ensembles(ensembles.select {|ensemble| ensemble.level == "Med-Easy"})
            when "3"
                display = display_ensembles(ensembles.select {|ensemble| ensemble.level == "Medium"})
            when "4"
                display = display_ensembles(ensembles.select {|ensemble| ensemble.level == "Med-Advanced"})
            when "5"
                display = display_ensembles(ensembles.select {|ensemble| ensemble.level == "Advanced"})
            end
        end
    end

    def players(ensembles = PercussionEnsembles::Ensemble.all)
        input = ""
       
        while input != "exit"    
            puts "To return to the previous menu, type 'exit'.".red
            puts "Type the number of players you would like in the ensemble.".yellow

            input = gets.strip

            puts "---------------------------------------------".green
            
            if ensembles.select {|ensemble| ensemble.personnel.to_i.to_s == input}.any?
                display = display_ensembles(ensembles.select {|ensemble| ensemble.personnel.to_i.to_s == input})
            elsif input == "exit"
            else
                puts "NO ENSEMBLES TO DISPLAY".red
            end
        end
    end

    def both(ensembles = PercussionEnsembles::Ensemble.all)
        input = ""
       
        while input != "exit"    
            puts "To return to the main menu, type 'exit'.".red
            puts "Type the number of players you would like in the ensemble.".yellow

            input = gets.strip

            puts "---------------------------------------------".green
            
            if ensembles.select {|ensemble| ensemble.personnel.to_i.to_s == input}.any?
                display = display_ensembles(ensembles.select {|ensemble| ensemble.personnel.to_i.to_s == input})
                difficulty(display)
            else
                puts "NO ENSEMBLES TO DISPLAY".red
            end
        end
    end
end