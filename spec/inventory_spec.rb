require 'inventory'
describe Inventory do
  it "should have a count of snacks" do
    expect(subject.count).to eq(0)
  end

  it "should be able to have a new snack added" do
    snack = Snack.new(:Snickers, 0.75)
    subject.add(snack)
    expect(subject.count).to eq(1)
  end

  it "should be able to have a specific snack removed" do
    snack = Snack.new(:Snickers, 0.75)
    subject.add(snack)
    removed = subject.remove(:Snickers)
    expect(removed.price).to eq(0.75)
    expect(subject.count).to eq(0)
  end

  it "should remove nothing if there is no snack to remove" do
    removed = subject.remove(:Snickers)
    expect(removed).to be_nil
  end
  
  it "should be able to have many snacks of one type" do
    snack = Snack.new(:Snickers, 0.75)
    subject.add(snack)
    snack = Snack.new(:Snickers, 0.75)
    subject.add(snack)
    expect(subject.count).to eq(2)
  end

  it "should remove nothing if it is the wrong snack to remove" do
    snack = Snack.new(:Snickers, 0.75)
    subject.add(snack)
    removed = subject.remove(:Milky_Way)
    expect(removed).to be_nil
    expect(subject.count).to eq(1)
  end

  it "should be able to tell what kinds of snacks are in stock" do
    snack = Snack.new(:Snickers, 0.75)
    subject.add(snack)
    snack = Snack.new(:Mikly_Way, 0.50)
    subject.add(snack)
    expect(subject.snack_list.count).to eq(2)
  end
   
  it "should only list a type of snack once" do 
    snack = Snack.new(:Snickers, 0.75)
    subject.add(snack)
    snack = Snack.new(:Snickers, 0.75)
    subject.add(snack)
    expect(subject.snack_list.count).to eq(1)
  end

  it "should be able to locate a snack for reference" do
    snack = Snack.new(:Snickers, 0.50)
    subject.add(snack)
    actual_snack = subject.snack_info(:Snickers)
    expect(actual_snack.price).to eq(0.50)
  end

  it "should not be able to describe a snack it doesn't have" do
    expect(subject.snack_info(:Peanut_Brittle)).to be_nil
  end

end
