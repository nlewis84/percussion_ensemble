class PercussionEnsembles::CLI

    BASE_PATH = "https://www.tapspace.com/percussion-ensemble/"

    def call
        puts "---------------------------------------------".green
        puts "Welcome to Percussion Ensembles!".green
        puts "---------------------------------------------".green
        make_ensembles
        display_ensembles
    end

    def make_ensembles
        ensembles_array = PercussionEnsembles::Scraper.new.scrape(BASE_PATH)
        PercussionEnsembles::Ensemble.create_from_collection(ensembles_array)
    end

    def display_ensembles
        PercussionEnsembles::Ensemble.all.each do |ensemble|
            puts "#{ensemble.name.upcase}".magenta
            puts "#{ensemble.composer}".yellow
            puts "#{ensemble.level}".blue
            puts "#{ensemble.personnel}".cyan
            puts "#{ensemble.duration}".white
            puts "---------------------------------------------".green
        end
    end
end