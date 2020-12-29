class PercussionEnsembles::Scraper
    def scrape(site)
        doc = Nokogiri::HTML(open(site))

        doc.css("div.catalog-list2").map do |card|
            current_ensemble = {}

            ensemble_title = card.css("div.catalog-product-image img").first["title"]

            full_name = card.css("div.catalog-product-title a:nth-of-type(2)").first["title"].split
            composer_name = "#{full_name.last}, #{full_name[0]}"
            
            composer = PercussionEnsembles::Composer.find_or_create_by(composer_name)
            
            more_info = card.css("div.catalog-fields")

            # refactor the following details into separate things.

            current_ensemble.merge!(:name => ensemble_title, :composer => composer)
            more_info.each do |info|
                full_details = {}
                info.text.split(" | ").each do |details|
                    key, value = details.split ': ', 2
                    full_details.merge!(key.downcase.to_sym => value)
                    current_ensemble.merge!(full_details)
                end
            end
            current_ensemble
        end
    end
end