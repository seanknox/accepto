  # Parses the pull_request_action from the GitHub webhook params and calls the
  # appropiate class. E.g. An Opened pr_action will result in the Opened class
  # being called.
RespondToPullRequestEvent = Struct.new(:params) do
  SUPPORTED_PR_ACTIONS = %w(
    synchronize
    opened
    reopened
    closed
  )

  def self.call(*args)
    new(*args).call
  end

  def call
    return unless IsPrRespondable.call(
      pr_action: params.fetch('action'),
      pr_title: params.fetch('pull_request').fetch('title')
    )
    options_from_params = OptionsFromParams.call(params)
    options_from_params.fetch(:pr_class).call(
      options_from_params.fetch(:pr_class_options)
    )
  end
end
