

with Ada.Command_Line,
     Ada.Text_IO,
     GNAT.Command_Line,
     GNAT.OS_Lib,
     System;

procedure Touch is
   use Ada.Command_Line,
       Ada.Text_IO,
       GNAT.OS_Lib;

   type Timebufs is record
      Access_Time : OS_Time;
      Mod_Time    : OS_Time;
   end record;
   type Timebufs_Ptr is access Timebufs;

   function Native_Utime (Filename : in String;
                          Times    : access Timebufs) return Integer
      with Import, Convention => C,
                   Link_Name  => "utime";
   -- utime(2);
begin
   if Argument_Count = 0 then
      Put_Line ("touch: missing file operand");
      Set_Exit_Status (1);
      return;
   end if;

   declare
      Target          : constant String := Argument (1);
      Descriptor      : File_Descriptor;
      Current_Timebuf : aliased Timebufs := (Access_Time => Current_Time,
                                                Mod_Time => Current_Time);
      Return_Val : Integer := 0;
   begin
      if Is_Writable_File (Target) then
         Return_Val := Native_Utime (Target, Current_Timebuf'Access);
      else
         Descriptor := Create_New_File (Target, Text);
      end if;
   end;
end Touch;
