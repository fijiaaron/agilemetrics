require 'singleton'

class CustomLogger < Logger
  include Singleton

  class Formatter
    def call(severity, time, progname, msg)
      formatted_severity = sprintf("%-5s",severity.to_s)
      formatted_time = time.strftime("%Y-%m-%d %H:%M:%S")
      "[#{formatted_severity} #{formatted_time}] #{msg.strip}\n"
    end
  end

  def initialize
    super(Rails.root.join('log/post_error.log'))
    self.formatter = Formatter.new
    self
  end

  def self.error(msg); instance.error(msg) end
  def self.debug(msg); instance.debug(msg) end
  def self.fatal(msg); instance.fatal(msg) end
  def self.info(msg); instance.info(msg) end
  def self.warn(msg); instance.warn(msg) end
  def self.add(msg); instance.add(msg) end
  def self.log(msg); instance.log(msg) end
end

CUSTOM_LOGGER = Logger.new("#{Rails.root}/log/my.log")
