# Database Schema

## Общие принципы

- Supabase/Postgres является основным источником данных.
- Все таблицы с пользовательскими или бизнес-данными должны иметь RLS.
- В таблицах используем `uuid` primary key.
- Для дат используем `timestamptz`.
- Для денег используем integer minor units, например копейки, а не float.

## Таблицы MVP

### profiles

Профиль пользователя, связанный с Supabase Auth.

```text
id uuid primary key references auth.users(id)
email text
phone text
full_name text
role text default 'customer'
created_at timestamptz
updated_at timestamptz
```

Роли:

- `customer`
- `manager`
- `admin`

### products

```text
id uuid primary key
slug text unique
name text
subtitle text
description text
status text
base_price_minor integer
currency text default 'RUB'
collection_id uuid references collections(id)
is_featured boolean
created_at timestamptz
updated_at timestamptz
```

Статусы:

- `draft`
- `active`
- `archived`

### product_variants

```text
id uuid primary key
product_id uuid references products(id)
sku text unique
color_name text
color_hex text
price_minor integer
stock_quantity integer
image_id uuid references product_images(id)
is_active boolean
created_at timestamptz
updated_at timestamptz
```

### product_images

```text
id uuid primary key
product_id uuid references products(id)
storage_path text
alt_text text
sort_order integer
created_at timestamptz
```

### collections

```text
id uuid primary key
slug text unique
name text
description text
hero_image_path text
sort_order integer
is_active boolean
created_at timestamptz
updated_at timestamptz
```

### cart_items

```text
id uuid primary key
user_id uuid references auth.users(id)
session_id text
variant_id uuid references product_variants(id)
quantity integer
created_at timestamptz
updated_at timestamptz
```

Для гостей можно хранить корзину локально на клиенте, а в таблицу переносить после авторизации или checkout.

### orders

```text
id uuid primary key
order_number text unique
user_id uuid references auth.users(id)
status text
payment_status text
delivery_status text
subtotal_minor integer
discount_minor integer
delivery_price_minor integer
total_minor integer
currency text default 'RUB'
customer_email text
customer_phone text
customer_name text
shipping_address_id uuid references shipping_addresses(id)
promo_code_id uuid references promo_codes(id)
created_at timestamptz
updated_at timestamptz
```

Order statuses:

- `draft`
- `pending_payment`
- `paid`
- `processing`
- `shipped`
- `delivered`
- `cancelled`
- `refunded`

### order_items

```text
id uuid primary key
order_id uuid references orders(id)
product_id uuid references products(id)
variant_id uuid references product_variants(id)
product_name text
variant_name text
sku text
unit_price_minor integer
quantity integer
total_minor integer
created_at timestamptz
```

Дублируем название, SKU и цену на момент заказа, чтобы история заказа не ломалась при изменении каталога.

### payments

```text
id uuid primary key
order_id uuid references orders(id)
provider text
external_payment_id text
status text
amount_minor integer
currency text
raw_payload jsonb
created_at timestamptz
updated_at timestamptz
```

### shipping_addresses

```text
id uuid primary key
user_id uuid references auth.users(id)
country text
city text
postal_code text
address_line1 text
address_line2 text
recipient_name text
recipient_phone text
created_at timestamptz
updated_at timestamptz
```

### delivery_methods

```text
id uuid primary key
name text
description text
price_minor integer
free_from_minor integer
is_active boolean
created_at timestamptz
updated_at timestamptz
```

### promo_codes

```text
id uuid primary key
code text unique
type text
value integer
starts_at timestamptz
ends_at timestamptz
usage_limit integer
used_count integer
is_active boolean
created_at timestamptz
updated_at timestamptz
```

Types:

- `percent`
- `fixed_minor`
- `free_delivery`

### reviews

```text
id uuid primary key
product_id uuid references products(id)
user_id uuid references auth.users(id)
order_id uuid references orders(id)
rating integer
text text
status text
created_at timestamptz
updated_at timestamptz
```

### wishlist_items

```text
id uuid primary key
user_id uuid references auth.users(id)
product_id uuid references products(id)
created_at timestamptz
```

### content_blocks

```text
id uuid primary key
key text unique
title text
body text
image_path text
cta_label text
cta_url text
sort_order integer
is_active boolean
metadata jsonb
created_at timestamptz
updated_at timestamptz
```

### inventory_movements

```text
id uuid primary key
variant_id uuid references product_variants(id)
delta integer
reason text
order_id uuid references orders(id)
created_by uuid references auth.users(id)
created_at timestamptz
```

### admin_audit_logs

```text
id uuid primary key
actor_id uuid references auth.users(id)
action text
entity_type text
entity_id uuid
before jsonb
after jsonb
created_at timestamptz
```

## RLS минимум

- Гости могут читать только `active` продукты, коллекции и активные content blocks.
- Покупатель может читать и менять только свой профиль, адреса, wishlist и заказы.
- Покупатель не может напрямую менять `payment_status`.
- Manager/Admin имеют доступ через роль.
- Все admin mutations логируются.
- Webhook функции используют service role, но код функции валидирует провайдера и payload.
