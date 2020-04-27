module HomepageHelper
  def data_by_year(data)
    data.where('extract(year from date) = ?', Date.today.year)
  end

  def data_by_month(data)
    data.where('extract(month from date) = ?', Date.today.month)
  end
end
