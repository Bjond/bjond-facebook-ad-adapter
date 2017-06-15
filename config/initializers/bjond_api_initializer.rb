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
      :description => 'Sample field description',
      :title => 'Sample field'
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