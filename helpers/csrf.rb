helpers do
  def csrf_token
    Rack::Csrf.csrf_token(env)
  end

  def csrf_tag
    Rack::Csrf.csrf_tag(env)
  end

  def csrf_metatag
    Rack::Csrf.metatag(env)
  end
end