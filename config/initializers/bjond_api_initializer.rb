require 'bjond-api'

integration_app = BjondApi::BjondAppDefinition.new
integration_app.id           = '526d136c-10e3-432f-8d43-5f291460d75d'
integration_app.author       = 'Bjönd, Inc.'
integration_app.name         = 'Bjönd Facebook Ad App'
integration_app.description  = 'Testing API functionality'
integration_app.iconURL      = 'https://facebookbrand.com/wp-content/themes/fb-branding/prj-fb-branding/assets/images/fb-art.png'

# Warning: If you change configURL, or rootEndpoint, you will need to manually configure Bjond service routes.
#          We recommend leaving these two variables alone.
integration_app.configURL    = "http://#{Rails.application.config.action_controller.default_url_options[:host] || `hostname`}/bjond-app/services"
integration_app.rootEndpoint = "http://#{Rails.application.config.action_controller.default_url_options[:host] || `hostname`}/bjond-app/services"



config = BjondApi::BjondAppConfig.instance
config.active_definition = integration_app
config.group_configuration_schema = {
  :id => 'urn:jsonschema:com:bjond:persistence:bjondservice:GroupConfiguration',
  :title => 'bjond-facebook-ad-app-schema',
  :type  => 'object',
  :properties => {
    :sample_field => {
      :type => 'string',
      :description => 'Facebook Marketing App, which contains consequences for configuring ads.',
      :title => 'Facebook Ad App'
    }
  },
  :required => ['sample_field']
}.to_json

config.encryption_key_name = 'BJOND_FACEBOOK_AD_ENCRYPTION_KEY'

def config.configure_group(result, bjond_registration)
  puts '[ App group configuration method not implemented. This can be set via BjondAppConfig.instance.configure_group ]'
end

def config.get_group_configuration(bjond_registration)
  puts '[ get_group_configuration method not implemented. This can be set via BjondAppConfig.instance.get_group_configuration ]'
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
      c.jsonKey = 'createAd'
      c.name = 'Create Ad'
      c.description = 'Creates a Facebook Ad'
      c.webhook = "http://#{Rails.application.config.action_controller.default_url_options[:host] || `hostname`}/facebookad/consequences/createAd"
      c.serviceId = app_def.id
    end
  ]
end