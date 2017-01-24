class Api::V1::BaseController < ActionController::Base

  rescue_from Exception, with: :render_error

  before_action do
    key = model.friendly_id_config.base rescue :id
    @record = model.find_by(key => params[:id]) if params[:id]
  end

  # GET /v1/{models}
  def index
    @records = model.all
  end

  # GET /v1/{models}/:id
  def show
  end

  # POST /v1/{models}
  def create
    @record = model.create!(request_data)
    render :show
  end

  # PATCH /v1/{models}/:id
  def update
    @record = @record.update!(request_data)
    render :show
  end

  # DELETE /v1/{models}/:id
  def destroy
    model.find_by(uuid: params[:id]).destroy
  end

  private

  def render_error(exception = nil)
    logger.error "#{exception.class.name}: #{exception.message}"
    logger.error exception.backtrace.join("\n")
    @exception = exception
    render status: 500, template: 'api/v1/error'
  end

  def redis
    @redis ||= Redis.new(url: "#{Settings.redis.endpoint}/stream")
  end

  def request_data
    @request_data ||= JSON.parse(request.body.read, symbolize_names: true)
  end

  def model
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  def publish(channel, data)
    redis.publish('lounge', 'entered')
  end

end
