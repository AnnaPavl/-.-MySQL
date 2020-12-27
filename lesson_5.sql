/*Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»*/

/* 1.Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.*/

UPDATE users SET updated_at = NOW();
UPDATE users SET created_at = NOW();

/* 2.Таблица users была неудачно спроектирована. 
 * Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
 * Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/

ALTER TABLE users ADD new_created_at DATETIME;
ALTER TABLE users ADD new_updated_at DATETIME;
UPDATE users SET new_created_at = STR_TO_DATE(created_at, '%d.%m.%Y %l:%i');
UPDATE users SET new_updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %l:%i');
ALTER TABLE users DROP created_at, CHANGE new_created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users DROP updated_at, CHANGE new_updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


/* 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
 *0, если товар закончился и выше нуля, если на складе имеются запасы. 
 *Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 *Однако нулевые запасы должны выводиться в конце, после всех записей.*/

SELECT value FROM storehouses_products ORDER BY CASE WHEN value = 0 then 2 else 1 end, value;

/* 4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
 *Месяцы заданы в виде списка английских названий (may, august)*/

select name, birthday_at from users where DATE_FORMAT (birthday_at, "%M") in ('may', 'august');

/* 5. Из таблицы catalogs извлекаются записи при помощи запроса. 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2) order by case when id = 5 then 0 else 1 end, id;

/*Практическое задание теме «Агрегация данных»*/

/* 1. Подсчитайте средний возраст пользователей в таблице users.*/
 
SELECT avg(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) FROM users;

/* 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

select count(*), DATE_FORMAT (birthday_at, "%a") from users group by DATE_FORMAT (birthday_at, "%a");

/* 3. Подсчитайте произведение чисел в столбце таблицы.*/

select exp(sum(ln(value))) from tab;


