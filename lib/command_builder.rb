module CommandBuilder
  RUBYMINE_PATH = "'#{Dir.home}/Library/Application Support/JetBrains/Toolbox/scripts/rubymine'"

  def self.parse_argument(argument)
    file_path, line_number = argument.split(":", 2)
    file_path = file_path.delete_prefix("/usr/src/app/")
    file_path = file_path.delete_prefix("/usr/src/hr-hub/")
    file_path = File.expand_path(file_path) if file_path.start_with?("~")

    [file_path, line_number]
  end

  def self.build(argument)
    file_path, line_number = parse_argument(argument)

    parts = [RUBYMINE_PATH]
    parts << "--line #{line_number}" unless line_number.nil?
    parts << file_path

    parts.join(" ")
  end
end

