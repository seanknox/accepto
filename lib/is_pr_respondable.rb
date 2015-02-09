class IsPrRespondable
  SUPPORTED_PR_ACTIONS = %w(
    synchronize
    opened
    reopened
    closed
  )

  def self.call(*args)
    new(*args).call
  end

  def initialize(options)
    @options = options
  end

  def call
    action_is_supported? and !work_in_progress?
  end

  def action_is_supported?
    SUPPORTED_PR_ACTIONS.include?(
      @options.fetch(:pr_action)
    )
  end

  def work_in_progress?
    /wip/i.match(@options.fetch(:pr_title))
  end
end
