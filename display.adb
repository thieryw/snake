with ada.text_io,ada.integer_text_io,nt_console ;
use ada.text_io ;





package body display is







        procedure render(screen : grid) is
                procedure clear_screen is
                begin
                        ada.text_io.put(ASCII.ESC & "[2J") ;
                end clear_screen ;
                

                display : string(1..((screen'length(1) + 2) * (screen'length(2) + 2) + (screen'length(1) + 2))) ;
                count : integer := 1 ;

        begin

                nt_console.clear_screen ;

                for i in screen'first(1)-1..screen'last(1)+1 loop
                        for j in screen'first(2)-1..screen'last(2)+1 loop
                                if i = screen'first(1)-1 or j = screen'first(2)-1 or i = screen'last(1)+1 or j = screen'last(2)+1 then 
                                        display(count) := ('#') ;
                                else
                                        if screen(i,j) = true then
                                                display(count) := ('#') ;
                                        else
                                                display(count) := (' ') ;
                                        end if ;
                                end if ;
                                count := count + 1 ;

                        end loop ;

                        display(count) := character'val(10) ;
                        count := count+1 ;


                end loop ;

                put(display) ;



        end render ;


end display ;
