class DealerBuilder
  attr_reader :computer

  def initialize
    @dealer = Dealer.new
    @dealer.contact_info
  end

  def columns_values
    columns = Dealer.column_names + ContactInfo.column_names
    columns -= %w[created_at updated_at]
    columns
  end

  def contact_info
    @dealer.contanct_info = ContactInfo.new
  end

  def name=(name)
    @dealer.name = name
  end

  def category=(category)
    @dealer.category = category
  end

  def sf_id=(sf_id)
    @dealer.sf_id = sf_id
  end

  def longitude=(longitude)
    @dealer.longitude = longitude
  end

  def latitude=(latitude)
    @dealer.latitude = latitude
  end

  def street=(street)
    @dealer.contact_info.street = street
  end

  def city=(city)
    @dealer.contact_info.city = city
  end

  def zip=(zip)
    @dealer.contact_info.zip = zip
  end

  def country=(country)
    @dealer.contact_info.zip = country
  end

  def state=(state)
    @dealer.contact_info.state = state
  end

  def phone=(phone)
    @dealer.contact_info.phone = phone
  end

  def dealer
    obj = @dealer.dup
    @dealer = Dealer.new
    obj
  end
end
