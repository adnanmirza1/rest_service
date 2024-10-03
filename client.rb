require 'net/http'
require 'json'

BASE_URL = 'http://localhost:3000'

def login(email, password)
  uri = URI("#{BASE_URL}/login")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
  request.body = { email: email, password: password }.to_json
  response = http.request(request)

  if response.is_a?(Net::HTTPSuccess)
    token = JSON.parse(response.body)['token']
    puts "Logged in successfully. Token: #{token}"
    return token
  else
    puts "Login failed: #{response.body}"
    return nil
  end
end

def signup(name, email, password)
  uri = URI("#{BASE_URL}/signup")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
  request.body = { user: { name: name, email: email, password: password } }.to_json
  response = http.request(request)

  if response.is_a?(Net::HTTPSuccess)
    puts "Signup successful."
  else
    puts "Signup failed: #{response.body}"
  end
end

def get_items(token)
  uri = URI("#{BASE_URL}/items")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.path, 'Authorization' => "Bearer #{token}")
  response = http.request(request)

  if response.is_a?(Net::HTTPSuccess)
    puts JSON.parse(response.body)
  else
    puts "Failed to get items: #{response.body}"
  end
end

def create_item(token, name, description)
  uri = URI("#{BASE_URL}/items")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{token}")
  request.body = { item: { name: name, description: description } }.to_json
  response = http.request(request)

  if response.is_a?(Net::HTTPSuccess)
    puts "Item created: #{response.body}"
  else
    puts "Failed to create item: #{response.body}"
  end
end

# Example usage


signup('John Doe', 'john2@example.com', 'password123')
token = login('john2@example.com', 'password123')
get_items(token) if token
create_item(token, 'Sample Item', 'This is a sample item.') if token
