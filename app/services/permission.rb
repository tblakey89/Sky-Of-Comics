class Permission
  def initialize(user)
    allow :users, [:new, :create, :show, :index, :following, :followers]
    allow 'devise/registrations', [:new, :create, :cancel]
    allow 'devise/sessions', [:new, :create]
    allow 'omniauth_callbacks', [:passthru, :failure, :all, :twitter, :facebook]
    allow 'devise/confirmations', [:new, :create, :show]
    allow 'devise/passwords', [:new, :edit, :create, :update]
    allow :static_pages, [:home, :help, :about]
    allow :activities, [:index]
    allow :comics, [:index, :show]
    allow :comments, [:index]
    allow :blogs, [:index, :show]
    allow :images, [:index, :show]
    if user
      allow :users, [:edit, :update] do |the_user|
        the_user.id == user.id
      end
      allow :private_messages, [:create, :new, :index, :sent, :create, :new]
      allow :private_messages, [:show] do |message|
        message.sender_id = user.id || message.recipient_id = user.id
      end
      allow :comics, [:new, :create]
      allow :blogs, [:new, :create]
      allow :images, [:new, :create]
      allow :follows, [:create, :destroy]
      allow_if_owned :registrations, [:edit, :update, :destroy], user
      allow_if_owned :comics, [:update, :edit, :delete, :destroy], user
      allow_if_owned :blogs, [:update, :edit, :delete, :destroy], user
      allow_if_owned :images, [:update, :edit, :delete, :destroy], user
      allow :comments, [:create, :new]
      allow_all if user.is_super_admin?
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed== true || resource && allowed.call(resource))
  end

  def allow_all
    @allow_all = true
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  def allow_if_owned(controllers, actions, user)
    allow controllers, actions do |item|
      item.user_id == user.id
    end
  end

  def allow_param(resources, attributes)
    @allowed_params ||= {}
    Array(resources).each do |resource|
      @allowed_params[resource]  ||= []
      @allowed_params[resource] = Array(attributes)
    end
  end

  def allow_param?(resource, attribute)
    if @allow_all
      true
    elsif @allowed_params && @allowed_params[:resource]
      @allowed_params[resource].include? attribute
    end
  end

  def permit_params!(params)
    if @allow_all
      params.permit!
    elsif @allowed_params
      @allowed_params.each do |resource, attributes|
        if params[resource].respond_to? :permit
          params[resource] = params[resource].permit(*attributes)
        end
      end
    end
  end
end
