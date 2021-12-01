class PercussionEnsembles::Scraper
    def scrape(site)
        browser = Watir::Browser.new :safari
        browser.goto site
        25.times do
            browser.send_keys :end
            sleep 0.5
        end
        doc = Nokogiri::HTML(browser.html)

        doc.css("div.catalog-list2").map do |card|
            current_ensemble = {}

            ensemble_title = card.css("div.catalog-product-image img").first["title"]

            full_name = card.css("div.catalog-product-title a:nth-of-type(2)").any? ? card.css("div.catalog-product-title a:nth-of-type(2)").first["title"].split : ["Multiple", "Composers"]
            composer_name = full_name[1] === "Composers" ? "#{full_name[0]} #{full_name[1]}" : "#{full_name.last}, #{full_name[0]}"

            composer = PercussionEnsembles::Composer.find_or_create_by(composer_name)
            
            more_info = card.css("div.catalog-fields")

            id = ensemble_title.to_i(36) + composer_name.to_i(36)
            # refactor the following details into separate things.

            current_ensemble.merge!(:id => id, :name => ensemble_title, :composer => composer)
            more_info.each do |info|
                full_details = {}
                info.text.split(" | ").each do |details|
                    key, value = details.split ': ', 2
                    full_details.merge!(key.downcase.to_sym => value)
                    current_ensemble.merge!(full_details)
                end
            end
            browser.close
            current_ensemble
        end
    end
end