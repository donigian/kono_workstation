#
# Cookbook Name:: kono_workstation
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "applications::default"
include_recipe 'kono_workstation::java'

if platform?('mac_os_x')
  package 'rbenv' do
    action [:install, :upgrade]
  end

  package 'ruby-build' do
    action [:install, :upgrade]
  end

  package 'rbenv-gem-rehash' do
    action [:install, :upgrade]
  end

  execute 'Install ruby 2.0.0-p247' do
    user node['current_user']
    command "export RBENV_ROOT=/usr/local/var/rbenv;/usr/local/bin/rbenv install 2.0.0-p247;/usr/local/bin/rbenv global 2.0.0-p247"
  end

  execute 'Install jruby-1.7.4' do
    user node['current_user']
    command 'export PATH=/usr/local/var/rbenv/shims:/usr/local/bin:/usr/local/sbin:/usr/local/opt/rbenv/shims:/usr/local/opt/rbenv/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin;export RBENV_ROOT=/usr/local/var/rbenv;/usr/local/bin/rbenv install jruby-1.7.4'
  end

elsif platform_family?('debian')
  include_recipe "ruby_build"
  include_recipe "rbenv::user_install"

  rbenv_ruby "jruby-1.7.4"
  rbenv_ruby "2.0.0-p247"
  rbenv_global "2.0.0-p247"
end

