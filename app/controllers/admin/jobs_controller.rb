class Admin::JobsController < ApplicationController
    def index
        render json: jobs_to_json(Job.all)
    end

    private
    def jobs_to_json(jobs)
        jobs.map {|job| { job_id: job.id, pickup_address: job.pickup_address.to_json, drop_address: job.drop_address.to_json } }
    end
end
