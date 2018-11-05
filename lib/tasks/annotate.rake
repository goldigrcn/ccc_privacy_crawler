desc "annotate models"
task :annotate => :environment do
  require "annotate/annotate_models"

  AnnotateModels.do_annotations(
    model_dir:         "#{__dir__}/../../models/",
    exclude_fixtures:  true,
    exclude_factories: true,
    exclude_tests:     true,
    exclude_helpers:   true,
    show_indexes:      true,
    format_markdown:   false,
    is_rake:           true,
  )
end
