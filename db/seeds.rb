# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

stickers = [ {stk_pkg_id: 1, stk_id: ((1..17).to_a + [21] + (100..139).to_a + (401..430).to_a) },
             {stk_pkg_id: 2, stk_id: ((18..20).to_a + (22..47).to_a + (140..179).to_a + (501..527).to_a) } 
           ].reduce([]) do |a, e|
             a + e[:stk_id].map{ |i| { stk_pkg_id: e[:stk_pkg_id], stk_id: i }  }
           end


stickers.each { |s| LineSticker.find_or_create_by(s) }
