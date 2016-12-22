require "capistrano/scm/none/version"
require "capistrano/scm/plugin"

module Capistrano
  module Scm
    module None 
      class Plugin < ::Capistrano::SCM::Plugin
        def set_defaults
        end

        def define_tasks
          namespace :scm do
            namespace :none do
              task :create_release do
                on release_roles :all do
                  execute :mkdir, "-p", release_path
                  if Rake::Task.task_defined?('deploy:upload')
                    invoke('deploy:upload')
                  else
                    raise "Expecting a deploy:upload task to be defined."
                  end
                end
              end

              task :set_current_revision do
                # TODO something better here
                #sh :git, "rev-list --max-count=1 branch"
                set :current_revision, "do to grab current git revision"
              end
            end
          end
        end

        def register_hooks
          after "deploy:new_release_path", "scm:none:create_release"
          before "deploy:set_current_revision", "scm:none:set_current_revision"
        end
      end
    end
  end
end
