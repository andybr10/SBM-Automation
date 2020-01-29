-- Copyright (c) Strongback Mobility.

CREATE SCHEMA [sbmsr];

CREATE TABLE [sbmsr].[article](
	[id] int PRIMARY KEY,
	[user_id] int NULL,
	[article_type_id] int NULL,
	[contact_id] int NULL,
	[deliverer_code] nvarchar(255) NULL,
	[deliverer_name] nvarchar(255) NULL,
	[deliverer_description] text NULL,
	[intern_code] nvarchar(255) NULL,
	[intern_name] nvarchar(255) NULL,
	[intern_description] text NULL,
	[purchase_price] decimal(18, 6) NULL,
	[sale_price] decimal(18, 6) NULL,
	[purchase_total] decimal(18, 6) NULL,
	[sale_total] decimal(18, 6) NULL,
	[currency_id] int NULL,
	[tax_income_id] int NULL,
	[tax_id] int NULL,
	[tax_expense_id] int NULL,
	[unit_id] int NULL,
	[is_stock] bit NULL,
	[stock_id] int NULL,
	[stock_place_id] int NULL,
	[stock_nr] int NULL,
	[stock_min_nr] int NULL,
	[stock_reserved_nr] int NULL,
	[stock_available_nr] int NULL,
	[stock_picked_nr] int NULL,
	[stock_disposed_nr] int NULL,
	[stock_ordered_nr] int NULL,
	[width] decimal(18, 6) NULL,
	[height] decimal(18, 6) NULL,
	[weight] decimal(18, 6) NULL,
	[volume] decimal(18, 6) NULL,
	[html_text] nvarchar(255) NULL,
	[remarks] nvarchar(255) NULL,
	[delivery_price] decimal(18, 6) NULL,
	[article_group_id] int NULL
);


CREATE TABLE [sbmsr].[article_type](
	[id] int primary key,
	[name] nvarchar(255)
);

CREATE TABLE [sbmsr].[contact_type](
	[id] int primary key,
	[name] nvarchar(255)
);

CREATE TABLE [sbmsr].[contact_branch](
	[id] int primary key,
	[name] nvarchar(255)
);

CREATE TABLE [sbmsr].[contact_group](
	[id] int primary key,
	[name] nvarchar(255)
);

CREATE TABLE [sbmsr].[contact_relation](
	[id] int primary key,
	[contact_id] int NULL,
	[contact_sub_id] int NULL,
	[description] nvarchar(255) NULL,
	[updated_at] datetime NULL
); 

CREATE TABLE [sbmsr].[salutation](
	[id] int primary key,
	[name] nvarchar(255)
);

CREATE TABLE [sbmsr].[title](
	[id] int primary key,
	[name] nvarchar(255)
);

CREATE TABLE [sbmsr].[currency](
	[id] int primary key,
	[name] nvarchar(255),
	[round_factor] decimal (18,6)
);

CREATE TABLE [sbmsr].[contact](
	[id] int primary key,
	[nr] nvarchar(255) NULL,
	[contact_type_id] int NULL,
	[name_1] nvarchar(255) NULL,
	[name_2] nvarchar(255) NULL,
	[salutation_id] int NULL,
	[salutation_form] int NULL,
	[title_id] int NULL,
	[birthday] nvarchar(255) NULL,
	[address] nvarchar(255) NULL,
	[postcode] nvarchar(255) NULL,
	[city] nvarchar(255) NULL,
	[country_id] int NULL,
	[mail] nvarchar(255) NULL,
	[mail_second] nvarchar(255) NULL,
	[phone_fixed] nvarchar(255) NULL,
	[phone_fixed_second] nvarchar(255) NULL,
	[phone_mobile] nvarchar(255) NULL,
	[fax] nvarchar(255) NULL,
	[url] nvarchar(255) NULL,
	[skype_name] nvarchar(255) NULL,
	[remarks] nvarchar(255) NULL,
	[language_id] int NULL,
	[is_lead] bit NULL,
	[contact_group_ids] int NULL,
	[contact_branch_ids] int NULL,
	[user_id] int NULL,
	[owner_id] int NULL,
	[updated_at] datetime NULL
);

