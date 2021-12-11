# mb_blackout
Simple blackout resource for FiveM

# Description
Resource which allows the player to trigger a blackout (all lights disabled) for a preconfigured time. E.G. Can be used when robbing a bank to get an advantage.

# Dependencies
- ESX
- Can be easily converted to work with any framework. 

# Installation Guide
1. Download the resource from Github
2. Drag n' drop the folder to your `resources` folder
3. Rename the folder to `mb_blackout`
4. Add `ensure mb_blackout` to your server.cfg file
5. Configure config.lua and sv_bo.lua files
6. Add the item into your database
7. Ensure the resource or restart your server

# Usage
- Trigger a blackout by using an item or a command
- Blackout will end after the preconfigured time has been passed

# How to add the item to database
### Old ESX (Item limit)
```sql
INSERT INTO `items` (name, label, limit) VALUES
  ('laptop', 'Laptop', 1)
;
```
### Updated ESX (Item weight)
```sql
INSERT INTO `items` (name, label, weight) VALUES
  ('laptop', 'Laptop', 3)
;
```
