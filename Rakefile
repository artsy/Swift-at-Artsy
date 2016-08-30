desc "Generate a Swift playground from markdown"
task :port, :directory do |task, args|
  dir = args[:directory]
  abort "You must specify a directory." if dir.nil? || dir.length < 1

  source_path = "#{dir}/README.md"
  playground = Dir.glob("#{dir}/*.playground").first

  puts "Converting from #{source_path}."
  puts "Overwriting playground at #{playground}."

  dest = "#{playground}/Contents.swift"
  file = File.read(source_path)
  prefix = "import Foundation\n/*:"
  suffix = "*/"
  content = file.gsub("```swift", "*/\n").gsub("```", "/*:")
  File.write(dest, prefix + content + suffix)
end
