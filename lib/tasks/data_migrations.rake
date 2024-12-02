namespace :data_migrations do
  desc "Migrarte single to many attachments"
  task update_attachments: :environment do
    ActiveStorage::Attachment.where(name: "attachment").update_all(name: "attachments")
  end
end
