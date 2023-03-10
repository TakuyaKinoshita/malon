module MetaTaggable
    extend ActiveSupport::Concern
    include ActionView::Helpers::AssetUrlHelper

    included do
        before_action :prepare_meta_tags
    end
    private
    def prepare_meta_tags(options = {})
        base = I18n.t('meta_tags.base')
        site = base[:site]
        description = base[:description]
        title = t("meta_tags.titles.#{controller_name}.#{action_name}", default: '')
        image = image_url('ogp.png')
        image = options[:image].presence || image_url('ogp.png')

        defaults = {
            site: site,
            title: title,
            description: description,
            keywords: base[:keywords],
            canonical: request.url,
            og: {
            url: request.url,
            title: title.presence || site,
            description: description,
            site_name: site,
            type: 'article',
            image: image
            }
        }
    options.reverse_merge!(defaults)
    set_meta_tags(options)
    end
end