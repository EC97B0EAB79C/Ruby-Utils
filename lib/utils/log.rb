require 'logger'

class MajorMinorLogger
  def initialize(logfile = 'logger.log')
    @stdout_logger = Logger.new(STDOUT)
    @stdout_logger.formatter = proc do |severity, datetime, progname, msg|
      "#{severity[0]}, [##{Process.pid}]  #{severity} -- : #{msg}\n"
    end

    file = File.open(logfile, 'a')
    @file_logger = Logger.new(file)
    @file_logger.datetime_format = "%Y-%m-%d %H:%M:%S"

    @major_step = nil
    @minor_steps = []
    @num_minor_steps_shown = 0
  end

  def log_major_step(step_name)
    clear_minor_steps if @num_minor_steps_shown > 0
    @major_step = step_name
    @minor_steps = []
    @num_minor_steps_shown = 0
    @stdout_logger.info(@major_step)
    @file_logger.info(@major_step)
  end

  def log_minor_step(step_message)
    @minor_steps << step_message
    print_minor_steps
  end

  def finish_major_step
    clear_minor_steps
    @major_step = nil
    @minor_steps = []
  end

  private

  def print_minor_steps
    clear_minor_steps
    @minor_steps.last(3).each do |step|
      @stdout_logger.info(step)
    end
    @file_logger.info(@minor_steps.last())
    @num_minor_steps_shown = [@minor_steps.size, 3].min
  end

  def clear_minor_steps
    return if @num_minor_steps_shown.zero?

    @num_minor_steps_shown.times do
      print "\e[F\e[K"
    end
    @num_minor_steps_shown = 0
  end
end

# Example usage
logger = MajorMinorLogger.new

logger.log_major_step("Step 1/3: Downloading dependencies")
sleep(1)
logger.log_minor_step("Fetching package A...")
sleep(0.5)
logger.log_minor_step("Fetching package B...")
sleep(0.5)
logger.log_minor_step("Fetching package C...")
sleep(0.5)
logger.log_minor_step("Fetching package D...")
sleep(0.5)
logger.log_minor_step("Fetching package E...")
sleep(0.5)
logger.log_minor_step("Fetching package F...")
sleep(0.5)
logger.finish_major_step

logger.log_major_step("Step 2/3: Building application")
sleep(1)
logger.log_minor_step("Compiling source code...")
sleep(0.5)
logger.log_minor_step("Linking binaries...")
sleep(0.5)
logger.finish_major_step

logger.log_major_step("Step 3/3: Packaging")
sleep(1)
logger.log_minor_step("Creating archive...")
sleep(0.5)
logger.finish_major_step

logger.log_major_step("Build complete.")

