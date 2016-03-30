require 'byebug'
require 'benchmark'

class AreaFinder
  def initialize(area_1, area_2)
    @area_1 = area_1
    @area_2 = area_2
  end

  def overlapping_rectangle
    find_corner_areas
    find_overlapping_area
    formatted_output
  end

  def find_overlapping_area
    @x_overlap = overlap(0, :bottom_left, :bottom_right)
    @y_overlap = overlap(1, :bottom_left, :top_left)
  end

  def formatted_output
    # coordinates of bottom-left corner
    return 'no overlap' if @x_overlap.empty? && @y_overlap.empty?
    { 'left_x' => @x_overlap[0],
      'bottom_y' => @y_overlap[0],

      # width and height
      'width' => @x_overlap[-1] - @x_overlap[0],
      'height' => @y_overlap[-1] - @y_overlap[0]
    }
  end

  def find_corner_areas
    @area_1_corner = calculate_corners_for_area(@area_1)
    @area_2_corner = calculate_corners_for_area(@area_2)
  end

  def calculate_corners_for_area(area)
    @area = area
    { bottom_left: bottom_left_corners,
      top_left: top_left_corners,
      bottom_right: bottom_right_corners,}
  end

  def overlap(index, corner_one_symbol, corner_two_symbol)
    overlap = []
    (@area_2_corner.fetch(corner_one_symbol)[index]..@area_2_corner.fetch(corner_two_symbol)[index]).each do |num|
      overlap << num if num.between?(@area_1_corner.fetch(corner_one_symbol)[index], @area_1_corner.fetch(corner_two_symbol)[index])
    end
    overlap
  end

  private

  def bottom_left_corners
    [@area['left_x'], @area['bottom_y']]
  end

  def bottom_right_corners
    # [@area['left_x'] + area['width'], @area['bottom_y']]
    @bottom_right_corners = [bottom_left_corners[0] + @area['width'], bottom_left_corners[1]]
    @bottom_right_corners
  end

  def top_left_corners
    # [@area['left_x'], @area['bottom_y'] + @area['height']]
    @top_left_corners = [bottom_left_corners[0], bottom_left_corners[1] + @area['height']]
    @top_left_corners
  end
end


area_1 = {
  # coordinates of bottom-left corner
  'left_x' => 1,
  'bottom_y' => 5,

  # width and height
  'width' => 1000,
  'height' => 400,
}

area_2 = {
  # coordinates of bottom-left corner
  'left_x' => 1,
  'bottom_y' => 7,

  # width and height
  'width' => 200,
  'height' => 1000,
}

# area_2 = {
#   # coordinates of bottom-left corner
#   'left_x' => 11,
#   'bottom_y' => 9,
#
#   # width and height
#   'width' => 3,
#   'height' => 3,
# }


#non overlapping
# area_2 = {
#   # coordinates of bottom-left corner
#   'left_x' => 20,
#   'bottom_y' => 20,
#   # width and height
#   'width' => 2,
#   'height' => 10,
# }

puts AreaFinder.new(area_1, area_2).overlapping_rectangle

def find_range_overlap(point1, length1, point2, length2)

    # find the highest start point and lowest end point.
    # the highest ("rightmost" or "upmost") start point is
    # the start point of the overlap.
    # the lowest end point is the end point of the overlap.
    highest_start_point = [point1, point2].max
    lowest_end_point = [point1 + length1, point2 + length2].min

    # return nil overlap if there is no overlap
    if highest_start_point >= lowest_end_point
        return [nil, nil]
    end

    # compute the overlap length
    overlap_length = lowest_end_point - highest_start_point

    return [highest_start_point, overlap_length]
end

def find_rectangular_overlap(rect1, rect2)

    # get the x and y overlap points and lengths
    x_overlap_point, overlap_width  = find_range_overlap(\
        rect1['left_x'], rect1['width'],  rect2['left_x'], rect2['width'])
    y_overlap_point, overlap_height = find_range_overlap(\
        rect1['bottom_y'], rect1['height'], rect2['bottom_y'], rect2['height'])

    # return nil rectangle if there is no overlap
    if !overlap_width || !overlap_height
        return {
            'left_x' => nil,
            'bottom_y' => nil,
            'width' => nil,
            'height' => nil,
        }
    end

    return {
        'left_x' => x_overlap_point,
        'bottom_y' => y_overlap_point,
        'width' => overlap_width,
        'height' => overlap_height,
    }
end

puts find_rectangular_overlap(area_1, area_2)


require 'benchmark'

n = 5000000
Benchmark.bm(7) do |x|
  x.report("mine:") { AreaFinder.new(area_1, area_2).overlapping_rectangle }

  x.report("his:")  { find_rectangular_overlap(area_1, area_2) }
end
