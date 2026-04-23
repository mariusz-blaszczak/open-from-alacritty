module CommandBuilder
  RUBYMINE_PATH = "'/Users/mblaszczak/Library/Application Support/JetBrains/Toolbox/scripts/rubymine'"

  def self.parse_argument(argument)
    argument.split(":", 2)
  end

  def self.build(argument)
    file_path, line_number = parse_argument(argument)

    parts = [RUBYMINE_PATH]
    parts << "--line #{line_number}" unless line_number.nil?
    parts << file_path

    parts.join(" ")
  end
end

