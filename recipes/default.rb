#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2011, Atalanta Systems Ltd
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when "debian", "ubuntu"
  package "git-core"
else 
  package "git"
end

