module EMailable
  def send_mail(params)
    Pony.mail({
      :to => self.email,
      :subject => params[:subject],
      :body => params[:body],
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'contact@walkinc.co.kr',
        :password             => '_skahffkfk@!',
        :authentication       => :plain,
        :domain               => "walkinc.co.kr"
      }
    })
  end
end
