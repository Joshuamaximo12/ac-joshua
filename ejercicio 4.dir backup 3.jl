{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "b2fcb362",
   "metadata": {},
   "source": [
    "# Ejercicio 4: Derivación e integración"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7d8fdf58",
   "metadata": {},
   "source": [
    "## Derivación\n",
    "1. Escribe una función que reciba como argumento otra función y un número real y que evalúe\n",
    "la derivada de esa función en el punto dado sin utilizar ninguna librería externa de Julia,\n",
    "el resultado debe ser otro número real. Prueba tu implementación con los siguientes valores:\n",
    "f(x) = cos(x) en el punto x = 2, el resultado debería aproximarse a −0.909297... (3 puntos).\n",
    "\n",
    "2. Añade un parámetro n a la función anterior que sirva para mejorar la precisión de cálculo,\n",
    "¿qué valor debe tomar n para que el cálculo de la derivada anterior sea exacta en al menos 5\n",
    "dígitos? Justifica tu respuesta con código (1 punto).\n",
    "\n",
    "3. Añade otra condición a la función del punto 1 que imprima un mensaje de error cuando la\n",
    "función no es derivable en ese punto. Prueba tu código con la función f(x) = log(x) en los\n",
    "puntos x = 0 y x = 1 (1 punto).\n",
    "\n",
    "4. Desarrolla un código que visualice la gráfica de una función junto con la recta tangente a un\n",
    "punto en su dominio, incluye en tu visualización una leyenda que muestre la pendiente de la\n",
    "recta tangente. Prueba tu implementación con las funciones descritas en los puntos anteriores\n",
    "(2 puntos).\n",
    "\n",
    "5. (Bonus). Realiza una animación que muestre el desplazamiento de la recta tangente a una\n",
    "función a lo largo de un intervalo, puedes usar como referencia el siguiente video:\n",
    "\n",
    "Aplica tu código a la función $f(x) = 4 − x{^2}$ en el intervalo [−2, 2] (2 puntos).\n",
    "\n",
    "## Integración\n",
    "\n",
    "1. Escribe la función ‘integrar‘ con las siguientes características:\n",
    "function integrar(func, a, b, n)\n",
    "Evalúa la integral de una función en un intervalo dado con cierta precisión.\n",
    "\n",
    "#### Parámetros\n",
    "-------\n",
    "\n",
    "func : function\n",
    "Una función de julia que toma floats como valores\n",
    "a : float\n",
    "El limite inferior a integrar\n",
    "b : float\n",
    "El limite superior a integrar\n",
    "n : integer\n",
    "La precisión del cálculo\n",
    "\n",
    "#### Returns\n",
    "-------\n",
    "\n",
    "float\n",
    "El resultado de integrar la función ’func’ en el intervalo [a, b]\n",
    "con precisión n.\n",
    "\n",
    "Prueba tu implementación con los siguientes valores: f(x) = cos(x) en el intervalo [0, π], el\n",
    "resultado debería aproximarse a 0.\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f7ce40f5",
   "metadata": {},
   "source": [
    "#### Inciso 1:\n",
    "Escribe una función que reciba como argumento otra función y un número real y que evalúe la derivada de esa función en el punto dado sin utilizar ninguna librería externa de Julia, el resultado debe ser otro número real. Prueba tu implementación con los siguientes valores: f(x) = cos(x) en el punto x = 2, el resultado debería aproximarse a −0.909297..."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 71,
   "id": "014f716a",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "derivada (generic function with 1 method)"
      ]
     },
     "execution_count": 71,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# Partimos de la definición de la derivada en un punto: f'(x)=lim(h→0)[f(x+h)-f(x)]/h. A partir de esta definción, se puede elegir\n",
    "# un valor pequeño de h que nos sirva de aproximación. Por otra parte, para declarar la función que recibe como argumento otra\n",
    "# función y un número real se emplea la sintaxis \"function nombre()\". El primer argumento es la función f, que en cuestión \n",
    "# es cos(x) a la cual se le quiere obtener su derivada y como argumento dos el valor real o de tipo Float 64 que en este caso \n",
    "# es x=2.\n",
    "\n",
    "function derivada(f::Function, x::Float64)\n",
    "    h = 0.001\n",
    "    return (f(x+h) - f(x)) / h\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 73,
   "id": "3d4d3e01",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "-0.9090892018750463"
      ]
     },
     "execution_count": 73,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# Para probar la función con la función f(x) = cos(x) en el punto x=2, podemos hacer lo siguiente:\n",
    "\n",
    "f(x) = cos(x)\n",
    "x = 2.0\n",
    "derivada(f, x)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1ac4623c",
   "metadata": {},
   "source": [
    "#### Inciso 2:\n",
    "Añade un parámetro n a la función anterior que sirva para mejorar la precisión de cálculo,\n",
    "¿qué valor debe tomar n para que el cálculo de la derivada anterior sea exacta en al menos 5\n",
    "dígitos? Justifica tu respuesta con código (1 punto)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 118,
   "id": "435bccde",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "derivada_aproximada (generic function with 2 methods)"
      ]
     },
     "execution_count": 118,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# En primer lugar vamos a partir de la estructura del ejercicio anterior, en la que teníamos una función con dos parámetros\n",
    "# la función f(x)=cos(x), y el valor de x=2. Pero ahora se requiere de un tercer parámetro \"n\" el cual dependiendo de su valor,\n",
    "# será la aproximación que vamos a obtner de la derivada, sin embargo, para incluir este tercer parámetro el cual debe tomar \n",
    "# valores enteros positivos (Int64) se empleará el método de la \"Extrapolación de Richardson\", el cual utiliza dos estimaciones\n",
    "# de la derivada para calcular una tercera aproximación más exacta, la cual está dada por la fórmula:\n",
    "# D≈(4*D(h2)-D*(h1))/3 donde D es la derivada en cuestión evaluada en un cierto tamaño de h2 y h1 respectivamente.\n",
    "\n",
    "# Entonces la idea es calcular la derivada usando dos diferentes tamaños, \"h\" y \"h/2\" y luego usar estos dos valores para estimar \n",
    "# el valor con mayor precisión de la derivada.\n",
    "\n",
    "\n",
    "function derivada_aproximada(f, x::Real, n::Int=5)\n",
    "    h = 0.000001\n",
    "    D1 = (f(x + h) - f(x)) / h  #Se declara D1 a partir únicamente de la definción de la derivada\n",
    "    for i in 1:n                # n corre con valores desde 1 hasta n, hasta conseguir una estimación de 5 dígitos\n",
    "        h /= 2\n",
    "        D2 = (f(x + h) - f(x)) / h  #Se declara a D2, utilizando también la definción de la derivada, pero con un valor de \"h/2\"\n",
    "        D3 = (4D2 - D1)/3       # Finalmente D3 es la fórmula de la aproximación de Richardson.\n",
    "        \n",
    "        return D3\n",
    "    end\n",
    "end\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "714f550a",
   "metadata": {},
   "source": [
    "Por otra parte, para encontrar el valor mínimo n necesario para que el cálculo de la derivada sea exacta en al menos 5 dígitos, se puede hacer la estimación utilizando la siguiente fórmula:\n",
    "\n",
    "`error=O(h^n)`\n",
    "\n",
    "donde O es la notación de orden, que indica cómo se comporta el error en función de h. En este caso, se sabe que h = 0.000001, y se quiere encontrar n tal que el error sea menor que 0.00001 (5 dígitos de precisión).\n",
    "\n",
    "Entonces, se puede despejar n de la siguiente manera:\n",
    "\n",
    "error = O(h^n) \n",
    "⇒ 0.00001 = O(0.0001^n)\n",
    "⇒ log10(0.00001) = n * log10(0.0001)\n",
    "⇒ n = log10(0.00001) / log10(0.0001)\n",
    "⇒ n ≈ 5.0\n",
    "\n",
    "Por lo tanto, se necesita un valor mínimo de n igual a 5 para que el cálculo de la derivada sea exacta en al menos 5 dígitos."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 120,
   "id": "c5112f05",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "-0.9092973575578848"
      ]
     },
     "execution_count": 120,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# Con el resultado anterior, se puede observar que el valor de n=5 se puede incluir dentro del arreglo de la función \n",
    "# \"derivada aproximada\" para obtner un valor estimado de al menos 5 dígitos.\n",
    "\n",
    "f(x) = cos(x)\n",
    "derivada_aproximada(f, 2, 5)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1dca5efb",
   "metadata": {},
   "source": [
    "#### Inciso 3:\n",
    "\n",
    "Añade otra condición a la función del punto 1 que imprima un mensaje de error cuando la\n",
    "función no es derivable en ese punto. Prueba tu código con la función f(x) = log(x) en los\n",
    "puntos x = 0 y x = 1."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 211,
   "id": "a3787c80",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "derivada1 (generic function with 1 method)"
      ]
     },
     "execution_count": 211,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# Se requiere utilizar la misma estructura que en el inciso 1, con la diferencia que la función es llamada \"derivada 1\" para evitar\n",
    "# problemas de reasiganción de valor de la función ya que ahora la función f1(x)=log(x).\n",
    "\n",
    "function derivada1(f1::Function, x::Float64)\n",
    "    h = 0.0001\n",
    "    return (f1(x+h) - f1(x)) / h\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 238,
   "id": "871d5ff6",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "¡error!\n"
     ]
    }
   ],
   "source": [
    "# Para añadir la la condición de un mensaje de error, se emplean condicionales, en este caso \"if\", si x=0.0, entonces para \n",
    "# obtener un mensaje de error debido a que no se puede evaluar el valor de x=0.0 en la derivada, se emplea \"println\" y dentro \n",
    "# de los paréntesis el mensaje.\n",
    "\n",
    "f1(x) = log(x)\n",
    "    \n",
    "if x == 0.0\n",
    "    \n",
    "    derivada1(f1, x) \n",
    "    \n",
    "else  \n",
    "    println(\"¡error!\")    \n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "a4030d73",
   "metadata": {
    "scrolled": true
   },
   "outputs": [],
   "source": [
    "#Por otra parte la derivada de log(x) está bien definida cuando se evalua en x=1.0, por lo que para notar que sí se puede evaluar\n",
    "# también se emplea una condicional \"if\", asi como \"println\" con el mensaje correspondiente de que sí esta definida la \n",
    "# la derivada para x=1.\n",
    "\n",
    "f1(x) = log(x)\n",
    "if x == 1.0\n",
    " derivada1(f1, x) \n",
    "    \n",
    "    println(\"¡la derivada está bien definida para x igual a 1!\")\n",
    "    \n",
    "end\n",
    "f1(x) = log(x)\n",
    "x = 1.0\n",
    "derivada1(f1, x)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "2595d26a",
   "metadata": {},
   "source": [
    "## Integración\n",
    "\n",
    "Ejercicio 1"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "0022bb9c",
   "metadata": {},
   "outputs": [],
   "source": [
    "2+2"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Julia 1.8.5",
   "language": "julia",
   "name": "julia-1.8"
  },
  "language_info": {
   "file_extension": ".jl",
   "mimetype": "application/julia",
   "name": "julia",
   "version": "1.8.5"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
