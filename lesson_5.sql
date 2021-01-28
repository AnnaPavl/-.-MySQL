/*������������ ������� �� ���� ����������, ����������, ���������� � �����������*/

/* 1.����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.*/

UPDATE users SET updated_at = NOW();
UPDATE users SET created_at = NOW();

/* 2.������� users ���� �������� ��������������. 
 * ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10. 
 * ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.*/

ALTER TABLE users ADD new_created_at DATETIME;
ALTER TABLE users ADD new_updated_at DATETIME;
UPDATE users SET new_created_at = STR_TO_DATE(created_at, '%d.%m.%Y %l:%i');
UPDATE users SET new_updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %l:%i');
ALTER TABLE users DROP created_at, CHANGE new_created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users DROP updated_at, CHANGE new_updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


/* 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����:
 *0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. 
 *���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. 
 *������ ������� ������ ������ ���������� � �����, ����� ���� �������.*/

SELECT value FROM storehouses_products ORDER BY CASE WHEN value = 0 then 2 else 1 end, value;

/* 4. �� ������� users ���������� ������� �������������, ���������� � ������� � ���. 
 *������ ������ � ���� ������ ���������� �������� (may, august)*/

select name, birthday_at from users where DATE_FORMAT (birthday_at, "%M") in ('may', 'august');

/* 5. �� ������� catalogs ����������� ������ ��� ������ �������. 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2) order by case when id = 5 then 0 else 1 end, id;

/*������������ ������� ���� ���������� �������*/

/* 1. ����������� ������� ������� ������������� � ������� users.*/
 
SELECT avg(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) FROM users;

/* 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. 
 * ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.*/

select count(*), DATE_FORMAT (birthday_at, "%a") from users group by DATE_FORMAT (birthday_at, "%a");

/* 3. ����������� ������������ ����� � ������� �������.*/

select exp(sum(ln(value))) from tab;


