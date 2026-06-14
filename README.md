# 皮肤健康咨询网站

> 从头发丝到脚底板的皮肤健康咨询平台

## 功能

- **在线问诊**：客户填写症状，自动分析推荐产品
- **产品展示**：治疗类+护肤类产品卡片
- **管理后台**：查看咨询记录，更新状态，填写专业分析
- **照片上传**：客户上传患处照片，方便远程诊断

## 部署步骤

### 1. Supabase 设置

1. 打开 https://supabase.com，用 GitHub 登录
2. 点 New Project
   - Name: `skin-consult`
   - Region: `Southeast Asia (Singapore)` 或 `Northeast Asia (Tokyo)`
   - Database Password: 设一个复杂的密码，记住它
3. 等项目初始化完成（变绿）
4. 左侧菜单点 **SQL Editor**
5. 粘贴 `setup-supabase.sql` 的全部内容，点 **Run**
6. 显示 Success 就好了
7. 左侧菜单 **Storage** → **New bucket**
   - Name: `consultation-photos`
   - Public: 打勾
8. 左侧菜单 **Settings** → **API**
   - 复制 **Project URL**（格式：`https://xxxxxx.supabase.co`）
   - 复制 **anon public** Key（以 `eyJ` 开头的长字符串）

### 2. 填入配置

打开 `index.html`，搜索替换：

```
YOUR_SUPABASE_URL  →  你的 Project URL
YOUR_SUPABASE_ANON_KEY  →  你的 anon key
```

### 3. 本地测试

直接用浏览器打开 `index.html` 即可测试。

管理后台密码：`8866`

### 4. 部署到 Cloudflare Pages

1. 把代码推到 GitHub
2. 打开 https://dash.cloudflare.com → Pages
3. 点 Create a project → Connect to Git
4. 选你的 GitHub 仓库
5. Build settings 全部留空（纯静态站点不需要构建）
6. 点 Save and Deploy
7. 等部署完成，会给你一个 `xxx.pages.dev` 的域名

## 文件结构

```
skin-consult/
├── index.html          # 主页面（单页应用）
├── setup-supabase.sql  # Supabase 建表脚本
└── README.md           # 本文件
```

## 管理后台

访问网站后，点导航栏的「管理」，输入密码 `8866` 进入后台。

功能：
- 查看所有咨询记录
- 按状态筛选（待回复/已回复/跟进中/已完成）
- 点击记录查看详情+照片
- 更新状态、填写专业分析、内部备注
