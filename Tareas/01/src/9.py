def main():
    var = False
    k = 0
    arr_bytes = bytearray()
    with open("sample/foto.cifrada", "rb") as f:
        while (byte := f.read(1)):
            arr_bytes.append(int.from_bytes(byte, "big"))
    while k <= 255 and not var:
        var = decripta(k, arr_bytes)
        k = k+1

def decripta(key, arr_bytes):
    out = []
    
    for byte in arr_bytes:        
        out.append((byte-key) % 256);
        
    if esPNG(out[:8]):
        print("*exito: "+str(key)+" sí es la llave")
        archivo_salida = open("out/img_"+str(key)+".png", "wb")
        archivo_salida.write(bytearray(out))
        archivo_salida.close
        return True
    else:
        print("error: "+str(key)+" NO es la llave")
        return False
            
def esPNG(lista):
    return lista == [137,80,78,71,13,10,26,10] #números mágicos para png

if __name__ == "__main__":
    main()
