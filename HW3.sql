#Zach Koontz
#29 March
#HW3



#67
select CHECK_NUM,BOOK_NUM,CHECK_OUT_DATE
from table
where CHECK_OUT_DATE<'2017-04-05'
order by CHECK_NUM;

#68
select BOOK_NUM, BOOK_TITLE, BOOK_YEAR, BOOK_SUBJECT, BOOK_COST FROM BOOK 
where (BOOK_SUBJECT = 'Middleware' OR BOOK_SUBJECT = 'Cloud') 
and BOOK_COST > 70;

#70
select AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR
from AUTHOR
where AU_BIRTHYEAR BETWEEN 1980 AND 1989
order by AU_ID;

#80
select count(Book_Num)
from Book where Book_Num not in(
select Book_Num 
from Checkout 
where Check_Out_Date is not null);

#85
select AUTHOR.AU_ID , Count(BOOK.BOOK_NUM) as "Books Written" from AUTHOR
inner join WRITES on AUTHOR.AU_ID = WRITES.AU_ID
inner join BOOK on WRITES.BOOK_NUM = BOOK.BOOK_NUM 
group by AUTHOR.AU_ID 
order by Count(BOOK.BOOK_NUM) desc, AUTHOR.AU_ID;

#96
select a.Au_ID, Au_FName, Au_LName, b.Book_Num, Book_Title
from BOOK b, AUTHOR a, WRITES w
where a.Au_ID = w.Au_ID and b.Book_Num = w.Book_Num and Book_Subject = 'Cloud'
order by Book_Title, Au_LNAME;

#98
select Book.Book_Num, Book_Title, IFNULL(count(*),0) "Times Checked Out"
from Book LEFT JOIN CHECKOUT ON Book.Book_Num = CHECKOUT.Book_Num
group by Book.Book_Num, Book_Title
order by count(*) desc, Book_Title;

#100
select AUTHOR.AU_ID,AUTHOR.AU_LNAME,BOOK.BOOK_TITLE,CHECKOUT.CHECK_OUT_DATE, PATRON.PAT_LNAME
from ((((AUTHOR
join WRITES ON AUTHOR.AU_ID = WRITES.AU_ID)
join BOOK ON WRITES.BOOK_NUM = BOOK.BOOK_NUM)
join CHECKOUT ON BOOK.BOOK_NUM = CHECKOUT.BOOK_NUM)
join PATRON ON CHECKOUT.PAT_ID = PATRON.PAT_ID))
where AUTHOR.AU_LNAME="Bruer" 
andPATRON.PAT_LNAME="Miles"
order by CHECKOUT.CHECK_OUT_DATE;

#101
select PAT_ID, PAT_FNAME, PAT_LNAME 
from PATRON 
where PAT_ID not in (select pat_id from CHECKOUT)
order by PAT_LNAME, PAT_FNAME;

#105
select BOOK_NUM, BOOK_TITLE, BOOK_COST
from BOOK
where BOOK_COST = (SELECT MIN(BOOK_COST) FROM BOOKS)
order by BOOK_NUM;

#106
select AUTHOR.AU_ID, AUTHOR.AU_FNAME, AUTHOR.AU_LNAME 
from AUTHOR 
inner join WRITES on WRITES.AU_ID = AUTHOR.AU_ID 
inner join BOOK on BOOK.BOOK_NUM = WRITES.BOOK_NUM 
where BOOK.BOOK_SUBJECT != "Programming" 
group by AUTHOR.AU_LNAME;

#108
select b.Book_Num, b.Book_Title, b.Book_Subject, a.Au_LName, t.count AS "NumBooksByAuthor"
from BOOK b, AUTHOR a, WRITES w, (SELECT Au_ID, count(DISTINCT Book_Num) AS count FROM WRITES GROUP BY Au_ID) AS t
where b.Book_Num = w.Book_Num AND w.Au_ID = a.Au_ID AND a.Au_ID = t.Au_ID AND b.Book_Subject = 'Cloud'
order by b.Book_Title, a.Au_LName;
