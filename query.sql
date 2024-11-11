--1.External File Format:

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 FIRST_ROW = 2,
			 USE_TYPE_DEFAULT = FALSE
			))
GO


--2.External Data Source

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'raw_synapse243storage_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [raw_synapse243storage_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://raw@synapse243storage.dfs.core.windows.net' 
	)
GO


--3. External Table

CREATE EXTERNAL TABLE dbo.SalesLT_Address(
	[AddressID] varchar(4000) ,
	[AddressLine1] varchar(4000),
	[AddressLine2] varchar(4000),
	[City] varchar(4000),
	[StateProvince] varchar(4000),
	[CountryRegion] varchar(4000),
	[PostalCode] varchar(4000),
	[rowguid] varchar(4000),
	[ModifiedDate] varchar(4000) 
	)
	WITH (
	LOCATION = '/SalesLT/Address',
	DATA_SOURCE = [raw_synapse243storage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


--4. Querying Table

SELECT TOP 100 * FROM dbo.SalesLT_Address
GO