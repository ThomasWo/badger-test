# More info at https://github.com/guard/guard#readme

ignore %r{^spec/support_files/}, /public/
filter(/\.txt$/, /.*\.zip/, /.*\.pdf/)

guard :bundler do
  watch('Gemfile')
  # Uncomment next line if your Gemfile contains the `gemspec' command.
  # watch(/^.+\.gemspec/)
end

guard 'rails' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

