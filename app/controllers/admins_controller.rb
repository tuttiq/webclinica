#encoding: utf-8 
class AdminsController < ApplicationController
  load_and_authorize_resource

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    @admin.activate!
    
    if @admin.save
      @admin.deliver_reset_password_instructions!
      flash[:success] = 'Cadastrado com sucesso.'
      redirect_to admins_path
    else
		  render :new
    end
  end

  def edit
    @admin = Admin.find_by_id(params[:id])
  end

  def update
    @admin = Admin.find_by_id(params[:id])
    params[:admin].delete :username
    @admin.update_attributes(params[:admin])
    if @admin.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to admins_path
    else
      render :edit
    end
  end

  def destroy
    if Admin.all.count == 1
      flash[:error] = 'Não é possível desativar todos os administradores.'
      redirect_to admins_path
    else
      @admin = Admin.find_by_id(params[:id])
      @admin.deactivate!
      
      if @admin.save
        flash[:success] = 'Desativado com sucesso'
      else
        flash[:error] = 'Erro ao tentar desativar'
      end
      
      redirect_to admins_path
    end
  end
end
