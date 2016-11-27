------------------------------------------------------------------------------
--  `readlink` print resolved symbolic links or canonical file names
--
--  Copyright (C) 2016 R. Tyler Croy <tyler@linux.com>
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License
--  as published by the Free Software Foundation; either version 2
--  of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
------------------------------------------------------------------------------


with Ada.Command_Line,
     Ada.Text_IO,
     GNAT.Directory_Operations,
     GNAT.OS_Lib;

procedure Readlink is
   use Ada.Command_Line,
       Ada.Text_IO,
       GNAT.Directory_Operations,
       GNAT.OS_Lib;
begin
   Set_Exit_Status (1);

   if Argument_Count = 0 then
      Put_Line ("readlink: missing operand");
      return;
   end if;

   declare
      Target : constant String := Argument (1);
   begin
      if Is_Symbolic_Link (Target) then
         Put_Line (Normalize_Pathname (Target));
         Set_Exit_Status (0);
      end if;
   end;
end Readlink;
