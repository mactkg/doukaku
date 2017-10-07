input = gets.chomp
r = input.match(%r!(\d+),(\d+)(R|L|T|B)(\d+)/(\d+),(\d+)(R|L|T|B)(\d+)!)

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
    result.push("#{current_x},#{current_y}")

    # wing area
    n.times do |n|
      n += 1
      case d
        when 'R','L'
          result.push("#{current_x},#{current_y+n}")
          result.push("#{current_x},#{current_y-n}")
        when 'T','B'
          result.push("#{current_x+n},#{current_y}")
          result.push("#{current_x-n},#{current_y}")

      end
    end

    # ready for next loop
    current_x += diff_x
    current_y += diff_y
  end

  result
end

A = calc(r[1].to_i, r[2].to_i, r[3], r[4].to_i)
B = calc(r[5].to_i, r[6].to_i, r[7], r[8].to_i)
C = A + B
p C.size - C.uniq.size
