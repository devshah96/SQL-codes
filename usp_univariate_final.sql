create procedure usp_univariate @table_name nvarchar(30), @column_name nvarchar(500)
as
declare @sql nvarchar(max)
declare @average nvarchar(max)
set @sql = 'select count (' +@column_name + ') as count ,
                   avg('+ @column_name  + ') as average,
				   ( SELECT TOP 1' +  @column_name + ' from ' +  @table_name + ' GROUP  BY '+ @column_name + ' ORDER  BY COUNT(*) DESC) as mode,
				   max (' + @column_name + ') - min (' + @column_name +' ) as range,
				   var(' +@column_name +') as variance,
				   sqrt( var(' + @column_name +') ) as standard_deviation,
				   sqrt( var(' + @column_name +') ) /  avg(' + @column_name  + ') as CV,
				   (((select max(' + @column_name +') from (select top 50 percent '+@column_name+' from '+@table_name+' order by '+@column_name+') as a)+
				   (select min('+ @column_name +') from (select top 50 percent '+@column_name +' from '+ @table_name +' order by '+ @column_name +' desc) as c))/2) 
				   as median from '+@table_name
EXECUTE sp_executesql @sql

exec usp_univariate 'orders_denorm','order_dow'
drop procedure usp_univariate