class UserMailer < ActionMailer::Base

  default from: 'amazing@site.com'

  def processed_data_email(params)
    @params = params
    attachments['bar-chart.svg'] = params[:attachments][0].sub('data:image/svg+xml,','')
    attachments['pie-chart.svg'] = params[:attachments][1].sub('data:image/svg+xml,','')
    mail(to: params[:recipient], subject: 'Processed Data')
  end

end
