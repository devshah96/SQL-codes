create procedure usp_bivariate @table_name nvarchar(max),@target_colname nvarchar(max),@predictor_colname nvarchar(max)
as
declare @cmd nvarchar(max)

create table temp( target varchar(max),count int,avg float,std float, var float)
select @cmd ='insert into temp
select '+@target_colname+', count('+@predictor_colname+') , avg(1.0*'+@predictor_colname+'),stdev('+@predictor_colname+'),var('+@predictor_colname+') 
from '+@table_name+' group by '+@target_colname
exec(@cmd)
select * from temp
declare @z_value float
declare @sd1 float
declare @sd2 float
declare @var1 float
declare @var2 float
declare @c1 int
declare @c2 int
declare @avg1 float                        
declare @avg2 float

select @avg1 = (select top 1 avg from temp order by avg desc)
select @sd1 = (select top 1 std from temp order by avg desc)
select @var1 = (select top 1 var from temp order by avg desc)
select @c1 = (select top 1 count from temp order by avg desc)

select @avg2 = (select top 1 avg from temp order by avg )
select @sd2 = (select top 1 std from temp order by avg )
select @var2 = (select top 1 var from temp order by avg)
select @c2 = (select top 1 count from temp order by avg)
drop table temp
set @z_value = (@avg1 - @avg2)/sqrt((@var1/@c1)+(@var2/@c2))
select @z_value as Z_Value

exec usp_bivariate 'challengerORing', 'ORingFailure', 'LaunchTemperature'
drop procedure usp_bivariate