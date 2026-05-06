-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 04, 2026 lúc 01:36 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `lomarket`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account_emailaddress`
--

CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `account_emailaddress`
--

INSERT INTO `account_emailaddress` (`id`, `email`, `verified`, `primary`, `user_id`) VALUES
(2, 'nmtri099019@gmail.com', 0, 1, 7),
(3, 'minhquan1999dt@gmail.com', 0, 1, 8);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account_emailconfirmation`
--

CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `authtoken_token`
--

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`) VALUES
('03637b303c4a49dbdc63b76a8deeeeb77f6e7dc7', '2026-04-29 03:50:34.674626', 7),
('6dba5c668c9715feea14eb53f6a181a013c6bbcd', '2026-04-28 03:36:31.031309', 2),
('fdaa286699fa41864169cfe5205fbe4f68906a10', '2026-04-30 07:05:10.662217', 8);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add member', 7, 'add_member'),
(26, 'Can change member', 7, 'change_member'),
(27, 'Can delete member', 7, 'delete_member'),
(28, 'Can view member', 7, 'view_member'),
(29, 'Can add email address', 8, 'add_emailaddress'),
(30, 'Can change email address', 8, 'change_emailaddress'),
(31, 'Can delete email address', 8, 'delete_emailaddress'),
(32, 'Can view email address', 8, 'view_emailaddress'),
(33, 'Can add email confirmation', 9, 'add_emailconfirmation'),
(34, 'Can change email confirmation', 9, 'change_emailconfirmation'),
(35, 'Can delete email confirmation', 9, 'delete_emailconfirmation'),
(36, 'Can view email confirmation', 9, 'view_emailconfirmation'),
(37, 'Can add social account', 10, 'add_socialaccount'),
(38, 'Can change social account', 10, 'change_socialaccount'),
(39, 'Can delete social account', 10, 'delete_socialaccount'),
(40, 'Can view social account', 10, 'view_socialaccount'),
(41, 'Can add social application', 11, 'add_socialapp'),
(42, 'Can change social application', 11, 'change_socialapp'),
(43, 'Can delete social application', 11, 'delete_socialapp'),
(44, 'Can view social application', 11, 'view_socialapp'),
(45, 'Can add social application token', 12, 'add_socialtoken'),
(46, 'Can change social application token', 12, 'change_socialtoken'),
(47, 'Can delete social application token', 12, 'delete_socialtoken'),
(48, 'Can view social application token', 12, 'view_socialtoken'),
(49, 'Can add Token', 13, 'add_token'),
(50, 'Can change Token', 13, 'change_token'),
(51, 'Can delete Token', 13, 'delete_token'),
(52, 'Can view Token', 13, 'view_token'),
(53, 'Can add Token', 14, 'add_tokenproxy'),
(54, 'Can change Token', 14, 'change_tokenproxy'),
(55, 'Can delete Token', 14, 'delete_tokenproxy'),
(56, 'Can view Token', 14, 'view_tokenproxy'),
(57, 'Can add site', 15, 'add_site'),
(58, 'Can change site', 15, 'change_site'),
(59, 'Can delete site', 15, 'delete_site'),
(60, 'Can view site', 15, 'view_site');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(2, 'pbkdf2_sha256$600000$p1IVBhLP8hOWtYl1zcP2kB$9BJFSEbRl7dKvv8G11efwe7S5FXPWcinH/w0gfjs5qU=', '2026-04-30 07:35:42.296313', 1, 'nguyenminhtri', '', '', 'nmtri099019@gmail.com', 1, 1, '2026-04-27 16:59:02.492467'),
(7, 'pbkdf2_sha256$600000$ijdXGNPhYZyqjXHykXWDSA$DTIiPpsUdZifZtftIohjZixTyHDmJWIh46x++S+yyQk=', '2026-04-29 03:51:00.907230', 0, 'minhtri', '', '', 'nmtri099019@gmail.com', 0, 1, '2026-04-29 03:50:34.503941'),
(8, 'pbkdf2_sha256$600000$qDDlZsvQ1DnkyxNHsB7GJ2$nIBXeQfnyzysCQIEsTnePnQRqZXnA3BANyg5ba95Z2M=', '2026-04-30 07:05:10.765066', 0, 'minhquan', '', '', 'minhquan1999dt@gmail.com', 0, 1, '2026-04-30 07:05:10.465495');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(8, 'account', 'emailaddress'),
(9, 'account', 'emailconfirmation'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(13, 'authtoken', 'token'),
(14, 'authtoken', 'tokenproxy'),
(5, 'contenttypes', 'contenttype'),
(7, 'members', 'member'),
(6, 'sessions', 'session'),
(15, 'sites', 'site'),
(10, 'socialaccount', 'socialaccount'),
(11, 'socialaccount', 'socialapp'),
(12, 'socialaccount', 'socialtoken');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-04-27 15:39:47.492204'),
(2, 'auth', '0001_initial', '2026-04-27 15:39:47.668885'),
(3, 'admin', '0001_initial', '2026-04-27 15:39:47.711580'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-04-27 15:39:47.716675'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-04-27 15:39:47.720847'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-04-27 15:39:47.750374'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-04-27 15:39:47.772854'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-04-27 15:39:47.779258'),
(9, 'auth', '0004_alter_user_username_opts', '2026-04-27 15:39:47.783929'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-04-27 15:39:47.806785'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-04-27 15:39:47.808230'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-04-27 15:39:47.815276'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-04-27 15:39:47.823407'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-04-27 15:39:47.831306'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-04-27 15:39:47.838608'),
(16, 'auth', '0011_update_proxy_permissions', '2026-04-27 15:39:47.844178'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-04-27 15:39:47.850832'),
(18, 'members', '0001_initial', '2026-04-27 15:39:47.855564'),
(19, 'members', '0002_member_joined_date_member_phone', '2026-04-27 15:39:47.863096'),
(20, 'sessions', '0001_initial', '2026-04-27 15:39:47.879288'),
(36, 'members', '0003_alter_member_id', '2026-04-27 16:51:01.259352'),
(37, 'authtoken', '0001_initial', '2026-04-28 01:42:45.703499'),
(38, 'authtoken', '0002_auto_20160226_1747', '2026-04-28 01:42:45.724597'),
(39, 'authtoken', '0003_tokenproxy', '2026-04-28 01:42:45.724597'),
(40, 'authtoken', '0004_alter_tokenproxy_options', '2026-04-28 01:42:45.732631'),
(41, 'account', '0001_initial', '2026-04-28 04:17:47.163519'),
(42, 'account', '0002_email_max_length', '2026-04-28 04:17:47.173997'),
(43, 'account', '0003_alter_emailaddress_create_unique_verified_email', '2026-04-28 04:17:47.185067'),
(44, 'account', '0004_alter_emailaddress_drop_unique_email', '2026-04-28 04:17:47.376111'),
(45, 'account', '0005_emailaddress_idx_upper_email', '2026-04-28 04:17:47.396734'),
(46, 'account', '0006_emailaddress_lower', '2026-04-28 04:17:47.397331'),
(47, 'account', '0007_emailaddress_idx_email', '2026-04-28 04:17:47.407330'),
(48, 'account', '0008_emailaddress_unique_primary_email_fixup', '2026-04-28 04:17:47.423433'),
(49, 'account', '0009_emailaddress_unique_primary_email', '2026-04-28 04:17:47.423433'),
(50, 'sites', '0001_initial', '2026-04-28 04:17:47.423433'),
(51, 'sites', '0002_alter_domain_unique', '2026-04-28 04:17:47.455925'),
(52, 'socialaccount', '0001_initial', '2026-04-28 04:17:47.597470'),
(53, 'socialaccount', '0002_token_max_lengths', '2026-04-28 04:17:47.613315'),
(54, 'socialaccount', '0003_extra_data_default_dict', '2026-04-28 04:17:47.613315'),
(55, 'socialaccount', '0004_app_provider_id_settings', '2026-04-28 04:17:47.645181'),
(56, 'socialaccount', '0005_socialtoken_nullable_app', '2026-04-28 04:17:47.724149'),
(57, 'socialaccount', '0006_alter_socialaccount_extra_data', '2026-04-28 04:17:47.755862');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('094z8zjcjcpyl4l6y0ia8fuas0b4lx19', '.eJxVjMsOwiAQRf-FtSEwAwx16b7fQIaHUjU0Ke3K-O_apAvd3nPOfYnA21rD1ssSpizOAsTpd4ucHqXtIN-53WaZ5rYuU5S7Ig_a5Tjn8rwc7t9B5V6_tdJaF_IDIhkALA5BoY-oYIArGWSwikpUwC55cllxjCaDNpZ0dsaK9weRcjYG:1wHdWk:GHDuPzBzYCPiYIH1xDv7u_GAjveIYofA8eXv3M_B4iQ', '2026-05-12 08:10:42.537321'),
('22iw9l0gi907hfqiqfypcp2dyceutucu', '.eJxVjMsOwiAQRf-FtSEwAwx16b7fQIaHUjU0Ke3K-O_apAvd3nPOfYnA21rD1ssSpizOAsTpd4ucHqXtIN-53WaZ5rYuU5S7Ig_a5Tjn8rwc7t9B5V6_tdJaF_IDIhkALA5BoY-oYIArGWSwikpUwC55cllxjCaDNpZ0dsaK9weRcjYG:1wILvy:BxPSXkhLCESaC1W-DVNJtIQeLuvw9SEOMbLzFvn9Fv4', '2026-05-14 07:35:42.300320'),
('4vf88w2qq9w7johy69qcr8rwurg0xikk', '.eJxVjMsOwiAQRf-FtSEwAwx16b7fQIaHUjU0Ke3K-O_apAvd3nPOfYnA21rD1ssSpizOAsTpd4ucHqXtIN-53WaZ5rYuU5S7Ig_a5Tjn8rwc7t9B5V6_tdJaF_IDIhkALA5BoY-oYIArGWSwikpUwC55cllxjCaDNpZ0dsaK9weRcjYG:1wHdmT:YdzGovZxp6feFRIlZHozKlzKnx2jgsnNv5tAmDbWKB8', '2026-05-12 08:26:57.686671'),
('fsf229shm8s7845bq801ir95nhegleaa', '.eJxVjMsOwiAQRf-FtSEwAwx16b7fQIaHUjU0Ke3K-O_apAvd3nPOfYnA21rD1ssSpizOAsTpd4ucHqXtIN-53WaZ5rYuU5S7Ig_a5Tjn8rwc7t9B5V6_tdJaF_IDIhkALA5BoY-oYIArGWSwikpUwC55cllxjCaDNpZ0dsaK9weRcjYG:1wHe8C:EN-n-haE1BTfHD_B7bxxI1mjuAMM9i1IILq1ep2Brh4', '2026-05-12 08:49:24.078273'),
('gyimyqtihvijrhpawrzhtoeitve0wmt7', '.eJxVjMsOwiAQRf-FtSEwAwx16b7fQIaHUjU0Ke3K-O_apAvd3nPOfYnA21rD1ssSpizOAsTpd4ucHqXtIN-53WaZ5rYuU5S7Ig_a5Tjn8rwc7t9B5V6_tdJaF_IDIhkALA5BoY-oYIArGWSwikpUwC55cllxjCaDNpZ0dsaK9weRcjYG:1wHdrm:JONghFBqigZLbTZir1E8HnXrA9IE5abw0dum44CBL5U', '2026-05-12 08:32:26.736718'),
('rdl8ppjx5esy6x5asj7f84zmro26p1hi', '.eJxVjMsOwiAQRf-FtSEwAwx16b7fQIaHUjU0Ke3K-O_apAvd3nPOfYnA21rD1ssSpizOAsTpd4ucHqXtIN-53WaZ5rYuU5S7Ig_a5Tjn8rwc7t9B5V6_tdJaF_IDIhkALA5BoY-oYIArGWSwikpUwC55cllxjCaDNpZ0dsaK9weRcjYG:1wHuyl:3nSzKiyjBr6zKyTjw6ZAZMaSvBO_BN23pbcnw5EYUzk', '2026-05-13 02:48:47.494089'),
('zqrf8b1ga5orccdyawqbjlsz6is9erlp', '.eJxVjMEOgjAQRP-lZ9O0tCzFo3e-odndLhY1JaFwMv67kHDQ22Tem3mriNua41ZliVNSV9Wpy29HyE8pB0gPLPdZ81zWZSJ9KPqkVQ9zktftdP8OMta8r0FCGNmwjI0hJhe46VtE6ywBW-PIJ3bJAGKATjxBL63dMwAl561Xny8CBTgl:1wHvwy:dqKp-ajCwGu6Rh9QJ7JGa-l5jPpXx13NgUt2mdbtj7Y', '2026-05-13 03:51:00.907230'),
('zxy0e3syyffirfgsj580uceq8kcnfz93', '.eJxVjM0OwiAQhN-FsyHdlp_iTV-EbJclEBuaCJyM725retDjfDPzvYTH3pLvlZ8-B3EVRlx-2YL04HIUuK4Hlki09dLkd3PWVd72xKVlwpa3cj9ff6qENe0eNhNoHl3Uw6wJXLRAi1GgBkvWGAsBwLlJKQQeowGFMzJSsDYGQori_QGaKDxP:1wHlWk:2kKmczouFZcg4z2ZKUfaXpBy5fX4VEyqebbJHO6UmgA', '2026-05-12 16:43:14.105811');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_site`
--

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `django_site`
--

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
(1, 'example.com', 'example.com');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `members_member`
--

