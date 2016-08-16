desc "Generate a Swift playground from markdown"
task :port do
  source_path = "Fledgling/Lesson One/README.md"
  dest = "Fledgling/Lesson One/Fledgling - Lesson One.playground/Contents.swift"
  file = File.read(source_path)
  prefix = "import Foundation\n/*:"
  suffix = "*/"
  content = file.gsub("```swift", "*/\n").gsub("```", "/*:")
  File.write(dest, prefix + content + suffix)
end
