#!/usr/bin/env ruby

require "logger"
require_relative "lib/command_builder"

# Initialize the logger
log_file_path = '/Users/mblaszczak/Projects/Ruby/open-from-alacritty/logfile.log'
logger = Logger.new(log_file_path)
logger.info('Script started.')

# arguments
file_path_with_line_number = ARGV[0]

command = CommandBuilder.build(file_path_with_line_number)
logger.info(command)

system(command)
