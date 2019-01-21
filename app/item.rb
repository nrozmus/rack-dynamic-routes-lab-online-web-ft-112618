class Application
  
  # instructions
  # accept the /items/<ITEM NAME> route, and everything else should 404
  # if user requests /items/<ITEM NAME>, return price of that item
  # if user requests item that you don't have, return 400 and error message
  
  def call(env)
            
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    
    @@items = Item.all
    
    route_match = true if req.path.match(/items/)
    item_name = req.path.split("/items/").last if route_match
    
    route_match ? route_item(resp, item_name) : route_not_found(resp)

    resp.finish
  end # end of def call
  
  def route_item(resp, item_name)
      if item = @@items.detect { |i| i.name == item_name }
        resp.write item.price
      else 
        resp.write "Item not found"
        resp.status = 400
      end
  end # end of def route_item
  
  def route_not_found(resp)
    resp.status = 404
    resp.write "Route not found"
  end # end of def route_not_found
  
end # end of class
    # if route_match
    #  route_item(resp, item_name)
    # else
    #  route_not_found(resp)
    # end # end of nested if
    
    # find_this = req.path.split("/items").last if route_match
    # found_item = ""
    
    # if route_match
      # check for item name
      # if item exists look for price
    #  if find_this
     #   @@items.each do |item|
      #    found_item = item if item.name == find_this
    #    end
        # show item price
      #  resp.write found_item.price
       # else, item wasn't found
    #   else
    #    resp.status = 400
    #    resp.write "Item not found"
    #   end
     # route_match is false, route was not found
    # else
    #  resp.write "Route not found"
     # resp.status = 404
    # end # end of nested if
