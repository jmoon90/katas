require 'byebug'
class AreaFinder
  def initialize(area_1, area_2)
    @area_1 = area_1
    @area_2 = area_2
  end

  def overlapping_rectangle
    overlapping_area
    formatted_output
  end

  def overlapping_area
    @x_overlap = x_overlap(corner_areas)
    @y_overlap = y_overlap(corner_areas)
    [@x_overlap, @y_overlap]
  end

  def formatted_output
    # coordinates of bottom-left corner
    { 'left_x' => @x_overlap[0],
      'bottom_y' => @y_overlap[0],

      # width and height
      'width' => @x_overlap[-1] - @x_overlap[0],
      'height' => @y_overlap[-1] - @y_overlap[0]
    }
  end

  def corner_areas
    area_1_corners = calculate_corners_for_area(area_1)
    area_2_corners = calculate_corners_for_area(area_2)
    [area_1_corners, area_2_corners]
  end

  def calculate_corners_for_area(area)
    @area = area
    { bottom_left: bottom_left_corners,
      top_left: top_left_corners,
      bottom_right: bottom_right_corners,
      top_right: top_right_corners }
  end

  def x_overlap(corner_areas)
    # {:bottom_left=>[1, 5], :top_left=>[1, 9], :bottom_right=>[11, 5], :top_right=>[11, 9]}
    x_overlap = []
    area_1_corner = corner_areas.first
    area_2_corner = corner_areas.last

    (area_2_corner.fetch(:bottom_left)[0]..area_2_corner.fetch(:bottom_right)[0]).each do |num|
      x_overlap << num if num.between?(area_1_corner.fetch(:bottom_left)[0],area_1_corner.fetch(:bottom_right)[0])
    end
    x_overlap
  end

  def y_overlap(corner_areas)
    y_overlap = []
    area_1_corner = corner_areas.first
    #=> {:bottom_left=>[1, 5], :top_left=>[1, 9], :bottom_right=>[11, 5], :top_right=>[11, 9]}
    area_2_corner = corner_areas.last
    #=> {:bottom_left=>[1, 7], :top_left=>[1, 17], :bottom_right=>[3, 7], :top_right=>[3, 17]}

    (area_2_corner.fetch(:bottom_left)[1]..area_2_corner.fetch(:top_left)[1]).each do |num|
      y_overlap << num if num.between?(area_1_corner.fetch(:bottom_left)[1],area_1_corner.fetch(:top_left)[1])
    end
    y_overlap
  end

  private

  attr_accessor :area_2, :area_1
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

  def top_right_corners
    # [@area['left_x'] + @area['width'], @area['bottom_y'] + @area['height']]
    @top_right_corners = [bottom_right_corners[0], top_left_corners[1]]
    @top_right_corners
  end
end


area_1 = {
  # coordinates of bottom-left corner
  'left_x' => 1,
  'bottom_y' => 5,

  # width and height
  'width' => 10,
  'height' => 4,
}

area_2 = {
  # coordinates of bottom-left corner
  'left_x' => 1,
  'bottom_y' => 7,

  # width and height
  'width' => 2,
  'height' => 10,
}

puts AreaFinder.new(area_1, area_2).overlapping_rectangle
