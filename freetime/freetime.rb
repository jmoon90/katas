require 'byebug'

START_TIME = 9
MEETING_BLOCK = 0.5

# def human_readable
# end

def condense_meeting_times(meeting_times)
  final_meeting_schedule = []

  meeting_times.each_with_index do |meeting_time, outter_index|
    @start_time = meeting_time[0]
    @end_time = meeting_time[1]

    included = false
    meeting_times.each_with_index do |inner_meeting_time, inner_index|
      next if inner_index == outter_index

      inner_start_time = inner_meeting_time[0]
      inner_end_time = inner_meeting_time[1]
      if inner_start_time.between?(start_time, end_time)
        s_times = [start_time, inner_start_time].sort[0]
        e_times = [end_time, inner_end_time].sort[-1]

        included = true
        meeting_times.delete_at(inner_index)
        final_meeting_schedule << [s_times, e_times]
      elsif inner_meeting_time.include?(start_time)
        s_times = [start_time, inner_start_time].sort[0]
        e_times = [end_time, inner_end_time].sort[-1]

        included = true
        meeting_times.delete_at(inner_index)
        final_meeting_schedule << [s_times, e_times]
      elsif inner_meeting_time.include?(end_time)
        s_times = [start_time, inner_start_time].sort[0]
        e_times = [end_time, inner_end_time].sort[-1]

        included = true
        meeting_times.delete_at(inner_index)
        final_meeting_schedule << [s_times, e_times]
      end
    end

    if included == false
      final_meeting_schedule << meeting_time
    end
  end
  puts final_meeting_schedule
end

def start_time
  @start_time
end

def end_time
  @end_time
end


condense_meeting_times([ [0, 1], [3, 5], [4, 8], [10, 12], [9, 10] ])
# [ [0, 1], [3, 8], [9, 12] ]
