namespace :generate do
  task :pages=>:environment do
    Book.all.each do |b|
      b.wiki.pages.each do |p|
        item = b.items.find_or_create_by_name(p.name)
      end
    end
  end
end