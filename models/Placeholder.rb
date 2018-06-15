class Placeholder

  attr_accessor :id, :scientificAnimalName, :commonAnimalName

  # Open the connection to the DB
  def self.open_connection

    conn = PG.connect( dbname: 'animals' )

  end

  # Method to get all instances from our DB
  def self.all

    # calling the open_connection method
    conn = self.open_connection

    # Creating a SQL string
    sql = "SELECT * FROM mock_data ORDER BY id"

    # Execute the connection with our SQL string, storing it in a variable
    # 'Dirty array'
    results = conn.exec(sql)

    # 'Cleaned array'
    placeholders = results.map do |tuple|
      self.hydrate tuple
    end

  end

  # Find one using the ID that'll give it when we call it
  def self.find id
    # Open connection
    conn = self.open_connection

    # SQL to find using the ID
    sql = "SELECT * FROM mock_data WHERE id=#{ id } LIMIT 1"

    # Get the raw results
    placeholders = conn.exec(sql)

    # Result comes back as array so need to run hydrate on first instance
    placeholder = self.hydrate placeholders[0]

    # Return the cleaned post
    placeholder

  end

  def save

    conn = Placeholder.open_connection

    # If the object that the save method is run on does NOT have an existing ID, create a new instance
    if (!self.id)
      sql = "INSERT INTO mock_data (scientificAnimalName, commonAnimalName) VALUES ('#{ self.scientificAnimalName }','#{ self.commonAnimalName }')"
    else
      sql = "UPDATE mock_data SET scientificAnimalName='#{self.scientificAnimalName}', commonAnimalName='#{self.commonAnimalName}' WHERE id='#{self.id}'"
    end

    conn.exec(sql)

  end

  # DESTROY method
  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM mock_data WHERE id=#{id}"

    conn.exec(sql)
  end

  # The data we get back from the DB isn't particularly clean, so we need to create a method to clean it up before we send it to the Controller
  def self.hydrate post_data

    # Create a new instance of Post
    placeholder = Placeholder.new

    # Assign the id, title and body properties to those that come back from the DB
    placeholder.id = post_data['id']
    placeholder.scientificAnimalName = post_data['scientificAnimalName']
    placeholder.commonAnimalName = post_data['commonAnimalName']

    # Return the post
    placeholder

  end


end
