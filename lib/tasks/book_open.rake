namespace :books do
  task :open,[:book_id]=>[:environment] do |t,args|
    whichbook = args[:book_id] || 1
    require 'gollum'

    exec = {}
    options = { 'port' => 4567, 'bind' => '0.0.0.0' }
    wiki_options = {}

    gollum_path = File.expand_path("./books/#{whichbook}.git/",Rails.root)

    require 'gollum/frontend/app'
    Precious::App.set(:gollum_path, gollum_path)
    Precious::App.set(:wiki_options, wiki_options)

    Precious::App.run!(options)
    
  end
end