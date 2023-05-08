#!/bin/sh

#
# Esta función exporta todas las variables en su archivo .env.dev como antes. 
#   Luego, utiliza un bucle for para iterar a través de todas las variables 
#   de entorno definidas en el shell actual (${!BASH_ENV[@]}) 
#   y evaluarlas nuevamente para resolver cualquier variable anidada. 
#   La sintaxis ${!var} devuelve el valor de la variable que está referenciando.
#
function eval_env_vars() {
  # Export all variables in .env file
  eval $(grep -v '^#' .env.dev | xargs -I {} echo export {})

  # Evaluate nested variables in a loop
  for var in "${!BASH_ENV[@]}"; do
    eval "export $var=${!var}"
  done
}