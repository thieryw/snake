with display,Ada.Containers.Hashed_Maps ;
with Ada.Strings.Hash;
with Ada.text_io; use Ada.text_io;

package body snake_types is

        function Hash_Func(Key : character) return Ada.Containers.Hash_Type is
        begin
                return Ada.Strings.Hash(Key'Image);

        end Hash_Func;



end snake_types ;


