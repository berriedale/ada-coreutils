---
--- Implementation of ls(1) in Ada
---

with Ada.Command_Line,
     Ada.Strings.Unbounded,
     Ada.Text_IO,
     GNAT.Directory_Operations,
     GNAT.Command_Line,
     GNAT.OS_Lib,
     Userland,
     Userland.IO;

procedure Ls is
   use Ada.Command_Line,
       Ada.Strings.Unbounded,
       Ada.Text_IO,
       GNAT.Directory_Operations,
       GNAT.Command_Line,
       Userland,
       Userland.IO;

   function List_Directory (Directory : in String)
                            return Dir_Elements.Set is
   -- Walk the directory using GNAT.Directory_Operations and generate
   -- Dir_Element records

      Location : Dir_Type;
      Elements : Dir_Elements.Set;
   begin
      Open (Dir      => Location,
            Dir_Name => Directory);

      loop
         declare
            Element : Dir_Element;
            Item    : String (1 .. MAX_FILE_NAME_LENGTH);
            Index   : Natural := 0;
         begin
            Read (Dir  => Location,
                  Str  => Item,
                  Last => Index);
            -- Read sets Index to 0 when the last item in the directory
            -- has been read
            exit when Index = 0;

            Element.Name := To_Unbounded_String (Item (1 .. Index));

            if Head (Source => Element.Name,
                     Count  => 1) = "." then
               Element.Hidden := True;
            end if;

            Elements.Insert (Element);
         end;
      end loop;
      Close (Dir => Location);

      return Elements;
   end List_Directory;

   Elements : Dir_Elements.Set;
   Show_Hidden : Boolean := False;
   Reverse_Sort : Boolean := False;

   procedure Print_Element (Element     : in Dir_Element;
                            Show_Hidden : in Boolean := False) is
      use Ada.Text_IO;
   begin
      if (Element.Hidden = False) or (Element.Hidden = Show_Hidden) then
         Put (To_String (Element.Name));

         if Is_Piped then
            New_Line;
         else
            Put ("  ");
         end if;
      end if;
   end Print_Element;

begin
   loop
      case Getopt ("a r -all -reverse") is
      when 'a' =>
         Show_Hidden := True;

      when 'r' =>
         Reverse_Sort := True;

      when '-' =>
         if Full_Switch = "-all" then
            Show_Hidden := True;
         end if;

         if Full_Switch = "-reverse" then
            Reverse_Sort := True;
         end if;

      when others =>
         exit;
      end case;
   end loop;

   declare
      Target : String := GNAT.Command_Line.Get_Argument;
   begin
      if Target'Length = 0 then
         Elements := List_Directory (Get_Current_Dir);
      elsif GNAT.OS_Lib.Is_Directory (Target) then
         Elements := List_Directory (Target);
      else
         Put_Line (Target);
         return;
      end if;
   end;

   if Reverse_Sort then
      for E of reverse Elements loop
         Print_Element (Element     => E,
                        Show_Hidden => Show_Hidden);
      end loop;
      return;
   end if;

   for E of Elements loop
      Print_Element (Element     => E,
                     Show_Hidden => Show_Hidden);
   end loop;
end Ls;
