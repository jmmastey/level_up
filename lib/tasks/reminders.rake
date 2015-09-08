desc "send reminder emails to unenrolled users"
task reg_reminder: :environment do
  puts "Sending reminders to unenrolled users..."
  int = RemindRegistrationDropoffs.call
  puts "done. Sent #{int.context.users.length} emails."
end

desc "send reminder emails to enrolled users who have stopped progress"
task progress_reminder: :environment do
  puts "Sending reminders to unenrolled users..."
  int = RemindActivityDropoffs.call
  puts "done. Sent #{int.context.enrollments.length} emails."
end

desc "send reminder emails for users nearing their deadline"
task deadline_reminder: :environment do
  puts "Sending reminders to deadline users..."
  int = RemindDeadlines.call
  puts "done. Sent #{int.context.deadlines.length} emails."
end
