desc "Generate all Swift playgrounds from beginner"
task :beginner do |task, args|
  folders = Dir.glob("Beginners/*") - ["Beginners/beginners.yml", "Beginners/README.md"]

  folders.each do |folder|
    name = File.basename(folder)
    `bundle exec playgroundbook wrapper "#{folder}/README.md" "#{name}"`
  end
end
