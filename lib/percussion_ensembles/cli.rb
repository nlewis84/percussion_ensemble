class PercussionEnsembles::CLI

    def call
        puts "Welcome to Percussion Ensembles!"
        PercussionEnsembles::Scraper.new.scrape
    end
end