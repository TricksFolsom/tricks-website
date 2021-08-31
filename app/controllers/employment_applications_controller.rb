class EmploymentApplicationsController < ApplicationController
  before_action :set_employment_application, only: [:show, :update, :destroy, :archive]
  load_and_authorize_resource :except => [:new, :create]
  skip_load_resource only: :update_review

  # GET /employment_applications
  def index
    # EmploymentApplication.first.employment_application_reviews.first.id
    search_result = EmploymentApplicationReview.joins(:employment_application).search(params[:search])

    query = Hash.new
    query[:archived] = nil
    
    if params.has_key?(:location)
      query[:location] = params[:location]
    end
    
    if params.has_key?(:status)
      query[:status] = params[:status]
      if (params[:status] != 4 && params[:status != 5])
        # for maybe_later and not_hired we can show non active reviews, but for all others, we only want the active reviews
        # this means that once hired, further reviews will never have be looked at, should probably just delete them at that point.
        query[:active] = true
      end
      # otherwise we DO want to include the inactive ones, because that should be everything in those 2 categories
    else
      query[:status] = "0"
      query[:active] = true
    end
    
    if params.has_key?(:department)
      query[:department] = params[:department]
    end
    
    @employment_application_reviews = search_result.where(query).order("created_at DESC")
    
    @counts = Hash.new
    
    status_query = query.clone
    # remove existing status from query
    status_query.except!(:status)
    # get counts for each status
    EmploymentApplicationReview::STATUS.each do |status|
      status_query[:status] = status[0]
      @counts["status_"+status[0].to_s] = search_result.where(status_query).count
    end
    
    
    location_query = query.clone
    # remove existing location from query
    location_query.except!(:location)
    locations = Location.all.pluck(:name)
    # locations.each do |loc|
    #   loc_name = loc.downcase.gsub(" ", "_")
    #   location_query.except!(:"#{loc_name}")
    # end
    
    # get count of all locations
    @counts["all"] = search_result.where(location_query).count
    
    locations.each do |loc|
      # match location name to symbol syntax
      loc_name = loc.downcase.gsub(" ", "_")
      # add query for loc = true
      location_query[:location] = loc_name
      # get count using query
      @counts[loc_name] = search_result.where(location_query).count
      # remove query for next iteration
      location_query.except!(:location)
    end
    
    
    departments_query = query.clone
    # since we can select multiple departments we want to get counts 
    # if we added a single additional department to the existing query
    departments = [:gymnastics, :dance, :swim, :tag, :hospitality]
    departments.each do |dep|
      if !departments_query.key?(dep)
        # add query for loc = true
        departments_query[:department] = dep
        # get count using query
        @counts[dep] = search_result.where(departments_query).count
        # remove query for next iteration
        departments_query.except!(dep)
      else
        @counts[dep] = search_result.where(query).count
      end
    end
    
  end

  # GET /employment_applications/1
  def show
    @review = EmploymentApplicationReview.find(params[:id])
    @employment_application = @review.employment_application
  end

  # GET /employment_applications/new
  def new
    @employment_application = EmploymentApplication.new
    @employment_application.build_address
    @employment_application.employment_histories.build
    @employment_application.employment_histories.each do |history|
      history.build_address
    end
  end

  # POST /employment_applications
  def create
    @employment_application = EmploymentApplication.new(employment_application_params)

    # I should do some priority duplication checks here, that way an applicant can't apply to the same
    # location and department more than once.

    if verify_recaptcha(model: @employment_application) && @employment_application.save
      # reverse them so that we create the last review first, that way they can reference the next one
      review = EmploymentApplicationReview.new
      priorities = params["app_priorities"].to_unsafe_h.to_a
      priorities.reverse.each do |priority, app|
        unique_string = app["location"] + "_" + app["department"]
        should_create = true

        # loop over higher up priorities, priority contains the key, (1-max_priorities)
        # doing -1 makes sure we don't compare with self
        priorities.first(priority.to_i - 1).each do |priority2, app2|
          # starting at the top, skip review creation if we know we have a higher priority duplicate
          # that will be created in the future
          if unique_string == app2["location"] + "_" + app2["department"]
            should_create = false
          end
        end

        if should_create
          # need a way to chain the reviews together so that it can continue on when one priority rejects
          # puts priority + ": " + app["location"] + " " + app["department"]

          # review won't have an id on the first pass, only having having been saved does it get an id
          if (!review.id.nil?)
            old_id = review.id
            review = EmploymentApplicationReview.new
            review.next_review_id = old_id
          end
          # link the review to the applications
          review.employment_application_id = @employment_application.id

          # review location and department
          review.location = app["location"]
          review.department = app["department"]

          # this works because user cannot remove the first priority choice
          if (priority == "1")
            review.active = true
          else
            review.active = false
          end
          review.save
        # else
          # puts "DUPLICATE FOUND"
        end
      end

      # only deliver to the highest priority gym (which should be the last review created)
      EmploymentApplicationMailer.gym_notification(review).deliver_now

      EmploymentApplicationMailer.application_confirmation(@employment_application).deliver_now
      redirect_to thankyou_path, notice: 'Employment Application was successfully submitted.'
    else
      render :new
    end
  end

  # PATCH/PUT /employment_applications/1
  def update
    if @employment_application.update(employment_application_params)
      redirect_to @employment_application, notice: 'Employment application was successfully updated.'
    else
      render :edit
    end
  end
  
  def update_review
    review = EmploymentApplicationReview.find(params[:id])
    if (params[:employment_application_review].has_key?(:location))
      review.location = params[:employment_application_review][:location].downcase.gsub(" ", "_")
    end
    if (params[:employment_application_review].has_key?(:department))
      review.department = params[:employment_application_review][:department].downcase
    end
    review.status = params[:employment_application_review][:status]

    review.notes = params[:employment_application_review][:notes]
    review.last_edited_by = params[:employment_application_review][:last_edited_by]

    if (review.status == 4 || review.status == 5)
      # 4 == Maybe Later, 5 == Not Hired
      # A decision has been made to pass this review to the next one, mark this one as not active.
      # the filter pages for these status should search both active and non active reviews.
      review.active = false
    end

    if review.save
      if (review.status == 4 || review.status == 5)
        # 4 == Maybe Later, 5 == Not Hired
        # If status was maybe_later or not_hired, pass to next review priority
        if (!review.next_review_id.nil?)
          next_review = EmploymentApplicationReview.find(review.next_review_id)
          next_review.active = true
          if next_review.save
            EmploymentApplicationMailer.gym_notification(next_review).deliver_now
          end
        end
      end
      redirect_to employment_applications_url, notice: 'Application Review has been updated.'
    else
      redirect_to review, notice: "Failed to update Application Review"
    end
  end

  # def complete_interview
  #   app = EmploymentApplication.find(params[:id])
  #   app.interviewed_by = params[:employment_application][:interviewed_by]
  #   app.comment = params[:employment_application][:comment]
  #   app.status = params[:employment_application][:status]
  #   app.interview_date = Time.now
  #   if app.save
  #     redirect_to employment_applications_url, notice: 'Interview status has been updated.'
  #   else
  #     redirect_to app, notice: "Failed to update the interview"
  #   end
  # end

  # DELETE /employment_applications/1
  def destroy
    @employment_application.destroy
    redirect_to employment_applications_url, notice: 'Employment Application was successfully destroyed.'
  end
  
  def archive
  	@review.archived = true
  	if @review.save
      if (!@review.next_review_id.nil?)
        next_review = EmploymentApplicationReview.find(@review.next_review_id)
        next_review.active = true
        if next_review.save
          EmploymentApplicationMailer.gym_notification(next_review).deliver_now
        end
      end
      redirect_to employment_applications_url, notice: 'Application Review was Archived. If this was a mistake, contact the webmaster.'
    end
    #check for things archived more than 30 days ago, destroy them all.
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employment_application
      @review = EmploymentApplicationReview.find(params[:id])
      @employment_application = @review.employment_application
    end

    # Only allow a trusted parameter "white list" through.
    def employment_application_params
      params.require(:employment_application).permit(:granite_bay, :folsom, :sacramento, :gymnastics, :dance, :swim, :tag, :hospitality, :firstname, :lastname, :middlename, :image, :resume, :image_new, :resume_new, :phone, :mornings, :saturdays, :previous_experience, :experience_with_children, :previous_office_experience, :customer_service_experience, :reason, :application_date, :email, :position_desired, :over_eighteen, :can_drive, :can_commit_one_year, :expected_pay, :desired_hours, :date_available, :job_requirements_response, :high_school_year, :high_school_graduation_year, :high_school_name, :college_year, :college_graduation_year, :college_name, :college_degree, :hobbies, :continuing_education, :do_not_contact_employer, :do_not_contact_reason, :convicted, :convictions, :interview_date, :interviewed_by, address_attributes: [:street, :city, :state, :zip], employment_histories_attributes: [:company_name, :supervisor_name, :job_title, :description, :phone, :start_date, :end_date, :reason_for_leaving, address_attributes: [:street, :city, :state, :zip]])
    end
end
