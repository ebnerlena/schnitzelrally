# MMP2a Virtuelle Schnitzeljagd Prototype

rails g scaffold GameTask name:string description:string hint:string latitude:float longitude:float user:references 

rails g scaffold Route id:String tasks:references user:references users:references latitude:float longitude:float radius:integer start_time:timestamp end_time:timestamp

use devise, guest devise gem, active storage, aasm as statemachine, leaflet-rails

bundle exec guard

