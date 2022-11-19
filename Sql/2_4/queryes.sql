--- Попробуйте вывести не просто самую высокую зарплату во всей команде, а вывести именно фамилию сотрудника с самой высокой зарплатой.

select name, salarу  from workers ORDER BY salarу desc limit 1;

--- Попробуйте вывести фамилии сотрудников в алфавитном порядке

select left(name, strpos(name, ' ') - 1)  from workers ORDER BY name ;

--- Рассчитайте средний стаж для каждого уровня сотрудников

SELECT "level", AVG(AGE(CURRENT_DATE, start_work_date))  AS EXPERIENCE FROM workers group by "level" ORDER by "level" ;

--- Выведите фамилию сотрудника и название отдела, в котором он работает

select workers.name, departments."name"  from workers 
LEFT JOIN departments ON
workers.id_department = departments.id;

--- Выведите название отдела и фамилию сотрудника с самой высокой зарплатой в данном отделе и саму зарплату также.

WITH t1 AS (select e1.name, e1.salarу , e1.id_department
from workers e1
where e1.salarу =
  (select max(e.salarу) as maxsalary --, e. department_id
     from workers e 
     where e.id_department = e1.id_department 
   group by e.id_department
   )
)
select DISTINCT ON (departments.name) departments.name, t1.name , t1.salarу from t1 
JOIN departments ON departments.id = t1.id_department;
 
--- Выведите название отдела, сотрудники которого получат наибольшую премию по итогам года. 
--- Как рассчитать премию можно узнать в последнем задании предыдущей домашней работы

WITH t1 as (
select name, id_department, ratio from workers
where ratio = (select max(ratio) from workers))
select departments.name from t1
LEFT JOIN departments ON
t1.id_department = departments.id;

--- *Проиндексируйте зарплаты сотрудников с учетом коэффициента премии. 
--- Для сотрудников с коэффициентом премии больше 1.2 – размер индексации составит 20%, для сотрудников с коэффициентом премии от 1 до 1.2 размер индексации составит 10%. 
--- Для всех остальных сотрудников индексация не предусмотрена.

--- создадим новое поле для новой зарплаты

ALTER TABLE new_salry add column ratio type float8 ;
--- заполним новой зарплатой

update workers 
 set new_salary  = case 
    when ratio > 1.2 then salarу * 1.2
       when (ratio >= 1) and (ratio <= 1.2)   then salarу * 1.1
       else salarу
    end

-- 
--По итогам индексации отдел финансов хочет получить следующий отчет: 
--вам необходимо на уровень каждого отдела вывести следующую информацию:
--i.    Название отдела
--ii.   Фамилию руководителя
--iii.  Количество сотрудников
--iv.   Средний стаж
--v.    Средний уровень зарплаты
--vi.   Количество сотрудников уровня junior
--vii.  Количество сотрудников уровня middle
--viii. Количество сотрудников уровня senior
--ix.   Количество сотрудников уровня lead
--x.    Общий размер оплаты труда всех сотрудников до индексации
--xi.   Общий размер оплаты труда всех сотрудников после индексации
--xii.  Общее количество оценок А
--xiii. Общее количество оценок B
--xiv.  Общее количество оценок C
--xv.   Общее количество оценок D
--xvi.  Общее количество оценок Е
--xvii. Средний показатель коэффициента премии
--xviii.Общий размер премии.
--xix.  Общую сумму зарплат(+ премии) до индексации
--xx.   Общую сумму зарплат(+ премии) после индексации(премии не индексируются)
--xxi.  Разницу в % между предыдущими двумя суммами(первая/вторая)

select w."name", w."level",new_salary,salarу , (new_salary - salarу) as premia
from workers w ;

select m.worker 
from marks m 
group by m.worker;

with t1 as (
	select w.id_department, 
		round(avg(w.salarу)) as avg_salary , 
		AVG(AGE(CURRENT_DATE, start_work_date))  AS avg_exp ,
		Count( CASE WHEN  w."level"=1 THEN 1 end ) as junior,
		Count( CASE WHEN  w."level"=2 THEN 1 end ) as midle,
 		Count( CASE WHEN  w."level"=3 THEN 1 end ) as senior,
 		Count( CASE WHEN  w."level"=4 THEN 1 end ) as lead,
 		sum(salarу) as before_ind , sum(new_salary) as after_ind, 
 		round(avg(ratio),2) as  avg_ratio,
 		sum( new_salary - salarу) as sum_premia
	from workers w 
	group by id_department),
	t2 as (
	select m.worker
		,sum( CASE WHEN m."name"='a' THEN 1 end ) as mark_a
		,sum( CASE WHEN m."name"='b' THEN 1 end ) as mark_b
		,sum( CASE WHEN m."name"='c' THEN 1 end ) as mark_c
		,sum( CASE WHEN m."name"='d' THEN 1 end ) as mark_d
		,sum( CASE WHEN m."name"='e' THEN 1 end ) as mark_e
		from marks m 
		group by m.worker),
	t3 as (
	select w2.id, w2.id_department, mark_a, mark_b, mark_c, mark_d, mark_e  from workers w2
	join t2 on t2.worker = w2.id
	)	
select d.id			--- id отдела
,d."name"			--- Название отдела
,d.fio_master 		--Фамилию руководителя
,d."count" 			--iii.  Количество сотрудников
,t1.avg_salary		--v.    Средний уровень зарплаты
,t1.avg_exp 		--iv.   Средний стаж
,t1.junior 			--vi.   Количество сотрудников уровня junior
,t1.midle 			---Количество сотрудников уровня middle
,t1.senior			--viii. Количество сотрудников уровня senior
,t1.lead  			--ix.   Количество сотрудников уровня lead
,before_ind			--x.    Общий размер оплаты труда всех сотрудников до индексации
,after_ind			--xi.   Общий размер оплаты труда всех сотрудников после индексации
,t3.mark_a 			--xii.  Общее количество оценок А
,t3.mark_b 			--xiii. Общее количество оценок B
,t3.mark_c 			--xiv.  Общее количество оценок C
,t3.mark_d 			--xv.   Общее количество оценок D
,t3.mark_e			--xvi.  Общее количество оценок Е
,t1.avg_ratio 		--xvii. Средний показатель коэффициента премии
,t1.sum_premia		--xviii.Общий размер премии.
,(before_ind + t1.sum_premia )  sal_prem_b		--xix.  Общую сумму зарплат(+ премии) до индексации
,(after_ind + t1.sum_premia )  sal_prem_a		--xx.   Общую сумму зарплат(+ премии) после индексации(премии не индексируются)
, round(( 100 * (( before_ind  - after_ind ) / (after_ind + t1.sum_premia )))) as raznica  --xxi.  Разницу в % между предыдущими двумя суммами(первая/вторая)
from departments d 
join t1 on t1.id_department = d.id
join t3 on t3.id_department = d.id
;
    
    
    
    
    
    
    
    