# Find a comment from a user with 'bob' in its name sorted by the name.
# Note: NoBrainer will use the :name index from User by default
# User.where(:name => /bob/).order_by(:name => :desc).to_a

# User.find "4M39V517kzBSpG"
# User.where(:first_name => /Oleg/).order_by(:first_name => :desc).to_a
# User.where(:isActive => false).sample(2)
# order_by()/reverse_order/without_ordering
# with_index/without_index/used_index/indexed?
# with_cache/without_cache/reload
# preload() - eager loading
# after_find()
# sample(n)
# merge() merge!()

# rake nobrainer:sync_schema
# rake nobrainer:sync_indexes
# rake db:update_indexes
# console> NoBrainer.update_indexes
# console> Model.perform_update_indexes

# r.table('users').filter(lambda user: r.expr([1,2,3]).contains(user['id']) & (user['active'] == 1))
# r.table('users').filter(lambda user: r.all(r.expr([1,2,3]).contains(user['id']), user['active'] == 1))

# User.create(first_name: 'Oleg', last_name: 'Kapranov', middle_name: 'G.', password: '12345678', email: 'lugatex@yahoo.com', description: 'Hello Wolrd!')
