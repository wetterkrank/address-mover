namespace :testpdf do
  desc "Sending the test letter via ClickSend"
  task send: :environment do
    LetterSendJob.perform_now
  end
end
