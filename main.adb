with snake_functions,snake_types,ada.calendar ;




procedure main is

        tab : snake_types.T_snake_zone := (others => (others => false)) ;


begin


        for i in tab'first(1)..tab'last(1) loop

                for j in tab'first(2)..tab'last(2) loop 
                        tab(i,j) := true ;
                        snake_functions.render(tab) ;
                        tab(i,j) := false ;
                        delay 0.1 ;
                end loop ;

        end loop ;


end main ;




