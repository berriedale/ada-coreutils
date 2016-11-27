------------------------------------------------------------------------------
--  `true` a program which does nothing, successfully
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
     GNAT.Command_Line,
     Userland.Build;

procedure BinTrue is
   use GNAT.Command_Line;
begin
   loop
      case Getopt ("-version") is
      when '-' =>
         if Full_Switch = "-version" then
            Ada.Text_IO.Put_Line ("true " & Userland.Build.Version);
         end if;
      when others => exit;
      end case;
   end loop;

   Ada.Command_Line.Set_Exit_Status (Code => 0);
end BinTrue;
