#!/usr/bin/env ruby

@λ = 0.004#1.0/(10*24)
m = 0.25
t = 1/m
N = 100000
broken = 0.0
normal = 0.0
state = '00'


def rand
  (-1.0/@λ)*Math.log(Random.rand())
end

i = 0
while(i < N) do
  broked = rand() < @λ
    case state
    when '00' then
      if broked
        state = '10'
        broken +=1
      else
        normal+=1
      end
    when '10' then
        if broked
          state = '11'
          broken +=1
        else
          state = '20'
          i+=t
        end
    when '11' then
        state = '21'
        i+=t
    when '20' then
        if broked
          state = '21'
          broken +=1
        else
          state = '00'
          i+=t
        end
    when '21' then
        state = '22'
        i+=t
    when '22' then
        state = '20'
        i+=t
    end
  i+=1
end
p "broken = #{broken} ;normal = #{normal}"
p broken / N
p @λ
p normal / N


