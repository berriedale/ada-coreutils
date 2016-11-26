---
--- Implementation of ls(1) in Ada
---

with Ada.Characters.Latin_1,
     Ada.Characters.Handling,
     Ada.Command_Line,
     Ada.Containers.Indefinite_Ordered_Sets,
     Ada.Strings.Fixed,
     Ada.Strings.Unbounded,
     Ada.Text_IO,
     GNAT.Directory_Operations,
     GNAT.Command_Line;

procedure Ls is
   use Ada.Command_Line,
       Ada.Strings.Unbounded,
       Ada.Text_IO,
       GNAT.Directory_Operations;

   MAX_FILE_NAME_LENGTH : constant := 255;
   -- Ext[2-4] file systems, and many others have a file name length maximum
   -- of 255 bytes, for now that's easy enough to limit ourselves at since this
   -- value is going to result in stack allocations of file names, etc.

   subtype File_Name is Unbounded_String;
   -- Subtype to enforce file name size limits and consistency of using it
   -- inside of various procedures

   type Dir_Element is record
      Name   : File_Name ; --:= (others => Ada.Characters.Latin_1.NUL);
      Hidden : Boolean   := False;
   end record;
   -- Record for processing directory item meta-data once for later re-use
   -- and display

   function Compare_Dir_Elements (Left, Right : Dir_Element) return Boolean is
      use Ada.Characters.Handling,
          Ada.Strings.Unbounded;
   begin
      return To_Lower (To_String (Left.Name)) < To_Lower (To_String (Right.Name));
   end Compare_Dir_Elements;

   function Equal_Dir_Elements (Left, Right : Dir_Element) return Boolean is
      use Ada.Characters.Handling,
          Ada.Strings.Unbounded;
   begin
      return Left.Name = Right.Name;
   end Equal_Dir_Elements;

   package Dir_Element_Set is
     new Ada.Containers.Indefinite_Ordered_Sets (Element_Type => Dir_Element,
                                                 "<"          => Compare_Dir_Elements,
                                                 "="          => Equal_Dir_Elements);
   -- Container for Dir_ELement records which is automatically sorted

   procedure List_Directory (Directory : in String) is
   -- Walk the directory using GNAT.Directory_Operations and generate
   -- Dir_Element records

      Location : Dir_Type;

      Elements : Dir_Element_Set.Set;
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

      for E of Elements loop
         if E.Hidden /= True then
            Put (To_String (E.Name));
            Put ("  ");
         end if;
      end loop;

      New_Line;
      Close (Dir => Location);
   end List_Directory;

begin
   if Argument_Count = 0 then
      List_Directory (Get_Current_Dir);
   else
      List_Directory (Argument (1));
   end if;
end Ls;
