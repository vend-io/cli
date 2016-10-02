require "./repl"
require "./vendio"

repl = REPL.instance
im = ItemManager.instance
repl.implement :new, Item.method(:new)
repl.implement :add, im.method(:add)
repl.implement :remove, im.method(:remove)
repl.add_verb :slot
repl.implement :slot, im.method(:slot)
repl.run
