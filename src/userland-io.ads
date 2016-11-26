
with Ada.Containers.Indefinite_Ordered_Sets,
     Ada.Strings.Unbounded;

package Userland.IO is

   MAX_FILE_NAME_LENGTH : constant := 255;
   -- Ext[2-4] file systems, and many others have a file name length maximum
   -- of 255 bytes, for now that's easy enough to limit ourselves at since this
   -- value is going to result in stack allocations of file names, etc.

   subtype File_Name is Ada.Strings.Unbounded.Unbounded_String;
   -- Subtype to enforce file name size limits and consistency of using it
   -- inside of various procedures

   type Dir_Element is record
      Name   : File_Name ; --:= (others => Ada.Characters.Latin_1.NUL);
      Hidden : Boolean   := False;
   end record;
   -- Record for processing directory item meta-data once for later re-use
   -- and display

   function Is_Piped return Boolean;
   -- Return true if the Standard Output of this process is going to a unix
   -- pipe instead of a terminal

   function Compare_Dir_Elements (Left, Right : Dir_Element) return Boolean;
   function Equal_Dir_Elements (Left, Right : Dir_Element) return Boolean;

   package Dir_Elements is
     new Ada.Containers.Indefinite_Ordered_Sets (Element_Type => Dir_Element,
                                                 "<"          => Compare_Dir_Elements,
                                                 "="          => Equal_Dir_Elements);
   -- Container for Dir_Element records which is automatically sorted
end Userland.IO;
