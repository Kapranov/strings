# Find a comment from a user with 'bob' in its name sorted by the name.
# Note: NoBrainer will use the :name index from User by default
# User.where(:name => /bob/).order_by(:name => :desc).to_a

# rake nobrainer:sync_indexes
# User.create(first_name: 'Oleg', last_name: 'Kapranov', middle_name: 'G.', password: '12345678', description: 'Hello Wolrd!')
