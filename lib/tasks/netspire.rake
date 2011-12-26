namespace :netspire do
  namespace :domains do
    desc "Create new domain (options: NAME=name, TITLE=title)."
    task :create => :environment do
      Domain.create!(:name => ENV['NAME'], :title => ENV['TITLE'])
    end
  end

  namespace :admins do
    desc "Create new Admin account (options: LOGIN=login, PASSWORD=password, DOMAIN=name)."
    task :create => :environment do
      domain = Domain.find_by_name(ENV['DOMAIN'])
      admin = domain.admins.create!(:login => ENV['LOGIN'].dup,
                                    :password => ENV['PASSWORD'].dup)
      admin.reset_authentication_token!

      # Assign permission to admin account
      Permission.all.each do |p|
        admin.admin_permissions.create!(:permission => p)
      end
      puts "Authentication token is #{admin.authentication_token}"
    end
  end
end
