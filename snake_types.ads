
with ada.Containers.Hashed_Maps,display, Ada.Containers.Hashed_Maps,ada.containers.doubly_linked_lists ;

package snake_types is






        type Snake_direction is (LEFT,RIGHT,UP,DOWN) ;

        type Coordinates is
                record

                        x : integer range 1..20  ;
                        y : integer range 1..70  ;

                end record ;


        package snake_list is new ada.Containers.doubly_linked_lists(Coordinates) ;

        subtype snake is snake_list.list ;

        function Hash_Func(Key : character) return Ada.Containers.Hash_Type ;

        package User_Controls is new Ada.Containers.Hashed_Maps
                (Key_Type => character,
                Element_Type => Snake_direction,
                Hash => Hash_Func,
                Equivalent_Keys => "=");










end snake_types ;