CREATE TABLE [sbmsr].[kb_delivery](
	[id] int primary key,
	[document_nr] nvarchar(255) NULL,
	[title] nvarchar(255) NULL,
	[contact_id] int NULL,
	[contact_sub_id] int NULL,
	[user_id] int NULL,
	[logopaper_id] int NULL,
	[language_id] int NULL,
	[bank_account_id] int NULL,
	[currency_id] int NULL,
	[header] text NULL,
	[footer] text NULL,
	[total_gross] decimal(18,6) NULL,
	[total_net] decimal(18,6) NULL,
	[total_taxes] decimal(18,6) NULL,
	[total] decimal (18,6) NULL,
	[mwst_type] int NULL,
	[mwst_is_net] bit NULL,
	[is_valid_from] date NULL,
	[contact_address] nvarchar(255) NULL,
	[delivery_address_type] int NULL,
	[delivery_address] nvarchar(255) NULL,
	[kb_item_status_id] int NULL,
	[api_reference] nvarchar(255) NULL,
	[viewed_by_client_at] datetime NULL,
	[updated_at] datetime NULL
);

CREATE TABLE [sbmsr].[kb_invoice](
	[id] int primary key,
	[document_nr] nvarchar(255) NULL,
	[title] nvarchar(255) NULL,
	[contact_id] int NULL,
	[contact_sub_id] int NULL,
	[user_id] int NULL,
	[project_id] int NULL,
	[logopaper_id] int NULL,
	[language_id] int NULL,
	[bank_account_id] int NULL,
	[currency_id] int NULL,
	[payment_type_id] int NULL,
	[header] text NULL,
	[footer] text NULL,
	[total_gross] decimal(18,6) NULL,
	[total_net] decimal(18,6) NULL,
	[total_taxes] decimal(18,6)  NULL,
	[total_received_payments] decimal(18,6)  NULL,
	[total_credit_vouchers] decimal(18,6)  NULL,
	[total_remaining_payments]decimal(18,6)  NULL,
	[total] decimal(18,6)  NULL,
	[mwst_type] int NULL,
	[mwst_is_net] bit NULL,
	[show_position_taxes] bit NULL,
	[is_valid_from] date NULL,
	[is_valid_to] date NULL,
	[contact_address] nvarchar(255) NULL,
	[kb_item_status_id] int NULL,
	[api_reference] nvarchar(255) NULL,
	[viewed_by_client_at] datetime NULL,
	[updated_at] datetime NULL,
	[esr_id] int NULL,
	[network_link] nvarchar(255) NULL
);

CREATE TABLE [sbmsr].[kb_order](
	[id] int primary key,
	[document_nr] nvarchar(255) NULL,
	[title] nvarchar(255) NULL,
	[contact_id] int NULL,
	[contact_sub_id] int NULL,
	[user_id] int NULL,
	[project_id] int NULL,
	[logopaper_id] int NULL,
	[language_id] int NULL,
	[bank_account_id] int NULL,
	[currency_id] int NULL,
	[payment_type_id] int NULL,
	[header] text NULL,
	[footer] text NULL,
	[total_gross] decimal(18,6) NULL,
	[total_net] decimal(18,6) NULL,
	[total_taxes] decimal(18,6) NULL,
	[total] decimal(18,6) NULL,
	[mwst_type] int NULL,
	[mwst_is_net] bit NULL,
	[show_position_taxes] bit NULL,
	[is_valid_from] date NULL,
	[contact_address] nvarchar(255) NULL,
	[delivery_address_type] int NULL,
	[delivery_address] nvarchar(255) NULL,
	[kb_item_status_id] int NULL,
	[is_recurring] bit NULL,
	[api_reference] nvarchar(255) NULL,
	[viewed_by_client_at] datetime NULL,
	[updated_at] datetime NULL,
	[network_link] nvarchar(255) NULL
); 

