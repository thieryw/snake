with snake_functions,snake_types,ada.calendar,display,ada.text_io ;
use ada.text_io,ada.calendar ;

procedure main is

        s : snake_types.Snake ;
        dir : snake_types.Snake_direction:=snake_types.LEFT ;
        has_new_user_input: boolean;
        user_requested_direction : snake_types.Snake_direction ;
        user_controls_default : snake_types.User_Controls.Map;
        fruit : snake_types.Coordinates ;
        fruit_timeout : integer  ;
        score : integer := 0 ;
        timestamp : ada.calendar.time= clock ;
        

begin

        user_controls_default := snake_functions.get_user_controls_default ;

        s := snake_functions.create_snake ;

        snake_functions.generate_fruit(s, fruit,fruit_timeout) ;


        loop

                snake_functions.render_game(s,fruit) ;

                snake_functions.retreve_user_input(
                        has_new_user_input,
                        user_requested_direction,
                        user_controls_default
                        ) ;

                if  has_new_user_input then
                        snake_functions.update_direction(dir,user_requested_direction) ;
                end if ;
                

                --FIXME: generate fruit and timeout
                snake_functions.move_snake(s,dir,fruit,does_eat_fruit) ;

                if snake_functions.is_end_of_game(s) then
                        exit ;
                end if ;

                fruit_timeout := fruit_timeout - 1 ;

                if fruit_timeout = 0 then
                        snake_functions.generate_fruit(s, fruit,fruit_timeout) ;
                end if ;


                --FIXME
                put_line("SCORE : " & integer'image(score)) ;


                delay 0.1 - (timestamp - clock) ;
                timestamp := ada.calendar.clock ;


        end loop ;

                put_line("YOU LOSE MOTHER FUCKER") ;

                delay 3.0 ;

end main ;




