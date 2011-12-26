domain = Domain.create!(:name => 'fiction', :title => 'FictionISP')

admin = domain.admins.create!(:login => 'admin', :password => 'secret',
                              :email => 'admin@domain.com')
admin.reset_authentication_token!

# Permissions
# Account
Permission.create!(:subject_class => 'Account',
                   :action => 'index',
                   :name => 'List of the accounts')
Permission.create!(:subject_class => 'Account',
                    :action => 'edit',
                    :name => 'View account')
Permission.create!(:subject_class => 'Account',
                   :action => 'destroy',
                   :name => 'Delete account')
Permission.create!(:subject_class => 'Account',
                   :action => 'update',
                   :name => 'Edit account')
Permission.create!(:subject_class => 'Account',
                   :action => 'create',
                   :name => 'Create account')

# Transaction
Permission.create!(:subject_class => 'Transaction',
                   :action => 'index',
                   :name => 'List of the transactions')

# Admin
Permission.create!(:subject_class => 'Admin',
                   :action => 'create',
                   :name => 'Create administrative account')
Permission.create!(:subject_class => 'Admin',
                   :action => 'Edit',
                   :name => 'View administrative account')
Permission.create!(:subject_class => 'Admin',
                   :action => 'destroy',
                   :name => 'Delete administrative account')
Permission.create!(:subject_class => 'Admin',
                   :action => 'update',
                   :name => 'Edit administrative account')
Permission.create!(:subject_class => 'Admin',
                   :action => 'index',
                   :name => 'List of the administrative accounts')
Permission.create!(:subject_class => 'Admin',
                   :action => 'reset_auth_token',
                   :name => 'Reset authentication token')

# Assign permission to admin account
Permission.all.each do |p|
  admin.admin_permissions.create!(:permission => p)
end

account1 = domain.accounts.create!(:first_name => 'Joel',
                                   :last_name => 'Albers',
                                   :login => 'joel', :password => 'secret')
account1.deposit(20)
account1.deposit(30)
account1.withdraw(15)

account2 = domain.accounts.create!(:first_name => 'Patricia',
                                   :last_name => 'Slogan',
                                   :login => 'patricia', :password => 'secret')
account2.deposit(10)
account2.deposit(20)
account2.withdraw(15)

service1 = Service.create!(:name => 'iptraffic',
                           :title => 'Internet access via PPP')
service2 = Service.create!(:name => 'ipoe',
                           :title => 'Internet access via IPoE')
service3 = Service.create!(:name => 'voip',
                           :title => 'Voice over Internet Protocol (VoIP)')

# Plans
plan1 = Plan.create!(:name => "Awesome Ultimate", :code => "Ultimate")
plan2 = Plan.create!(:name => "Nightly Geek", :code => "Nightly")
plan3 = Plan.create!(:name => "Till Daylight Dies", :code => "Daylight")

# Add some options for service
service2.options.create!(:name => 'bw_limit_in',
                         :title => 'Max bandwidth in',
                         :required => true,
                         :value_type => Option::Type::NUMERIC)
service2.options.create!(:name => "bw_limit_out",
                         :title => "Max bandwidth out",
                         :required => true,
                         :value_type => Option::Type::NUMERIC)

ps1 = plan1.assigned_services.create!(:service => service2)

# Add ServiceLink to Account
account1.service_links.create!(:assigned_service => ps1)
