class Serv::Room < ActiveRecord::Base
  has_many :meets, class_name: '::Serv::Meet'
end
