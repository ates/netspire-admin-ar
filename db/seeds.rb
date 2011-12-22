admin = Admin.create!(:login => 'admin', :password => 'secret',
                      :email => 'admin@domain.com')
admin.reset_authentication_token!

# Permissions
Permission.create!(:subject_class => 'Account',
                   :action => 'index',
                   :name => 'List of the accounts')
Permission.create!(:subject_class => 'Account',
                    :action => 'edit',
                    :name => 'Edit account')
Permission.create!(:subject_class => 'Account',
                   :action => 'destroy',
                   :name => 'Delete account')
Permission.create!(:subject_class => 'Account',
                   :action => 'update',
                   :name => 'Update account')
Permission.create!(:subject_class => 'Account',
                   :action => 'create',
                   :name => 'Create account')
Permission.create!(:subject_class => 'Transaction',
                   :action => 'index',
                   :name => 'List of the transactions')

# Assign permission to admin account
Permission.all.each do |p|
  admin.admin_permissions.create!(:permission => p)
end

account1 = Account.create!(:login => 'joel', :password => 'secret')
account1.deposit(20)
account1.deposit(30)
account1.withdraw(15)

account2 = Account.create!(:login => 'patricia', :password => 'secret')
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
