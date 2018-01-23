include ActiveSupport::NumberHelper

And(/^savings and investment question, answer appended to the calculator Previous answers section$/) do
  expect(any_calculator_page.previous_answers.disposable_capital.answer.text).to eql number_to_currency(user.disposable_capital, precision: 0, unit: '£')
end

Then(/^I should see that (?:I am|we are) likely to get help with fees$/) do
  marital_status = user.marital_status.downcase
  msg = messaging.translate("hwf_decision.disposable_capital.#{marital_status}.positive.detail",
    fee: number_to_currency(user.fee, precision: 0, unit: '£'),
    disposable_capital: number_to_currency(user.disposable_capital, precision: 0, unit: '£'))
  expect(any_calculator_page.feedback_message_with_header(messaging.translate("hwf_decision.disposable_capital.#{marital_status}.positive.heading"))).to be_present
  expect(any_calculator_page.feedback_message_with_detail(msg)).to be_present
end

Then(/^I should see that (?:I am|we are) unlikely to get help with fees$/) do
  marital_status = user.marital_status.downcase
  msg = messaging.translate("hwf_decision.disposable_capital.#{marital_status}.negative.detail",
    fee: number_to_currency(user.fee, precision: 0, unit: '£'),
    disposable_capital: number_to_currency(user.disposable_capital, precision: 0, unit: '£'))
  expect(not_eligible_page).to be_displayed
  expect(not_eligible_page.feedback_message_with_detail(msg)).to be_present
  expect(not_eligible_page.feedback_message_with_header(messaging.translate("hwf_decision.disposable_capital.#{marital_status}.negative.heading"))).to be_present
end

And(/^response highlighted in blue$/) do
  expect(any_calculator_page.positive_message).to be_present
end

And(/^response highlighted in red$/) do
  expect(any_calculator_page.negative_message).to be_present
end
