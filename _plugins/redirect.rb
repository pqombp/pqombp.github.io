# frozen_string_literal: true

# https://talk.jekyllrb.com/t/how-to-create-a-page-from-a-generator-plugin/6053
module RedirectPlugin
  class RedirectPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      redirects = site.data['redirects']
      redirects.each do |item|
        site.pages << Jekyll::PageWithoutAFile.new(site, site.source, '.', item['name'] + '.html').tap do |file|
          file.data.merge!(
            "layout" => "redirect",
            "redirect_url" => item['redirect_url'],
            "sitemap" => false,
          )
          file.output
        end
      end
    end
  end
end