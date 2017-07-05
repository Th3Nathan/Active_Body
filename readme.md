# Active Body

Active Body is an Object Relational Mapping system based on Rails Active Record. It can be used for grouping and selecting database tables, inserting into and updating the database, and intuitively performing table joins through associations.

  * Select database items by row
  * Search the database
  * Select data through associations
  * Update and create database instances
  * Queue functions until DOM is fully loaded

## Getting Started

To try out Active Body, download the file and install dependencies. View the demo file in the lib folder to see how data models can be structured. Then, load the demo file in PRY to test out the API.

### Manipulating the Database

#### `#insert`

Adds an instance of a class inheriting from SQL Object to the database.

#### `#update`

Updates an instance that is already stored in the database

#### `#save`

Updates instance if already stored in the database. Inserts if the instance is new.

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
This would find all houses which have the same human owner as the cat.
ck");
```
