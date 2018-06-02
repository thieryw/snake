with snake_functions,snake_types,ada.calendar,display,ada.text_io ;
use ada.text_io,ada.calendar ;




procedure main is


        snake_variable : snake_types.Snake ;

        dir : snake_types.Snake_direction:=snake_types.LEFT ;

        has_new_user_input: boolean;

        user_requested_direction : snake_types.Snake_direction ;

        user_controls_default : snake_types.User_Controls.Map;

        fruit : snake_types.Coordinates := (x => 5,y => 5) ;

        end_of_game : boolean := false ;

        fruit_time_out : integer := 25 ;

        score : integer := 0 ;

        start_time : ada.calendar.time ;
        

begin

        user_controls_default := snake_functions.get_user_controls_default ;

        snake_variable := snake_functions.create_snake ;


        loop
                start_time := ada.calendar.clock ;
                

                

                snake_functions.retreve_user_input(
                        has_new_user_input,
                        user_requested_direction,
                        user_controls_default
                        ) ;

                if  has_new_user_input then

                        snake_functions.update_direction(dir,user_requested_direction) ;

                end if ;



                snake_functions.render_game(snake_variable,fruit) ;


                snake_functions.is_end_of_game(snake_variable,end_of_game) ;

                if end_of_game then
                        exit ;
                end if ;
                

                snake_functions.move_snake(snake_variable,dir,fruit,fruit_time_out,score) ;

                fruit_time_out := fruit_time_out - 1 ;

                if fruit_time_out = 0 then
                        snake_functions.generate_fruit(fruit,snake_variable,fruit_time_out) ;
                end if ;


                put_line("SCORE : " & integer'image(score)) ;



                delay 0.1 - (start_time - clock) ;



        end loop ;

                put_line("YOU LOSE MOTHER FUCKER") ;

                delay 3.0 ;




end main ;




