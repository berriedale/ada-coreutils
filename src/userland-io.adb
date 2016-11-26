
with Ada.Characters.Handling,
     Ada.Strings.Unbounded,
     Interfaces.C_Streams;

package body Userland.IO is

   function Is_Piped return Boolean is
   -- Return True if our current Standard_Output is a Unix Pipe, and therefore
   -- we're not printing to a normal terminal
      use Interfaces.C_Streams;
      Output_Stream : constant Integer := fileno (stdout);
   begin
      return isatty (Output_Stream) = 0;
   end Is_Piped;

   function Normalize_Filename (Filename : in String) return String is
   -- Normalize the filenames for sorting purposes, this will ensure that
   -- files like `Makefile` and `.Makefile.swp` can be sorted appropriately
      use Ada.Characters.Handling;
   begin
      if Filename'Length > 2 and Filename (Filename'First) = '.' then
         -- Only trim files that have a preceeding dot and aren't `..` or `.`
         return To_Lower (Filename (2 .. Filename'Length));
      end if;

      return To_Lower (Filename);
   end Normalize_Filename;

   function Compare_Dir_Elements (Left, Right : Dir_Element) return Boolean is
      use Ada.Strings.Unbounded;
   begin
      return Normalize_Filename (To_String (Left.Name)) <
        Normalize_Filename (To_String (Right.Name));
   end Compare_Dir_Elements;

   function Equal_Dir_Elements (Left, Right : Dir_Element) return Boolean is
      use Ada.Characters.Handling,
          Ada.Strings.Unbounded;
   begin
      return Left.Name = Right.Name;
   end Equal_Dir_Elements;
end Userland.IO;
