
CREATE TABLE departments (
	id serial4 NOT NULL,
	"name" varchar(40) NULL,
	fio_master varchar(40) NULL,
	count int4 NULL,
	CONSTRAINT departments_pkey PRIMARY KEY (id)
);

INSERT INTO public.departments ("name",fio_master,count) VALUES
	 ('Бухгалтерский','Павлова Лариса Максимовна',3),
	 ('IT отдел','Бодалян Оксана Геннадиевна',2),
	 ('АХЧ','Самохвалова Наталия Алексеевна',1),
	 ('Интеллектуального анализа данных','Леденева Софья Ильинична',2);


CREATE TABLE worker_level (
	id serial4 NOT NULL,
	"name" varchar(10) NULL,
	CONSTRAINT worker_level_pkey PRIMARY KEY (id)
);

INSERT INTO public.worker_level ("name") VALUES
	 ('Junior'),
	 ('Midle'),
	 ('Senior'),
	 ('Lead');
	

CREATE TABLE workers (
	id serial4 NOT NULL,
	"name" varchar(40) NULL,
	born_date date NULL,
	start_work_date date NULL,
	"position" varchar(40) NULL,
	"level" int4 NULL,
	salarу float8 NULL,
	id_department int4 NULL,
	"permission" bool NULL,
	CONSTRAINT workers_pkey PRIMARY KEY (id)
);

ALTER TABLE public.workers ADD CONSTRAINT workers_id_department_fkey FOREIGN KEY (id_department) REFERENCES departments(id);
ALTER TABLE public.workers ADD CONSTRAINT workers_level_fkey FOREIGN KEY ("level") REFERENCES worker_level(id);



INSERT INTO public.workers ("name",born_date,start_work_date,"position","level",salarу,id_department,"permission") VALUES
	 ('Самохвалова Наталия Алексеевна','2017-03-14','2017-04-30','начальник',1,12000.0,3,true),
	 ('Павлова Лариса Максимовна','2017-03-14','2017-04-30','начальник',2,14000.0,1,true),
	 ('Баршев Андрей Николаевич','2017-03-14','2017-04-30','бухгалтер',3,15000.0,1,true),
	 ('Герасимов Александр Платонович','2017-03-14','2017-04-30','бухгалтер',4,15000.0,1,false),
	 ('Оверченков Захар Михайлович','2017-03-14','2017-04-30','инженер',1,16000.0,2,false),
	 ('Бодалян Оксана Геннадиевна','2017-03-14','2017-04-30','начальник',2,17000.0,2,false),
	 ('Леденева Софья Ильинична','1984-03-14','2022-04-30','программист',1,15000.0,4,true),
	 ('Ватолкина Светлана Геннадиевна','1983-03-14','2017-04-30','программист',2,17000.0,4,true),
	 ('Гришин Пантелеймон Евсеевич','1984-05-14','2021-03-12','программист',4,17000.0,4,true);

	
CREATE TABLE marks (
	id serial4 NOT NULL,
	"name" varchar(1) NULL,
	"date" date NULL,
	worker int4 NULL,
	CONSTRAINT marks_pkey PRIMARY KEY (id)
);

ALTER TABLE public.marks ADD CONSTRAINT marks_worker_fkey FOREIGN KEY (worker) REFERENCES workers(id);

INSERT INTO public.marks ("name","date",worker) VALUES
	 ('a','2022-03-01',7),
	 ('a','2022-03-01',8),
	 ('b','2022-03-01',9),
	 ('b','2022-03-01',10),
	 ('a','2022-12-01',7),
	 ('e','2022-12-01',8),
	 ('d','2022-12-01',9),
	 ('c','2022-12-01',10),
	 ('b','2022-12-01',11),
	 ('a','2022-12-01',12);
INSERT INTO public.marks ("name","date",worker) VALUES
	 ('b','2022-12-01',13),
	 ('a','2022-12-01',14),
	 ('a','2022-09-01',7),
	 ('a','2022-09-01',8),
	 ('b','2022-09-01',9),
	 ('e','2022-09-01',10),
	 ('d','2022-09-01',11),
	 ('b','2022-09-01',12),
	 ('a','2022-09-01',13),
	 ('c','2022-09-01',14);
INSERT INTO public.marks ("name","date",worker) VALUES
	 ('c','2022-06-01',7),
	 ('a','2022-06-01',8),
	 ('e','2022-06-01',9),
	 ('a','2022-06-01',10),
	 ('d','2022-06-01',11),
	 ('d','2022-06-01',12),
	 ('b','2022-06-01',13),
	 ('a','2022-06-01',14),
	 ('c','2022-03-01',11),
	 ('c','2022-03-01',12);
INSERT INTO public.marks ("name","date",worker) VALUES
	 ('d','2022-03-01',13),
	 ('a','2022-03-01',14),
	 ('a','2022-03-01',15),
	 ('e','2022-06-01',15),
	 ('d','2022-09-01',15),
	 ('a','2022-12-01',15);
