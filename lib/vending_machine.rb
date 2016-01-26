require 'inventory'

class VendingMachine

  def initialize
    @current_currency = 0
    @inventory = Inventory.new
  end

  def add_money(currency)
    @current_currency += currency
  end

  def currency
    return @current_currency
  end

  def dispense_change
    change = @current_currency
    @current_currency = 0
    return change
  end

  def snack_list
    return @inventory.snack_list
  end

  def set_inventory(new_inventory)
    @inventory = new_inventory
  end

  def snack_price(snack_type) 
    snack = @inventory.snack_info(snack_type)
    return snack.price
  end

  def vend(snack_type)
    snack = @inventory.snack_info(snack_type)
    if(snack.nil?)
      return nil
    end
    if(@current_currency < snack.price)
      return nil
    end
    @current_currency -= snack.price
    return @inventory.remove(snack_type)
  end

end
