module Nesta
  module Overrides
    module Renderers
      def haml(template, options = {}, locals = {})
        defaults = Overrides.render_options(template, :haml)
        super(template, defaults.merge(options), locals)
      end

      def scss(template, options = {}, locals = {})
        defaults = Overrides.render_options(template, :scss)
        super(template, defaults.merge(options), locals)
      end

      def sass(template, options = {}, locals = {})
        defaults = Overrides.render_options(template, :sass)
        super(template, defaults.merge(options), locals)
      end
    end

    def self.load_local_app
      require Nesta::Path.local("app")
    rescue LoadError
    end
    
    def self.load_theme_app
      if Nesta::Config.theme
        require Nesta::Path.themes(Nesta::Config.theme, "app")
      end
    rescue LoadError
    end

    private
      def self.template_exists?(engine, views, template)
        views && File.exist?(File.join(views, "#{template}.#{engine}"))
      end

      def self.render_options(template, engine)
        if template_exists?(engine, local_view_path, template)
          { :views => local_view_path }
        elsif template_exists?(engine, theme_view_path, template)
          { :views => theme_view_path }
        else
          {}
        end
      end

      def self.local_view_path
        Nesta::Path.local("views")
      end
    
      def self.theme_view_path
        if Nesta::Config.theme.nil?
          nil
        else
          Nesta::Path.themes(Nesta::Config.theme, "views")
        end
      end
  end
end
