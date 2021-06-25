require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :client, :users, :equipos

  #Initialize é um construtor
  def initialize
    #conexão com mongoDB
    @client = Mongo::Client.new(CONFIG["mongo"])
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_danger
    @client.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    # puts user[:_id]
    # puts user[:_id].class
    return user[:_id]
  end

  def remove_equipo(name, email)
    user_id = get_user(email)
    @equipos.delete_many({ name: name, user: user_id })
  end
end

#no cmder executar: ruby features\support\libs\mongo.rb
#Ele trás a collection >> #<Mongo::Collection::View:0x0000000003bc7520>
#Ao add .class ele mostra que tipo que é (sem o return) >> BSON::ObjectId
#Dessa forma eu sei que é o cara corretono bd
#MongoDB.new.get_user("betao@yahoo.com")
