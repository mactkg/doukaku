require 'parallel'

def calc(x, y, d, h)
  diff_x, diff_y = 0, 0
  result = []
  case d
    when 'R' # left <- right
      diff_x = -1
    when 'L' # left -> right
      diff_x = 1
    when 'T' # up -> down
      diff_y = 1
    when 'B' # down -> up
      diff_y = -1
    else
      return []
  end

  current_x = x
  current_y = y
  h.times do |n|
    # center point
    result.push([current_x, current_y])

    # wing area
    n.times do |n|
      n += 1
      case d
        when 'R','L'
          result.push([current_x, current_y+n])
          result.push([current_x, current_y-n])
        when 'T','B'
          result.push([current_x-n, current_y])
          result.push([current_x+n, current_y])
      end
    end

    # ready for next loop
    current_x += diff_x
    current_y += diff_y
  end

  result
end

input = gets.chomp
a, b = input.split('/')

results = Parallel.map([a, b]) do |triangle|
  parsed = triangle.match(%r!(\d+),(\d+)(R|L|T|B)(\d+)!)
  calc(parsed[1].to_i, parsed[2].to_i, parsed[3], parsed[4].to_i)
end
c = results.flatten(1)
p c.size - c.uniq.size

