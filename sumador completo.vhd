entity sumadorcompleto is
Port(x,y,cin: in std_logic;
     cout,suma: out std_logic);
end sumadorcompleto;

architecture ecuaciones of sumadorcompleto is
begin
sum <= x xor y xor cin;
cout <= (x and y) or (x and cin) or (y and cin);
end ecuaciones;
      
