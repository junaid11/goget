class JobsController < ApplicationController
    def index
        @jobs = Job.where.not(created_by: @current_user.id)
        render status: 200, json: jobs_to_json(@jobs)
    end

    def my_jobs
        @jobs = @current_user.my_jobs
        render status: 200, json: jobs_to_json(@jobs)
    end

    def create
        pickup_address = Address.new(job_params[:pickup_address])
        drop_address = Address.new(job_params[:drop_address])
        if pickup_address.save && drop_address.save
            job = Job.create(pickup_address_id: pickup_address.id, drop_address_id: drop_address.id, created_by: @current_user.id)
            render status: 200, json: { message: "Job successfully created!", job_id: job.id }
        else
            render status: 400, json: { errors: pickup_address.errors.messages.merge(drop_address.errors.messages) }
        end
    end

    def claim_job
        job = Job.find_by(id: params[:id])
        if job.present?
            if job.open? && job.created_by != @current_user.id
                job.claimed!
                render status: 200, json: { message: "Job Claimed Successfully!" }
            else
                render status: 400, json: { message: "Job is already #{job.status.capitalize}" }
            end
        else
            render status: 400, json: { message: "No such job exists" }
        end
    end

    def execute_job
        job = Job.find_by(id: params[:id])
        if job.present?
            if job.claimed? && job.created_by != @current_user.id
                job.completed!
                render status: 200, json: { message: "Job Executed Successfully!" }
            else
                render status: 400, json: { message: "Job is #{job.status.capitalize}" }
            end
        else
            render status: 400, json: { message: "No such job exists" }
        end
    end

    private

    def jobs_to_json(jobs)
        jobs.map {|job| { job_id: job.id, pickup_address: job.pickup_address.to_json, drop_address: job.drop_address.to_json } }
    end

    def job_params
        params.require(:job).permit(:pickup_address => {}, :drop_address => {})
    end
end