CREATE TABLE `members_member` (
  `id` int(11) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `joined_date` date DEFAULT NULL,
  `phone` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `socialaccount_socialaccount`
--

CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL,
  `provider` varchar(200) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`extra_data`)),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `socialaccount_socialapp`
--

CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `provider_id` varchar(200) NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`settings`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `socialaccount_socialapp_sites`
--

CREATE TABLE `socialaccount_socialapp_sites` (
  `id` int(11) NOT NULL,
  `socialapp_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `socialaccount_socialtoken`
--

CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_emailaddress_user_id_email_987c8728_uniq` (`user_id`,`email`),
  ADD KEY `account_emailaddress_email_03be32b2` (`email`);

--
-- Chỉ mục cho bảng `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`),
  ADD KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`);

--
-- Chỉ mục cho bảng `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Chỉ mục cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Chỉ mục cho bảng `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Chỉ mục cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Chỉ mục cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Chỉ mục cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Chỉ mục cho bảng `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Chỉ mục cho bảng `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Chỉ mục cho bảng `django_site`
--
ALTER TABLE `django_site`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`);

--
-- Chỉ mục cho bảng `members_member`
--
ALTER TABLE `members_member`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  ADD KEY `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` (`user_id`);

--
-- Chỉ mục cho bảng `socialaccount_socialapp`
--
ALTER TABLE `socialaccount_socialapp`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `socialaccount_socialapp_sites`
--
ALTER TABLE `socialaccount_socialapp_sites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  ADD KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`);

--
-- Chỉ mục cho bảng `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  ADD KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT cho bảng `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT cho bảng `django_site`
--
ALTER TABLE `django_site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `members_member`
--
ALTER TABLE `members_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `socialaccount_socialapp`
--
ALTER TABLE `socialaccount_socialapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `socialaccount_socialapp_sites`
--
ALTER TABLE `socialaccount_socialapp_sites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  ADD CONSTRAINT `account_emailaddress_user_id_2c513194_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  ADD CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`);

--
-- Các ràng buộc cho bảng `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Các ràng buộc cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Các ràng buộc cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  ADD CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `socialaccount_socialapp_sites`
--
ALTER TABLE `socialaccount_socialapp_sites`
  ADD CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  ADD CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`);

--
-- Các ràng buộc cho bảng `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  ADD CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  ADD CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
