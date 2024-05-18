/*
***** PROYECTO MICROECONOMETRIA APLICADA *****

Grupo conformado por:
Francisca Adasme
Raúl Haltenhoff
Francisca Villegas
*/

*log using log_proyecto.log, replace

cap which estout
if (_rc) ssc install estout														// Paquete necesario para generar tablas en formato de Latex

* Cargando directorios de los participantes del grupo
if "`c(username)'" == " " {
	cd ""
}
else if "`c(username)'" == " " {
	cd ""
}
else if "`c(username)'" == "franc" {
	cd "C:\Users\franc\Documents\GitHub\Proyecto_MicroAplicada"
	
}

// Preparación base de datos 

use base.dta, clear

* Crea nueva variable 'mujer' y asigna el valor 0 a todos los casos
gen mujer = 0

* Cambia el valor de 'is_female' a 1 cuando 'sex' es igual a 2 (Female)
replace mujer = 1 if sex == 2

*Missing values 
*replace mujer = . if sex == 9

* Crea nueva variable 'hijos y asigna valor 0 a todos los casos
gen hijos = 0

* Cambiar el valor de 'hijos' a 1 cuando 'nchild' es mayor que 0
replace hijos = 1 if nchild > 0

* Crea nueva variable 'hijos_5' y asigna el valor 0 a todos los casos
gen hijos_5 = 0

* Cambia el valor de 'hijos_5' a 1 cuando 'nchlt5' es mayor que 0
replace hijos_5 = 1 if nchlt5 > 0

rename incwage_cpiu_2010 salario

save "baseproyecto.dta", replace

** Gráficos y Estadísticas descriptivas

* Descriptivas Básicas
sum salario, detail

* Histogramas
histogram salario, bin(20) normal

* Boxplots por nivel educativo
graph box salario, over(educ)

* Scatter plot salario vs. nivel educativo
scatter salario hijos
graph export "salario_hijos.pdf", replace

scatter salario hijos_5
graph export "salario_hijos5.pdf", replace

scatter salario educ
graph export "salario_educ.pdf", replace

scatter salario mujer 
graph export "salario_mujer.pdf", replace

* ANOVA: permite evaluar si hay una diferencia significativa en los salarios medios entre hombres y mujeres.
anova salario educ mujer hijos hijos_5




** Regresión MCO

eststo: reg salario educ mujer hijos hijos_5, r
esttab using "regMCO.tex" , replace







*log close
*translate log_proyecto.log log_proyecto.pdf, translator(smcl2pdf)

