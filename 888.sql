
-- Представляю Вашему вниманию БД посвященную программе лояльности клиентов в рамках сети магазнинов розничной торговли электронной техники.
-- БД позволяет отследить количество выданных карт лояльности, начисленных/спианных ББ, проанализировать связь между активностью покупателей и бонусами, которые начисляются клиентам за покупки/в честь
-- праздников и т.д. Можно стимулировать клиентов на покупки, тем самым повышая прибыль компании. В целом данная БД является отличным инструментом для анализа
-- клиентского поведения.


-- Создание БД

DROP DATABASE IF EXISTS bb;
create database bb;
use bb;

-- Создание таблиц с первичными ключами

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  user_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  birthday DATE NOT NULL COMMENT "Дата рождения",
  gender INT UNSIGNED NOT NULL COMMENT "Пол",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  marital_status INT UNSIGNED NOT NULL COMMENT "Семейное положение",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Ссылка на пользователя", 
  card_num INT UNSIGNED NOT NULL UNIQUE COMMENT "Ссылка на номер бонусной карты",
  active INT NOT NULL COMMENT "Баланс активного счёта",
  reserve INT NOT NULL COMMENT "Баланс резервного счёта",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 


DROP TABLE IF EXISTS cards;
CREATE TABLE cards (
card_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
card_num INT UNSIGNED NOT NULL UNIQUE COMMENT "Номер бонусной карты",
card_status INT UNSIGNED NOT NULL COMMENT "Статус карты",
card_type INT UNSIGNED NOT NULL COMMENT "Тип карты",
store VARCHAR(30) NOT NULL COMMENT "Номер магазина выдачи карты",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Карты"; 


DROP TABLE IF EXISTS card_types;
CREATE TABLE card_types (
type_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
description VARCHAR(30) NOT NULL COMMENT "Тип карты",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы карт"; 

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
transaction_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
card_num INT UNSIGNED NOT NULL COMMENT "Номер бонусной карты",
store_num VARCHAR(30) NOT NULL COMMENT "Номер магазина покупки",
write_off INT UNSIGNED NOT NULL COMMENT "Кол-во списанных бонусов",
accrual INT UNSIGNED NOT NULL COMMENT "Кол-во начисленных бонусов",
cheque_num INT UNSIGNED NOT NULL UNIQUE COMMENT "Ссылка на номер чека покупки",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "История транзакций"; 

DROP TABLE IF EXISTS stores;
CREATE TABLE stores (
store_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
store_num VARCHAR(30) NOT NULL UNIQUE COMMENT "Номер магазина",
address VARCHAR(100) NOT NULL UNIQUE COMMENT "Адрес магазина",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Магазины";


DROP TABLE IF EXISTS card_status;
CREATE TABLE card_status (
card_status_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
description VARCHAR(100) NOT NULL UNIQUE COMMENT "Статус карты",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Статусы карт";

DROP TABLE IF EXISTS cheque;
CREATE TABLE cheque (
cheque_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
cheque_num INT UNSIGNED NOT NULL UNIQUE COMMENT "Номер чека покупки",
purchase VARCHAR(100) NOT NULL COMMENT "Наименование товара",
cheque_date DATE NOT NULL COMMENT "Дата совершения покупки",
total DECIMAL (12,2) NOT NULL COMMENT "Сумма покупки в валюте",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Чеки";


DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts (
contact_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
user_id INT UNSIGNED NOT NULL UNIQUE COMMENT "Ссылка на пользователя", 
email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Контактная информация";

DROP TABLE IF EXISTS gender;
CREATE TABLE gender (
gender_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
description VARCHAR(100) NOT NULL UNIQUE COMMENT "Пол",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Контактная информация";


DROP TABLE IF EXISTS marital_status;
CREATE TABLE marital_status (
marital_status_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
description VARCHAR(100) NOT NULL UNIQUE COMMENT "Статус семейного положения",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Семейное положение";


DROP TABLE IF EXISTS purch;
CREATE TABLE purch (
purch_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Номенклатурный номер товара",
description VARCHAR(100) NOT NULL UNIQUE COMMENT "Наименование товара",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Товарный справочник";

-- Создание внешних ключей

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
ALTER TABLE cards ADD CONSTRAINT cards_card_status_fk FOREIGN KEY (card_status) REFERENCES card_status(card_status_id);
ALTER TABLE cards ADD CONSTRAINT cards_card_type_fk FOREIGN KEY (card_type) REFERENCES card_types(type_id);
ALTER TABLE cards ADD CONSTRAINT cards_store_fk FOREIGN KEY (store) REFERENCES stores(store_num);
ALTER TABLE contacts ADD CONSTRAINT contacts_user_id_fk FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
ALTER TABLE profiles ADD CONSTRAINT profiles_card_num_fk FOREIGN KEY (card_num) REFERENCES cards(card_num);
ALTER TABLE transactions ADD CONSTRAINT transactions_card_num_fk FOREIGN KEY (card_num) REFERENCES cards(card_num);
ALTER TABLE transactions ADD CONSTRAINT transactions_store_num_fk FOREIGN KEY (store_num) REFERENCES stores(store_num);
ALTER TABLE transactions ADD CONSTRAINT transactions_cheque_num_fk FOREIGN KEY (cheque_num) REFERENCES cheque(cheque_num);
ALTER TABLE users ADD CONSTRAINT users_gender_fk FOREIGN KEY (gender) REFERENCES gender(gender_id);
ALTER TABLE users ADD CONSTRAINT users_marital_status_fk FOREIGN KEY (marital_status) REFERENCES marital_status(marital_status_id);
ALTER TABLE cheque ADD CONSTRAINT cheque_purchase_fk FOREIGN KEY (purchase) REFERENCES purch(description);

-- Создание индексов


create index cheque_ch_date_idx on cheque(cheque_date);
create index cheque_purchase_idx on cheque(purchase);
create unique index contacts_mail_phone_idx on contacts(email, phone);
create index users_first_last_idx on users(first_name, last_name);
create index users_city_idx on users(city);


-- Скрипты наполнения БД данными

INSERT INTO card_status (description) VALUES ('Активна'), ('Отказ от участия'), ('Заблокирована'), ('Проверка СБ'), ('Выдана');
INSERT INTO card_types (description) VALUES ('Пластиковая'), ('Электронная'), ('Подарочная'), ('Призовая');
INSERT INTO gender (description) VALUES ('Male'), ('Female'), ('Non-binary'), ('Androgyne'), ('Bigender'), ('Neither'), ('Pangender'), ('Trans');
INSERT INTO marital_status (description) VALUES ('Married'), ('Widowed'), ('Divorced'), ('Single');
INSERT INTO purch (description) VALUES ('Пылесос'), ('Холодильник'), ('Стиральная машина'), ('Телевизор'), ('Микроволновка'), ('Духовка'), ('Вытяжка'), ('Утюг');


CREATE OR REPLACE VIEW random_data AS
WITH RECURSIVE sequence AS (
  SELECT 1 AS number
  UNION ALL
  SELECT number + 1 AS value FROM sequence WHERE sequence.number < 500
)
SELECT NUMBER,
CONCAT(SUBSTRING(MD5(UUID()), 1, 5 + rand()*10) , '@mail.com') email,
concat('+', FLOOR(rand() * 10), ' ', FLOOR(rand() * 1000), ' ', FLOOR(rand() * 1000), ' ', FLOOR(rand() * 10000)) phone,
concat('77', number + 254100) cards_numbers,
number + 7400 cheque_numbers,
concat('A', number+1) store_number,
round(RAND()*(36323), 2) total,
concat(FLOOR(RAND()*2513)) active_write_off,
concat(FLOOR(RAND()*251)) reserve_accrual,
REGEXP_REPLACE(MAKE_SET(rand()*9999999999999999,
'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
), ',', '') purchase_address,
REGEXP_REPLACE(MAKE_SET(rand()*9999,
'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
), ',', '') first_name_city_country,
REGEXP_REPLACE(MAKE_SET(rand()*9999999,
'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
), ',', '') last_name,
date_add('2021-01-27', INTERVAL - rand() * 365 day) cheque_date, 
date_add('1970-01-27', INTERVAL  rand() * 10800 day) birthday  -- Следим за тем, чтобы участнику программы лояльности исполнилось 18 лет
FROM sequence;


INSERT INTO users (
  first_name, last_name, birthday, gender, city, country, marital_status)
SELECT
  first_name_city_country, last_name, birthday, (select gender_id FROM gender ORDER BY rand() LIMIT 1),
  (select first_name_city_country FROM random_data ORDER BY rand() LIMIT 1),
  (select first_name_city_country FROM random_data ORDER BY rand() LIMIT 1),
  (select marital_status_id FROM marital_status ORDER BY rand() LIMIT 1)
FROM random_data
WHERE number BETWEEN 1 AND 250;



INSERT INTO stores (
  store_num, address)
  select
 store_number, purchase_address
FROM random_data
WHERE number 
BETWEEN 100 AND 130;

INSERT INTO stores (store_num, address) VALUES ('INTERNET', 'INTERNET_SHOP'); -- Отдельно добавляем площадку интернет магазина


INSERT INTO cards (
  card_num, card_status, card_type, store)
SELECT
  cards_numbers,
  (select card_status_id FROM card_status ORDER BY rand() LIMIT 1),
  (select type_id FROM card_types ORDER BY rand() LIMIT 1),
  (select store_num FROM stores ORDER BY rand() LIMIT 1)
FROM random_data
WHERE number BETWEEN 1 AND 250;


INSERT INTO profiles (
  card_num, active, reserve)
SELECT
  card_num, 
  (select active_write_off from random_data ORDER BY rand() LIMIT 1),
  (select reserve_accrual from random_data ORDER BY rand() LIMIT 1)
FROM cards;

UPDATE profiles as p left join cards as c on p.card_num = c.card_num SET active = 0 where c.card_status = 5; -- У неактивированных карт в поле 'Активный счёт' прописываем  - 0
UPDATE profiles as p left join cards as c on p.card_num = c.card_num SET reserve = 0 where c.card_status = 5; -- У неактивированных карт в поле 'Резервный счёт' прописываем  - 0


INSERT INTO cheque (
  cheque_num, purchase, cheque_date, total)
SELECT
cheque_numbers, (select description from purch ORDER BY rand() LIMIT 1), cheque_date, total
FROM random_data
WHERE number BETWEEN 1 AND 450;

INSERT INTO transactions (
card_num, store_num, write_off, accrual, cheque_num)
SELECT
(select c from (select card_num as c from profiles where active > 0) as n ORDER BY rand() LIMIT 1), -- Не создаём транзакций по неактивированным картам
(select store_num FROM stores ORDER BY rand() LIMIT 1),
(select active_write_off FROM random_data ORDER BY rand() LIMIT 1),
(select reserve_accrual FROM random_data ORDER BY rand() LIMIT 1),
cheque_num from cheque;


INSERT INTO contacts (
user_id, email, phone)
SELECT
user_id,
(select email FROM random_data ORDER BY rand() LIMIT 1),
(select phone FROM random_data ORDER BY rand() LIMIT 1)
from users;

-- скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы):

-- вложенные таблицы активно использовала при наполнении БД данными

-- Количество проданных товаров в разрезе наименования.
select count(purchase), purchase from cheque group by purchase;


-- Узнаем спрос на товары в разрезе магазинов.
select t.store_num, c.purchase, count(c.purchase) from cheque c left join transactions t on t.cheque_num = c.cheque_num group by c.purchase, t.store_num order by store_num;

-- 10 участников программы лояльности, которые совершили больше всего покупок, можем на день рождения начислить им подарочные бонусы в качестве благодарности,
-- уведомим их об этом посредством коммуникации по SMS/email.
select count(t.card_num) as количество_покупок, t.card_num, u.first_name, u.birthday, co.email, co.phone from transactions t left join profiles p on p.card_num = t.card_num 
left join users u on u.user_id = p.user_id left join contacts co on co.user_id = u.user_id group by t.card_num order by количество_покупок desc limit 10; 


-- Узнаем общее количество списанных и начисленных бонусных баллов в разрезе магазинов.
select store_num, sum(write_off), sum(accrual) from transactions group by store_num;


-- Количество выданных карт лояльностив разрезе магазинов
select count(card_num), store from cards group by store order by count(card_num) desc;


-- Представление, содержащее только карты в статусе "Активна":
CREATE OR REPLACE VIEW active_cards (номер_карты, тип_карты, магазин_выдачи) AS
SELECT c.card_num, cc.description, store
FROM cards c left join card_types cc on c.card_type = cc.type_id
WHERE card_status = 1;

-- 5 клиентов с самым большим количеством бонусных баллов на активном счёте.
-- Может клиенты забыли о своих бонусах? Мы можем отправить им SMS сообщение с напоминанием о состоянии их активного счёта.
CREATE OR REPLACE VIEW bonuses (номер_карты, бонусы, имя, телефон) AS
select p.card_num, p.active, u.first_name, c.phone from profiles p left join users u on u.user_id = p.user_id 
left join contacts c on c.user_id = u.user_id order by active desc limit 5;


-- Хранимые процедуры / триггеры:

-- Процедура, написанная ниже позволяет определить количество карт по их типу и статусу

DELIMITER //

DROP PROCEDURE IF EXISTS card//
CREATE PROCEDURE card (c_type int, c_status int)
BEGIN
	select count(c.card_num), s.description, t.description from cards c left join card_status s on c.card_status = s.card_status_id 
left join card_types t on c.card_type = t.type_id group by c.card_status, c.card_type having c.card_status = c_status and c.card_type = c_type;
END//

-- Например узнаем количество активных пластиковых карт
CALL card(1, 1)//

-- Или количество заблокированных электронных карт
CALL card(2, 3)//


-- Мы не должны позволять списывать больше бонусных баллов, чем имеется у клиента на активном/резервном счете

DELIMITER //
DROP TRIGGER IF EXISTS positive//
CREATE TRIGGER positive BEFORE UPDATE ON profiles
FOR EACH ROW
BEGIN
 IF (NEW.active < 0 or NEW.reserve < 0) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Недостаточно бонусных баллов для списания!';
 END IF;
END//

-- проверка
UPDATE profiles set active = -5 where user_id = 1//
UPDATE profiles set active = -5, reserve = 36 where user_id = 1//
UPDATE profiles set active = -5, reserve = -40 where user_id = 1//
UPDATE profiles set active = 5, reserve = 40 where user_id = 1//