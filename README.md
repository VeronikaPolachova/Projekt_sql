# Projekt 1 - SQL

## Zadání projektu
Projekt zpracovává výzkumné otázky z oblasti dostupnosti základních potravin široké veřejnosti. Cílem projektu bylo zpracování dvou tabulek, sloužících jako datový podklad a zodpovězení pěti výzkumných otázek uvedených níže. 

## Výstup projektu

### Tabulky
**[Tabulka 1](https://github.com/VeronikaPolachova/Projekt_sql/blob/main/Project_SQL_PolachovaV_Table1.sql)** obsahuje informace o mzdách, přepočtených na plný úvazek, napříč odvětvími a cenách základních potravin v České republice mezi lety 2006 a 2018.

**[Tabulka 2](https://github.com/VeronikaPolachova/Projekt_sql/blob/main/Project_SQL_PolachovaV_Table2.sql)** obsahuje informace o ekonomických ukazatelích (populace, HDP, GINI) pro všechny evropské státy opět mezi lety 2006 a 2018.

Dál je přiložena sada **pěti SQL dotazů** generující datové sady odpovídající na výzkumné otázky.

### Odpovědi na výzkumné otázky

#### Otázka 1
**Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

Na základě [dat](https://github.com/VeronikaPolachova/Projekt_sql/blob/main/otazka1.sql) se dá zhodnotit, že celkově mzdy za celé sledované období, tedy mezi lety 2006 a 2018 ve všech odvětvích **průměrně vzrostly**. Nejhorším rokem, co se týče meziročních nárůstů mezd je rok **2013**, kdy mzdy meziročně **klesaly v celkem 11 odvětvích**. Nejčastěji meziročně klesaly mzdy v odvětví **Těžba a dobývání** a to konkrétně v letech 2009, 2013, 2014 a 2016.

#### Otázka 2
**Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

První dostupný zkoumaný rok byl rok 2006, kdy byla cena 1 litru mléka 14,4 Kč a cena za 1 kg chleba byla 16,1 Kč při průměrném platu 21165 Kč. Tyto hodnoty srovnáváme s cenami v roce 2018, kdy byla cena 1 litru mléka 19,8 Kč a cena za 1 kg chleba byla 24,2 Kč při průměrném platu 33091 Kč. 
Z [dat](https://github.com/VeronikaPolachova/Projekt_sql/blob/main/otazka2.sql) vyplývá, že tzv. index dostupnosti byl v roce **2006 1312 kg chleba nebo 1465 l mléka** za průměrnou výplatu. V roce **2018** se počty mírně navýšily a to tak, že za průměrnou výplatu bylo možné si pořídit **1365 kg chleba nebo 1669 l mléka.** 
V roce 2018 tak tedy bylo možné za průměrnou výplatu koupit **o 204 l mléka nebo 53 kg chleba víc**, než v roce 2006.

#### Otázka 3
**Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

Z uvedených [dat](https://github.com/VeronikaPolachova/Projekt_sql/blob/main/otazka3.sql) vyplývá, že nejpomaleji za období mezi lety 2006 a 2018 zdražoval **cukr krystalový**, který v průměru meziročně **zlevňoval o 1,92 %**. Naopak nejrychleji zdražující potravinou byly ve stejném období **papriky**, které průměrně **zdražovaly o 7,29 %** ročně. 

#### Otázka 4
**Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

Z uvedených dat v [tabulce](https://github.com/VeronikaPolachova/Projekt_sql/blob/main/otazka4.sql) vyplývá, že ani jeden rok nepřesáhl rozdíl mezi meziročním procentuálním nárůstem mezd a cen v ČR v období 2007 – 2018 hranici 10 %. Nejblíže tomu ale měl **rok 2009**, kdy **platy meziročně stouply o v průměru 3,07 %** a přitom **průměrné ceny potravin klesly o 6,81 %**, jejich rozdíl tedy činil **9,88 %**.

#### Otázka 5
**Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**

Z [dat](https://github.com/VeronikaPolachova/Projekt_sql/blob/main/otazka5.sql) vyplývá, že v letech **2007, 2015 a 2017** došlo k výraznějším meziročním nárůstům **HDP** **vyšším než 5 %**. V následujících letech **2008 a 2018** sice došlo k výraznějšímu meziročnímu **nárůstu mezd** na **7,69 resp. 7,70 %**, avšak v roce 2016, kdy by tedy podle očekávání měla průměrná mzda také výrazněji vzrůst, se tak nestalo. Nárůst mezd v roce **2016** byl **pouze 3,64 %**.
Průměrné **ceny potravin** výrazněji rostly častěji, a to i v letech, které nenásledovaly vyšší růst HDP. 
Na základě těchto dat se hypotéza přímé souvislosti růstu HDP, mezd a cen **nedá zcela potvrdit**. 



 
