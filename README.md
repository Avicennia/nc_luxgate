# nc_luxgate


This mod is still a WIP and may contain bugs and glitches. 



Luxgate is a simple mod meant to add portals to your nodecore worlds in the form of stargate-like structures called "Luxgates".




[]---------------------------CRAFTING YOUR NEW LUXGATE------------------------------[]



There are 2 varieties of the luxgate, which differ only in orientation; the base recipe goes as follows:


Key:
"u" = Ulvstone
"i" = Ilmenite Block
"x" = Lux Cobble node


Total crafting structure height 3x3x2 (length x width x height)

Ground tier 3x3x1 (length x width x height)
[u][i][u]
[x][u][x]
[u][i][u]

Second tier 3x3x1 (length x width x height)
[u][u][u]
[u][i][u]
[u][u][u]







[]-----------------USING YOUR NEW PORTAL---------------------[]


After crafting a portal, a player can power their gate by placing lux emitting nodes (lux cobble is a good power source) within 2 nodes of the 4 corner nodes of the main portal ring and punch the lambda portal control node (middle node with the yellow symbol on it)

This will activate the gate and it will now be registered to the global network of portals.

Next shift-click the same control node to move forward along options within the network (if any) to set as a destination. You will see a display of the state of the destination and it's distance from the gate.

Stand in the center of the gate (in the ring, on top of the control node) and wait to be teleported.

If teleportation does not work, it is likely that your portal needs to be energized more.

Energizing is done the same as starting up the portal, simply punch the control node (without shift pressed), and if there are nearby suitable lux emission nodes your portal will draw energy from them.

Try teleporting again, your portal will teleport you if it has enough energy to transmit you accross the distance to your destination.




[]------------------TUNING YOUR PORTAL-------------------[]



Gates can also be tuned to a certain "frequency" of sorts using charcoal glyphs. Simply inscribe charcoal 
glyphs along the sides of the bottommost nodes (the wide flat base platform of 5x5 underneath the gate's ring) to add layers of exclusion to your gate. Afterwards, gates can only recieve teleports from other gates with the same combination of glyphs on their sides. There is an order to sides for those who want to manipulate glyph order (still WIP) to make portals a bit more exclusive. Portals with glyph tuning can also teleport to "blank" portals that are not tuned, but not recieve from blank portals.




[]---------------Chatcommand guide-----------------[]



/lgremove 
--Removes the nearest gate, does not return nodes. Must be standing on or in the middle of the portal frame.

/lgassert
--For adding a new gate to the dynamic table if for some reason a gate that was made is not registered properly. Must be standing on or in the middle of the portal frame.

/lglistms
--Messages the player a list of the modstored dynamic table backup.

/lglist
--Messages the player the dynamic table as a list.

/lgclear
--Removes duplicate positions from the dynamic table if required.