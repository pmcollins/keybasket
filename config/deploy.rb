require 'palmtree/recipes/mongrel_cluster'

default_environment['PATH'] = '/home/pcollins/bin:/home/pcollins/local/bin:/home/pcollins/local/gem_home/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
default_environment['GEM_HOME'] = '/home/pcollins/local/gem_home'
default_environment['RUBYLIB'] = '/home/pcollins/local/lib'

set :application, "keybasket"
set :repository,  "svn+ssh://polonius/home/pcollins/local/svn/keybasket/trunk"

set :deploy_to, "/home/pcollins/web/#{application}"
set :use_sudo, false
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

role :app, "pcollins@polonius"
role :web, "pcollins@polonius"
role :db,  "pcollins@polonius", :primary => true
