#!/usr/bin/env ruby

x, y, queue ,z = false, false, 0, false
p_x, p_y,p_z = 0.5, 0.48, 0.5
N = 10000
processed = 0.0
rejected = 0.0
bids = 0.0
expectation = 0.0
N.times do
  if(rand() > p_z && z)
    processed +=1
    z = false
  end

  if(rand() > p_y && y)
    if z
      rejected +=1
    end
    z = true
    y = false
  end

  if(queue >0 && !y)
    y = true
    queue-=1
  end

  p queue if queue !=0

  if(x || rand() > p_x)
    bids+=1
    x = false

    if queue == 0 && !y
      y = true
    end
    if queue == 1
      queue+=1
      p queue
    elsif queue == 2
      x = true
      expectation +=1
    end
  end
end
p processed/N
p processed/bids
p "expectation -> #{expectation}"
p bids
