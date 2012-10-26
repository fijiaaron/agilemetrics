# Be sure to restart your server when you modify this file.

admin = YAML.load_file("#{Rails.root}/config/admin.yml")

# Set super_admin_users to a comma separated list of usernames that qualify as super admins
Agilemetrics::Application.config.super_admin_users = admin['super_users']

# Set the admin email address for feedback
Agilemetrics::Application.config.admin_email = admin['admin_email']