class PercussionEnsembles::Ensemble
    attr_accessor :id, :name, :composer, :duration, :level, :personnel

    @@all = []

    def initialize(ensemble_hash)
        ensemble_hash.each do |key, value|
            self.send("#{key}=", value)
        end

        # do before init
        if @@all.none? {|ensemble| ensemble.name == self.name}
            @@all << self
        end
        # end of change

        self.composer.add_song(self)
        @@all.sort_by {|obj| obj.name}
    end

    def self.all
        @@all
    end
  
    def self.create_from_collection(ensemble_array)
        ensembles = ensemble_array.map {|ensemble| PercussionEnsembles::Ensemble.new(ensemble)}
        
        ensembles
    end
    
    def self.create_csv(ensembles)
        file = "/Users/nlewis/Desktop/percussion_data.csv"
        headers = ["id", "name", "composer", "duration", "level", "personnel"]

        CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
            ensembles.each do |ensemble|
                writer << [ensemble.id, ensemble.name, ensemble.composer.name, ensemble.duration, ensemble.level, ensemble.personnel]
            end
        end
    end
    # ensembles = PercussionEnsembles.order(:name)

end