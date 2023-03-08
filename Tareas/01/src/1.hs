-- Solución inciso b
alfabet_index = [1..26]
alfabet = ['a'..'z']         

getTuplesM = zip alfabet alfabet_index

c_toInt :: Char -> [(Char, Integer)] -> Integer
c_toInt c (x:xs)
  | c == (fst x) = snd x
  | otherwise    = c_toInt c xs
          
-- | cipher_char: encripta el carácter recibido
--                con una llave (ya pasada a entero).
-- input -> key -> Integer
cipher_char :: Char -> Integer -> Integer
cipher_char c k = k + (mod m 26)
  where m = c_toInt c getTuplesM

-- | all_values: devuelve una lista con todas
--               las posibles salidas para este caracter
--               dado el alfabeto de claves(aquí ya mapeado
--               a enteros.
-- *Usa índice base 1
all_values :: Char -> [Integer]
all_values c = all_values_aux c 1

-- | all_values_aux: función auziliar para all_values (itera).
-- *Usa indice base 1
all_values_aux :: Char -> Integer -> [Integer]
all_values_aux c 26 = (cipher_char c 26):[]
all_values_aux c n = (cipher_char c n):all_values_aux c (n+1)

