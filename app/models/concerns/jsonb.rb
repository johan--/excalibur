# module Concerns::Jsonb
#   extend ActiveSupport::Concern

#   # Public : This method adds data to the model using the supplied Hash. It is
#   # possible to store one new key/value or multiple at the same time. The method
#   # returns itself and can therefore be chained.
#   #
#   # Examples :
#   #   point = Point.last
#   #   point.set(domain: "firmapi.com")
#   #   point.set(domain: "firmapi.com", twitter: "_Firmapi").del(:linkedin)
#   #
#   def set(all_data)
#     data.merge!(all_data)

#     save!
#     self
#   end

#   # Public : Deletes the key/value pairs for the given instance. Multiple (or
#   # no) keys can be given at the same time.
#   #
#   # Examples :
#   #   point = Point.last
#   #   point.del(:domain)
#   #   point.del("twitter", "domain")
#   #
#   #
#   def del(*keys)
#     keys.each { |key| data.delete(key.to_s) }

#     save!
#     self
#   end

#   # Public : Simply returns a key. It is possible to give a default value
#   # in case the key isn't found.
#   #
#   # Example :
#   #   point = Point.last
#   #
#   #   point.get(:domain)
#   #   => "firmapi.com"
#   #
#   #   point.get(:nothing, default: "Default value")
#   #   => "Default value"
#   #
#   def get(key, default: nil)
#     data[key.to_s] || default
#   end

#   # Shared methods used to simplify search within JSONB.
#   #
#   # Use with caution, some of them might be slow depending on your configuration
#   # and the amount of data in your database. Indexes can be created.
#   #
#   module ClassMethods
#     # Public : Returns all the instances with the key(s) supplied.
#     #
#     # Example :
#     #   Point.contains(:domain)
#     #
#     def contains(key)
#       where(["data ? :key", key: key.to_s])
#     end

#     # Public : Returns all the instances with the given key/value pair(s).
#     #
#     # Example :
#     #   Point.where_data(domain: "firmapi.com")
#     #   Point.where_data(domain: "firmapi.com", twitter: "_Firmapi")
#     #
#     def where_data(args)
#       where("data @> '#{args.to_json}'")
#     end
#   end
# end