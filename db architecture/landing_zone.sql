-- Copyright (c) Strongback Mobility.

-- SCHEMA [bexio]
CREATE SCHEMA bexio;

CREATE TABLE bexio.contact (
	[id] NVARCHAR(255),
	[nr] NVARCHAR(255),
	[contact_type_id] NVARCHAR(255),
	[name_1] NVARCHAR(255),
	[name_2] NVARCHAR(255),
	[salutation_id] NVARCHAR(255),
	[salutation_form] NVARCHAR(255),
	[title_id] NVARCHAR(255),
	[birthday] NVARCHAR(255),
	[address] NVARCHAR(255),
	[postcode] NVARCHAR(255),
	[city] NVARCHAR(255),
	[country_id] NVARCHAR(255),
	[mail] NVARCHAR(255),
	[mail_second] NVARCHAR(255),
	[phone_fixed] NVARCHAR(255),
	[phone_fixed_second] NVARCHAR(255),
	[phone_mobile] NVARCHAR(255),
	[fax] NVARCHAR(255),
	[url] NVARCHAR(255),
	[skype_name] NVARCHAR(255),
	[remarks] NVARCHAR(255),
	[language_id] NVARCHAR(255),
	[is_lead] NVARCHAR(255),
	[contact_group_ids] NVARCHAR(255),
	[contact_branch_ids] NVARCHAR(255),
	[user_id] NVARCHAR(255),
	[owner_id] NVARCHAR(255),
	[updated_at] NVARCHAR(255)
);

CREATE TABLE [bexio].[kb_order] (
	[id] NVARCHAR(255),
	[document_nr] NVARCHAR(255),
	[title] NVARCHAR(255),
	[contact_id] NVARCHAR(255),
	[contact_sub_id] NVARCHAR(255),
	[user_id] NVARCHAR(255),
	[project_id] NVARCHAR(255),
	[logopaper_id] NVARCHAR(255),
	[language_id] NVARCHAR(255),
	[bank_account_id] NVARCHAR(255),
	[currency_id] NVARCHAR(255),
	[payment_type_id] NVARCHAR(255),
	[header] TEXT,
	[footer] TEXT,
	[total_gross] NVARCHAR(255),
	[total_net] NVARCHAR(255),
	[total_taxes] NVARCHAR(255),
	[total] NVARCHAR(255),
	[mwst_type] NVARCHAR(255),
	[mwst_is_net] NVARCHAR(255),
	[show_position_taxes] NVARCHAR(255),
	[is_valid_from] NVARCHAR(255),
	[contact_address] NVARCHAR(255),
	[delivery_address_type] NVARCHAR(255),
	[delivery_address] NVARCHAR(255),
	[kb_item_status_id] NVARCHAR(255),
	[is_recurring] NVARCHAR(255),
	[api_reference] NVARCHAR(255),
	[viewed_by_client_at] NVARCHAR(255),
	[updated_at] NVARCHAR(255),
	[network_link] NVARCHAR(255)
);

CREATE TABLE [bexio].[kb_invoice] (
	[id] NVARCHAR(255),
	[document_nr] NVARCHAR(255),
	[title] NVARCHAR(255),
	[contact_id] NVARCHAR(255),
	[contact_sub_id] NVARCHAR(255),
	[user_id] NVARCHAR(255),
	[project_id] NVARCHAR(255),
	[logopaper_id] NVARCHAR(255),
	[language_id] NVARCHAR(255),
	[bank_account_id] NVARCHAR(255),
	[currency_id] NVARCHAR(255),
	[payment_type_id] NVARCHAR(255),
	[header] TEXT,
	[footer] TEXT,
	[total_gross] NVARCHAR(255),
	[total_net] NVARCHAR(255),
	[total_taxes] NVARCHAR(255),
	[total_received_payments] NVARCHAR(255),
	[total_credit_vouchers] NVARCHAR(255),
	[total_remaining_payments] NVARCHAR(255),
	[total] NVARCHAR(255),
	[mwst_type] NVARCHAR(255),
	[mwst_is_net] NVARCHAR(255),
	[show_position_taxes] NVARCHAR(255),
	[is_valid_from] NVARCHAR(255),
	[is_valid_to] NVARCHAR(255),
	[contact_address] NVARCHAR(255),
	[kb_item_status_id] NVARCHAR(255),
	[api_reference] NVARCHAR(255),
	[viewed_by_client_at] NVARCHAR(255),
	[updated_at] NVARCHAR(255),
	[esr_id] NVARCHAR(255),
	[network_link] NVARCHAR(255)
);

