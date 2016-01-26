require 'vending_machine'
require 'inventory'

describe VendingMachine do
  let(:inventory) { Inventory.new }

  describe "Handling money" do
    it "should be able to accept currency" do
      subject.add_money(0.25)
      expect(subject.currency).to eq(0.25)
    end

    it "should be able to accept currency several times" do
      subject.add_money(0.25)
      subject.add_money(0.25)
      expect(subject.currency).to eq(0.50)
    end

    it "should provide change if requested" do
      expect(subject.dispense_change).to eq(0)
    end

    it "should provide give change equal to currency if nothing was dispensed" do
      subject.add_money(0.25)
      expect(subject.dispense_change).to eq(0.25)
    end
    
    it "should report no currency if you've dispensed the change" do
      subject.add_money(0.25)
      subject.dispense_change
      expect(subject.currency).to eq(0)
    end
  end

  describe "Inventory management" do

    before(:each) do
      inventory.add(Snack.new(:Snickers, 0.75))
      inventory.add(Snack.new(:Milky_Way, 0.50))
      subject.set_inventory(inventory)
    end
    
    it "should be aware of what kinds of snacks it has" do
      subject.set_inventory(Inventory.new)
      expect(subject.snack_list.count).to eq(0)
    end
    
    it "should have a different list with different snacks" do
      subject.set_inventory(inventory)
      expect(subject.snack_list.count).to eq(2)
    end

    it "should be able to tell me the price for a given snack" do
      subject.set_inventory(inventory)
      expect(subject.snack_price(:Snickers)).to eq(0.75)
    end
  end

  describe "Vending snacks" do

    before(:each) do
      inventory.add(Snack.new(:Snickers, 0.75))
      inventory.add(Snack.new(:Milky_Way, 0.50))
      subject.set_inventory(inventory)
    end

    it "should not vend an item if no money has been given" do
      snack = subject.vend(:Snickers)
      expect(snack).to be_nil
    end

    it "should vend an item if the price is correct" do
      subject.add_money(0.75)

      snack = subject.vend(:Snickers)
      expect(snack.name).to eq(:Snickers)
      expect(subject.currency).to eq(0)
    end

    it "should have change if there is too much money" do
      subject.add_money(1)

      snack = subject.vend(:Snickers)
      expect(snack.name).to eq(:Snickers)
      expect(subject.currency).to eq(0.25)
    end

    it "should not vend an item if there isn't one available" do
      subject.add_money(1)

      snack = subject.vend(:Peanut_Brittle)
      expect(snack).to be_nil
      expect(subject.currency).to eq(1)
    end
  end


end
