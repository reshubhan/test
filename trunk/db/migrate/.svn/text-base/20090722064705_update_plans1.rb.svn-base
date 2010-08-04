class UpdatePlans1 < ActiveRecord::Migration
  def self.up
    plans = Plan.find_all_by_name("Plus")
    plans.each { |plan|
      plan.duration == "One Year" ? plan.update_attribute("no_of_views", "100") : plan.update_attribute("no_of_views", "200")
      plan.duration == "One Year" ? plan.update_attribute("no_of_emails", "10 per Annum") : plan.update_attribute("no_of_emails", "20 per Annum")
    }
  end

  def self.down
    plans = Plan.find_all_by_name("Plus")
    plans.each { |plan|
      plan.update_attribute("no_of_views", "Unlimited")
      plan.update_attribute("no_of_emails", "10 per Annum")
    }
  end
end
