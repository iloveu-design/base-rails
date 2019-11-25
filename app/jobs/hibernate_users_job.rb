class HibernateUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    users_to_inform = User.where("(sign_in_count = 0 and last_sign_in_at <= :date) or (sign_in_count > 0 and current_sign_in_at < :date)", {date: 11.months.ago.to_date}).where({hibernated: false, hibernate_notified_at: nil})

    users_to_inform.each do |user|
      UserMailer.hibernate_notify(user.id).deliver
      user.update(hibernate_notified_at: DateTime.current)
    end

    users_to_dehibernate = User.where("hibernate_notified_at is not null and current_sign_in_at > hibernate_notified_at")
    users_to_dehibernate.update_all({hibernated: false, hibernate_notified_at: nil})

    users_to_hibernate = User.where("hibernated = false and hibernate_notified_at is not null and hibernate_notified_at < :date", {date: 1.month.ago.to_date})
    users_to_hibernate.update_all(hibernated: true)
  end
end
