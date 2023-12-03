class LevelsController < ApplicationController
  before_action :set_level, only: [:edit, :update, :destroy]
  load_and_authorize_resource :except => [:get_jr_classes]
  # GET /levels
  def index
    @levels = Level.all.order(:sort_order)
  end

  # GET /levels/new
  def new
    @level = Level.new
  end

  # GET /levels/1/edit
  def edit
  end

  # POST /levels
  def create
    @level = Level.new(level_params)
    if !@level.video_url.empty?
    	@level.video_url = "https://www.youtube.com/embed/" + @level.video_url.split('/').last.split('=').last
    end

    if @level.save
      redirect_to levels_path, notice: 'Level was successfully created.'
    else
      render :new
    end
  end

  # PUT /levels/1
  def update
    new_params = level_params
    if !new_params[:video_url].empty?
			new_params[:video_url] = "https://www.youtube.com/embed/" + new_params[:video_url].split('/').last.split('=').last
		end
    if @level.update(new_params)
      redirect_to levels_path, notice: 'Level was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /levels/1
  def destroy
    @level.destroy
    redirect_to levels_url
  end
  
  def get_jr_classes
		level = Level.find(params[:level_id])
    out = "<div class='columns 11-small'>"
		Location.all.each do |loc|
			case loc.shortname
			when "FOL"
				org_id = "550122"
			when "GB"
				org_id = "550123"
			when "SAC"
				org_id = "550124"
			end
			#313983 // old org_id
			puts org_id
			url = 'https://app.jackrabbitclass.com/jr3.0/Openings/OpeningsJson?orgid='+org_id+'&cat2='+level.jack_rabbit_name
			response = JSON.parse(HTTParty.get(url).body)
			out += '<div class="location-classes-information" id="'+loc.shortname+'" style="display: none; width: 100%; overflow: auto;">'
			if response['rows'].length > 0
			  sorted_classes = []
				price = response['rows'][0]['tuition']['fee']
				start_time = Time.parse(response['rows'][0]['start_time'])
				end_time = Time.parse(response['rows'][0]['end_time'])
				duration = ((end_time - start_time) / 60).to_i


					# out += "<script>
					# 	$('."+loc.shortname+"_price').text('$"+ '%.2f' % price +" / 4 Week Session');
					# </script>"
	
				out +='
					<div class="row level-details" style="margin-bottom: 0px;">
						<div class="columns small-12">
							<h4 style="text-align: center;">
								<span style="margin-right: 50px;">' + duration.to_s + ' mins</span>
								$' + '%.2f' % price + ' / 4 Week Session
							</h4>
						</div>
					</div>
				'

				response['rows'].each do |r|
					# puts r.to_s.gsub("=>",":")
					entry = {}
					day = {0 => "Unassigned"}
					r['meeting_days'].each do |d|
						if d[1] == true
							case d[0]
							when "mon"
							  day = {1 => "Monday"}
							when "tue"
							  day = {2 => "Tuesday"}
							when "wed"
							  day = {3 => "Wednesday"}
							when "thu"
							  day = {4 => "Thursday"}
							when "fri"
							  day = {5 => "Friday"}
							when "sat"
							  day = {6 => "Saturday"}
							when "sun"
							  day = {7 => "Sunday"}
							else
							  day = {0 => "None"}
							end
						end
					end

					instructor = "<span style='color: red;'>Staff</span>".html_safe
					if !r['instructors'][0].nil?
						# puts ":" + r['instructors'][0] + ":"
						if loc.shortname == "GB" || loc.shortname == "SAC"
							instructor = r['instructors'][0]
						else
							name_parts = []
							r['instructors'][0].split.map(&:capitalize).each do |section|
								# we do this because sometimes they add gym locations to the end of someones name. So first we need to remove that part.
								if section[0] != '('
									name_parts.push(section)
								end
							end
							# puts "name_parts: " +  name_parts.to_s + ":"
							if name_parts.size > 1
								name_parts.pop(1) # Pop off the last name of the instructor
								instructor = name_parts.join(" ")  # and join the rest
							else 
								instructor = name_parts[0]
							end
						end
						# puts "dispaly name: " + instructor
					end

  				entry['link'] = r['online_reg_link'].gsub("amp;", "")
  				entry['link_text'] = r['openings']['calculated_openings'] > 0 ? "Register" : "Get on Wait List"
  				entry['openings'] = r['openings']['calculated_openings'] > 0 ? r['openings']['calculated_openings'] : r['openings']['calculated_openings'].abs.to_s + " on Wait List"
  				entry['day'] = day
  				entry['time'] = Time.strptime(r['start_time'], '%H:%M').strftime('%l:%M %P')

  				min_age = (r['min_age'].empty?) ? '' : r['min_age'][1..2]#, months: r['min_age'][4..5]}
  				max_age = (r['max_age'].empty?) ? '' : r['max_age'][1..2]#, months: r['max_age'][4..5]}
  				if min_age != '' && max_age != ''
  					if min_age == max_age
	  					entry['age'] = min_age.gsub(/^0/, "")
  					else
	  					entry['age'] = min_age.gsub(/^0/, "") + " - " + max_age.gsub(/^0/, "")
  					end
	  			elsif min_age != ''
	  				entry['age'] = min_age.gsub(/^0/, "")
	  			elsif max_age != ''
	  				entry['age'] = max_age.gsub(/^0/, "")
	  			else
  					entry['age'] = '<span style="color: red">none</span>'
	  			end
	  			
  				entry['instructor'] = instructor
  				
  				if (sorted_classes.length > 0)
  					count = 0
  					sorted_classes.each do |c|
  						if entry['day'].keys[0] < c['day'].keys[0] #check if entry class is on a day earlier than c class
  							break
  						elsif entry['day'].keys[0] == c['day'].keys[0] #classes are on same day, check time
  							if entry['time'] < c['time']
  								break
  							else
  								count = count + 1
  							end
  						else #entry class comes later in the week than c
  							count = count + 1
  						end
  					end
  					sorted_classes.insert(count, entry)
  				else
  					sorted_classes << entry
  				end
  				
  			end
				
				out += "<table style='text-align: center;'>
								<tr>
									<th></th>
									<th>Openings</th>
									<th>Day</th>
									<th>Time</th>
									<th>Age</th>
									<th>Instructor</th>
								</tr>"
								
				sorted_classes.each do |c|
					# puts view_context.link_to(c['link_text'], c['link'])
					out += "<tr>
						<td style=\"padding: 7px;\">" + (c['link'] == '' ? 'Call to Register' : view_context.link_to(c['link_text'], c['link'], class: "button expanded", style: "margin: 0; padding: 7px;")) + "</td> 
						<td>" + c['openings'].to_s + "</td>
						<td>" + c['day'].values[0] + "</td>
						<td>" + c['time'] + "</td>
						<td>" + c['age'] + "</td>
						<td>" + c['instructor'] + "</td>
					</tr>"
				end
				out += "</table>"
			else
				out += "<h4 style='text-align:center;'>No classes for this level at this location</h4>"
			end
			out += "</div>"
		end
		out += "</div>"
    render plain: out
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_level
      @level = Level.find(params[:id])
    end
    
    # Only allow a trusted parameter "white list" through.
    def level_params
      params.require(:level).permit(:description, :short_description, :video_url, :classtype_id, :levelname, :length, :age, :gender, :sort_order, :jack_rabbit_name, :color, :image, :show_registration, :active)
    end
end
