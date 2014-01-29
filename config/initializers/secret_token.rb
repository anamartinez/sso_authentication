# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
ZendeskSsoAuthentication::Application.config.secret_key_base = 'c4894e9d50d3659d6db6fc3358eb1ef18f99d3e2cf1af8a4f8d5b92b48bdf76c6517825b12384cb37324b57a622d63847b612573a9fe9c023b7083a7c610b229'