CREATE TABLE [bexio].[kb_delivery] (
	[id] NVARCHAR(255),
	[document_nr] NVARCHAR(255),
	[title] NVARCHAR(255),
	[contact_id] NVARCHAR(255),
	[contact_sub_id] NVARCHAR(255),
	[user_id] NVARCHAR(255),
	[logopaper_id] NVARCHAR(255),
	[language_id] NVARCHAR(255),
	[bank_account_id] NVARCHAR(255),
	[currency_id] NVARCHAR(255),
	[header] TEXT,
	[footer] TEXT,
	[total_gross] NVARCHAR(255),
	[total_net] NVARCHAR(255),
	[total_taxes] NVARCHAR(255),
	[total] NVARCHAR(255),
	[mwst_type] NVARCHAR(255),
	[mwst_is_net] NVARCHAR(255),
	[is_valid_from] NVARCHAR(255),
	[contact_address] NVARCHAR(255),
	[delivery_address_type] NVARCHAR(255),
	[delivery_address] NVARCHAR(255),
	[kb_item_status_id] NVARCHAR(255),
	[api_reference] NVARCHAR(255),
	[viewed_by_client_at] NVARCHAR(255),
	[updated_at] NVARCHAR(255)
);

CREATE TABLE [bexio].[article] (
	[id] NVARCHAR(255),
	[user_id] NVARCHAR(255),
	[article_type_id] NVARCHAR(255),
	[contact_id] NVARCHAR(255),
	[deliverer_code] NVARCHAR(255),
	[deliverer_name] NVARCHAR(255),
	[deliverer_description] TEXT,
	[intern_code] NVARCHAR(255),
	[intern_name] NVARCHAR(255),
	[intern_description] TEXT,
	[purchase_price] NVARCHAR(255),
	[sale_price] NVARCHAR(255),
	[purchase_total] NVARCHAR(255),
	[sale_total] NVARCHAR(255),
	[currency_id] NVARCHAR(255),
	[tax_income_id] NVARCHAR(255),
	[tax_id] NVARCHAR(255),
	[tax_expense_id] NVARCHAR(255),
	[unit_id] NVARCHAR(255),
	[is_stock] NVARCHAR(255),
	[stock_id] NVARCHAR(255),
	[stock_place_id] NVARCHAR(255),
	[stock_nr] NVARCHAR(255),
	[stock_min_nr] NVARCHAR(255),
	[stock_reserved_nr] NVARCHAR(255),
	[stock_available_nr] NVARCHAR(255),
	[stock_picked_nr] NVARCHAR(255),
	[stock_disposed_nr] NVARCHAR(255),
	[stock_ordered_nr] NVARCHAR(255),
	[width] NVARCHAR(255),
	[height] NVARCHAR(255),
	[weight] NVARCHAR(255),
	[volume] NVARCHAR(255),
	[html_text] NVARCHAR(255),
	[remarks] NVARCHAR(255),
	[delivery_price] NVARCHAR(255),
	[article_group_id] NVARCHAR(255)
);

CREATE TABLE [bexio].[article_type] (
	[id] NVARCHAR(255),
	[name] NVARCHAR(255)
);

CREATE TABLE [bexio].[position_article] (
	[id] NVARCHAR(255),
	[type] NVARCHAR(255),
	[amount] NVARCHAR(255),
	[unit_id] NVARCHAR(255),
	[account_id] NVARCHAR(255),
	[unit_name] NVARCHAR(255),
	[tax_id] NVARCHAR(255),
	[tax_value] NVARCHAR(255),
	[text] TEXT,
	[unit_price] NVARCHAR(255),
	[discount_in_percent] NVARCHAR(255),
	[position_total] NVARCHAR(255),
	[pos] NVARCHAR(255),
	[internal_pos] NVARCHAR(255),
	[parent_id] NVARCHAR(255),
	[is_optional] NVARCHAR(255),
	[article_id] NVARCHAR(255)
);

