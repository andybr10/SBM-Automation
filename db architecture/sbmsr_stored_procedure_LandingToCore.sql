/****** Object:  StoredProcedure [sbmsr].[LandingToCore]    Script Date: 19.1.2019 15:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      Andreia Marques
-- Create Date: 05.01.2019
-- Description: Extracts, converts and loads data from landing zone tables into the core tables
-- =============================================
CREATE PROCEDURE [sbmsr].[LandingToCore]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

	    -- article
	TRUNCATE TABLE [sbmsr].[article];

	INSERT INTO [sbmsr].[article]
	SELECT
		CAST([id] AS INT),
		CAST([user_id] AS INT),
		CAST([article_type_id] AS INT),
		CAST([contact_id] AS INT),
		[deliverer_code],
		[deliverer_name],
		[deliverer_description],
		[intern_code],
		[intern_name],
		[intern_description],
		CAST([purchase_price] AS DECIMAL(18,6)),
		CAST([sale_price] AS DECIMAL(18,6)),
		CAST([purchase_total] AS DECIMAL(18,6)),
		CAST([sale_total] AS DECIMAL(18,6)),
		CAST([currency_id] AS INT),
		CAST([tax_income_id] AS INT),
		CAST([tax_id] AS INT),
		CAST([tax_expense_id] AS INT),
		CAST([unit_id] AS INT),
		CAST([is_stock] AS BIT),
		CAST([stock_id] AS INT),
		CAST([stock_place_id] AS INT),
		CAST([stock_nr] AS INT),
		CAST([stock_min_nr] AS INT),
		CAST([stock_reserved_nr] AS INT),
		CAST([stock_available_nr] AS INT),
		CAST([stock_picked_nr] AS INT),
		CAST([stock_disposed_nr] AS INT),
		CAST([stock_ordered_nr] AS INT),
		CAST([width] AS DECIMAL(18,6)),
		CAST([height] AS DECIMAL(18,6)),
		CAST([weight] AS DECIMAL(18,6)),
		CAST([volume] AS DECIMAL(18,6)),
		[html_text],
		[remarks],
		CAST([delivery_price] AS DECIMAL(18,6)),
		CAST([article_group_id] AS INT)
	FROM [bexio].[article];

    -- article_type
	TRUNCATE TABLE [sbmsr].[article_type];

    INSERT INTO [sbmsr].[article_type]
	SELECT
		CAST([id] AS INT),
		[name]
	FROM [bexio].[article_type];

	-- contact
	TRUNCATE TABLE [sbmsr].[contact];

    INSERT INTO [sbmsr].[contact]
	SELECT
		CAST([id]AS INT),
		[nr],
		CAST([contact_type_id]AS INT),
		[name_1],
		[name_2],
		CAST([salutation_id]AS INT),
		CAST([salutation_form]AS INT),
		CAST([title_id]AS INT),
		[birthday],
		[address],
		[postcode],
		[city],
		CAST([country_id]AS INT),
		[mail],
		[mail_second],
		[phone_fixed],
		[phone_fixed_second],
		[phone_mobile],
		[fax],
		[url],
		[skype_name],
		[remarks],
		CAST([language_id]AS INT),
		CAST([is_lead]AS BIT),
		CAST([contact_group_ids]AS INT),
		CAST([contact_branch_ids]AS INT),
		CAST([user_id]AS INT),
		CAST([owner_id]AS INT),
		CAST([updated_at] AS DATETIME)
	FROM [bexio].[contact];

	-- contact_branch
	TRUNCATE TABLE [sbmsr].[contact_branch];

    INSERT INTO [sbmsr].[contact_branch]
	SELECT
		CAST([id] AS INT),
		[name]
	FROM [bexio].[contact_branch];

	-- contact_group
	TRUNCATE TABLE [sbmsr].[contact_group];

    INSERT INTO [sbmsr].[contact_group]
	SELECT
		CAST([id] AS INT),
		[name]
	FROM [bexio].[contact_group];

	-- contact_relation
	TRUNCATE TABLE [sbmsr].[contact_relation];

    INSERT INTO [sbmsr].[contact_relation]
	SELECT
		CAST([id] AS INT),
		CAST([contact_id] AS INT),
		CAST([contact_sub_id] AS INT),
		[description],
		CAST([updated_at] AS datetime)
	FROM [bexio].[contact_relation];

	-- contact_type
	TRUNCATE TABLE [sbmsr].[contact_type];

    INSERT INTO [sbmsr].[contact_type]
	SELECT
		CAST([id]AS INT),
		[name]
	FROM [bexio].[contact_type];

	-- country
	TRUNCATE TABLE [sbmsr].[country];

    INSERT INTO [sbmsr].[country]
	SELECT
		CAST([id]AS INT),
		[name],
		[name_short],
		[iso_3166_alpha2]
	FROM [bexio].[country];

	-- currency
	TRUNCATE TABLE [sbmsr].[currency];

    INSERT INTO [sbmsr].[currency]
	SELECT
		CAST([id]AS INT),
		[name],
		CAST([round_factor]AS DECIMAL(18,6))
	FROM [bexio].[currency];

	-- kb_delivery
	TRUNCATE TABLE [sbmsr].[kb_delivery];

    INSERT INTO [sbmsr].[kb_delivery]
	SELECT
		CAST([id]AS INT),
		[document_nr],
		[title],
		CAST([contact_id]AS INT),
		CAST([contact_sub_id]AS INT),
		CAST([user_id]AS INT),
		CAST([logopaper_id]AS INT),
		CAST([language_id]AS INT),
		CAST([bank_account_id]AS INT),
		CAST([currency_id]AS INT),
		[header],
		[footer],
		CAST([total_gross]AS DECIMAL(18,6)),
		CAST([total_net]AS DECIMAL(18,6)),
		CAST([total_taxes]AS DECIMAL(18,6)),
		CAST([total]AS DECIMAL(18,6)),
		CAST([mwst_type]AS INT),
		CAST([mwst_is_net]AS BIT),
		CAST([is_valid_from]AS DATE),
		[contact_address],
		CAST([delivery_address_type]AS INT),
		[delivery_address],
		CAST([kb_item_status_id]AS INT),
		[api_reference],
		CAST([viewed_by_client_at]AS DATETIME),
		CAST([updated_at]AS DATETIME)
	FROM [bexio].[kb_delivery];

	-- kb_invoice
	TRUNCATE TABLE [sbmsr].[kb_invoice];

    INSERT INTO [sbmsr].[kb_invoice]
	SELECT
		CAST([id]AS INT),
		[document_nr],
		[title],
		CAST([contact_id]AS INT),
		CAST([contact_sub_id]AS INT),
		CAST([user_id]AS INT),
		CAST([project_id]AS INT),
		CAST([logopaper_id]AS INT),
		CAST([language_id]AS INT),
		CAST([bank_account_id]AS INT),
		CAST([currency_id]AS INT),
		CAST([payment_type_id]AS INT),
		[header],
		[footer],
		CAST([total_gross]AS DECIMAL(18,6)),
		CAST([total_net]AS DECIMAL(18,6)),
		CAST([total_taxes]AS DECIMAL(18,6)),
		CAST([total_received_payments]AS DECIMAL(18,6)),
		CAST([total_credit_vouchers]AS DECIMAL(18,6)),
		CAST([total_remaining_payments]AS DECIMAL(18,6)),
		CAST([total]AS DECIMAL(18,6)),
		CAST([mwst_type]AS INT),
		CAST([mwst_is_net]AS BIT),
		CAST([show_position_taxes]AS BIT),
		CAST([is_valid_from]AS DATE),
		CAST([is_valid_to]AS DATE),
		[contact_address],
		CAST([kb_item_status_id]AS INT),
		[api_reference],
		CAST([viewed_by_client_at]AS DATETIME),
		CAST([updated_at]AS DATETIME),
		CAST([esr_id]AS INT),
		[network_link]
	FROM [bexio].[kb_invoice];

	-- kb_order
	TRUNCATE TABLE [sbmsr].[kb_order];

    INSERT INTO [sbmsr].[kb_order]
	SELECT
		CAST([id]AS INT),
		[document_nr],
		[title],
		CAST([contact_id]AS INT),
		CAST([contact_sub_id]AS INT),
		CAST([user_id]AS INT),
		CAST([project_id]AS INT),
		CAST([logopaper_id]AS INT),
		CAST([language_id]AS INT),
		CAST([bank_account_id]AS INT),
		CAST([currency_id]AS INT),
		CAST([payment_type_id]AS INT),
		[header],
		[footer],
		CAST([total_gross]AS DECIMAL(18,6)),
		CAST([total_net]AS DECIMAL(18,6)),
		CAST([total_taxes]AS DECIMAL(18,6)),
		CAST([total]AS DECIMAL(18,6)),
		CAST([mwst_type]AS INT),
		CAST([mwst_is_net]AS BIT),
		CAST([show_position_taxes]AS BIT),
		CAST([is_valid_from]AS DATE),
		[contact_address],
		CAST([delivery_address_type]AS INT),
		[delivery_address],
		CAST([kb_item_status_id]AS INT),
		CAST([is_recurring]AS BIT),
		[api_reference],
		CAST([viewed_by_client_at]AS DATETIME),
		CAST([updated_at]AS DATETIME),
		[network_link]
	FROM [bexio].[kb_order];

	-- payment_type
	TRUNCATE TABLE [sbmsr].[payment_type];

    INSERT INTO [sbmsr].[payment_type]
	SELECT
		CAST([id]AS INT),
		[name]
	FROM [bexio].[payment_type];

	-- position_article
	TRUNCATE TABLE [sbmsr].[position_article];

	INSERT INTO [sbmsr].[position_article]
	SELECT
		CAST(pa.[id]AS INT),
		pa.[type],
		CAST(pa.[amount]AS DECIMAL(18,6)),
		CAST(pa.[unit_id]AS INT),
		CAST(pa.[account_id]AS INT),
		pa.[unit_name],
		CAST(pa.[tax_id]AS INT),
		CAST(pa.[tax_value]AS DECIMAL(18,6)),
		pa.[text],
		CAST(pa.[unit_price]AS DECIMAL(18,6)),
		CAST(pa.[discount_in_percent]AS DECIMAL(18,6)),
		CAST(pa.[position_total]AS DECIMAL(18,6)),
		CAST(pa.[pos]AS INT),
		CAST(pa.[internal_pos]AS INT),
		CAST(pa.[parent_id]AS INT),
		CAST(pa.[is_optional]AS BIT),
		CAST(pa.[article_id]AS INT),
		CAST(
			CASE
				WHEN par.kb_order_id IS NULL THEN
					inv.is_valid_from
				ELSE
					ord.is_valid_from
			END AS date
		),
		CAST(
			CASE
				WHEN par.kb_order_id IS NULL THEN
					inv.currency_id
				ELSE
					ord.currency_id
			END AS int
		),
		NULL
	FROM [bexio].[position_article] as pa
	LEFT JOIN [bexio].[position_article_relation] as par ON pa.id = par.position_article_id
	LEFT JOIN [bexio].[kb_order] as ord ON par.kb_order_id = ord.id
	LEFT JOIN [bexio].[kb_invoice] as inv ON par.kb_invoice_id = inv.id;

	-- position_article_relation
	TRUNCATE TABLE [sbmsr].[position_article_relation];

    INSERT INTO [sbmsr].[position_article_relation]
	SELECT
		CAST([position_article_id]AS INT),
		CAST([kb_order_id]AS INT),
		CAST([kb_invoice_id]AS INT),
		CAST([kb_delivery_id]AS INT)
	FROM [bexio].[position_article_relation];

	-- position_custom
	TRUNCATE TABLE [sbmsr].[position_custom];

    INSERT INTO [sbmsr].[position_custom]
	SELECT
		CAST(pc.[id]AS INT),
		pc.[type],
		CAST(pc.[amount]AS DECIMAL(18,6)),
		CAST(pc.[unit_id]AS INT),
		CAST(pc.[account_id]AS INT),
		pc.[unit_name],
		CAST(pc.[tax_id]AS INT),
		CAST(pc.[tax_value]AS DECIMAL(18,6)),
		pc.[text],
		CAST(pc.[unit_price]AS DECIMAL(18,6)),
		CAST(pc.[discount_in_percent]AS DECIMAL(18,6)),
		CAST(pc.[position_total]AS DECIMAL(18,6)),
		CAST(pc.[pos]AS INT),
		CAST(pc.[internal_pos]AS INT),
		CAST(pc.[parent_id]AS INT),
		CAST(pc.[is_optional]AS BIT),
		CAST(
			CASE
				WHEN pcr.kb_order_id IS NULL THEN
					inv.is_valid_from
				ELSE
					ord.is_valid_from
			END AS date
		),
		CAST(
			CASE
				WHEN pcr.kb_order_id IS NULL THEN
					inv.currency_id
				ELSE
					ord.currency_id
			END AS int
		),
		NULL
	FROM [bexio].[position_custom] as pc
	LEFT JOIN [bexio].[position_custom_relation] as pcr ON pc.id = pcr.position_custom_id
	LEFT JOIN [bexio].[kb_order] as ord ON pcr.kb_order_id = ord.id
	LEFT JOIN [bexio].[kb_invoice] as inv ON pcr.kb_invoice_id = inv.id;

	-- position_discount
	TRUNCATE TABLE [sbmsr].[position_discount];

    INSERT INTO [sbmsr].[position_discount]
	SELECT
		CAST(pd.[id] AS INT),
        pd.[type],
        pd.[text],
        CAST(pd.[is_percentual] AS bit),
        CAST(pd.[value] AS DECIMAL(18, 6)),
        CAST(pd.[discount_total] AS DECIMAL(18, 6)),
		CAST(
			CASE
				WHEN pdr.kb_order_id IS NULL THEN
					inv.is_valid_from
				ELSE
					ord.is_valid_from
			END AS date
		),
		CAST(
			CASE
				WHEN pdr.kb_order_id IS NULL THEN
					inv.currency_id
				ELSE
					ord.currency_id
			END AS int
		)
	FROM [bexio].[position_discount] AS pd
	LEFT JOIN [bexio].[position_discount_relation] as pdr ON pd.id = pdr.position_discount_id
	LEFT JOIN [bexio].[kb_order] as ord ON pdr.kb_order_id = ord.id
	LEFT JOIN [bexio].[kb_invoice] as inv ON pdr.kb_invoice_id = inv.id;;

	-- position_article_relation
	TRUNCATE TABLE [sbmsr].[position_custom_relation];

    INSERT INTO [sbmsr].[position_custom_relation]
	SELECT
		CAST([position_custom_id]AS INT),
		CAST([kb_order_id]AS INT),
		CAST([kb_invoice_id]AS INT),
		CAST([kb_delivery_id]AS INT)
	FROM [bexio].[position_custom_relation];

    -- position_discount_relation
	TRUNCATE TABLE [sbmsr].[position_discount_relation];

    INSERT INTO [sbmsr].[position_discount_relation]
	SELECT
		CAST([position_discount_id]AS INT),
		CAST([kb_order_id]AS INT),
		CAST([kb_invoice_id]AS INT),
		CAST([kb_delivery_id]AS INT)
	FROM [bexio].[position_discount_relation];

	-- salutation
	TRUNCATE TABLE [sbmsr].[salutation];

    INSERT INTO [sbmsr].[salutation]
	SELECT
		CAST([id]AS INT),
		[name]
	FROM [bexio].[salutation];

	-- title
	TRUNCATE TABLE [sbmsr].[title];

    INSERT INTO [sbmsr].[title]
	SELECT
		CAST([id]AS INT),
		[name]
	FROM [bexio].[title];

	-- unit
	TRUNCATE TABLE [sbmsr].[unit];

    INSERT INTO [sbmsr].[unit]
	SELECT
		CAST([id]AS INT),
		[name]
	FROM [bexio].[unit];

	-- user
	TRUNCATE TABLE [sbmsr].[user];

    INSERT INTO [sbmsr].[user]
	SELECT
		CAST([id]AS INT),
		[nickname],
		[firstname],
		[lastname],
		[email],
		[color],
		[phone_fixed],
		[phone_mobile],
		CAST([is_superadmin]AS BIT)
	FROM [bexio].[user];

	-- fxrates
	TRUNCATE TABLE [sbmsr].[fxrates];

    INSERT INTO [sbmsr].[fxrates]
	SELECT
        [type] =	'avg',
        [period] =	CASE
                        WHEN LEN([monat]) = 6 THEN
                            CAST(REPLACE([monat],'-','0') AS INT)
                        ELSE
                            CAST(REPLACE([monat],'-','') AS INT)
                    END,
        [from_currency] = UPPER([code]),
        [to_currency] = 'CHF',
        [rate] = CAST([kurs] AS decimal(24,12)) / CAST(LEFT([waehrung], CHARINDEX(N' ', [waehrung])) AS INT)
    FROM [ezv].[fxrates_chf];

END
