require 'byebug'

START_TIME = 9
MEETING_BLOCK = 0.5

class FreeTime
  def initialize(meeting_times)
    @meeting_times = meeting_times
    @final_meeting_schedule = []
    @skip_indexes = []
  end

  # FreeTime.new([ [0, 1], [4, 8], [3, 5], [10, 12], [9, 10] ]).condense_meeting_times
  def condense_meeting_times
    meeting_times.each_with_index do |meeting_time, outter_index|
      next if @skip_indexes.include?(outter_index)
      @outer_meeting_time = meeting_time
      @best_condensed_start_time = nil
      @best_condensed_end_time = nil

      included = false
      meeting_times.each_with_index do |inner_meeting_time, inner_index|
        next if meeting_time == inner_meeting_time
        @inner_meeting_time = inner_meeting_time
        if meets_any_time_slot_condition?
          included = true
          if @best_condensed_start_time == nil || @best_condensed_start_time > condensed_start_time
            @best_condensed_start_time = condensed_start_time
          end
          if @best_condensed_end_time == nil || @best_condensed_end_time < condensed_end_time
            @best_condensed_end_time = condensed_end_time
          end
          byebug if outter_index == 2
          @skip_indexes << inner_index
        end
      end
      if included == false
        final_meeting_schedule << meeting_time
      else
        final_meeting_schedule << [@best_condensed_start_time, @best_condensed_end_time]
      end
    end
  end

  def condensed_meeting_schedule
    condense_meeting_times
    puts final_meeting_schedule
  end

  private

  attr_accessor :final_meeting_schedule, :inner_meeting_time, :outer_meeting_time, :meeting_times

  def condensed_start_time
    [start_time, inner_start_time].sort[0]
  end

  def condensed_end_time
    [end_time, inner_end_time].sort[-1]
  end

  def meets_any_time_slot_condition?
    inner_meeting_time.include?(end_time) ||
      inner_meeting_time.include?(start_time) ||
      inner_start_time.between?(start_time, end_time) ||
      inner_end_time.between?(start_time, end_time) ||
      next_meeting_block? ||
      between_best_condensed_time? ||
      next_best_condensed_time?
  end

  def start_time
    @start_time = outer_meeting_time[0]
  end

  def end_time
    @end_time = outer_meeting_time[1]
  end

  def next_meeting_block?
    outer_meeting_time.include?(@inner_start_time + 1) ||
      outer_meeting_time.include?(@inner_start_time - 1)
  end

  def between_best_condensed_time?
    return unless @best_condensed_start_time
    return unless @best_condensed_end_time
    inner_start_time.between?(@best_condensed_start_time, @best_condensed_end_time) ||
      inner_end_time.between?(@best_condensed_start_time, @best_condensed_end_time)
  end

  def next_best_condensed_time?
    return unless @best_condensed_start_time
    return unless @best_condensed_end_time
    inner_meeting_time.include?(@best_condensed_start_time + 1) ||
      inner_meeting_time.include?(@best_condensed_start_time - 1) ||
      inner_meeting_time.include?(@best_condensed_end_time + 1) ||
      inner_meeting_time.include?(@best_condensed_end_time - 1)
  end

  def inner_start_time
    @inner_start_time = inner_meeting_time[0].to_i
  end

  def inner_end_time
    @inner_end_time = inner_meeting_time[1].to_i
  end
end


FreeTime.new([ [0, 1], [4, 8], [3, 5], [10, 12], [9, 10] ]).condensed_meeting_schedule
# [ [0, 1], [3, 8], [9, 12] ]
#[0,12]
