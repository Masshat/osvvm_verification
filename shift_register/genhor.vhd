-- generateur d'horloge programmable
library ieee ;
use ieee.std_logic_1164.all ;

entity genhor is
   port(tck : in time := 100 ns ;
         hor : buffer std_logic := '0') ;
end genhor ;

architecture simple of genhor is
begin
horloge : process 
begin
   if tck > 0 ns then
      wait for tck/2 ;
      hor <= not hor ;
   else
      wait on tck ;
   end if ;
end process horloge ;
end simple ;
