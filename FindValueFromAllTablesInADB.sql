DECLARE @SearchValue NVARCHAR(100) = 'Keyword';
DECLARE @SQL NVARCHAR(MAX) = '';

-- Generate the SQL query to search in all tables containing 'possible_table_name' in their names
SELECT @SQL = @SQL + 
    'SELECT ''' + TABLE_NAME + ''' AS TableName, ''' + COLUMN_NAME + ''' AS ColumnName, ' + 
    QUOTENAME(COLUMN_NAME) + ' AS Value ' +
    'FROM ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
    ' WHERE ' + QUOTENAME(COLUMN_NAME) + ' LIKE ''%' + @SearchValue + '%'' UNION ALL '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME LIKE '%possible_table_name%'  -- Filter to include only tables with 'possible_table_name' in their names
AND DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar', 'text', 'ntext');

-- Remove the last UNION ALL
SET @SQL = LEFT(@SQL, LEN(@SQL) - 10);

-- Execute the final query
EXEC sp_executesql @SQL;
