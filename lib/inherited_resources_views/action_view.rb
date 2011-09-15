module InheritedResourcesViews
  module ActionView
    def self.included(base)
      base.class_eval do
        def self.process_view_paths(value)
          PathSet.new(Array.wrap(value))
        end
      end
    end

    class PathSet < ::ActionView::PathSet
      def find(path, prefix = nil, partial = false, details = {}, key = nil, keys = [])
        super
      rescue ::ActionView::MissingTemplate
        super(path, "inherited_resources", partial, details, key, keys)
      end

      def find_template(original_template_path, format = nil, html_fallback = true)
        super
      rescue ::ActionView::MissingTemplate
        # http://rubular.com/r/DcPvglzGLh
        original_template_path.sub!(/^[\w\/]+(\/[\w.]+)$/, 'inherited_resources\1')
        super
      end
    end
  end
end