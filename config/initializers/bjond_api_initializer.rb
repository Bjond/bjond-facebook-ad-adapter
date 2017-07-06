require 'bjond-api'

integration_app = BjondApi::BjondAppDefinition.new
integration_app.id           = '526d136c-10e3-432f-8d43-5f291460d75d'
integration_app.author       = 'Bjönd, Inc.'
integration_app.name         = 'Bjönd Facebook Ad App'
integration_app.description  = 'Testing API functionality'
integration_app.iconURL      = 'https://facebookbrand.com/wp-content/themes/fb-branding/prj-fb-branding/assets/images/fb-art.png'

# Warning: If you change configURL, or rootEndpoint, you will need to manually configure Bjond service routes.
#          We recommend leaving these two variables alone.
integration_app.configURL    = "http://#{Rails.application.config.action_controller.default_url_options ? Rails.application.config.action_controller.default_url_options[:host] : nil || `hostname`}/bjond-app/services"
integration_app.rootEndpoint = "http://#{Rails.application.config.action_controller.default_url_options ? Rails.application.config.action_controller.default_url_options[:host] : nil || `hostname`}/bjond-app/services"



config = BjondApi::BjondAppConfig.instance
config.active_definition = integration_app
config.group_configuration_schema = {
  :id => 'urn:jsonschema:com:bjond:persistence:bjondservice:GroupConfiguration',
  :title => 'bjond-facebook-ad-app-schema',
  :type  => 'object',
  :properties => {
    :facebook_app_id => {
      :type => 'string',
      :description => 'Developer app ID for this particular tenant.',
      :title => 'Facebook App ID'
    },
    :facebook_app_secret => {
      :type => 'string',
      :description => 'Facebook Marketing App, which contains consequences for configuring ads.',
      :title => 'Facebook App Secret'
    }
  },
  :required => ['sample_field']
}.to_json

config.encryption_key_name = 'BJOND_FACEBOOK_AD_ENCRYPTION_KEY'

def config.configure_group(result, bjond_registration, groupid)
  fb_config = FacebookConfig.find_or_initialize_by(:bjond_registration_id => bjond_registration.id, :group_id => groupid)
  if (fb_config.facebook_app_id != result['facebook_app_id'] || fb_config.facebook_app_secret != result['facebook_app_secret'])
    fb_config.facebook_app_id = result['facebook_app_id']
    fb_config.facebook_app_secret = result['facebook_app_secret']
    fb_config.save
  end
  return fb_config
end

def config.get_group_configuration(bjond_registration, groupid)
  fb_config = FacebookConfig.find_by_bjond_registration_id_and_group_id(bjond_registration.id, groupid)
  if (fb_config.nil?)
    puts 'No configuration has been saved yet.'
    return {
      :facebook_app_id => '',
      :facebook_app_secret => '',
    }
  else
    return fb_config
  end
end

### The integration app definition is sent to Bjond-Server core during registration.
config.active_definition = BjondApi::BjondAppDefinition.new.tap do |app_def|
  app_def.id           = 'b93dc2ef-f791-48d1-b34c-cfdf11abcba7'
  app_def.author       = 'Bjönd, Inc.'
  app_def.name         = 'Bjönd Facebook Marketing App'
  app_def.description  = 'Bjönd interface with Facebook API.'
  app_def.iconURL      = 'https://facebookbrand.com/wp-content/themes/fb-branding/prj-fb-branding/assets/images/fb-art.png'
  app_def.integrationConsequence = [
    BjondApi::BjondConsequence.new.tap do |c|
      c.id = '99768ef5-4567-4c19-8f69-e59f04843913'
      c.jsonKey = 'createOffer'
      c.name = 'Create Offer'
      c.description = 'Creates a Facebook Offer'
      c.webhook = "/facebookad/consequences/create_offer"
      c.serviceId = app_def.id
    end
  ]
end