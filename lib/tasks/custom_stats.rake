task :stats => "custom_stats:stats"

namespace :custom_stats do
  task :stats do
    require 'rails/code_statistics'
    ::STATS_DIRECTORIES << ["Interactors", "app/interactors"]
    ::STATS_DIRECTORIES << ["Migrations", "db/migrate"]
  end
end

