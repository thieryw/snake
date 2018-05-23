with snake_types,ada.text_io,ada.integer_text_io ;
use ada.text_io ;


package body snake_functions is




        procedure render(zone : snake_types.T_snake_zone) is
                procedure clear_screen is
                begin
                        put(ASCII.ESC & "[2J") ;
                end clear_screen ;

        begin
                clear_screen ;
                
                
                for i in zone'first(1)-1..zone'last(1)+1 loop
                        for j in zone'first(2)-1..zone'last(2)+1 loop
                               if i = zone'first(1)-1 or j = zone'first(2)-1 or i = zone'last(1)+1 or j = zone'last(2)+1 then 
                                       put("#") ;
                               else
                                       if zone(i,j) = true then
                                               put("#") ;
                                       else
                                               put(" ") ;
                                       end if ;
                               end if ;
                                
                        end loop ;
                        new_line ;
                end loop ;


        end render ;


end snake_functions ;
