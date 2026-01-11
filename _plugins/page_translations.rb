# frozen_string_literal: true

# https://talk.jekyllrb.com/t/how-to-create-a-page-from-a-generator-plugin/6053
module TranslationsPlugin
  class TranslatedPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      translations = site.data['page_translations']
      translations.each do |item|
        sv_name = item['sv_name'].nil? ? 'index' : item['sv_name']
        sv_title = item['sv_title']
        en_name = item['en_name'].nil? ? 'index' : item['en_name']
        en_title = item['en_title']

        # sv page
        site.pages << Jekyll::PageWithoutAFile.new(site, site.source, '.', sv_name + '.md').tap do |file|
            file.data.merge!(
                "layout" => "bootstrap_page",
                "title" => sv_title,
                "sv" => true
            )
            file.content = File.read(File.expand_path("../_includes/base_pages/#{sv_name}.md", __dir__))
            file.output
        end

        # en page
        site.pages << Jekyll::PageWithoutAFile.new(site, site.source, 'en', en_name + '.md').tap do |file|
            file.data.merge!(
                "layout" => "bootstrap_page",
                "title" => en_title
            )
            file.content = File.read(File.expand_path("../_includes/base_pages/#{sv_name}.md", __dir__))
            file.output
        end
      end
    end
  end
end