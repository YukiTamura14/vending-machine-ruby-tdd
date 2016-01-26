
Snack = Struct.new(:name, :price)

class Inventory

  def initialize
    @inventory = []
  end

  def add(snack)
    @inventory.push snack
  end

  def count
    return @inventory.count
  end

  def remove(snack_type)
    item = locate_snack(snack_type)
    @inventory.delete(item)
    return item
  end

  def snack_list
    snacks = @inventory.map { |snack| snack.name }
    return snacks.uniq
  end

  def snack_info(snack_type)
    snack = locate_snack(snack_type)
    return snack
  end

  private
  def locate_snack(snack_type)
    index = @inventory.index { |item| item.name == snack_type }
    if index.nil?
      return nil
    end
    return @inventory[index]
  end
end
