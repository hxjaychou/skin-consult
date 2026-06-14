-- ============================================
-- 皮肤健康咨询网站 - Supabase 建表脚本
-- ============================================
-- 使用方法：
-- 1. 登录 https://supabase.com
-- 2. 创建新项目（选 Singapore 或 Tokyo 区域）
-- 3. 左侧菜单点 SQL Editor
-- 4. 粘贴下面全部内容，点 Run
-- 5. 等显示 Success
-- 6. 左侧菜单 Settings -> API，复制 URL 和 anon key
-- 7. 填到 index.html 里的 YOUR_SUPABASE_URL 和 YOUR_SUPABASE_ANON_KEY
-- 8. 左侧菜单 Storage -> New bucket，名字填 consultation-photos，开启 Public
-- ============================================

-- 1. 创建咨询记录表
create table consultations (
  id uuid default gen_random_uuid() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  nickname text not null,
  contact text not null,
  category text not null,
  symptom text not null,
  photo_url text,
  history text default '',
  expectation text default '',
  status text default '待回复' not null,
  analysis text default '',
  recommended_products text[] default '{}',
  notes text default ''
);

-- 2. 开启行级安全策略
alter table consultations enable row level security;

-- 3. 允许匿名用户读写（前端直连需要）
create policy "Allow anonymous insert" on consultations
  for insert with check (true);

create policy "Allow anonymous select" on consultations
  for select using (true);

create policy "Allow anonymous update" on consultations
  for update using (true);

-- 4. 创建索引加速查询
create index idx_consultations_status on consultations(status);
create index idx_consultations_created_at on consultations(created_at desc);
create index idx_consultations_category on consultations(category);

-- 5. 创建照片存储桶（也可以在控制台手动创建）
-- 在 Storage 页面点 New bucket：
--   Name: consultation-photos
--   Public: 开启（打勾）

-- 6. 如果已经创建了 bucket，执行下面的策略让图片可公开访问
-- 在 SQL Editor 里运行：
create policy "Public access for consultation photos" on storage.objects
  for select using (bucket_id = 'consultation-photos');

create policy "Allow upload consultation photos" on storage.objects
  for insert with check (bucket_id = 'consultation-photos');
-- ============================================
-- 建表完成！
-- ============================================