CREATE TABLE [sbmsr].[position_article](
	[id] int primary key,
	[type] nvarchar(255) NULL,
	[amount] decimal(18,6) NULL,
	[unit_id] int NULL,
	[account_id] int NULL,
	[unit_name] nvarchar(255) NULL,
	[tax_id] int NULL,
	[tax_value] decimal(18,6) NULL,
	[text] text NULL,
	[unit_price] decimal(18,6) NULL,
	[discount_in_percent] decimal(18,6) NULL,
	[position_total] decimal(18,6) NULL,
	[pos] int NULL,
	[internal_pos] int NULL,
	[parent_id] int NULL,
	[is_optional] bit NULL,
	[article_id] int NULL,
	[doc_date] date NULL,
	[doc_currency_id] int NULL,
	[product_code_from_text] nvarchar(255) NULL
);

CREATE TABLE [sbmsr].[position_article_relation](
    [position_article_id] int primary key,
	[kb_order_id] int NULL,
	[kb_invoice_id] int NULL,
	[kb_delivery_id] int NULL
);

CREATE TABLE [sbmsr].[position_custom](
	[id] int primary key,
	[type] nvarchar(255) NULL,
	[amount] decimal(18, 6) NULL,
	[unit_id] int NULL,
	[account_id] int NULL,
	[unit_name] nvarchar(255) NULL,
	[tax_id] int NULL,
	[tax_value] decimal(18, 6) NULL,
	[text] text NULL,
	[unit_price] decimal(18, 6) NULL,
	[discount_in_percent] decimal(18, 6) NULL,
	[position_total] decimal(18, 6) NULL,
	[pos] int NULL,
	[internal_pos] int NULL,
	[parent_id] int NULL,
	[is_optional] bit NULL,
	[doc_date] date NULL,
	[doc_currency_id] int NULL,
	[product_code_from_text] nvarchar(255) NULL
);

CREATE TABLE [sbmsr].[position_custom_relation](
    [position_custom_id] int primary key,
	[kb_order_id] int NULL,
	[kb_invoice_id] int NULL,
	[kb_delivery_id] int NULL
);

CREATE TABLE [sbmsr].[position_discount] (
    [id] int primary key,
    [type] nvarchar(255) NULL,
    [text] nvarchar(255) NULL,
    [is_percentual] bit NULL,
    [value] decimal(18, 6) NULL,
    [discount_total] decimal(18, 6) NULL,
	[doc_date] date NULL,
	[doc_currency_id] int NULL
);

CREATE TABLE [sbmsr].[position_discount_relation] (
    [position_discount_id] int primary key,
	[kb_order_id] int NULL,
	[kb_invoice_id] int NULL,
	[kb_delivery_id] int NULL
);

CREATE TABLE [sbmsr].[country] (
    [id] int primary key,
    [name] nvarchar(255) NULL,
    [name_short] nvarchar(255) NULL,
    [iso_3166_alpha2] nvarchar(255) NULL
);

CREATE TABLE [sbmsr].[unit] (
	[id] int primary key,
	[name] nvarchar(255) NULL
);

CREATE TABLE [sbmsr].[payment_type] (
	[id] int primary key,
	[name] nvarchar(255) NULL
);

CREATE TABLE [sbmsr].[user] (
    [id] int primary key,
    [nickname] NVARCHAR(255) NULL,
    [firstname] NVARCHAR(255) NULL,
    [lastname] NVARCHAR(255) NULL,
    [email] NVARCHAR(255) NULL,
    [color] NVARCHAR(255) NULL,
    [phone_fixed] NVARCHAR(255) NULL,
    [phone_mobile] NVARCHAR(255) NULL,
    [is_superadmin] bit NULL
);

CREATE TABLE [sbmsr].[document_status] (
    [id] int primary key,
    [status_text] nvarchar(255)
);

-- FX rates
CREATE TABLE [sbmsr].[fxrates] (
    [type] nvarchar(3),
    [period] int,
    [from_currency] nvarchar(3),
    [to_currency] nvarchar(3),
    [rate] decimal(24,12)
);
