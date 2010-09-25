class Admin::TinyPaperController < ApplicationController
  layout "picker"
  WebImageTypes = %w( image/jpg image/jpeg image/gif image/png image/x-png )
  DefaultParams = [:title, :page, :sort_by, :sort_order]
  before_filter :attach_js_css 
  def images
    params[:view] ||= 'thumbnails'
    @assets = Asset.search(params['search'], {'image' => true}, params['p'])
    @thumbnails = Asset.attachment_definitions[:asset][:styles]

    respond_to do |f|
      f.html { render }
      f.js { 
        if params[:view] == "thumbnails"
          render :partial => 'images_images.html.haml', :layout => false
        else
          render :partial => 'images_titles.html.haml', :layout => false
        end
      }
    end
  end
  
  
  def files
    @assets = Asset.search(params['search'], {}, params['p'])
    respond_to do |f|
      f.html { render }
      f.js { render :partial => 'files_titles.html.haml', :layout => false }
    end
  end
  
  def pages
    @homepage = Page.find(:first, :conditions => {:parent_id => nil}, :include => :children)
  end
  
  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      flash[:success] = "Asset successfully uploaded."
      redirect_to :"#{params[:type]}"
    else
      flash[:error] = @asset.errors.full_messages.join(" ")
      redirect_to :"#{params[:type]}"
    end
  end
  
  protected
  
    def attach_js_css
      include_stylesheet "admin/tiny_paper"
      include_javascript "admin/prototype"
      include_javascript "admin/effects"
      include_javascript "admin/controls"
      include_javascript "tiny_mce/tiny_mce_popup"
      include_javascript "admin/tiny_paper"
    end 
end
