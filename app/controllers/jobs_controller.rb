class JobsController < ApplicationController
before_action :find_job, only: [:show, :edit, :update, :destroy]
before_filter :authenticate_user!, except: [:index, :show]
	def index
		if params[:category].blank?
			@jobs = Job.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@jobs = Job.where(category_id: @category_id).order("created_at DESC")
		end
		
	end
	def new
		@job = current_user.jobs.build
	end
def show

end

	def create
		@job = current_user.jobs.build(jobs_params)
		
		if @job.save
			redirect_to @job
		else
			render 'New'
				
		end


	end
	def update
		if @job.update(jobs_params)
			redirect_to @job
		else
			render "New"
		end
	end

	def destroy
	@job.destroy
	redirect_to root_path	
	end
	def jobs_params
		params.require(:job).permit(:title, :description, :company, :url, :category_id, :user_id)
	end
	def find_job
		@job = Job.find(params[:id])
	end
end
