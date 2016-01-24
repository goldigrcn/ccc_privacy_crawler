require "bundler/setup"
require "padrino-core/cli/rake"

PadrinoTasks.use(:database)
PadrinoTasks.use(:activerecord)
PadrinoTasks.init

require "padrino-core"
if Padrino.env == :development
  Rake::Task["ar:migrate"].enhance do
    Rake::Task["annotate"].invoke
  end

  Rake::Task["ar:rollback"].enhance do
    Rake::Task["annotate"].invoke
  end
end
