require_dependency 'application_controller'

class TinyPaperExtension < Radiant::Extension
  version "0.9"
  description "Radiand CMS Tiny MCE support using Paperclipped assets"
  url "http://github.com/p8/radiant-tiny-paper-extension/tree/master"

  define_routes do |map|
    map.with_options(:controller => 'admin/tiny_paper') do |asset|
      asset.images            "/admin/tiny_paper/images",                 :action => 'images'
      asset.images_sizes      "/admin/tiny_paper/:id/images_sizes",       :action => 'images_sizes'
      asset.files             "/admin/tiny_paper/files",                  :action => 'files'
      asset.pages             "/admin/tiny_paper/pages",                  :action => 'pages'
      asset.create            "/admin/tiny_paper/create",                 :action => 'create'
    end
  end
  
  def activate
    TinyMceFilter
    Asset.class_eval { include TinyPaper::AssetExtensions }

    Admin::PagesController.class_eval { include TinyPaper::AddJavascriptsAndStyles }
    Radiant::AdminUI.class_eval do      
      attr_accessor :tiny_paper
    end
    unless defined? admin.tiny_paper.index
      Radiant::AdminUI.send :include, AssetsAdminUI      
      admin.tiny_paper = Radiant::AdminUI.load_default_asset_regions   # UI is a singleton and already loaded
      admin.tiny_paper.images = admin.tiny_paper.files = admin.tiny_paper.pages = admin.tiny_paper.index
    end
        
    # admin.page.edit.add :part_controls, "admin/page/tiny_mce_control"
    admin.page.edit.add :part_controls, "tiny_mce_control"
  end
  
  def deactivate
  end
end
