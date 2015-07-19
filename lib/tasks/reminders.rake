desc "send reminder emails to unenrolled users"
task reg_reminder: :environment do
  puts "Sending reminders to unenrolled users..."
  int = RemindRegistrationDropoffs.new.call
  puts "done. Sent #{int.users.length} emails."
end

desc "send reminder emails to enrolled users who have stopped progress"
task progress_reminder: :environment do
  puts "Sending reminders to unenrolled users..."
  int = RemindActivityDropoffs.new.call
  puts "done. Sent #{int.enrollments.length} emails."
end
