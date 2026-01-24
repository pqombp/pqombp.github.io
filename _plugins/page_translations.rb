# https://talk.jekyllrb.com/t/how-to-create-a-page-from-a-generator-plugin/6053
module TranslationsPlugin
  class TranslatedPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      site.pages.each do |item|
        if !item.data.include?("sv") # unprocessed page
          item.data['sv'] = true
          item.data['slug'] = item.basename
          if item['en_title'] || item['en_slug'] # English translations are indicated by having one of these
            en_title = item['en_title'].nil? ? item['title'] : item['en_title']
            en_slug = item['en_slug'].nil? ? item.basename : item['en_slug']
            item.data['en_title'] = en_title
            item.data['en_slug'] = en_slug

            # Inherit data from Swedish page
            data = item.data.clone
            
            # Create new page
            site.pages << Jekyll::PageWithoutAFile.new(site, site.source, 'en' + item.dir, en_slug + '.md').tap do |file|
              file.data.merge!(
                data,
                "title" => en_title,
                "sv" => false
              )
              file.content = item.content
            end
          end
        end
      end
    end
  end
end