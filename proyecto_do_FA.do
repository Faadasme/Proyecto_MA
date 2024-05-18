clear
capture log close
log using proyecto1.log, replace

use base.dta, clear
*generamos variables para educ female nchild nchild5 age


*Seleccionamos si es mayor o igual a 18 años
keep if age>=18

*keep civilians
*keep if popstat==1

*variable dummy mujer
gen mujer = 0
replace mujer = 1 if sex == 2 //cambiamos el valor a mujer igual a 1 si sex es igual a 2
drop if mujer == 9 //para eliminar observaciones sin respuesta (no se elimina ninguna)

* casada
gen married= (marst==1 | marst==2)
replace married=. if marst==9  /*get rid of NIU*/


*educación
*5 category education variable
gen educ_5cat=.
replace educ_5cat=1 if educ<72  /*less than HS degree: 72 is cutoff for pre-1992, 73 for 92+*/
replace educ_5cat=2 if educ==72 | educ==73 /*HS diploma or equiv*/
replace educ_5cat=3 if educ>73 & educ<110 /*some college: 110 is cutoff for pre-1992, 111 for 92+*/
replace educ_5cat=4 if educ==110 | educ==111  /*Bachelor's degree */
replace educ_5cat=5 if educ>111 & educ~=999  /*more than Bachelor's*/


* children
* gen num_kids= nchild
* replace num_kids=3 if num_kids>3
* use created cchlt18
gen num_kids= nchlt18
replace num_kids=3 if nchlt18>3

gen kids_lt_6= (yngch <6) 


*full year, full time, hours 35+, weeks 40+
gen FTFY=(fullpart==1 & (wkswork2>=4 & wkswork2~=9))

replace incwage = 0 if incwage == 9999999 | incwage == 9999998
replace incbus = 0 if incbus == 9999999 | incbus == 9999998
replace incfarm = 0 if incfarm == 9999999 | incfarm == 9999998

replace oincwage = 0 if oincwage == 9999999 | oincwage == 9999998
replace oincbus = 0 if oincbus == 9999999 | oincbus == 9999998
replace oincfarm = 0 if oincfarm == 9999999 | oincfarm == 9999998


rename incwage_cpiu_2010 salario
gen ln_salario_cpiu2010 = log(salario)


**********************

* Crea nueva variable 'hijos y asigna valor 0 a todos los casos
gen hijos = 0

* Cambiar el valor de 'hijos' a 1 cuando 'nchild' es mayor que 0
replace hijos = 1 if nchild > 0

* Crea nueva variable 'hijos_5' y asigna el valor 0 a todos los casos
gen hijos_5 = 0

* Cambia el valor de 'hijos_5' a 1 cuando 'nchlt5' es mayor que 0
replace hijos_5 = 1 if nchlt5 > 0

rename incwage_cpiu_2010 salario

