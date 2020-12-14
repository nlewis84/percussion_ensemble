class PercussionEnsembles::Scraper
    def scrape(site)
        # site = "https://www.tapspace.com/percussion-ensemble/" ## use this line to hard code the scrape
        doc = Nokogiri::HTML(open(site))

        # titles = doc.css("div.catalog-product-image img")
        # composers = doc.css("div.catalog-product-title a:nth-of-type(2)")
        # more_info = doc.css("div.catalog-fields")

        # puts titles.count
        # puts composers.count
        # puts more_info.count

        # puts titles.first["title"]
        # puts composers.first["title"]
        # puts more_info.first.text.split(" | ")

        ensembles = []

        doc.css("div.catalog-list2").each do |card|
            current_ensemble = {}

            ensemble_title = card.css("div.catalog-product-image img").first["title"]
            composer_name = card.css("div.catalog-product-title a:nth-of-type(2)").first["title"]
            more_info = card.css("div.catalog-fields")

            current_ensemble.merge!(:name => ensemble_title, :composer => composer_name)
            more_info.each do |info|
                full_details = {}
                info.text.split(" | ").each do |details|
                    key, value = details.split ': ', 2
                    full_details.merge!(key.downcase.to_sym => value)
                    current_ensemble.merge!(full_details)
                end
            end
            ensembles << current_ensemble
        end
        ensembles
    end
end