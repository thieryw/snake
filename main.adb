with snake_functions,snake_types,ada.calendar,display,ada.text_io ;
use ada.text_io ;




procedure main is


        snake_variable : snake_types.Snake ;
        dir : snake_types.Snake_direction:=snake_types.LEFT ;
        has_new_user_input: boolean;
        user_requested_direction : snake_types.Snake_direction ;
        user_controls_default : snake_types.User_Controls.Map;

        fruit : snake_types.Coordinates ;
begin

        user_controls_default := snake_functions.get_user_controls_default ;

        snake_variable := snake_functions.create_snake ;

        fruit.x := 5 ;
        fruit.y := 5 ;


        loop


                snake_functions.retreve_user_input(
                        has_new_user_input,
                        user_requested_direction,
                        user_controls_default
                        ) ;

                if  has_new_user_input then

                        snake_functions.update_direction(dir,user_requested_direction) ;

                end if ;



                snake_functions.render_game(snake_variable,fruit) ;

                snake_functions.move_snake(snake_variable,dir) ;

                snake_functions.generate_fruit(fruit,snake_variable) ;
                delay 0.5 ;


        end loop ;




end main ;




