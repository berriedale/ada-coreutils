------------------------------------------------------------------------------
--  `pwd` a program which prints the current working directory
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


with Ada.Text_IO,
     GNAT.Command_Line,
     GNAT.Directory_Operations,
     Userland;

procedure Pwd is
   use Ada.Text_IO,
       GNAT.Command_Line,
       GNAT.Directory_Operations;

   PWD : constant String := Get_Current_Dir;
begin

   loop
      case Getopt("-version") is
         when '-' =>
            if Full_Switch = "-version" then
               Put_Line ("pwd " & Userland.Version);
               return;
            end if;
         when others => exit;
      end case;
   end loop;

   -- Get_Current_Dir comes with a trailing slash, so we must trim that off for
   -- printing
   Put_Line (PWD (1 .. (PWD'Length - 1)));
end Pwd;
