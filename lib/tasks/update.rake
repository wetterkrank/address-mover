namespace :update do
  desc "Sending the Update paper letter via ClickSend"

  task :send, [:uuid] => :environment do |t, args|
    pdf = PDF.find_by(uuid: args[:uuid])
    update = pdf.parent
    puts "Sending PDF to #{pdf.parent.provider.name}..."
    LetterSendJob.perform_now(update)
  end
end
