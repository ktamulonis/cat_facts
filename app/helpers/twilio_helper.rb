module TwilioHelper
  def parse_sms(sms)

    body = sms[:Body]&.strip&.upcase
    from = sms[:From]

    case body

    when "SUBSCRIBE"
      subscriber = Subscriber.create(phone_number: from)
      return "The number #{from} has been subscribed to receive cat facts. Text UNSUBSCRIBE at any time to unsubscribe."

    when "UNSUBSCRIBE"
      subscriber = Subscriber.find_by(phone_number: from)
      if subscriber
          subscriber.destroy
          return "The number #{from} has been unsubscribed. Text SUBSCRIBE at any time to resubscribe."
      else
          return "Sorry, I did not find a subscriber with the number #{from}."
      end

    when "FACT"
       return CatFact.last.fact

    else
        return "Sorry I didn't get that. the available commands are SUBSCRIBE, UNSUBSCRIBE, and FACT."
    end
  end
end
