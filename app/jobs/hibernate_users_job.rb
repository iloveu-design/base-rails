class HibernateUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    users_to_inform = User.where("(sign_in_count = 0 and last_sign_in_at <= :date) or (sign_in_count > 0 and current_sign_in_at < :date)", {date: 11.months.ago.to_date}).where({hibernated: false, hibernate_notified_at: nil})

    users_to_inform.each do |user|
      UserMailer.hibernate_notify(user.id).deliver
      user.update(hibernate_notified_at: DateTime.current)
    end

    users_to_hibernate = User.where("(sign_in_count = 0 and last_sign_in_at <= :date) or (sign_in_count > 0 and current_sign_in_at < :date)", {date: 1.years.ago.to_date}).where("hibernated = false and hibernate_notified_at is not null")

    users_to_hibernate.each do |user|
      user.update(hibernated: true)
    end

  end
end
