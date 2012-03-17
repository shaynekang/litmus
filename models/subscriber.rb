class Subscriber
  include DataMapper::Resource
  
  property :id, Serial, unique: true
  property :email, String, :required => true, :unique => true,
     :format   => :email_address,
     :messages => {
       :presence  => 'We need your email address.',
       :is_unique => 'We already have that email.',
       :format    => "Doesn't look like an email address to me ..."
     }
end