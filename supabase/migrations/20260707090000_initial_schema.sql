-- Criminal Brushes initial Supabase schema.
-- Money values are stored in minor units, for example RUB kopecks.

create extension if not exists pgcrypto;

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  phone text,
  full_name text,
  role text not null default 'customer' check (role in ('customer', 'manager', 'admin')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.collections (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  description text,
  hero_image_path text,
  sort_order integer not null default 0,
  is_active boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.products (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  subtitle text,
  description text,
  status text not null default 'draft' check (status in ('draft', 'active', 'archived')),
  base_price_minor integer not null check (base_price_minor >= 0),
  currency text not null default 'RUB',
  collection_id uuid references public.collections(id) on delete set null,
  is_featured boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.product_images (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id) on delete cascade,
  storage_path text not null,
  alt_text text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table public.product_variants (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id) on delete cascade,
  sku text not null unique,
  color_name text not null,
  color_hex text not null,
  price_minor integer not null check (price_minor >= 0),
  stock_quantity integer not null default 0 check (stock_quantity >= 0),
  image_id uuid references public.product_images(id) on delete set null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.shipping_addresses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  country text not null default 'RU',
  city text not null,
  postal_code text,
  address_line1 text not null,
  address_line2 text,
  recipient_name text not null,
  recipient_phone text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.delivery_methods (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  price_minor integer not null default 0 check (price_minor >= 0),
  free_from_minor integer check (free_from_minor is null or free_from_minor >= 0),
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.promo_codes (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  type text not null check (type in ('percent', 'fixed_minor', 'free_delivery')),
  value integer not null check (value >= 0),
  starts_at timestamptz,
  ends_at timestamptz,
  usage_limit integer check (usage_limit is null or usage_limit >= 0),
  used_count integer not null default 0 check (used_count >= 0),
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.orders (
  id uuid primary key default gen_random_uuid(),
  order_number text not null unique,
  user_id uuid references auth.users(id) on delete set null,
  status text not null default 'draft' check (
    status in ('draft', 'pending_payment', 'paid', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded')
  ),
  payment_status text not null default 'unpaid' check (
    payment_status in ('unpaid', 'pending', 'paid', 'failed', 'refunded', 'cancelled')
  ),
  delivery_status text not null default 'not_started' check (
    delivery_status in ('not_started', 'preparing', 'shipped', 'delivered', 'failed', 'returned')
  ),
  subtotal_minor integer not null default 0 check (subtotal_minor >= 0),
  discount_minor integer not null default 0 check (discount_minor >= 0),
  delivery_price_minor integer not null default 0 check (delivery_price_minor >= 0),
  total_minor integer not null default 0 check (total_minor >= 0),
  currency text not null default 'RUB',
  customer_email text,
  customer_phone text,
  customer_name text,
  shipping_address_id uuid references public.shipping_addresses(id) on delete set null,
  promo_code_id uuid references public.promo_codes(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  variant_id uuid references public.product_variants(id) on delete set null,
  product_name text not null,
  variant_name text not null,
  sku text not null,
  unit_price_minor integer not null check (unit_price_minor >= 0),
  quantity integer not null check (quantity > 0),
  total_minor integer not null check (total_minor >= 0),
  created_at timestamptz not null default now()
);

create table public.payments (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  provider text not null,
  external_payment_id text,
  status text not null default 'pending' check (status in ('pending', 'paid', 'failed', 'refunded', 'cancelled')),
  amount_minor integer not null check (amount_minor >= 0),
  currency text not null default 'RUB',
  raw_payload jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.reviews (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  order_id uuid references public.orders(id) on delete set null,
  rating integer not null check (rating between 1 and 5),
  text text,
  status text not null default 'pending' check (status in ('pending', 'published', 'rejected')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.wishlist_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  product_id uuid not null references public.products(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (user_id, product_id)
);

create table public.content_blocks (
  id uuid primary key default gen_random_uuid(),
  key text not null unique,
  title text,
  body text,
  image_path text,
  cta_label text,
  cta_url text,
  sort_order integer not null default 0,
  is_active boolean not null default false,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.inventory_movements (
  id uuid primary key default gen_random_uuid(),
  variant_id uuid not null references public.product_variants(id) on delete cascade,
  delta integer not null,
  reason text not null,
  order_id uuid references public.orders(id) on delete set null,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

create table public.admin_audit_logs (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references auth.users(id) on delete set null,
  action text not null,
  entity_type text not null,
  entity_id uuid,
  before jsonb,
  after jsonb,
  created_at timestamptz not null default now()
);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles
    where id = auth.uid()
      and role in ('admin', 'manager')
  );
$$;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, full_name)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name')
  )
  on conflict (id) do nothing;

  return new;
end;
$$;

create trigger on_auth_user_created
after insert on auth.users
for each row execute function public.handle_new_user();

create trigger set_profiles_updated_at
before update on public.profiles
for each row execute function public.set_updated_at();

create trigger set_collections_updated_at
before update on public.collections
for each row execute function public.set_updated_at();

create trigger set_products_updated_at
before update on public.products
for each row execute function public.set_updated_at();

create trigger set_product_variants_updated_at
before update on public.product_variants
for each row execute function public.set_updated_at();

create trigger set_shipping_addresses_updated_at
before update on public.shipping_addresses
for each row execute function public.set_updated_at();

create trigger set_delivery_methods_updated_at
before update on public.delivery_methods
for each row execute function public.set_updated_at();

create trigger set_promo_codes_updated_at
before update on public.promo_codes
for each row execute function public.set_updated_at();

create trigger set_orders_updated_at
before update on public.orders
for each row execute function public.set_updated_at();

create trigger set_payments_updated_at
before update on public.payments
for each row execute function public.set_updated_at();

create trigger set_reviews_updated_at
before update on public.reviews
for each row execute function public.set_updated_at();

create trigger set_content_blocks_updated_at
before update on public.content_blocks
for each row execute function public.set_updated_at();

create index collections_active_sort_idx on public.collections (is_active, sort_order);
create index products_status_featured_idx on public.products (status, is_featured);
create index products_collection_idx on public.products (collection_id);
create index product_images_product_sort_idx on public.product_images (product_id, sort_order);
create index product_variants_product_idx on public.product_variants (product_id);
create index orders_user_created_idx on public.orders (user_id, created_at desc);
create index order_items_order_idx on public.order_items (order_id);
create index payments_order_idx on public.payments (order_id);
create index reviews_product_status_idx on public.reviews (product_id, status);
create index wishlist_user_idx on public.wishlist_items (user_id);
create index content_blocks_active_sort_idx on public.content_blocks (is_active, sort_order);
create index inventory_variant_created_idx on public.inventory_movements (variant_id, created_at desc);
create index admin_audit_actor_created_idx on public.admin_audit_logs (actor_id, created_at desc);

alter table public.profiles enable row level security;
alter table public.collections enable row level security;
alter table public.products enable row level security;
alter table public.product_images enable row level security;
alter table public.product_variants enable row level security;
alter table public.shipping_addresses enable row level security;
alter table public.delivery_methods enable row level security;
alter table public.promo_codes enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.payments enable row level security;
alter table public.reviews enable row level security;
alter table public.wishlist_items enable row level security;
alter table public.content_blocks enable row level security;
alter table public.inventory_movements enable row level security;
alter table public.admin_audit_logs enable row level security;

create policy "Public can read active collections"
on public.collections for select
using (is_active = true);

create policy "Admins can manage collections"
on public.collections for all
using (public.is_admin())
with check (public.is_admin());

create policy "Public can read active products"
on public.products for select
using (status = 'active');

create policy "Admins can manage products"
on public.products for all
using (public.is_admin())
with check (public.is_admin());

create policy "Public can read images for active products"
on public.product_images for select
using (
  exists (
    select 1
    from public.products
    where products.id = product_images.product_id
      and products.status = 'active'
  )
);

create policy "Admins can manage product images"
on public.product_images for all
using (public.is_admin())
with check (public.is_admin());

create policy "Public can read active variants for active products"
on public.product_variants for select
using (
  is_active = true
  and exists (
    select 1
    from public.products
    where products.id = product_variants.product_id
      and products.status = 'active'
  )
);

create policy "Admins can manage product variants"
on public.product_variants for all
using (public.is_admin())
with check (public.is_admin());

create policy "Users can read own profile"
on public.profiles for select
using (auth.uid() = id or public.is_admin());

create policy "Users can update own profile"
on public.profiles for update
using (auth.uid() = id)
with check (auth.uid() = id and role = 'customer');

create policy "Admins can manage profiles"
on public.profiles for all
using (public.is_admin())
with check (public.is_admin());

create policy "Users can manage own shipping addresses"
on public.shipping_addresses for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "Admins can manage shipping addresses"
on public.shipping_addresses for all
using (public.is_admin())
with check (public.is_admin());

create policy "Public can read active delivery methods"
on public.delivery_methods for select
using (is_active = true);

create policy "Admins can manage delivery methods"
on public.delivery_methods for all
using (public.is_admin())
with check (public.is_admin());

create policy "Admins can manage promo codes"
on public.promo_codes for all
using (public.is_admin())
with check (public.is_admin());

create policy "Users can read own orders"
on public.orders for select
using (auth.uid() = user_id or public.is_admin());

create policy "Users can create own orders"
on public.orders for insert
with check (auth.uid() = user_id);

create policy "Admins can manage orders"
on public.orders for all
using (public.is_admin())
with check (public.is_admin());

create policy "Users can read own order items"
on public.order_items for select
using (
  public.is_admin()
  or exists (
    select 1
    from public.orders
    where orders.id = order_items.order_id
      and orders.user_id = auth.uid()
  )
);

create policy "Admins can manage order items"
on public.order_items for all
using (public.is_admin())
with check (public.is_admin());

create policy "Users can read own payments"
on public.payments for select
using (
  public.is_admin()
  or exists (
    select 1
    from public.orders
    where orders.id = payments.order_id
      and orders.user_id = auth.uid()
  )
);

create policy "Admins can manage payments"
on public.payments for all
using (public.is_admin())
with check (public.is_admin());

create policy "Public can read published reviews"
on public.reviews for select
using (status = 'published');

create policy "Users can create own reviews"
on public.reviews for insert
with check (auth.uid() = user_id);

create policy "Users can read own reviews"
on public.reviews for select
using (auth.uid() = user_id or public.is_admin());

create policy "Admins can manage reviews"
on public.reviews for all
using (public.is_admin())
with check (public.is_admin());

create policy "Users can manage own wishlist"
on public.wishlist_items for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "Public can read active content blocks"
on public.content_blocks for select
using (is_active = true);

create policy "Admins can manage content blocks"
on public.content_blocks for all
using (public.is_admin())
with check (public.is_admin());

create policy "Admins can manage inventory movements"
on public.inventory_movements for all
using (public.is_admin())
with check (public.is_admin());

create policy "Admins can read audit logs"
on public.admin_audit_logs for select
using (public.is_admin());

create policy "Admins can create audit logs"
on public.admin_audit_logs for insert
with check (public.is_admin());

insert into public.collections (slug, name, description, sort_order, is_active)
values
  ('tiny-trouble-drop', 'Tiny Trouble Drop', 'Первый drop электрических детских щеток Criminal Brushes.', 10, true);

insert into public.products (
  slug,
  name,
  subtitle,
  description,
  status,
  base_price_minor,
  currency,
  collection_id,
  is_featured
)
select
  'tiny-trouble',
  'Tiny Trouble',
  'Bubblegum Pink',
  'Мягкая щетина, умная вибрация и 2 минуты веселой чистки.',
  'active',
  599000,
  'RUB',
  collections.id,
  true
from public.collections
where slug = 'tiny-trouble-drop';

insert into public.product_variants (
  product_id,
  sku,
  color_name,
  color_hex,
  price_minor,
  stock_quantity,
  is_active
)
select products.id, variant.sku, variant.color_name, variant.color_hex, 599000, 100, true
from public.products
cross join (
  values
    ('CB-TT-PINK', 'Bubblegum Pink', '#FF5AAE'),
    ('CB-TT-LIME', 'Acid Lime', '#D7FF22'),
    ('CB-TT-BLACK', 'Stealth Black', '#050505'),
    ('CB-TT-BLUE', 'Cool Blue', '#BFE9FF')
) as variant(sku, color_name, color_hex)
where products.slug = 'tiny-trouble';

insert into public.delivery_methods (name, description, price_minor, free_from_minor, is_active)
values
  ('Стандартная доставка', 'Доставка по России после подтверждения заказа.', 30000, 300000, true);

insert into public.content_blocks (key, title, body, sort_order, is_active, metadata)
values
  (
    'home-hero',
    'Brush like a rebel',
    'Электрическая зубная щетка для маленьких бунтарей.',
    10,
    true,
    '{"cta":"В корзину","theme":"criminal-brushes"}'::jsonb
  );
