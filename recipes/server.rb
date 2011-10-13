
include_recipe "git"

username = node["git"]["user"]
repo_dir = node["git"]["repo_dir"]

directory repo_dir do
  owner username
  group username
  recursive true
end

user username do
  comment "Git User"
  home repo_dir
end

directory "#{repo_dir}/.ssh" do
  owner username
  group username
  mode "0700"
end

keys = []

search(:users, "git_key:*").each do |user|
  keys << user[:git_key][:public]
end

template "#{repo_dir}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner "git"
    group "git"
    mode "0600"
    variables :git_keys => keys 
end
 
search(:git_repos, "*:*").each do |repo|

  repo_path = "#{repo_dir}/#{repo[:id]}.git"
  
  directory repo_path do
    owner "git"
    group "git"
    mode "2775"
  end

  execute "initialize new shared git repo" do
    command "cd #{repo_path} && git --bare init --shared"
    only_if { !File.exists? "#{repo_path}/HEAD" }
  end
end
