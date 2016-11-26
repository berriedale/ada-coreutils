
with Ada.Characters.Handling,
     Ada.Strings.Unbounded;

package body Userland is

   function To_Lower (Input : in Ada.Strings.Unbounded.Unbounded_String) return String is
   -- Lower-case an entire Unbounded_String and return a Standard.String instead

      use Ada.Characters.Handling,
          Ada.Strings.Unbounded;
   begin
      return To_Lower (To_String (Input));
   end To_Lower;

end Userland;
