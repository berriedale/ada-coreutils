
with Ada.Characters.handling,
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

   function Compare_Dir_Elements (Left, Right : Dir_Element) return Boolean is
      use Ada.Characters.Handling,
          Ada.Strings.Unbounded;
   begin
      return To_Lower (Left.Name) < To_Lower (Right.Name);
   end Compare_Dir_Elements;

   function Equal_Dir_Elements (Left, Right : Dir_Element) return Boolean is
      use Ada.Characters.Handling,
          Ada.Strings.Unbounded;
   begin
      return Left.Name = Right.Name;
   end Equal_Dir_Elements;
end Userland.IO;
