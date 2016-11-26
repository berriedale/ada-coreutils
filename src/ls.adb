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
begin
   if Argument_Count = 0 then
      Elements := List_Directory (Get_Current_Dir);
   else
      declare
         Target : constant String := Argument (1);
      begin
         if GNAT.OS_Lib.Is_Directory (Target) then
           Elements := List_Directory (Target);
         else
            Put_Line (Target);
            return;
         end if;
      end;

      Elements := List_Directory (Argument (1));
   end if;

   for E of Elements loop
      if E.Hidden = False then
         Put (To_String (E.Name));
         if Is_Piped then
           New_Line;
         else
            Put ("  ");
         end if;
      end if;
   end loop;
end Ls;
