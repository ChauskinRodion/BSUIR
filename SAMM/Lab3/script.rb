#!/usr/bin/env ruby

N = 1000000
p_x, p_y, p_z = 0.75, 0.7, 0.7
x,y,u,z = false,false,false,false
a = 0.0
rejected = 0
request = 0.0
N.times do |i|
  if (rand() > p_z && z)
    z = false
    a+=1
  end
  if(!z && u)
    z = true
    u = false
  end
  if(rand() > p_y && y == true)
    unless (u)  #accept request
      u = true
      y = false
    else            #reject request
      u = true
      y = false
      rejected +=1
    end
  end
  if(x || rand() > p_x)
    unless (y)
      y = true
      x = false
      request+=1
    else            #block
      x = true
    end
  end
end


q = a / request
a  /=  N - rejected
a /= 10 if p_x == 0.0

p "A: #{a}"
p "Q: #{q}"
