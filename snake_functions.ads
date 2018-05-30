with snake_types ;







package snake_functions is


        function are_same_coord(point1 : snake_types.Coordinates ; point2 : snake_types.Coordinates) return boolean ;
        function create_snake return snake_types.Snake ;
        procedure move_snake(s : in out snake_types.Snake ; dir : snake_types.Snake_direction) ;
        procedure retreve_user_input(
                has_new_user_input: out boolean;
                direction: out snake_types.Snake_direction ; 
                user_controls_value: in snake_types.User_Controls.Map
                );
        function get_user_controls_default return snake_types.User_Controls.Map ;
        procedure update_direction(dir : in out snake_types.Snake_direction ; new_direction : snake_types.Snake_direction) ;
        procedure generate_fruit(fruit : in out snake_types.Coordinates ; s : snake_types.snake) ;
        procedure render_game(s : snake_types.snake ; fruit : snake_types.Coordinates) ;
end snake_functions ;
