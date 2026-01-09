# frozen_string_literal: true

# https://talk.jekyllrb.com/t/how-to-create-a-page-from-a-generator-plugin/6053
module TranslationsPlugin
  class TranslatedPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      translations = site.data['translations']
      translations.each do |item|
        # sv page
        site.pages << Jekyll::PageWithoutAFile.new(site, site.source, '.', item['sv_name'] + '.html').tap do |file|
            file.content = File.read(File.expand_path("../_includes/base/#{item['sv_name']}.md", __dir__))
            file.data.merge!(
                # "contents" => "{% include base/#{item['sv_name']}.md %}",
                "layout" => "default",
                "title" => item['sv_title'],
                "lang" => 'sv',
            )
            file.output
        end

        # en page
        site.pages << Jekyll::PageWithoutAFile.new(site, site.source, 'en', item['en_name'] + '.html').tap do |file|
            file.content = File.read(File.expand_path("../_includes/base/#{item['sv_name']}.md", __dir__))
            file.data.merge!(
                # "contents" => "{% include base/#{item['en_name']}.md %}",
                "layout" => "default",
                "title" => item['en_title'],
                "lang" => 'en'
            )
            file.output
        end
      end
    end
  end
end