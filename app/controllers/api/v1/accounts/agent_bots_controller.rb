class Api::V1::Accounts::AgentBotsController < Api::V1::Accounts::BaseController
  before_action :current_account
  before_action :check_authorization
  before_action :agent_bot, except: [:index, :create]

  def index
    @agent_bots = AgentBot.where(account_id: [nil, Current.account.id])
  end

  def show; end

  def create
    create_params = permitted_params.except(:avatar_url)
    
    # Ensure bot_config is properly formatted
    if create_params[:bot_config].present?
      create_params[:bot_config] = create_params[:bot_config].to_h
    end
    
    @agent_bot = Current.account.agent_bots.create!(create_params)
    process_avatar_from_url
  end

  def update
    update_params = permitted_params.except(:avatar_url)
    
    # Handle bot_config merging to preserve existing data
    if update_params[:bot_config].present?
      existing_config = @agent_bot.bot_config || {}
      update_params[:bot_config] = existing_config.merge(update_params[:bot_config].to_h)
    end
    
    @agent_bot.update!(update_params)
    process_avatar_from_url
  end

  def avatar
    @agent_bot.avatar.purge if @agent_bot.avatar.attached?
    @agent_bot
  end

  def destroy
    @agent_bot.destroy!
    head :ok
  end

  def reset_access_token
    @agent_bot.access_token.regenerate_token
    @agent_bot.reload
  end

  private

  def agent_bot
    @agent_bot = AgentBot.where(account_id: [nil, Current.account.id]).find(params[:id]) if params[:action] == 'show'
    @agent_bot ||= Current.account.agent_bots.find(params[:id])
  end

  def permitted_params
    params.permit(:name, :description, :outgoing_url, :avatar, :avatar_url, :bot_type, bot_config: [:mission])
  end

  def process_avatar_from_url
    ::Avatar::AvatarFromUrlJob.perform_later(@agent_bot, params[:avatar_url]) if params[:avatar_url].present?
  end
end
