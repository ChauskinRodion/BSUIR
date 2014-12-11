class DatabaseController <  ApplicationController

  def index
    @persons_grid   = initialize_grid(Person,
                                      :name => 'persons_grid',
                                      :per_page => 8,
                                      :include => [:mother, :father, :spouse])
    @companies_grid = initialize_grid(Company,
                                      :name => 'companies_grid',
                                      :per_page => 8,
                                      :include => [:head_company, :chief, :accountant])
  end

  def send_email
    ClientsNotifyWorker.perform_async(params[:database])
    render json: {success: true}
  end

  def create_client
    attributes =  params[:type] == 'Person' ? person_params : company_params
    success = params[:type].constantize.create(attributes)

    render json: { success: success }
  end

  def person_params
    params.require(:database).permit(:name, :sex, :address, :passport, :email, :skype, :almamater  )
  end

  def company_params
    params.require(:database).permit(:name, :address, :phone)
  end
end
