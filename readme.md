# Active Body

Active Body is an Object Relational Mapping system based on Rails Active Record. It can be used for grouping and selecting database tables, inserting into and updating the database, searching the database, and intuitively performing table joins through associations.


## Getting Started

Use the following commands to clone the repository, install dependencies, and enter the console.
 * git clone www.github.com/th3nathan/Active_Body
 * cd Active_Body
 * bundle install
 * apt-get install libsqlite3-dev (if sqlite3 is not installed)
 * pry
 * load 'demo.rb'

 Now try out the API, here are some suggestions.
 * Cat.first.home
 * Cat.where({"name" => "Cammy"})
 * first_cat = Cat.first
 * first_cat.name = "Nathan"
 * first_cat.update
 * Cat.first




### Manipulating the Database

#### `#insert`

Adds an instance of a class inheriting from SQL Object to the database.

#### `#update`

Updates an instance that is already stored in the database

#### `#save`

Updates instance if already stored in the database. Inserts if the instance is not in the database.

### Searching

#### `:find(id)`

Takes an id as an argument, and returns the first item matching that id.

#### `:where(match_params)`

Takes a hash of parameters as an argument, returns all items matching these parameters.

### Associations

#### `:belongs_to(name, options)`

Used to create an association (responding to name), which sets a parent relation to the caller. All instances of the calling class will have access to the association. See an example below,

```ruby
  #When defining a cat model
  belongs_to :owner,
  primary_key: :id,
  foreign_key: :owner_id,
  class_name: 'Human'
```

Now, calling owner on a cat instance will search for and return the human with an id which matches the cat's owner_id.

#### `:has_many(name, options)`

This is the reverse of belongs_to, it finds all children of a parent.

#### `:has_one_through(name, through_assoc, source_assoc)`

Traverses a through association to arrive at a narrowed-down source association by joining the through table to the source table.

```ruby
  #Cat model
  has_one_through :home, :owner, :house
```
This would find the house which have the same owner as the cat.
```
