SELECT lower(c.name) AS ColumnName
	FROM sys.columns c
	JOIN sys.tables t ON c.object_id = t.object_id
	WHERE t.name = 'tbl_TableName'


SELECT STUFF((
    SELECT ', ' + LOWER(c.name)
    FROM sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
    WHERE t.name = 'tbl_TableName'
    FOR XML PATH(''), TYPE
).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS ColumnNames;