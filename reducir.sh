#!/bin/bash
# Versión 1.2
# VARIABLES Y FORMATOS
declare -a array_argumentos=("$@")
declare -i var_numero_argumentos=$#
col_yellow='\033[1;33m'
col_red='\033[31m'
nc='\033[0m'

printf "${col_yellow}Ejecutando script ...${nc}\n"

# COMPROBACIÓN DE LA INSTALACIÓN DEL SCRIPT
if [ ! -e "/usr/bin/reducir" ]; then
        printf "${col_red}No existe el enlace simbólico, así que lo creo.${nc}\n"
        sudo ln -s "$PWD/reducir.sh" /usr/bin/reducir
fi

# COMPROBACIÓN DE SI SE HAN INTRODUCIDO ARGUMENTOS
if [ $var_numero_argumentos = 0 ]; then
        printf "${col_red}No has introducido argumentos. Por ejemplo 'reducir reducido.pdf original.pdf'${nc}\n"
        exit 1
fi

# MINI DOCUMENTACIÓN SEGÚN EL NIVEL VE COMPRESIÓN DESEADO:
# dPDFSETTINGS=/screen (72 dpi, menor tamaño y peor calidad)
# dPDFSETTINGS=/ebook (150 dpi, calidad media)                 POR DEFECTO Y CON BUENOS RESULTADOS 
# dPDFSETTINGS=/printer (300 dpi, alta calidad)
# dPDFSETTINGS=/prepress (300 dpi, alta calidad preservando el color)
# dPDFSETTINGS=/default (casi idéntico a screen, pero con calidad ligeramente superior)


# EJECUTO LA ACCIÓN
echo gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${array_argumentos[0]}" "${array_argumentos[@]:1}"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${array_argumentos[0]}" "${array_argumentos[@]:1}"

printf "${col_yellow}Reducción aparentemente realizada${nc}\n"
ls "${array_argumentos[-1]}"
exit 0