CREATE TABLE [bexio].[position_custom] (
	[id] NVARCHAR(255),
	[type] NVARCHAR(255),
	[amount] NVARCHAR(255),
	[unit_id] NVARCHAR(255),
	[account_id] NVARCHAR(255),
	[unit_name] NVARCHAR(255),
	[tax_id] NVARCHAR(255),
	[tax_value] NVARCHAR(255),
	[text] TEXT,
	[unit_price] NVARCHAR(255),
	[discount_in_percent] NVARCHAR(255),
	[position_total] NVARCHAR(255),
	[pos] NVARCHAR(255),
	[internal_pos] NVARCHAR(255),
	[parent_id] NVARCHAR(255),
	[is_optional] NVARCHAR(255)
);

CREATE TABLE [bexio].[position_discount] (
  [id] NVARCHAR(255),
  [type] NVARCHAR(255),
  [text] NVARCHAR(255),
  [is_percentual] NVARCHAR(255),
  [value] NVARCHAR(255),
  [discount_total] NVARCHAR(255)
);

CREATE TABLE [bexio].[position_article_relation] (
	[kb_order_id] NVARCHAR(255),
	[kb_invoice_id] NVARCHAR(255),
	[kb_delivery_id] NVARCHAR(255),
	[position_article_id] NVARCHAR(255)
);

CREATE TABLE [bexio].[position_custom_relation] (
	[kb_order_id] NVARCHAR(255),
	[kb_invoice_id] NVARCHAR(255),
	[kb_delivery_id] NVARCHAR(255),
	[position_custom_id] NVARCHAR(255)
);

CREATE TABLE [bexio].[position_discount_relation] (
	[kb_order_id] NVARCHAR(255),
	[kb_invoice_id] NVARCHAR(255),
	[kb_delivery_id] NVARCHAR(255),
	[position_discount_id] NVARCHAR(255)
);

CREATE TABLE [bexio].[contact_type] (
	[id] NVARCHAR(255),
	[name] NVARCHAR(255)
);

CREATE TABLE [bexio].[contact_branch] (
	[id] NVARCHAR(255),
	[name] NVARCHAR(255)
);

CREATE TABLE [bexio].[contact_group] (
	[id] NVARCHAR(255),
	[name] NVARCHAR(255)
);

CREATE TABLE [bexio].[contact_relation] (
	[id] NVARCHAR(255),
    [contact_id] NVARCHAR(255),
    [contact_sub_id] NVARCHAR(255),
    [description] NVARCHAR(255),
    [updated_at] NVARCHAR(255)
);

CREATE TABLE [bexio].[salutation] (
	[id] NVARCHAR(255),
	[name] NVARCHAR(255)
);

CREATE TABLE [bexio].[title] (
	[id] NVARCHAR(255),
	[name] NVARCHAR(255)
);

CREATE TABLE [bexio].[currency] (
	[id] NVARCHAR(255),
	[name] NVARCHAR(255),
	[round_factor] NVARCHAR(255)
);

CREATE TABLE [bexio].[country] (
    [id] NVARCHAR(255),
    [name] NVARCHAR(255),
    [name_short] NVARCHAR(255),
    [iso_3166_alpha2] NVARCHAR(255)
);

CREATE TABLE [bexio].[unit] (
	[id] NVARCHAR(255),
	[name] NVARCHAR(255)
);

CREATE TABLE [bexio].[payment_type] (
	[id] NVARCHAR(255),
	[name] NVARCHAR(255)
);

CREATE TABLE [bexio].[user] (
    [id] NVARCHAR(255),
    [nickname] NVARCHAR(255),
    [firstname] NVARCHAR(255),
    [lastname] NVARCHAR(255),
    [email] NVARCHAR(255),
    [color] NVARCHAR(255),
    [phone_fixed] NVARCHAR(255),
    [phone_mobile] NVARCHAR(255),
    [is_superadmin] NVARCHAR(255)
);

-- SCHEMA [ezv]
-- Exchange rates from http://www.pwebapps.ezv.admin.ch/apps/rates/estv/getavgxml
CREATE SCHEMA ezv;

CREATE TABLE [ezv].[fxrates_chf] (
    [monat] NVARCHAR(255),
    [code] NVARCHAR(255),
    [land_de] NVARCHAR(255),
    [land_fr] NVARCHAR(255),
    [land_it] NVARCHAR(255),
    [waehrung] NVARCHAR(255),
    [kurs] NVARCHAR(255)
);
