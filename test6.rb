select * from Users where id in (select top 2 user_id from Messages group by user_id order by count(user_id) desc)
