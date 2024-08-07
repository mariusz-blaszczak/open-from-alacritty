#!/usr/bin/env ruby

require "logger"

# Initialize the logger
log_file_path = '/Users/mblaszczak/Projects/Ruby/open-from-alacritty/logfile.log'
logger = Logger.new(log_file_path)
logger.info('Script started.')
# arguments
file_path_with_line_number = ARGV[0]
file_path, line_number = file_path_with_line_number.split(":")

command_parts = []

command_parts << "'/Users/mblaszczak/Library/Application Support/JetBrains/Toolbox/scripts/rubymine'"
command_parts << "--line #{line_number}" unless line_number.nil?
command_parts << file_path
logger.info(command_parts.join(' '))

system(command_parts.join(" "))
