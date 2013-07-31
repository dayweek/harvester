class AdsController < ApplicationController
  # GET /ads
  # GET /ads.xml
  def index
    @ads = Ad.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ads }
    end
  end

  # GET /ads/1
  # GET /ads/1.xml
  def show
    @ad = Ad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ad }
    end
  end

  # GET /knock
  def knock
    pending_count = Ad.where(:review => false, :autorejected => false).count
    respond_to do |format|
      if pending_count == 0
       render :text => 'a', :status => 404
     else
       render  :text => 'a', :status => 200
     end
   end
 end
  # GET /ads/review
  def review
    @pending_count = Ad.where(:review => false, :autorejected => false).count
    @ad = Ad.where(:review => false, :autorejected => false).order('created_at DESC, id DESC').first
    if @ad and phones = Harvest::phones_from_text(@ad.text)
    	@phone = phones.first
    else
      @phone = ''
    end

    respond_to do |format|
      format.html # review.html.erb
    end
  end

  def next_review
    @ad = Ad.find(params[:id])
    @ad.review = true
    @ad.save
    redirect_to review_ads_path 
  end

  def phone
    @phone = params[:phone]
    @je_realitka = Harvest::je_realitka? @phone
    @google_results = Harvest::google @phone
    @stormm_ads = Harvest::Stormm.by_phone @phone
    respond_to do |format|
      format.html
    end
  end

  def insert_phone
  	ad = {}
  	ad[:phone] = params[:phone].gsub(/\D/,"")
  	@vlozeno = Harvest::Stormm.insert(ad)
    respond_to do |format|
      format.html
    end
  end

  # GET /ads/new
  # GET /ads/new.xml
  def new
    @ad = Ad.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ad }
    end
  end

  # GET /ads/1/edit
  def edit
    @ad = Ad.find(params[:id])
  end

  # POST /ads
  # POST /ads.xml
  def create
    @ad = Ad.new(params[:ad])

    respond_to do |format|
      if @ad.save
        format.html { redirect_to(@ad, :notice => 'Ad was successfully created.') }
        format.xml  { render :xml => @ad, :status => :created, :location => @ad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ads/1
  # PUT /ads/1.xml
  def update
    @ad = Ad.find(params[:id])

    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        format.html { redirect_to(@ad, :notice => 'Ad was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.xml
  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy

    respond_to do |format|
      format.html { redirect_to(ads_url) }
      format.xml  { head :ok }
    end
  end
end
