--- Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании
SELECT id, "name", start_work_date, AGE(CURRENT_DATE, start_work_date)  AS EXPERIENCE
FROM workers;

--- Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников
SELECT id, "name", start_work_date, AGE(CURRENT_DATE, start_work_date)  AS EXPERIENCE
FROM workers limit 3;

--- Уникальный номер сотрудников - водителей 
SELECT id, "name" FROM workers
where  permission = true;

--- Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E

select worker from marks where name in ('d','e');

 --- Выведите самую высокую зарплату в компании.
select max(salarу) from workers;

---  Выведите название самого крупного отдела
select name, count from departments ORDER BY count desc limit 1;

--- Выведите номера сотрудников от самых опытных до вновь прибывших

SELECT id, "name", start_work_date FROM workers  ORDER by start_work_date ;

---  Рассчитайте среднюю зарплату для каждого уровня сотрудников   
select worker_level.name, round(AVG(workers.salarу))  FROM workers 
join  worker_level on worker_level.id = workers."level" 
group by worker_level.name;

--- Добавьте столбец с информацией о коэффициенте годовой премии к основной таблице. 
--- Коэффициент рассчитывается по такой схеме: базовое значение коэффициента – 1, каждая оценка действует на коэффициент так:
--- Е – минус 20%  D – минус 10% С – без изменений B – плюс 10% A – плюс 20%

--- // 1. добвавим столбец 

ALTER TABLE workers add column ratio type NUMERIC(2,1);

----// заполним столбец
update  workers as  w
SET ratio = s.ratio
FROM (
with new_marks as (
select *,
	 CASE
           WHEN name = 'a' THEN 0.2
           WHEN name = 'b' THEN 0.1
           WHEN name = 'c' THEN 0
           WHEN name = 'd' THEN -0.1
           WHEN name = 'e' THEN -0.2
      END as m 
from marks )
select worker, (1 + sum( m)) as ratio from new_marks group by  worker
)  AS s
WHERE w.id = s.worker
;

select * from workers w ;


