class ProjectsController < ApplicationController
  before_action :get_project, except: [:index, :show, :create, :new]
  before_action :authenticate_user!

  def index
    @projects = Project.order('name').page(params[:page]).decorate
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find params[:id]
  end
  
  def create
    @project = current_user.projects.create(project_params)
    if @project.save
      flash[:success] = t('project.successful_create')
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      flash[:success] = t('project.successful_update')
      redirect_to projects_path
    else
      render 'edit'
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = t('project.successful_destroy')
      redirect_to projects_path
    else
      flash[:error] = t('project.error_destroy')
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :end_date, :start_date)
  end

  def get_project
    @project = current_user.projects.find(params[:id])
  end

end
