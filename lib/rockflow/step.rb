module Rockflow
  class Step
    attr_accessor :flow, :status, :params, :conditions, :errors

    def initialize(flow, opts = {})
      @flow = flow
      @after_dependencies = []
      @errors = []
      @params = opts[:params]
      @status = :not_started
      @conditions = opts[:conditions]
      add_after_dependencies(opts[:after])
    end

    def it_up
    end

    def payload
      @flow.payload
    end

    def finish!
      @status = :finished
    end

    def finished?
      @status == :finished
    end

    def fail!
      @status = :failed
    end

    def failed?
      @status == :failed
    end

    def add_payload(key, value)
      @flow.payload[key] = value
    end

    def add_after_dependencies(deps = [])
      [deps].flatten.each do |dep|
        @after_dependencies << dep
      end
    end

    def after_dependencies_finished?
      @after_dependencies.inject(true) do |result, elem|
        dependent_steps_running = !(@flow.steps.select do |step|
          step.class == elem && !step.finished?
        end.any?)
        result = result && dependent_steps_running
        result
      end
    end

    def select_conditions(pre_or_post)
      conditions.select do |cond|
        cond[pre_or_post.to_sym]
      end.map do |cond|
        cond[pre_or_post.to_sym]
      end rescue []
    end

    def execute_pre_conditions
      select_conditions(:pre).each do |cond|
        exec_condition(cond, ::Rockflow::Errors::PreCondition)
      end
    end

    def execute_post_conditions
      select_conditions(:post).each do |cond|
        exec_condition(cond, ::Rockflow::Errors::PostCondition)
      end
    end

    private

    def exec_condition(block_or_symbol, error)
      exec_block_or_symbol(block_or_symbol, error) do
        exec_condition_block(block_or_symbol, error)
      end
    end

    def exec_block_or_symbol(block_or_symbol, error)
      if block_or_symbol.is_a? Proc
        yield
      elsif block_or_symbol.is_a? Symbol
        exec_method(block_or_symbol, error)
      end
    end

    def exec_condition_block(block, error)
      unless block.call
        fail_execution(error)
      end
    end

    def exec_method(method, error)
      unless self.step.send(method.to_sym)
        fail_execution(error)
      end
    end

    def fail_execution(error)
      self.fail!
      @errors << error.new(self)
    end

  end
end