
limited with Ada.Strings.Unbounded;

package Userland is

   function To_Lower (Input : in Ada.Strings.Unbounded.Unbounded_String)
                      return String;
   -- Lower-case an entire Unbounded_String and return a Standard.String instead
end Userland;
