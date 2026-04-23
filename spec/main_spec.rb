require "spec_helper"
require_relative "../lib/command_builder"

RSpec.describe CommandBuilder do
  let(:rubymine_path) { "'/Users/mblaszczak/Library/Application Support/JetBrains/Toolbox/scripts/rubymine'" }

  describe ".build" do
    context "when argument contains both file path and line number" do
      it "includes --line flag and file path in the command" do
        command = CommandBuilder.build("/home/user/project/foo.rb:42")
        expect(command).to eq("#{rubymine_path} --line 42 /home/user/project/foo.rb")
      end

      it "uses the correct line number" do
        command = CommandBuilder.build("/some/file.rb:100")
        expect(command).to include("--line 100")
      end

      it "uses the correct file path" do
        command = CommandBuilder.build("/some/file.rb:100")
        expect(command).to include("/some/file.rb")
      end
    end

    context "when argument contains only a file path (no line number)" do
      it "does not include the --line flag" do
        command = CommandBuilder.build("/home/user/project/foo.rb")
        expect(command).not_to include("--line")
      end

      it "includes the file path" do
        command = CommandBuilder.build("/home/user/project/foo.rb")
        expect(command).to include("/home/user/project/foo.rb")
      end

      it "starts with the rubymine path" do
        command = CommandBuilder.build("/home/user/project/foo.rb")
        expect(command).to start_with(rubymine_path)
      end
    end

    context "when line number is part of the argument" do
      it "separates file path and line number on the first colon" do
        command = CommandBuilder.build("/path/to/file.rb:7")
        expect(command).to eq("#{rubymine_path} --line 7 /path/to/file.rb")
      end
    end
  end

  describe ".parse_argument" do
    it "returns file path and line number when both present" do
      file_path, line_number = CommandBuilder.parse_argument("/foo/bar.rb:10")
      expect(file_path).to eq("/foo/bar.rb")
      expect(line_number).to eq("10")
    end

    it "returns file path and nil when no line number" do
      file_path, line_number = CommandBuilder.parse_argument("/foo/bar.rb")
      expect(file_path).to eq("/foo/bar.rb")
      expect(line_number).to be_nil
    end
  end
end

