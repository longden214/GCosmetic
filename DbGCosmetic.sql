USE [GCosmetic]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý Ă ĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END


GO
/****** Object:  Table [dbo].[category]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[slug] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[config]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[config](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NULL,
	[value] [nvarchar](255) NULL,
	[url] [text] NULL,
	[status] [bit] NULL DEFAULT ((1)),
	[CreatedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExceptionLogger]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExceptionLogger](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExceptionMessage] [nvarchar](max) NULL,
	[ControllerName] [varchar](255) NULL,
	[ExceptionStackTrace] [nvarchar](max) NULL,
	[LogTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[brand] [nvarchar](255) NULL,
	[image] [varchar](255) NULL,
	[image_list] [text] NULL,
	[price] [float] NULL DEFAULT ((0)),
	[description] [nvarchar](max) NULL,
	[category_id] [int] NULL,
	[content] [nvarchar](max) NULL,
	[status] [bit] NULL DEFAULT ((1)),
	[viewCount] [int] NULL DEFAULT ((0)),
	[slug] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product_attribute_values]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_attribute_values](
	[value_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[attribute_id] [int] NULL,
	[status] [bit] NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[value_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_attributes]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_attributes](
	[attribute_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[product_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[attribute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[skus]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[skus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[price] [float] NULL DEFAULT ((0)),
	[product_id] [int] NULL,
	[sku] [varchar](255) NULL,
	[sku_attributes] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](100) NOT NULL,
	[displayName] [nvarchar](max) NOT NULL,
	[email] [varchar](max) NOT NULL,
	[avatar] [nvarchar](255) NULL,
	[password] [varchar](255) NULL,
	[CreatedDate] [datetime] NULL DEFAULT (getdate()),
	[ResetPasswordCode] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2094, N'Trang điểm môi', N'trang-diem-moi', CAST(N'2021-08-14 15:58:29.003' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2095, N'Trang điểm mặt', N'trang-diem-mat', CAST(N'2021-08-14 15:58:37.213' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2096, N'Dụng cụ làm đẹp', N'dung-cu-lam-dep', CAST(N'2021-08-14 15:58:43.027' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2097, N'Sữa rửa mặt', N'sua-rua-mat', CAST(N'2021-08-14 15:58:48.800' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2098, N'Nước cân bằng da', N'nuoc-can-bang-da', CAST(N'2021-08-14 15:58:54.650' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2099, N'Tắm & chăm sóc cơ thể', N'tam-cham-soc-co-the', CAST(N'2021-08-14 15:59:01.610' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2100, N'Kem dưỡng ẩm', N'kem-duong-am', CAST(N'2021-08-14 15:59:09.487' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2101, N'Kem chống nắng cho mặt', N'kem-chong-nang-cho-mat', CAST(N'2021-08-14 15:59:14.933' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2103, N'Tinh chất dưỡng', N'tinh-chat-duong', CAST(N'2021-08-14 15:59:31.057' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2104, N'Trang điểm mắt', N'trang-diem-mat', CAST(N'2021-08-14 15:59:39.087' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2105, N'Tẩy trang', N'tay-trang', CAST(N'2021-08-14 15:59:45.440' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2106, N'Nước hoa', N'nuoc-hoa', CAST(N'2021-08-15 10:48:51.987' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2107, N'Chăm sóc da mặt', N'cham-soc-da-mat', CAST(N'2021-08-15 10:57:31.440' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2112, N'Mặt nạ', N'mat-na', CAST(N'2021-08-15 16:48:26.027' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2113, N'Nhà cửa & Đời sống', N'nha-cua-doi-song', CAST(N'2021-08-16 21:55:29.023' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2114, N'Chăm sóc tóc', N'cham-soc-toc', CAST(N'2021-08-17 11:17:46.567' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2115, N'Mẹ & Bé', N'me-be', CAST(N'2021-08-17 16:19:40.620' AS DateTime))
INSERT [dbo].[category] ([id], [name], [slug], [CreatedDate]) VALUES (2116, N'Bộ sản phẩm làm đẹp', N'bo-san-pham-lam-dep', CAST(N'2021-08-18 16:26:03.877' AS DateTime))
SET IDENTITY_INSERT [dbo].[category] OFF
SET IDENTITY_INSERT [dbo].[config] ON 

INSERT [dbo].[config] ([id], [title], [value], [url], [status], [CreatedDate]) VALUES (1, N'Email', N'ahihi214@gmail.com', NULL, 1, CAST(N'2021-06-29 22:27:40.480' AS DateTime))
INSERT [dbo].[config] ([id], [title], [value], [url], [status], [CreatedDate]) VALUES (2, N'Phone', N'0988932076', NULL, 1, CAST(N'2021-06-29 22:27:40.480' AS DateTime))
INSERT [dbo].[config] ([id], [title], [value], [url], [status], [CreatedDate]) VALUES (3, N'Address', N'Xuân Trung, Nam Định', NULL, 1, CAST(N'2021-06-29 22:27:40.480' AS DateTime))
INSERT [dbo].[config] ([id], [title], [value], [url], [status], [CreatedDate]) VALUES (4, N'Working', N'8.00 - 22.00', NULL, 1, CAST(N'2021-06-29 22:27:40.480' AS DateTime))
INSERT [dbo].[config] ([id], [title], [value], [url], [status], [CreatedDate]) VALUES (5, N'Logo', N'/Uploads/images/logo/logoG.png', NULL, 1, CAST(N'2021-06-29 22:27:40.480' AS DateTime))
INSERT [dbo].[config] ([id], [title], [value], [url], [status], [CreatedDate]) VALUES (6, N'favicon', N'/Uploads/images/favicon/faviconG.ico', N'', 1, CAST(N'2021-08-08 21:50:26.317' AS DateTime))
SET IDENTITY_INSERT [dbo].[config] OFF
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4033, N'Son Kem 3CE Soft Lip Lacquer', N'3ce', N'/Uploads/images/product/pro1.jpg', N'/Uploads/images/product/pro1.jpg', 0, N'Son kem lì 3CE Soft Lip Lacquer là phiên bản nâng cấp của son lì truyền thống, lì vừa phải, có độ trơn mềm nhất định chứ không khô hẳn, là dòng son mang kết cấu chất son đặc biệt đầu tiên của hãng cùng với bảng màu đa dạng, dễ dùng cho bạn đôi môi mượt mà', 2094, N'<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>- Thương hiệu: 3CE</p>

<p>&nbsp;</p>

<p>- Bảng m&agrave;u:</p>

<p>+ Almost Mauve: t&iacute;m lạnh</p>

<p>+ Perk Up: đỏ hồng trầm</p>

<p>+ Change Mode: đỏ lạnh</p>

<p>+ Null Set: đỏ gạch</p>

<p>+ Explicit: hồng san h&ocirc;</p>

<p>+ Shawty: hồng tươi</p>

<p>+ Tawny Red: cam đất</p>
', 1, 0, N'son-kem-3ce-soft-lip-lacquer', CAST(N'2021-08-14 16:39:26.267' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4034, N'Mút tán Karadium Real Water Puff', N'Karadium', N'/Uploads/images/product/pro2.jpg', N'/Uploads/images/product/pro2.jpg', 90000, N'Mút tán kem nền - Karadium Real Water Puff được làm từ chất liệu cao su Latex có độ đàn hồi cực tốt cùng bề mặt mịn màng, mềm mại, lướt nhẹ nhàng trên da, tán kem hoàn hảo mà không gây rát da, kích ứng hoặc khó chịu khi sử dụng. Bông có thiết kế độc đáo v', 2096, N'<p>Xuất xứ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>- Đầu ti&ecirc;n phải kể đến đ&oacute; ch&iacute;nh l&agrave; cảm gi&aacute;c mềm, dai v&agrave; mịn khi nhẹ nh&agrave;ng chạm b&ocirc;ng m&uacute;t v&agrave;o da mặt.</p>

<p>- Được thiết kế mỏng nhẹ, sản phẩm bạn sử dụng sẽ dễ d&agrave;ng thẩm thấu tr&ecirc;n da hơn.</p>

<p>- Thiết kế giống như h&igrave;nh hồ l&ocirc;, dễ cầm v&agrave; chạm từng vị tr&iacute; tr&ecirc;n gương mặt bạn.</p>
', 1, 0, N'mut-tan-karadium-real-water-puff', CAST(N'2021-08-14 16:41:40.130' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4036, N'Son Tint Bóng Romand New Juicy Lasting', N'Romand', N'/Uploads/images/product/pro3.jpg', N'/Uploads/images/product/pro3.jpg', 0, N'Son tint bóng - Hot trend hè mà nàng nào bỏ lỡ em này quả là một thiếu sót lớn. Em này đúng chuẩn son tint bóng nhẹ, tự nhiên lắm luôn các nàng nhé!', 2094, N'<p>- Bảng m&agrave;u:</p>

<p>14 Berry Shot: Đỏ Berry⁣</p>

<p>15 Funnky Melon: Hồng Melon S&aacute;ng⁣</p>

<p>16 Corni Soda: Đỏ Quả Th&ugrave; Du⁣</p>

<p>17 Plum Coke: Đỏ Thẫm⁣</p>

<p>&nbsp;</p>

<p>- Son được bổ sung v&agrave;o rất nhiều dưỡng chất n&ecirc;n mang lại khả năng dưỡng ẩm cao, n&ecirc;n khi đ&aacute;nh l&ecirc;n m&ocirc;i kh&ocirc;ng những kh&ocirc;ng l&agrave;m lộ r&atilde;nh m&ocirc;i hay kh&ocirc; m&ocirc;i m&agrave; gi&uacute;p đ&ocirc;i m&ocirc;i bạn giữ được lớp m&agrave;u bền v&agrave; mọng hơn suốt nhiều giờ đồng hồ.</p>
', 1, 0, N'son-tint-bong-romand-new-juicy-lasting', CAST(N'2021-08-14 22:56:51.053' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4037, N'Bộ cọ 8 cây Vacosi', N'Vacosi', N'/Uploads/images/product/pro4.jpg', N'/Uploads/images/product/pro4.jpg', 0, N'Hộp cọ du lịch VACOSI My Darling 8 cây BC24 giúp cho việc trang điểm trở nên thú vị và sáng tạo hơn mỗi ngày.Đặc biệt hơn, với thiết kế xinh xắn, nhỏ gọn,VACOSI My Darling là món quà yêu thích của những cô nàng thích xê dịch.', 2096, N'<p>- Thương hiệu: Vacosi</p>

<p>- Xuất xứ thương hiệu: H&agrave;n Quốc</p>

<p>- M&agrave;u sắc:</p>

<p>&nbsp; &nbsp; + Đỏ</p>

<p>&nbsp; &nbsp; + Đen</p>

<p>- Bộ cọ gồm:</p>

<p>&nbsp; &nbsp; + Powder/ cọ phủ m&aacute; hồng</p>

<p>&nbsp; &nbsp; + Flat Top/ cọ nền đầu bằng</p>

<p>&nbsp; &nbsp; + Foundation/ cọ nền đầu dẹp</p>

<p>&nbsp; &nbsp; + Eye Shading/ cọ phấn mắt</p>

<p>&nbsp; &nbsp; + Eye Blending/ cọ t&aacute;n phấn mắt</p>

<p>&nbsp; &nbsp; + Conceal/ cọ che khuyết điểm</p>

<p>&nbsp; &nbsp; + Angle/ Cọ m&agrave;y</p>

<p>&nbsp; &nbsp; + Lip/ Cọ m&ocirc;i</p>

<p>- Th&ocirc;ng tin sản phẩm:</p>

<p>&nbsp; &nbsp; + Bộ cọ VACOSI My darling được thiết kế nhỏ gọn v&agrave; tiện lợi. Với hộp chứa cọ bằng sắt gi&uacute;p bảo quản cọ an to&agrave;n, thuận tiện khi di chuyển.</p>

<p>&nbsp; &nbsp; + Tập hợp c&aacute;c đầu cọ trang điểm cơ bản, gi&uacute;p trang điểm dễ d&agrave;ng mọi l&uacute;c mọi nơi.</p>

<p>&nbsp; &nbsp; + L&ocirc;ng cọ mềm mại, kh&ocirc;ng g&acirc;y ngứa da hay ch&acirc;m ch&iacute;ch khi sử dụng.</p>
', 1, 0, N'bo-co-8-cay-vacosi', CAST(N'2021-08-15 09:09:14.780' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4038, N'Các dòng Nước Hoa Hồng Innisfree', N'Innisfree', N'/Uploads/images/product/pro5.jpg', N'/Uploads/images/product/pro5.jpg', 0, N'Innisfree có lẽ đã quá nổi tiếng cả ở thị trường Hàn Quốc lẫn thị trường Việt Nam, các sản phẩm chăm sóc da của Innisfree luôn được đánh giá cao bởi thành phần thiên nhiên lành tính và hiệu quả cao cho làn da.', 2098, N'<p>🖤🖤C&aacute;c d&ograve;ng Nước Hoa Hồng Innisfree🖤🖤</p>

<p>&nbsp;</p>

<p>1. Green Tea</p>

<p>- D&agrave;nh cho da hỗn hợp v&agrave; da thường.</p>

<p>- L&agrave; d&ograve;ng nước hoa hồng rất ph&ugrave; hợp với l&agrave; da của người Việt Nam bởi đa số người Việt sở hữu l&agrave;n da hỗn hợp thi&ecirc;n dầu hoặc hỗn hợp thi&ecirc;n kh&ocirc;. Với ưu điểm nổi trội l&agrave; cấp ẩm v&agrave; ngăn ngừa mụn tr&ecirc;n da.</p>

<p>- Nước hoa hồng Tr&agrave; xanh Green Tea</p>

<p>- Balancing Skin được chiết xuất từ tr&agrave; xanh tươi nguy&ecirc;n trồng bằng phương ph&aacute;p hữu cơ tr&ecirc;n đảo Jeju H&agrave;n Quốc n&ecirc;n đảm bảo sạch v&agrave; an to&agrave;n.</p>

<p>- Với th&agrave;nh phần ch&iacute;nh l&agrave; l&aacute; tr&agrave; xanh, chứa nhiều dưỡng chất EGCG v&agrave; c&aacute;c acid amin gi&uacute;p c&acirc;n bằng độ pH, se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng v&agrave; chống oxi h&oacute;a cho da.</p>

<p>- Green Tea Balancing Skin l&agrave; nước hoa hồng c&oacute; kết cấu đặc lỏng nhưng hơn nước, kh&ocirc;ng chứa cồn n&ecirc;n v&agrave; hấp thụ rất nhanh qua da, tạo điều kiện để c&aacute;c bước dưỡng sau đạt hiệu quả tốt nhất.</p>

<p>&nbsp;</p>

<p>2. Jeju Volcanic</p>

<p>- Loại da: th&iacute;ch hợp da d&acirc;̀u, h&ocirc;̃n hợp d&acirc;̀u, da nhạy cảm.</p>

<p>- Kiểm so&aacute;t b&atilde; nhờn dư thừa tr&ecirc;n da.</p>

<p>- Chiết xuất tro n&uacute;i lửa h&uacute;t sạch bụi bẩn, b&atilde; nhờn s&acirc;u b&ecirc;n trong lỗ ch&acirc;n l&ocirc;ng.</p>

<p>- Se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng.</p>

<p>- Gi&uacute;p da tươi mới v&agrave; rạng rỡ hơn.</p>

<p>- C&acirc;n bằng độ PH cho da sau khi rửa mặt.</p>

<p>- Kh&ocirc;ng chứa parabens, kh&ocirc;ng chất tạo m&agrave;u, m&ugrave;i tổng hợp, kh&ocirc;ng chứa kho&aacute;ng dầu.</p>

<p>- Sản phẩm c&oacute; 2 lớp: lớp bột v&agrave; lớp nước, khi lắc chai l&ecirc;n v&agrave; sử dụng sẽ thấy dung dịch c&oacute; m&agrave;u n&acirc;u nhạt, m&ugrave;i thơm như hương hoa. Khi d&ugrave;ng l&ecirc;n mặt kh&ocirc;ng tạo cảm gi&aacute;c d&iacute;nh, cũng kh&ocirc;ng qu&aacute; kh&ocirc; cho da.</p>

<p>&nbsp;</p>

<p>3. Cherry Blossom</p>

<p>- Gi&uacute;p b&ugrave; đắp v&agrave; kiểm so&aacute;t độ Ph bị thiếu hụt tr&ecirc;n da, gi&uacute;p da lu&ocirc;n trong trạng th&aacute;i c&acirc;n bằng v&agrave; hấp thụ tốt hơn những dưỡng chất từ c&aacute;c sản phẩm dưỡng da tiếp theo trong chu tr&igrave;nh skin care.</p>

<p>- Với h&agrave;m lượng 4ppm tinh chất l&aacute; hoa anh đ&agrave;o, sản phẩm cung cấp một nguồn dưỡng chất dồi d&agrave;o gồm c&aacute;c chất hữu cơ c&oacute; lợi, nhiều loại vitamin tốt cho da. Tinh chất từ l&aacute; hoa anh đ&agrave;o ho&agrave;ng gia đ&atilde; được kiểm chứng c&oacute; c&ocirc;ng dụng thần kỳ trong việc nu&ocirc;i dưỡng, phục hồi v&agrave; cải thiện tone da.</p>

<p>- C&ograve;n cung cấp độ ẩm cần thiết cho da nhờ chất Betaine (chiết xuất từ củ cải đường) gi&uacute;p da ẩm mịn hơn.</p>

<p>- Sản phẩm c&oacute; kết cấu dạng lỏng nhẹ, rất tươi m&aacute;t khi sử dụng tr&ecirc;n da, thẩm thấu nhanh v&agrave; kh&ocirc;ng g&acirc;y nhờn r&iacute;t tr&ecirc;n da.</p>

<p>&nbsp;</p>

<p>4. Bija Trouble</p>

<p>- D&ograve;ng sản phẩm đặc trị n&agrave;y gi&uacute;p kiểm so&aacute;t được lượng dầu thừa đồng thời s&aacute;t khuẩn nhẹ l&agrave;m se mụn nhanh v&agrave; ngăn ngừa mụn mới t&aacute;i ph&aacute;t.</p>

<p>- Chiết xuất từ quả nhục đậu khấu được nu&ocirc;i trồng tại đảo Jeju. Từ xa xưa ở H&agrave;n quốc quả nhục đậu khấu đ&atilde; được d&ugrave;ng l&agrave;m nguy&ecirc;n liệu qu&yacute; trong đ&ocirc;ng y v&agrave; d&acirc;n gian để d&acirc;ng l&ecirc;n vua với th&agrave;nh phần Salicylic acid v&agrave; rượu tự nhi&ecirc;n c&ugrave;ng một số c&aacute;c loại thảo mộc xanh tự nhi&ecirc;n kh&aacute;c, ho&agrave;n to&agrave;n l&agrave;nh t&iacute;nh với da, đặc biệt chuy&ecirc;n d&ugrave;ng cho da dầu c&oacute; mụn hoặc v&ugrave;ng c&oacute; kh&iacute; hậu ẩm ướt. L&agrave;n da bạn sẽ trở n&ecirc;n căng mịn khoẻ mạnh ngay sau khi sử dụng.</p>

<p>- Sản phẩm c&oacute; khả năng tẩy sạch c&aacute;c tạp chất s&acirc;u b&ecirc;n trong l&agrave;n da, s&aacute;t khuẩn v&agrave; kiểm so&aacute;t được lượng dầu thừa, hạn chế c&aacute;c nguy&ecirc;n nh&acirc;n ch&iacute;nh sản sinh ra mụn, se mụn nhanh v&agrave; ngăn ngừa mụn mới t&aacute;i ph&aacute;t. Đồng thời, với c&ocirc;ng thức tẩy tế b&agrave;o chết dịu nhẹ gi&uacute;p l&agrave;m sạch v&agrave; trắng s&aacute;ng sắc da bị sạm m&agrave;u.</p>
', 1, 0, N'cac-dong-nuoc-hoa-hong-innisfree', CAST(N'2021-08-15 09:40:57.393' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4039, N'Son Kem Lì Merzy The Heritage Velvet Tint', N'Merzy', N'/Uploads/images/product/pro6.jpg', N'/Uploads/images/product/pro6.jpg', 0, N'Son kem lì Merzy The Heritage Velvet Tint là dòng son kem lì nằm trong bộ sưu tập được thương hiệu Merzy ấp ủ đã lâu với tên gọi The Heritage Collection pha trộn giữa nét đẹp truyền thống và hiện đại, hội tụ mọi điều cần thiết để bạn chạm đến vẻ đẹp hoàn ', 2094, N'<p>- Bảng m&agrave;u:</p>

<p>&nbsp; &nbsp; #V19: sắc đỏ lạnh tươi mới như một đ&oacute;a hồng rạng rỡ</p>

<p>&nbsp; &nbsp; #V20: T&ocirc;ng đỏ thuần cổ điển thu h&uacute;t mọi &aacute;nh nh&igrave;n</p>

<p>&nbsp; &nbsp; #V21: sắc đỏ burgundy pha n&acirc;u ấn tượng, ph&ugrave; hợp với mọi t&ocirc;ng da</p>

<p>&nbsp; &nbsp; #V22: Sắc đỏ gạch &aacute;nh n&acirc;u mềm mại nhấn mạnh bản t&iacute;nh ri&ecirc;ng biệt</p>

<p>&nbsp;</p>

<p>- Son c&oacute; kết cấu phủ nhung mềm mại với độ l&ecirc;n m&agrave;u chuẩn r&otilde;, chuẩn m&agrave;u ngay từ lần chạm cọ đầu ti&ecirc;n</p>

<p>- Chất son được cải tiến cho độ l&ecirc;n m&agrave;u đậm r&otilde; v&agrave; duy tr&igrave; sự rạng rỡ như mới được apply l&ecirc;n m&ocirc;i trong nhiều giờ liền</p>

<p>- Son c&oacute; khả năng b&aacute;m m&agrave;u bền bỉ, kh&ocirc;ng bị d&acirc;y ra khẩu trang hoặc ly, t&aacute;ch khi ăn uống với độ bền m&agrave;u cao, giữ m&agrave;u l&acirc;u trong thời gian d&agrave;i</p>
', 1, 0, N'son-kem-li-merzy-the-heritage-velvet-tint', CAST(N'2021-08-15 09:57:45.353' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4040, N'Dầu tẩy trang Muji cleansing oil 200ml Nhật Bản', N'Muji', N'/Uploads/images/product/pro7.jpg', N'/Uploads/images/product/pro7.jpg', 250000, N'Dầu tẩy trang Muji Cleansing Oil với Kết cấu hạt dầu “đặc” nhưng không quá lỏng giúp Muji Cleansing Oil dễ dàng “len lỏi” vào các lỗ chân lông, hòa vào và cuốn trôi đi hết bụi bẩn, bã nhờn, lớp son môi đầy màu sắc hay mọi loại lớp nền “cứng đầu” chống nước không trôi.', 2105, N'<p>✖️ ƯU ĐIỂM:</p>

<p>✔️ Chất dầu cho người d&ugrave;ng cảm gi&aacute;c v&ocirc; c&ugrave;ng th&iacute;ch th&uacute; : kh&ocirc;ng qu&aacute; lỏng v&agrave; cũng kh&ocirc;ng qu&aacute; đặc. M&ugrave;i thơm thoang thoảng nhẹ mang đến cảm gi&aacute;c thư gi&atilde;n dễ chịu cho người d&ugrave;ng. Khi rửa sạch kh&ocirc;ng bị nhờn hay kh&ocirc; r&iacute;ch n&ecirc;n cho cảm gi&aacute;c rất thoải m&aacute;i.</p>

<p>✔️ Khả năng tẩy trang của dầu được đ&aacute;nh gi&aacute; rất cao dầu c&oacute; thể tẩy sạch hết những phấn trang điểm m&agrave; kh&ocirc;ng cần dụng lượng qu&aacute; nhiều hay m&aacute;t xa qu&aacute; l&acirc;u. Bạn n&agrave;o makeup đậm cũng c&oacute; thể tin tưởng d&ugrave;ng được.</p>

<p>✔️ Tẩy sạch rất tốt c&aacute;c thể loại makeup th&ocirc;ng thường như kem nền, phấn mắt, phấn m&aacute;,&hellip; c&oacute; thể tẩy trang được cho cả mắt v&agrave; m&ocirc;i, đ&aacute;nh bay c&aacute;c loại kẻ mắt, son v&agrave; mascara.</p>

<p>✔️ D&ugrave; l&agrave;m sạch da một c&aacute;ch mạnh mẽ nhưng Muji c&oacute; thể dễ d&agrave;ng rửa sạch lại với nước m&agrave; kh&ocirc;ng g&acirc;y nhờn d&iacute;nh, kh&ocirc;ng nặng nềtr&ecirc;n da một ch&uacute;t n&agrave;o. cho bạn một l&agrave;n da kh&ocirc;ng vương bụi, mềm mịn v&agrave; m&aacute;t nhẹ hơn rất rất nhiều ch&iacute;nh l&agrave; những g&igrave; m&agrave; tẩy trang oil cleansing sẽ mang đến cho bạn.</p>

<p>✔️ Sản phẩm hoạt động theo cơ chế emulsify (chuyển th&agrave;nh dạng sữa sau khi th&ecirc;m nước) rất dễ rửa sạch bằng nước.</p>

<p>✔️ Tẩy trang dạng dầu c&ograve;n gi&uacute;p dưỡng ẩm hơn, tăng cường độ đ&agrave;n hồi, gi&uacute;p da dễ thẩm thấu c&aacute;c lớp dưỡng da tiếp theo.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>- Bước 1: L&agrave;m ướt b&ocirc;ng bằng nước ấm, sau đ&oacute; lau nhẹ nh&agrave;ng v&ugrave;ng mắt, dọc sống mũi trước rồi đến c&aacute;c v&ugrave;ng c&ograve;n lại tr&ecirc;n mặt. Việc sử dụng nước ấm để lau trước ti&ecirc;n c&oacute; t&aacute;c dụng l&agrave;m ẩm da mặt, gi&uacute;p việc tẩy trang dễ d&agrave;ng hơn v&agrave; hạn chế tổn thương da.</p>

<p>- Bước 2: Cho sản phẩm tẩy trang ra b&ocirc;ng tẩy trang v&agrave; nhẹ nh&agrave;ng l&agrave;m sạch c&aacute;c v&ugrave;ng da. Ch&uacute;ng m&igrave;nh n&ecirc;n ch&uacute; &yacute; tới c&aacute;c phần khuất như c&aacute;nh mũi, v&ugrave;ng dưới m&ocirc;i&hellip;</p>

<p>- Bước 3: Rửa mặt thật sạch bằng sữa rửa mặt.</p>

<p>- Bước 4: Sau khi c&aacute;c v&ugrave;ng da tr&ecirc;n mặt đ&atilde; được l&agrave;m sạch, ch&uacute;ng ta n&ecirc;n dưỡng da với nước hoa hồng, kem dưỡng ẩm để c&acirc;n bằng lại độ ẩm cho da v&agrave; l&agrave;m se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng. B&ecirc;n cạnh đ&oacute;, bạn cũng n&ecirc;n d&ugrave;ng thuốc nhỏ mắt, kem dưỡng m&ocirc;i để bảo vệ cho c&aacute;c bộ phận n&agrave;y.</p>
', 1, 0, N'dau-tay-trang-muji-cleansing-oil-200ml-nhat-ban', CAST(N'2021-08-15 10:01:03.337' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4041, N'Son Kem Lì Romand New Zero Velvet Tint', N'Romand', N'/Uploads/images/product/pro8.jpg', N'/Uploads/images/product/pro8.jpg', 0, N'Son kem lì Romand New Zero Velvet Tint thuộc dòng Zero velvet tint của thương hiệu Romand trở lại với phiên bản mới có tên gọi Shell Beach Nude Collection với sự cải tiến về chất son và bảng màu được bổ sung thêm những màu son mới , với những ưu điểm vượt', 2094, N'<p>- Bảng m&agrave;u:</p>

<p>12 - Đỏ cam</p>

<p>13 - Đỏ hồng tươi</p>

<p>14 - Hồng đỏ đất</p>

<p>15 - Cam ch&aacute;y</p>

<p>16 - Hồng nude</p>

<p>17 - Cam nude</p>

<p>&nbsp;</p>

<p>- Chất son cải tiến xốp mịn, kh&ocirc;ng l&agrave;m lộ v&acirc;n m&ocirc;i.</p>

<p>- Độ chuẩn m&agrave;u kh&aacute; tốt.</p>

<p>- Lớp finish lỳ mịn rất đẹp mắt.</p>
', 1, 0, N'son-kem-li-romand-new-zero-velvet-tint', CAST(N'2021-08-15 10:05:51.140' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4042, N'Nước hoa hồng Hada Labo Nhật Lotion 170ml', N'Hada Labo', N'/Uploads/images/product/pro9.jpg', N'/Uploads/images/product/pro9.jpg', 0, N'Nước hoa hồng Hada Labo  của Rohto Nhật Bản là sản phẩm cực kỳ nổi tiếng. Cứ trung bình 4 giây lại có 1 chai được bán ra trên phạm vi toàn cầu. Lotion Hada Labo dòng cơ bản gồm 9 loại, chia làm 4 dòng chính: dưỡng ẩm, dưỡng trắng, chống lão hóa, chăm sóc da mụn.', 2098, N'<p>- Xuất xứ: Nhật Bản</p>

<p>- H&atilde;ng sản xuất: Rohto</p>

<p>- Quy c&aacute;ch: 170ml</p>

<p>&nbsp;</p>

<p>- Ph&acirc;n loại:</p>

<p>+ Trắng sọc xanh l&aacute;: Cấp ẩm da dầu</p>

<p>+ Trắng kh&ocirc;ng sọc: Cấp ẩm da kh&ocirc;</p>

<p>+ Xanh sọc đỏ: Dưỡng trắng da kh&ocirc;</p>

<p>+ Xanh kh&ocirc;ng sọc: Dưỡng trắng da dầu</p>
', 1, 0, N'nuoc-hoa-hong-hada-labo-nhat-lotion-170ml', CAST(N'2021-08-15 10:23:49.723' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4043, N'Kem dưỡng AHC 50ml', N'Ahc', N'/Uploads/images/product/pro10.jpg', N'/Uploads/images/product/pro10.jpg', 0, N'Kem dưỡng AHC  vừa mới ra mắt đã nhanh chóng xếp vào hàng những sản phẩm best seller và được yêu thích nhất của hãng AHC. Kem dưỡng AHC chống lão hóa giúp nuôi dưỡng sáng và đều màu da, làm mờ các vết thâm nám, ngăn ngừa các dấu hiệu của sự lão hóa, giúp nuôi dưỡng làn da ẩm mịn, mềm mại, mịn màn hơn, và tăng độ đàn hồi cho làn da.', 2100, N'<p>1. Xanh: Cấp ẩm</p>

<p>- Chứa Sodium Hyaluronate, Panthenol: gi&uacute;p cấp ẩm, giữ ẩm v&agrave; chống mất nước cho da.</p>

<p>- Niacinamide, Saccharomyces Ferment, Rice Ferment: l&agrave;m trắng s&aacute;ng v&agrave; mịn da.</p>

<p>- Bifida Ferment, Adenosine: chống nhăn da hiệu quả.</p>

<p>- Chiết xuất 20 loại thảo mộc kh&aacute;c nhau: gi&uacute;p cải thiện độ săn chắc da, đem đến l&agrave;n da s&aacute;ng b&oacute;ng v&agrave; căng mềm tươi s&aacute;ng.</p>

<p>&nbsp;</p>

<p>2. V&agrave;ng: Trắng da</p>

<p>- Chiết xuất Olive Fruit Oil, Squalane: cho l&agrave;n da mềm mượt, s&aacute;ng b&oacute;ng</p>

<p>- Ascorbic Acid, Galactomyces Ferment, Niacinamide: l&agrave;m trắng s&aacute;ng da hiệu quả.</p>

<p>- Bifida Ferment, Adenosine: chống nhăn da.</p>

<p>- Chiết xuất nhiều loại thảo mộc v&agrave; quả c&acirc;y bụi kh&aacute;c nhau: bổ sung h&agrave;m lượng vitamin tự nhi&ecirc;n l&agrave;m s&aacute;ng da v&agrave; hỗ trợ dưỡng căng mềm, chống oxy h&oacute;a da tối ưu.</p>

<p>&nbsp;</p>

<p>3. Đỏ: Chống l&atilde;o h&oacute;a</p>

<p>- Chống l&atilde;o h&oacute;a cung cấp collagen gi&uacute;p da đ&agrave;n hồi v&agrave; săn chắc</p>

<p>- Hydrolyzed Collagen: bổ sung collagen cho da, giữ l&agrave;n da đ&agrave;n hồi săn chắc v&agrave; mịn m&agrave;ng.</p>

<p>- Tinh dầu hạt hướng dương, đậu l&ecirc;n men: cho bề mặt da mềm mướt, đ&agrave;n hồi.</p>

<p>- Niacinamide v&agrave; Adenosine: l&agrave;m trắng v&agrave; chống nhăn hữu hiệu.</p>
', 1, 0, N'kem-duong-ahc-50ml', CAST(N'2021-08-15 10:29:57.623' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4044, N'Sữa Rửa Mặt Tẩy Tế Bào Chết St Ives Trà Xanh', N'St.ives', N'/Uploads/images/product/pro11.jpg', N'/Uploads/images/product/pro11.jpg', 100000, N'Tẩy tế bào chết là một trong những công đoạn quan trọng trong quá trình chăm sóc da của phái đẹp. Làn da hàng ngày phải chịu rất nhiều tác động gây hại từ môi trường bên ngoài, việc tẩy tế bào chết sẽ giúp loại bỏ bụi bẩn, vi khuẩn và những tế bào chết dư thừa, thúc đẩy quá trình tái tạo da. ', 2097, N'<p>➡️ Xuất xứ: USA</p>

<p>➡️ H&atilde;ng: St.Ives</p>

<p>➡️ Trọng lượng: 170g</p>

<p>&nbsp;</p>

<p>- L&agrave; sản phẩm tẩy tế b&agrave;o chết số 1 của Mỹ (được tạp ch&iacute; Allure b&igrave;nh chọn), tẩy da chết nhẹ nh&agrave;ng, kh&ocirc;ng l&agrave;m kh&ocirc; da. C&ocirc;ng thức chứa 100% hạt tẩy chiết xuất từ thi&ecirc;n nhi&ecirc;n, l&agrave;m da mềm mại, s&aacute;ng khỏe.l&agrave;m sạch s&acirc;u lỗ ch&acirc;n l&ocirc;ng, v&agrave; gi&uacute;p ngăn ngừa mụn trước khi ch&uacute;ng h&igrave;nh th&agrave;nh.</p>

<p>- St Ives Blackhead Clearing Green Tea Scrub được nghi&ecirc;n cứu một c&aacute;ch kỹ lưỡng v&agrave; được chọn lọc để mang đến cho bạn những th&agrave;nh phần tốt nhất từ thi&ecirc;n nhi&ecirc;n. Với c&ocirc;ng thức tuyệt vời cho một l&agrave;n da mềm mại, tươi s&aacute;ng.</p>

<p>- Sửa rửa mặt tẩy tế b&agrave;o chế St Ives Blackhead Clearing Green Tea Scrub từ tr&agrave; xanh l&agrave; d&ograve;ng sản phẩm mới nhất của St. Ives, th&agrave;nh phần ch&iacute;nh gồm c&oacute; Tr&agrave; xanh gi&agrave;u vitamins C v&agrave; E, tr&agrave; xanh được biết đến l&agrave; chất chống oxy gi&uacute;p bảo vệ l&agrave;n da dưới t&aacute;c hại của &aacute;nh nắng mặt trời, ngăn ngừa việc da bị l&atilde;o h&oacute;a đến sớm, l&agrave;m tăng độ s&aacute;ng của da, đẩy mạnh việc t&aacute;i tạo tế b&agrave;o da mới, v&agrave; quan trọng hơn n&oacute; c&ograve;n c&oacute; t&aacute;c dụng ngăn ngừa c&aacute;c loại ung thư da&hellip;</p>

<p>- Với chiết xuất từ 100% c&aacute;c th&agrave;nh phần thi&ecirc;n nhi&ecirc;n, sữa tẩy tế b&agrave;o chết ST.IVES Green Tea Scrub nhẹ nh&agrave;ng l&agrave;m dịu mụn sưng đỏ, đồng thời lấy những chất bịu bẩn, chất sừng v&agrave; mụn c&aacute;m tr&ecirc;n da một c&aacute;ch hiệu quả, mang đến cho bạn một l&agrave;n da mịn m&agrave;ng, tươi mới. B&ecirc;n cạnh đ&oacute;, dầu &ocirc;liu c&oacute; trong ST.IVES Green Tea Scrub sẽ gi&uacute;p nu&ocirc;i dưỡng, gi&uacute;p da trắng dần l&ecirc;n, đồng thời gi&uacute;p da săn chắc hơn. Sản phẩm chiết xuất từ những th&agrave;nh phần tự nhi&ecirc;n n&ecirc;n tuyệt đối an to&agrave;n đối với người sử dụng.</p>

<p>&nbsp;</p>

<p>- Th&agrave;nh phần Oil-free v&agrave; chứa Acid Salicylic sẽ đ&aacute;nh bay mụn c&aacute;m, mụn đầu đen cứng đầu, hỗ trợ thu nhỏ lỗ ch&acirc;n l&ocirc;ng:</p>

<p>+ Nhẹ nh&agrave;ng l&agrave;m sạch bụi bẩn &amp; dầu t&iacute;ch tụ trong lỗ ch&acirc;n l&ocirc;ng, ngăn ngừa sự ph&aacute;t triển của mụn đầu đen.</p>

<p>+ L&agrave;m giảm mẩn đỏ v&agrave; k&iacute;ch ứng do mụn g&acirc;y ra.</p>

<p>+ Mang lại một l&agrave;n da mịn m&agrave;ng, sạch tho&aacute;ng.</p>

<p>+ 100% hạt tẩy c&oacute; nguồn gốc tự nhi&ecirc;n.</p>

<p>+ Ko chứa Paraben</p>

<p>+ Ko chứa dầu</p>

<p>+ Được B&aacute;c sĩ da liễu thử nghiệm</p>

<p>&ndash; Ngo&agrave;i tinh chất tr&agrave; xanh c&oacute; t&aacute;c dụng kh&aacute;ng khuẩn, kh&aacute;ng vi&ecirc;m. Sản phẩm c&ograve;n bổ sung th&ecirc;m 1% salicylic acid l&agrave; chất gi&uacute;p ngăn ngừa mụn rất hiệu quả.</p>

<p>&ndash; Th&agrave;nh phần ch&iacute;nh: Tr&agrave; xanh, dầu &ocirc; liu v&agrave; chiết xuất từ l&aacute; oliu, Silica (c&aacute;t)</p>
', 1, 0, N'sua-rua-mat-tay-te-bao-chet-st-ives-tra-xanh', CAST(N'2021-08-15 10:33:52.250' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4045, N'Lăn khử mùi đá khoáng Soft Stone Double 20g', N'Deonatulle', N'/Uploads/images/product/pro12.jpg', N'/Uploads/images/product/pro12.jpg', 240000, N'Lăn khử mùi đá khoáng Soft Stone Double thành phần đá khoáng alum được “tinh chế” nâng cao khả năng ngăn tiết mùi và mồ hôi gấp đôi so với bản cũ. Ngoài ra, sản phẩm còn được bổ sung kẽm oxit giúp hấp thụ bã nhờn và giữ cảm giác mềm mại, mịn màng cho da.', 2099, N'<p>- Xuất xứ: Nhật Bản</p>

<p>&nbsp;</p>

<p>- L&agrave; sản phẩm khử m&ugrave;i nổi tiếng số 1 tại Nhật Bản. Deonatulle Soft Stone W kh&ocirc;ng những l&agrave; best-seller, m&agrave; c&ograve;n l&agrave; long-seller trong suốt 13 năm. Trong một cuộc khảo s&aacute;t, c&oacute; đến hơn 90% người được hỏi khẳng định họ sẽ tiếp tục mua lại sản phẩm n&agrave;y. Lăn khử m&ugrave;i Deonatulle Soft Stone W Nhật Bản được thiết kế dạng thanh lăn s&aacute;p tiện lợi. Đ&acirc;y l&agrave; sản phẩm khử m&ugrave;i long-seller, b&aacute;n chạy nhất tại Nhật trong suốt 13 năm</p>

<p>- Th&agrave;nh phần:</p>

<p>+ Burnt alum, isopropyl methyl phenol, menthol, hydrogenated castor oil, cyclopentasiloxane, POP butyl ether -1, sorbitan sesquiisostearate, stearyl alcohol, BHT. + Nếu như mọi năm ưu điểm của bạn n&agrave;y l&agrave; th&agrave;nh phần thi&ecirc;n nhi&ecirc;n v&agrave; kh&ocirc;ng g&acirc;y vệt ố v&agrave;ng tr&ecirc;n da, khử m&ugrave;i được 1 ng&agrave;y.</p>

<p>+ Th&igrave; mẫu mới nhất 2020 khắc phục được nhược điểm &yacute; nhờ khả năng khử m&ugrave;i gấp đ&ocirc;i mẫu cũ.</p>

<p>- Soft Stone khử m&ugrave;i cực hiệu quả nhờ th&agrave;nh phần bột muối đ&aacute; kho&aacute;ng Alum từ thi&ecirc;n nhi&ecirc;n. Chỉ sử dụng một lần v&agrave;o buổi s&aacute;ng, c&ocirc;ng dụng khử m&ugrave;i k&eacute;o d&agrave;i suốt cả ng&agrave;y, thậm ch&iacute; k&eacute;o d&agrave;i tối đa tới 3 ng&agrave;y. Ngo&agrave;i ra, bột muối đ&aacute; kho&aacute;ng Alum trong Lăn n&aacute;ch đ&aacute; kho&aacute;ng Nhật Soft Stone c&ograve;n c&oacute; t&aacute;c dụng l&agrave;m se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng tại v&ugrave;ng tiếp x&uacute;c với da v&agrave; gi&uacute;p hạn chế mồ h&ocirc;i tối đa.</p>

<p>- Lăn n&aacute;ch Nhật Bản Soft Stone c&oacute; dạng s&aacute;p, n&ecirc;n cảm gi&aacute;c thoa l&ecirc;n da kh&ocirc;ng bị nhờn m&agrave; kh&ocirc; tho&aacute;ng v&agrave; kh&ocirc;ng g&acirc;y kh&oacute; chịu. Soft Stone kh&ocirc;ng chứa cồn n&ecirc;n an to&agrave;n tuyệt đối cho da, kh&ocirc;ng g&acirc;y k&iacute;ch ứng, mẩn ngứa, kh&ocirc;ng b&agrave;o m&ograve;n v&agrave; l&agrave;m sạm m&agrave;u da như c&aacute;c sản phẩm lăn n&aacute;ch dạng lỏng kh&aacute;c. Lăn n&aacute;ch đ&aacute; kho&aacute;ng Nhật Soft Stone đ&atilde; được kiểm tra k&iacute;ch ứng tr&ecirc;n nhiều loại da, n&ecirc;n bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m nếu c&oacute; l&agrave;n da nhạy cảm.</p>

<p>- Kh&ocirc;ng chỉ d&ugrave;ng cho lăn v&agrave; khử m&ugrave;i n&aacute;ch, S&aacute;p lăn khử m&ugrave;i đ&aacute; kho&aacute;ng Soft Stone Nhật Bản c&ograve;n c&oacute; thể sử dụng tr&ecirc;n c&aacute;c v&ugrave;ng da cơ thể kh&aacute;c như khuỷu tay, khuỷu ch&acirc;n. Bất cứ v&ugrave;ng da n&agrave;o c&oacute; &ldquo;m&ugrave;i cơ thể&rdquo; kh&oacute; chịu, bạn đều c&oacute; thể thoa Soft Stone để thấy rằng từ nay m&ugrave;i cơ thể kh&ocirc;ng c&ograve;n l&agrave; nỗi lo ngại đối với bạn nữa. Soft Stone d&ugrave;ng được cho cả nam v&agrave; nữ.</p>

<p>- S&aacute;p lăn khử m&ugrave;i đ&aacute; kho&aacute;ng Soft Stone l&agrave; sản phẩm nhận giải thưởng &ldquo;mỹ phẩm tốt nhất của năm&rdquo; do tạp ch&iacute; online @Cosme bầu chọn (@Cosme l&agrave; tạp ch&iacute; cung cấp th&ocirc;ng tin review sản phẩm v&agrave; trao đổi về mỹ phẩm được ưa chuộng tại Nhật Bản).</p>

<p>- Gi&aacute; cả cực kỳ hợp l&yacute; so với chất lượng. Thỏi s&aacute;p lăn n&aacute;ch Nhật Bản Soft Stone tuy nhỏ nhưng chỉ cần 1 lần thoa, hiệu quả khử m&ugrave;i v&agrave; tiết chế mồ h&ocirc;i cho cả ng&agrave;y n&ecirc;n cực k&igrave; tiết kiệm, kh&ocirc;ng hề mau hết như c&aacute;c loại lăn n&aacute;ch dạng lỏng kh&aacute;c. 1 thỏi d&ugrave;ng cả năm v&ocirc; c&ugrave;ng tiết kiệm.</p>
', 1, 0, N'lan-khu-mui-da-khoang-soft-stone-double-20g', CAST(N'2021-08-15 10:39:47.807' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4046, N'Gel kẻ mắt Tonymoly', N'Tonymoly', N'/Uploads/images/product/pro19.jpg', N'/Uploads/images/product/pro19.jpg', 0, N'Gel kẻ mắt Tony Moly Backstage Gel Eyeliner với những công dụng vượt trội, giúp mắt bạn rạng ngời, tự tin hơn với lớp trang điểm hoàn hảo.Tony Moly Backstage Gel Eyeliner là dạng gel kẻ mắt có kết cấu dạng kem với kèm cây cọ vẽ chuyên dụng phía trên phần nắp của sản phẩm, thuận lợi hơn khi kẻ viền mắt.', 2104, N'<p>🖤🖤Gel kẻ mắt Tonymoly🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 105K</p>

<p>&nbsp;</p>

<p>✖️ Xuất xứ : H&agrave;n Quốc</p>

<p>✖️ Trọng lượng: 4g</p>

<p>✖️ M&agrave;u sắc:</p>

<p>➖ Đen (01)</p>

<p>➖ N&acirc;u (02)</p>

<p>&nbsp;</p>

<p>✖️ ƯU ĐIỂM:</p>

<p>✔️ Kh&ocirc;ng b&oacute;ng như kẻ mắt nước, kh&ocirc;ng d&agrave;y như đầu ch&igrave; kẻ mắt th&ocirc;ng thường, chất gel của kẻ mắt Tony Moly ph&ugrave; hợp cho bạn trong mọi ho&agrave;n cảnh cả b&igrave;nh thường, đi chơi, đi tiệc.</p>

<p>✔️ N&eacute;t đậm vừa đủ n&ecirc;n bạn chỉ cần kẻ một đường, kh&ocirc;ng cần chuốt lại sẽ tr&aacute;nh được t&igrave;nh trạng lệch, x&eacute;o đường kẻ trước.</p>

<p>✔️ Độ b&aacute;m của gel cực l&acirc;u, c&oacute; thể l&ecirc;n đến 12 tiếng.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG: D&ugrave;ng chổi tạo n&eacute;t v&eacute; theo đường viền s&aacute;t m&iacute; mắt</p>
', 1, 0, N'gel-ke-mat-tonymoly', CAST(N'2021-08-15 10:43:32.367' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4047, N'Phấn tạo khối 3 ô City Color Contour Effects Palette', N'City Color', N'/Uploads/images/product/pro13.jpg', N'/Uploads/images/product/pro13.jpg', 120000, N'Bảng phấn tạo khối 3 màu City Color Collection Contour Palette là sản phẩm không chỉ cung cấp màu sắc tuyệt vời, nó còn giúp bạn tiết kiệm một khoản tiền khá lớn. Chất bột phấn mịn màng giúp bạn tạo khối một cách dễ dàng hoàn hảo.', 2095, N'<p>➖ Thương hiệu: CITY COLOR MỸ</p>

<p>&nbsp;</p>

<p>✖️ Phấn tạo khối 3 &ocirc; City Color Contour Effects Palette g&ocirc;̀m 3 màu sắc:</p>

<p>➖ Highlight &ndash; màu sáng: được dùng đ&ecirc;̉ đánh highlight cùng các vùng chữ T</p>

<p>➖ Bronze &ndash; màu n&acirc;u nhẹ: dùng đ&ecirc;̉ đánh hai b&ecirc;n cánh mũi tạo hi&ecirc;̣u ứng s&ocirc;́ng mũi cao.</p>

<p>➖ Contour &ndash; n&acirc;u t&ocirc;́i: Dùng đ&ecirc;̉ đánh hai b&ecirc;n quai hàm, xung quanh khu&ocirc;n mặt tạo cảm giác khu&ocirc;n mặt nhỏ gọn.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>➖ Tạo sống mũi cao hơn: d&ugrave;ng m&agrave;u tối thoa dọc 2 b&ecirc;n sống mũi v&agrave; m&agrave;u s&aacute;ng t&aacute;n l&ecirc;n phần giữa sống mũi. Phương ph&aacute;p n&agrave;y sẽ gi&uacute;p tạo cảm gi&aacute;c mũi bạn cao hơn.</p>

<p>➖ Khắc phục khu&ocirc;n mặt vu&ocirc;ng: d&ugrave;ng m&agrave;u tối thoa 2 b&ecirc;n g&oacute;c m&aacute; gi&uacute;p tạo cảm gi&aacute;c khu&ocirc;n mặt đỡ vu&ocirc;ng v&agrave; thanh tho&aacute;t hơn.</p>

<p>➖ Tạo g&ograve; m&aacute; cao: h&oacute;p m&aacute; lại v&agrave; t&aacute;n m&agrave;u tối l&ecirc;n v&ugrave;ng hốc m&aacute;. Phương ph&aacute;p n&agrave;y sẽ tạo cảm gi&aacute;c g&ograve; m&aacute; cao v&agrave; sexy hơn.</p>
', 1, 0, N'phan-tao-khoi-3-o-city-color-contour-effects-palette', CAST(N'2021-08-15 10:46:43.740' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4048, N'Nước hoa Suddenly Madame Glamour 50ml', N'Suddenly', N'/Uploads/images/product/pro14.jpg', N'/Uploads/images/product/pro14.jpg', 160000, N'Bắt nguồn từ một cảm hứng bất chợt, Suddenly Madame Glamour xuất hiện một cách đột ngột vào năm 2000 bởi thương hiệu Lidl đến từ Đức. Giống như cái tên của mình, những nốt hương của chai nước hoa đột nhiên xuất hiện rồi luân phiên nhau biến mất theo cách mà chẳng ai ngờ tới.', 2106, N'<p>- Dung t&iacute;ch: 50ml</p>

<p>- Xuất xứ: Đức</p>

<p>&nbsp;</p>

<p>➡️ Bạn c&oacute; thể nh&igrave;n thấy sự th&agrave;nh thục, nữ t&iacute;nh v&agrave; kh&ocirc;ng k&eacute;m phần quyến rũ của Suddenly Madame Glamour ngay từ thiết kế b&ecirc;n ngo&agrave;i của n&oacute;. Bao b&igrave; b&ecirc;n ngo&agrave;i đơn giản, sang trọng v&agrave; rất chắc chắn. B&ecirc;n trong l&agrave; một chai thủy tinh nhỏ dạng xịt c&oacute; dung t&iacute;ch 50 ml. Thiết kế của chai l&agrave; những đường n&eacute;t tinh tế đầy nữ t&iacute;nh, mềm mại c&ugrave;ng với chất liệu trong suốt cao cấp, c&oacute; thể nh&igrave;n thấy mờ mờ m&agrave;u nước hoa. B&ecirc;n tr&ecirc;n lọ v&agrave; d&ograve;ng chữ Suddenly Madame Glamour nổi bật m&agrave;u v&agrave;ng kim v&agrave; nắp m&agrave;u trắng được tạo điểm nhấn với một v&ograve;ng m&agrave;u v&agrave;ng kim sang trọng. Sự kết hợp m&agrave;u tinh tế, nữ t&iacute;nh v&agrave; th&agrave;nh thục n&agrave;y đ&atilde; ngay lập tức l&agrave;m say l&ograve;ng cả những c&ocirc; n&agrave;ng kh&oacute; t&iacute;nh nhất.</p>

<p>➡️ Suddenly Madame Glamour l&agrave; một loại nước hoa c&oacute; tinh dầu thơm thuộc d&ograve;ng EAU DE PARFUM, l&agrave; một c&ocirc; n&agrave;ng nữ t&iacute;nh, dịu d&agrave;ng nhưng cũng đầy quyến rũ, với m&ugrave;i hương lưu lại vương vấn kh&ocirc;ng tan trong kh&ocirc;ng kh&iacute;.</p>

<p>➡️ M&ugrave;i hương của hương thơm của Suddenly Madame Glamour l&agrave; sự kết hợp tinh tế v&agrave; ho&agrave;n hảo giữa cam, qu&yacute;t, hương hoa v&agrave; kết hợp với hương cam bergamot v&agrave; hoa nh&agrave;i. M&ugrave;i hương hoa tự nhi&ecirc;n đ&atilde; gi&uacute;p cho Suddenly Madame Glamour vừa tươi mới, trang nhẽ v&agrave; nữ t&iacute;nh vừa quyến rũ v&agrave; sang trọng. C&oacute; thể n&oacute;i, Suddenly Madame Glamour ch&iacute;nh l&agrave; một trong những biểu tượng của sự nữ t&iacute;nh của ph&aacute;i đẹp với m&ugrave;i hương sinh động tươi m&aacute;t v&agrave; gi&uacute;p t&ocirc;n l&ecirc;n sự sang trọng, thanh lịch v&agrave; qu&yacute; ph&aacute;i của một người phụ nữ th&agrave;nh thục.</p>

<p>➡️ Đặc biệt, điều đ&atilde; l&agrave;m l&ecirc;n sự kh&aacute;c biệt v&agrave; danh tiếng của Suddenly Madame Glamour ch&iacute;nh l&agrave; m&ugrave;i hương độ đ&aacute;o v&agrave; gần nưh giống hệt với m&ugrave;i hương được tỏa ra từ d&ograve;ng nước hoa cao cấp &ndash; Chanel Coco Mademoiselle. Ngay cả c&aacute;c chuy&ecirc;n gia trong lĩnh vực n&agrave;y cũng kh&oacute; để t&igrave;m ra sự kh&aacute;c nhau giữa m&ugrave;i hương của d&ograve;ng nước hoa cao cấp đến từ thương hiệu nổi tiếng Chanel n&agrave;y. Thậm ch&iacute;, c&oacute; khoảng 50% người tham gia thử nghiệm đ&atilde; kh&ocirc;ng thể ph&acirc;n biệt được 2 m&ugrave;i hương n&agrave;y.</p>
', 1, 0, N'nuoc-hoa-suddenly-madame-glamour-50ml', CAST(N'2021-08-15 10:50:17.210' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4049, N'Sữa Rửa Mặt Sủi Bọt Loại Bỏ Mụn Đầu Đen Some By Mi Bye Bye Blackhead 30 Days Miracle Green Tea Tox Bubble Cleanser 120g', N'Some By Mi', N'/Uploads/images/product/pro15.jpg', N'/Uploads/images/product/pro15.jpg', 240000, N'Sữa Rửa Mặt Sủi Bọt Loại Bỏ Mụn Đầu Đen Some By Mi Bye Bye Blackhead 30 Days Miracle Green Tea Tox Bubble Cleanser là sữa rửa mặt sủi bọt thuộc thương hiệu Some By Mi làm sạch sâu giúp loại bỏ bã nhờn và mụn đầu đen. Làm sạch dịu nhẹ không gây căng kít nhờ BHA tự nhiên và chiết xuất thảo mộc thiên nhiên', 2097, N'<p>- Thương hiệu: Some By Mi</p>

<p>- Sản xuất tại: Korea</p>

<p>&nbsp;</p>

<p>✖️ T&Aacute;C DỤNG:</p>

<p>1. D&agrave;nh cho mọi loại da, đặc biệt da xuất hiện nhiều mụn đầu đen.</p>

<p>2. C&oacute; khả năng l&agrave;m sạch s&acirc;u b&atilde; nhờn, tạp chất s&acirc;u trong lỗ ch&acirc;n l&ocirc;ng, loại bỏ mụn đầu đen gi&uacute;p bề mặt da th&ocirc;ng tho&aacute;ng chỉ trong v&ograve;ng 5 ph&uacute;t.</p>

<p>3. Th&agrave;nh phần được chiết xuất từ 16 loại thảo mộc từ thi&ecirc;n nhi&ecirc;n, t&iacute;nh axit yếu, kh&ocirc;ng chưa 20 th&agrave;nh phần c&oacute; hại v&agrave; dễ g&acirc;y k&iacute;ch ứng cho da. Từ đ&oacute; gi&uacute;p chăm s&oacute;c l&agrave;n da khỏe mạnh.</p>

<p>&nbsp;</p>

<p>✖️ HDSD: + L&agrave;m sạch h&agrave;ng ng&agrave;y:</p>

<p>1.Thoa một lượng nhỏ sản phẩm l&ecirc;n mặt kh&ocirc;, tr&aacute;nh v&ugrave;ng mắt. Thoa sản phẩm mỏng v&agrave; đều, như đắp mặt nạ</p>

<p>2.Khi bọt nổi l&ecirc;n, massage nhẹ nh&agrave;ng tr&ecirc;n mặt bằng c&aacute;c chuyển động nhỏ hình tr&ograve;n với một chút nước.</p>

<p>3. Rửa lại bằng nước ấm.</p>

<p>&nbsp;</p>

<p>+ Sử dụng 2 đến 3 lần 1 tuần</p>

<p>1.Thoa một lượng nhỏ sản phẩm l&ecirc;n mặt kh&ocirc;, tr&aacute;nh v&ugrave;ng mắt. Thoa sản phẩm mỏng v&agrave; đều, như đắp mặt nạ</p>

<p>2.Lưu lại tr&ecirc;n da từ 3-5 ph&uacute;t sau khi bọt xuất hiện. Sau đ&oacute; nhẹ nh&agrave;ng massage mặt bằng c&aacute;c chuyển động nhỏ hình tr&ograve;n với một chút nước để loại bỏ tạp chất.</p>
', 1, 0, N'sua-rua-mat-sui-bot-loai-bo-mun-dau-den-some-by-mi-bye-bye-blackhead-30-days-miracle-green-tea-tox-bubble-cleanser-120g', CAST(N'2021-08-15 10:53:55.190' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4050, N'Nước xịt khoáng dưỡng da Vichy 150ml', N'Vichy', N'/Uploads/images/product/pro16.jpg', N'/Uploads/images/product/pro16.jpg', 0, N'Được làm giàu tự nhiên với 15 khoáng chất quý hiếm bao gồm sắt, potassium, canxi, manganese, silicon,... nước khoáng Vichy Mineralizing Thermal Spa đã được công nhận bởi tác dụng làm dịu, củng cố và làm đẹp da tuyệt vời của nó, được kiểm chứng bởi 34 thí nghệm trên hơn 600 người thuộc mọi loại da, thậm chí làn da nhạy cảm nhất và dưới sự giám sát của chuyên gia da liễu.', 2107, N'<p>- Thương hi&ecirc;̣u: Vichy</p>

<p>- Xuất xứ: Ph&aacute;p</p>

<p>&nbsp;</p>

<p>✖️ C&ocirc;ng dụng: Nước kho&aacute;ng dưỡng da vichy tăng cường sức sống v&agrave; l&agrave;m dịu cho da. Ph&ugrave; hợp với mọi loại da. Đặc biệt khuy&ecirc;n d&ugrave;ng cho da nhạy cảm.</p>

<p>✖️ Hướng d&acirc;̃n sử dụng:</p>

<p>- D&ugrave;ng nhiều lần trong ng&agrave;y.</p>

<p>- Đặt chai nước kho&aacute;ng song song với mặt, c&aacute;ch khoảng một gang tay. Xịt đều 1 - 2 v&ograve;ng khắp gương mặt, vỗ nhẹ v&agrave; thấm phần nước kho&aacute;ng c&ograve;n đọng lại tr&ecirc;n da bằng b&ocirc;ng tẩy trang/ khăn giấy.</p>

<p>- Bổ sung th&ecirc;m c&aacute;c sản phẩm kh&aacute;c của Vichy như sữa rửa mặt, gel c&aacute;t tẩy tế b&agrave;o chết, nước c&acirc;n bằng da, kem dưỡng da ng&agrave;y/đ&ecirc;m v&agrave; tinh chất để ph&aacute;t huy hiệu quả tối ưu v&agrave; c&oacute; l&agrave;n da khỏe mạnh</p>

<p>✖️ Review: Từ khi sử dụng em &acirc;́y, mình kh&ocirc;ng chỉ sở hữu m&ocirc;̣t làn da tươi tắn khỏe mạnh, mà còn được bổ sung th&ecirc;m dưỡng chất và vitamin cho da ngay từ khi c&ograve;n trẻ. Đặc biệt l&agrave; những ng&agrave;y thời tiết m&ugrave;a h&egrave; nắng n&oacute;ng, mình lu&ocirc;n phải lưu &yacute; v&agrave; chăm s&oacute;c da cẩn thận, tr&aacute;nh t&igrave;nh trạng da l&atilde;o h&oacute;a, kh&ocirc; sạm, thiếu sức sống. D&ugrave; cuộc sống c&oacute; bận rộn đến đ&acirc;u, c&aacute;c chị em phụ nữ cũng đừng qu&ecirc;n d&agrave;nh thời gian v&agrave; c&ocirc;ng sức chăm s&oacute;c da để c&oacute; được n&eacute;t trẻ trung v&agrave; l&agrave;n da kh&ocirc;ng t&igrave; vết như mình nh&eacute;.</p>
', 1, 0, N'nuoc-xit-khoang-duong-da-vichy-150ml', CAST(N'2021-08-15 11:01:41.553' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4051, N'Bộ cọ 8 cây', N'Oem', N'/Uploads/images/product/pro17.jpg', N'/Uploads/images/product/pro17.jpg', 0, N'Bộ cọ trang điểm 8 cây Vintage với thiết kế nhỏ gọn xinh xắn, nhưng không kém phần hiệu quả với 8 cây cọ đủ sức đáp ứng nhu cầu trang điểm của chị em phụ nữ mọi lúc mọi nơi.', 2096, N'<p>Với mức gi&aacute; rất tốt cho 1 bộ cọ gồm 8 c&acirc;y. Được để trong t&uacute;i zip vitage cực k&igrave; tiện lợi khi di chuyển. Đ&aacute;ng để mua ạ!</p>
', 1, 0, N'bo-co-8-cay', CAST(N'2021-08-15 11:09:09.310' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4052, N'Lăn Dưỡng Mắt Simple Kind To Eyes Revitalising Eye Roll-On', N'Simple', N'/Uploads/images/product/pro18.jpg', N'/Uploads/images/product/pro18.jpg', 115000, N'Vùng da mắt mỏng manh dễ tổn thương chính là điểm tố cáo sự già nua trên gương mặt bạn. Lăn dưỡng mắt Simple Kind To Eyes Revitalising Eye Roll On xuất xứ từ Anh Quốc với dung tích 15ml có thành phần chiết xuất dưa leo cùng các loại vitamin sẽ giúp làm giảm thâm quầng, bọng mắt và xóa tan các dấu hiệu của sự mệt mỏi, khiến đôi mắt đẹp rạng ngời, tôn lên vẻ đẹp thanh xuân cho khuôn mặt của bạn.', 2107, N'<p>- Xuất xứ: Anh</p>

<p>- Thương hiệu: Simple</p>

<p>- Dung t&iacute;ch: 15ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>- Lăn Dưỡng Mắt Simple Kind To Eyes Revitalising Eye Roll-On Chứa tinh chất collagen gi&uacute;p x&oacute;a nếp nhăn v&ugrave;ng mắt, hỗ trợ chống l&atilde;o h&oacute;a da v&agrave; v&agrave; tan mỡ bầu mắt.</p>

<p>- Gi&uacute;p chống quầng th&acirc;m, bọng mắt, chống nhăn v&agrave; dưỡng ẩm cho da.</p>

<p>- Kết cấu dạng nước lỏng v&agrave; nhẹ, khhi lăn đầu dưỡng mắt l&ecirc;n v&ugrave;ng mắt một cảm gi&aacute;c sảng kho&aacute;i man m&aacute;t do đầu kim loại mang lại, bạn sẽ thấy thật sự được thư gi&atilde;n.</p>

<p>- Lăn Dưỡng Mắt Simple Kind To Eyes Revitalising Eye Roll-On c&oacute; m&ugrave;i kh&aacute; nhẹ v&agrave; dễ chịu dễ d&agrave;ng sử dụng v&agrave; an to&agrave;n l&agrave;nh t&iacute;nh.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>- Rửa sạch mặt sau đ&oacute; d&ugrave;ng c&aacute;c bước dưỡng da như toner hoặc Lotion.</p>

<p>- Lăn đầu b&uacute;t Lăn Dưỡng Mắt - Simple Kind To Eyes Revitalising Eye Roll-On theo h&igrave;nh v&ograve;ng tr&ograve;n xung quanh mắt (v&ugrave;ng tr&ecirc;n v&agrave; dưới mắt).</p>

<p>- D&ugrave;ng ng&oacute;n tay &uacute;t hoặc ng&oacute;n tay đeo nhẫn nhẹ nh&agrave;ng thoa đều dưỡng chất c&ograve;n lại sau khi lăn.</p>

<p>- Sử dụng 2 lần mỗi ng&agrave;y s&aacute;ng v&agrave; tối.</p>
', 1, 0, N'lan-duong-mat-simple-kind-to-eyes-revitalising-eye-roll-on', CAST(N'2021-08-15 11:23:43.580' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4053, N'Serum dưỡng ẩm sâu Klairs Rich Moist Soothing 80ml', N'Dear, Klairs', N'/Uploads/images/product/pro20.jpg', N'/Uploads/images/product/pro20.jpg', 240000, N'Tinh chất dưỡng ẩm làm mịn da Rich Moist Soothing Serum dưỡng ẩm sâu cho làn da giúp da mềm mại, mịn màng hơn bao giờ hết. Bạn sẽ thấy bất ngờ ngay lần đầu tiên sử dụng bởi khi bôi tinh chất lên da cảm giác da đang được uống nước, da sẽ căng mọng và mát tức thì. Serum thẩm thấu sâu vào trong làn da, dưỡng da nhẹ nhàng, giúp da mịn màng và tươi sáng giữa thời tiết khô lạnh của mùa đông.', 2107, N'<p>- Gi&uacute;p cung cấp độ ẩm chuy&ecirc;n s&acirc;u d&agrave;nh cho t&igrave;nh trạng da kh&ocirc; mất nước, gi&uacute;p da trở n&ecirc;n căng mọng ngay tức th&igrave;, đồng thời hỗ trợ l&agrave;m dịu m&aacute;t da, xoa dịu mẩn đỏ v&agrave; hỗ trợ ngăn ngừa c&aacute;c dấu hiệu l&atilde;o h&oacute;a.</p>

<p>- Ưu điểm:</p>

<p>Gi&uacute;p dưỡng ẩm s&acirc;u v&agrave; cung cấp đủ lượng nước cho da, gi&uacute;p da tr&ocirc;ng mềm mịn, mượt m&agrave;.</p>

<p>Gi&uacute;p da căng b&oacute;ng, hỗ trợ thức đẩy tăng sinh collagen v&agrave; gi&uacute;p da c&oacute; độ đ&agrave;n hồi tốt hơn.</p>

<p>Gi&uacute;p l&agrave;m dịu v&agrave; dưỡng s&aacute;ng da hiệu quả.</p>

<p>Gi&uacute;p l&agrave;m đều m&agrave;u da, gi&uacute;p l&agrave;m mờ vết th&acirc;m v&agrave; hạn chế sự xuất hiện những nh&acirc;n mụn mới.</p>

<p>Gi&uacute;p hỗ trợ đẩy l&ugrave;i t&igrave;nh trạng da l&atilde;o h&oacute;a.</p>
', 1, 0, N'serum-duong-am-sau-klairs-rich-moist-soothing-80ml', CAST(N'2021-08-15 15:16:47.187' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4054, N'Son Tint Bóng Romand New Juicy Lasting', N'Romand', N'/Uploads/images/product/pro21.jpg', N'/Uploads/images/product/pro21.jpg', 0, N'Son tint bóng - Hot trend hè mà nàng nào bỏ lỡ em này quả là một thiếu sót lớn. Em này đúng chuẩn son tint bóng nhẹ, tự nhiên lắm luôn các nàng nhé!', 2094, N'<p>- Bảng m&agrave;u:</p>

<p>18 Mulled Peach (san hô đào).</p>

<p>19 Almond Rose (hoa hồng khô pha hạnh nhân).</p>

<p>20 Dark Coconut (cam nâu dừa).</p>

<p>21 Deep Sangria (đỏ đậm pha lựu).</p>

<p>&nbsp;</p>

<p>- Son được bổ sung v&agrave;o rất nhiều dưỡng chất n&ecirc;n mang lại khả năng dưỡng ẩm cao, n&ecirc;n khi đ&aacute;nh l&ecirc;n m&ocirc;i kh&ocirc;ng những kh&ocirc;ng l&agrave;m lộ r&atilde;nh m&ocirc;i hay kh&ocirc; m&ocirc;i m&agrave; gi&uacute;p đ&ocirc;i m&ocirc;i bạn giữ được lớp m&agrave;u bền v&agrave; mọng hơn suốt nhiều giờ đồng hồ.</p>
', 1, 0, N'son-tint-bong-romand-new-juicy-lasting', CAST(N'2021-08-15 15:22:30.373' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4055, N'Son Kem Black Rouge Air Fit Velvet Tint Ver 4', N'Black Rouge', N'/Uploads/images/product/pro22.jpg', N'/Uploads/images/product/pro22.jpg', 0, N'Black Rouge Ver 4 là phiên bản thứ 4 của dòng son Air Fit Velvet Tint nhà Black Rouge. Liên tiếp đảo phá thị trường son kem với 4 phiên bản son môi đình đám, Black Rouge đã thành công tạo nên dấu ấn thương hiệu trên khắp thị trường Châu Á.', 2094, N'<p>✖️ Bảng m&agrave;u:</p>

<p>#A18 - Coy Rose: Hồng Indie điểm n&acirc;u tinh tế</p>

<p>#A19 - Tough Rose: Đỏ Hồng Tomato hợp mọi tone da</p>

<p>#A20 - Girl Crush Rose: Đỏ t&iacute;m cherry rực rỡ, tươi mới</p>

<p>#A21 - Prickly Rose: Đỏ n&acirc;u &aacute;nh kh&oacute;i sắc sảo</p>

<p>#A22 - Vampire Rose: Đỏ n&acirc;u maple &aacute;nh t&iacute;m huyền ảo</p>
', 1, 0, N'son-kem-black-rouge-air-fit-velvet-tint-ver-4', CAST(N'2021-08-15 16:52:11.550' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4056, N'Son Kem Lỳ Phytotree Twenty Four Hour Velvet Tint 6g', N'Phytotree', N'/Uploads/images/product/pro23.jpg', N'/Uploads/images/product/pro23.jpg', 0, N'Son Kem Lỳ Phytotree khi lướt son lên môi ta cảm nhận son rất mướt, mịn độ bóng của son vừa phải. Độ ẩm tuyệt đối khi bôi lên mội sẽ ẩm ẩm mát mát. Sau khi khô lại trong 1 ngày dài thì độ ẩm vẫn nguyên như ban đầu giúp môi không bị khô dù là son kem lì.', 2094, N'<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>- M&agrave;u da k&eacute;n chọn? Ngại kh&ocirc; m&ocirc;i? Chất son dễ tr&ocirc;i?&hellip;. Đừng lo, v&igrave; đ&oacute; l&agrave; l&iacute; do PHYTOTREE -TWENTY FOUR VELVET HOUR xuất hiện. Son Kem Lỳ Phytotree Twenty Four Hour Velvet Tint l&agrave; em son kem giữ m&agrave;u l&ecirc;n đến 24H m&agrave; ko hề kh&ocirc; m&ocirc;i t&iacute; n&agrave;o.</p>

<p>- Chất son mịn, mướt c&oacute; m&ugrave;i thơm nhẹ cực th&iacute;ch nh&eacute; c&aacute;c n&agrave;ng, che được cả v&acirc;n m&ocirc;i lu&ocirc;n đ&oacute; ạ, kh&ocirc;ng hề bị kh&ocirc; m&ocirc;i đ&acirc;u nh&eacute;! Th&iacute;ch hợp với m&ocirc;i n&agrave;ng n&agrave;o hay bị kh&ocirc;, nhiều v&acirc;n m&ocirc;i.</p>

<p>- Khi mới l&ecirc;n m&ocirc;i rất dễ t&aacute;n, sau tầm 1 ph&uacute;t son sẽ bắt đầu l&igrave; lại. Tạo cho người d&ugrave;ng cảm gi&aacute;c m&ocirc;i m&igrave;nh tho&aacute;ng v&agrave; dễ chịu. Kh&ocirc;ng bị bết d&iacute;nh hay v&oacute;n cục.</p>

<p>- Son Kem Lỳ Phytotree khi lướt son l&ecirc;n m&ocirc;i ta cảm nhận son rất mướt, mịn độ b&oacute;ng của son vừa phải. Độ ẩm tuyệt đối khi b&ocirc;i l&ecirc;n mội sẽ ẩm ẩm m&aacute;t m&aacute;t. Sau khi kh&ocirc; lại trong 1 ng&agrave;y d&agrave;i th&igrave; độ ẩm vẫn nguy&ecirc;n như ban đầu gi&uacute;p m&ocirc;i kh&ocirc;ng bị kh&ocirc; d&ugrave; l&agrave; son kem l&igrave;.</p>

<p>- M&agrave;u sắc của Son Kem Lỳ Phytotree giữ tr&ecirc;n m&ocirc;i đến 24 tiếng. Sau khi ăn uống chỉ tr&ocirc;i tầm 20% nếu đ&aacute;nh to&agrave;n bộ m&ocirc;i, v&agrave; tr&ocirc;i khoảng 30% nếu đ&aacute;nh trong l&ograve;ng m&ocirc;i.</p>

<p>- M&ugrave;i thơm dịu nhẹ ko gắt tạo cảm gi&aacute;c dễ chịu.</p>

<p>- Ngo&agrave;i việc d&ugrave;ng để l&agrave;m son m&ocirc;i, c&aacute;c c&ocirc; g&aacute;i cũng c&oacute; thể tận dụng em son black rouge n&agrave;y để l&agrave;m m&aacute; hồng, tăng th&ecirc;m vẻ xinh xắn cho đ&ocirc;i m&aacute; nữa đ&oacute; bằng c&aacute;ch chỉ cần chấm 3 điểm nhỏ l&ecirc;n m&aacute; sau đ&oacute; t&aacute;n đều l&agrave; được.</p>

<p>&nbsp;</p>

<p>- Bảng m&agrave;u:</p>

<p>#01 Romantic Rose Signal (đỏ hồng d&acirc;u)</p>

<p>#02 Grapefruit Signal (đỏ cam)</p>

<p>#03 Chilli Pepper Signal (đỏ gạch)</p>

<p>#04 Burgundy Signal (đỏ lạnh)</p>

<p>#05 Brick Red Signal (đỏ n&acirc;u)</p>

<p>#06 Dry Rose Signal (đỏ cam ch&aacute;y)</p>
', 1, 0, N'son-kem-ly-phytotree-twenty-four-hour-velvet-tint-6g', CAST(N'2021-08-15 16:58:48.573' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4057, N'Kem Lót Kiềm Dầu Che Lỗ Chân Lông Maybelline Pore Eraser Baby Skin', N'Maybelline New York', N'/Uploads/images/product/pro24.jpg', N'/Uploads/images/product/pro24.jpg', 160000, N'Kem lót Baby Skin Pore Eraser giúp làm mịn da, che khuyết điểm, tạo hiệu ứng lỗ chân lông thu nhỏ, cho lớp nền mịn màng hoàn hảo.', 2095, N'<p>- Đ&acirc;y l&agrave; một sản phẩm kem l&oacute;t drugstore b&igrave;nh d&acirc;n được y&ecirc;u th&iacute;ch h&agrave;ng đầu tại thị trường Mỹ. Nhiều năm liền đứng top Best Seller của thương hiệu Maybelline đ&igrave;nh đ&aacute;m.</p>

<p>- Được xem như bản DUPE ho&agrave;n hảo của hai loại kem l&oacute;t High-end đắt đỏ l&agrave; SmashBox Photo Finish Primer hay Benefit Porefessional Primer. Với gi&aacute; tiền v&ocirc; c&ugrave;ng dễ chịu, kem l&oacute;t Maybelline Pore Eraser Baby Skin Primer vẫn đảm bảo được chất lượng cực tốt với mức gi&aacute; v&ocirc; c&ugrave;ng b&igrave;nh d&acirc;n.</p>

<p>- Sản phẩm được y&ecirc;u th&iacute;ch v&agrave; tin d&ugrave;ng bởi c&aacute;c beauty blogger v&agrave; beauty guru nổi tiếng tr&ecirc;n to&agrave;n Thế Giới như: Christen Dominique, Casey Holmes, EmilyNoel83, Tati,....</p>

<p>&nbsp;</p>

<p>- C&ocirc;ng dụng:</p>

<p>+ Chất kem l&oacute;t kiềm dầu Maybelline Baby Skin Primer đặc, dạng gel trong suốt, ngay lập tức sẽ che phủ những khuyết điểm tr&ecirc;n gương mặt của bạn như lỗ ch&acirc;n l&ocirc;ng to, sẹo l&otilde;m, sẹo mụn,... trả lại cho bạn một bề mặt da phẳng, mịn, đẹp kh&ocirc;ng t&igrave; vết</p>

<p>+ Sản phẩm kh&ocirc;ng chứa chất tạo m&agrave;u hay chất tạo m&ugrave;i. Ho&agrave;n to&agrave;n trong suốt.</p>

<p>+ Chất sản phẩm cực k&igrave; dễ t&aacute;n v&agrave; h&ograve;a v&agrave;o da cực kỳ tự nhi&ecirc;n. Để lại một lớp l&oacute;t mềm mịn y như da thật.</p>

<p>+ Bề mặt da kh&ocirc; tho&aacute;ng, mịn m&agrave;ng. Ho&agrave;n to&agrave;n kh&ocirc;ng g&acirc;y nặng mặt, b&iacute; da hay sinh ra mụn.</p>

<p>+ Khả năng kiềm dầu của kem l&oacute;t Maybelline Baby Skin Primer được đ&aacute;nh gi&aacute; rất cao. Gi&uacute;p lớp nền của bạn c&oacute; thể giữ được từ 8 đến 12 tiếng.</p>

<p>+ Sử dụng cực kỳ tiết kiệm. Chỉ cần một lượng sản phẩm to bằng 2 hạt đậu l&agrave; đ&atilde; đủ apply to&agrave;n bộ gương mặt.</p>
', 1, 0, N'kem-lot-kiem-dau-che-lo-chan-long-maybelline-pore-eraser-baby-skin', CAST(N'2021-08-15 17:01:43.717' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4058, N'Son Tint Lì Romand Juicy Lasting Tint', N'Romand', N'/Uploads/images/product/pro28.jpg', N'/Uploads/images/product/pro28.jpg', 0, N'Son tint lì Romand Juicy Lasting Tint là son tint thuộc thương hiệu Romand với chất son trong trẻo, tạo hiệu ứng căng mọng tự nhiên cho đôi môi, màu son duy trì trong nhiều giờ liền cho bạn cảm giác bờ môi sáng bóng, căng mọng và ngọt ngào', 2094, N'<p>- Thương hiệu: Romand</p>

<p>- Kh&ocirc;i lượng: 5,5g</p>

<p>&nbsp;</p>

<p>✖️ Bảng m&agrave;u: M&agrave;u</p>

<p>#01 Juicy Oh: Cam v&agrave;ng M&agrave;u</p>

<p>#02 Ruby Red: đỏ cam M&agrave;u</p>

<p>#03 Summer scent: đỏ hồng M&agrave;u</p>

<p>#04 Dragon Pink: hồng c&aacute;nh sen M&agrave;u</p>

<p>#05 Peach Me: hồng đ&agrave;o sữa M&agrave;u</p>

<p>#06 Fig Fig: hồng đỏ đất M&agrave;u</p>

<p>#07 Jujube: đỏ cam đất M&agrave;u</p>

<p>#08 Apple Brown: cam đất M&agrave;u</p>

<p>#09 Litchi Coral: hồng đ&agrave;o M&agrave;u</p>

<p>#10 NUDY PEANUT (nude cam trầm) M&agrave;u</p>

<p>#11 PINK PUMPKIN (hồng đất) M&agrave;u</p>

<p>#12 CHERRY BOMB (đỏ n&acirc;u cherry) M&agrave;u</p>

<p>#13 EAT DOTORI (n&acirc;u hạt dẻ trầm)</p>

<p>&nbsp;</p>

<p>✖️ Ưu điểm: Bộ sưu tập son tint Romand Juicy Lasting Tint lấy cảm hứng từ c&aacute;c loại tr&aacute;i c&acirc;y v&ugrave;ng nhiệt đới với 9 sắc m&agrave;u cực k&igrave; bắt mắt v&agrave; quyến rũ.</p>

<p>&ndash; Với độ b&oacute;ng ho&agrave;n hảo, m&agrave;u sắc bắt mắt v&agrave; duy&ecirc;n d&aacute;ng c&ugrave;ng độ b&aacute;m m&agrave;u thật l&acirc;u tr&ecirc;n đ&ocirc;i m&ocirc;i, Romand Juicy Lasting Tint sẽ đem cả m&ugrave;a h&egrave; rực rỡ v&agrave; s&ocirc;i động l&ecirc;n đ&ocirc;i m&ocirc;i của bạn.</p>

<p>&ndash; Thiết kế v&ocirc; c&ugrave;ng hiện đại m&agrave; kh&ocirc;ng k&eacute;m phần nữ t&iacute;nh. Th&acirc;n cọ son b&ecirc;n trong nhỏ vừa phải, đầu cọ c&oacute; h&igrave;nh giọt nước được l&agrave;m bằng lớp b&ocirc;ng mềm mịn gi&uacute;p m&agrave;u t&aacute;n đều tr&ecirc;n đ&ocirc;i m&ocirc;i.</p>

<p>&ndash; Chất son kh&aacute; đặc, thi&ecirc;n về dạng son kem v&agrave; tạo lớp son l&igrave; ho&agrave;n to&agrave;n tr&ecirc;n m&ocirc;i. Son kh&aacute; l&acirc;u tr&ocirc;i v&agrave; cũng kh&ocirc;ng g&acirc;y kh&ocirc; m&ocirc;i sau nhiều giờ.</p>

<p>&ndash; Độ b&aacute;m m&agrave;u kh&aacute; tốt, c&oacute; thể giữ từ 4-6 tiếng v&agrave; độ b&oacute;ng ho&agrave;n hảo ở mức độ vừa phải, kh&ocirc;ng qu&aacute; b&oacute;ng cũng kh&ocirc;ng phải kh&ocirc;. Đặc biệt, th&agrave;nh phần dưỡng ẩm kh&aacute; cao tạo một lớp b&oacute;ng ẩm nhưng kh&ocirc;ng bết d&iacute;nh khiến m&ocirc;i trong veo, căng mọng gi&uacute;p m&ocirc;i kh&ocirc;ng bị bong tr&oacute;c.</p>
', 1, 0, N'son-tint-li-romand-juicy-lasting-tint', CAST(N'2021-08-16 21:18:49.890' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4059, N'Bông tẩy trang IPEK 120 Miếng (Thổ Nhĩ Kì)', N'Ipek', N'/Uploads/images/product/pro29.jpg', N'/Uploads/images/product/pro29.jpg', 45000, N'Bông tẩy trang Ipek với thành phần 100% bông cotton với công nghệ sản xuất bông tiên tiến giúp tẩy trang và làm sạch mọi bụi bẩn bám trên da. Miếng bông được dệt thành 2 mặt giúp tận dụng được tối đa sản phẩm. Sợi bông mềm mịn thấm hút sâu dung dịch tẩy trang và nước hoa hồng, nhẹ nhàng tẩy sạch da.', 2096, N'<p>- B&ocirc;ng tẩy trang Ipek với th&agrave;nh phần 100% b&ocirc;ng cotton với c&ocirc;ng nghệ sản xuất b&ocirc;ng ti&ecirc;n tiến gi&uacute;p tẩy trang v&agrave; l&agrave;m sạch mọi bụi bẩn b&aacute;m tr&ecirc;n da.</p>

<p>- Miếng b&ocirc;ng được dệt th&agrave;nh 2 mặt gi&uacute;p tận dụng được tối đa sản phẩm.</p>

<p>- Sợi b&ocirc;ng mềm mịn thấm h&uacute;t s&acirc;u dung dịch tẩy trang v&agrave; nước hoa hồng, nhẹ nh&agrave;ng tẩy sạch da.</p>
', 1, 0, N'bong-tay-trang-ipek-120-mieng-tho-nhi-ki', CAST(N'2021-08-16 21:21:08.147' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4060, N'Bông dặm phấn Vacosi BP22', N'Vacosi', N'/Uploads/images/product/pro31.jpg', N'/Uploads/images/product/pro31.jpg', 30000, N'Bông Phấn Cushion Vacosi Cushion Sponge BP22 được thiết kế từ chất liệu mút nén siêu mịn với hàng trăm lỗ nhỏ li ti trên bề mặt. Bông phấn có 2 mặt khác nhau với nhiệm vụ điều tiết phấn và kiểm soát dầu trên da. Đặc biệt công nghệ bơm khí giúp giữ lớp kem nền phía dưới không bị hút phấn.', 2096, N'<p>- Được thiết kế từ chất liệu m&uacute;t n&eacute;n si&ecirc;u mịn với h&agrave;ng trăm lỗ nhỏ li ti tr&ecirc;n bề mặt.</p>

<p>- C&oacute; 2 mặt kh&aacute;c nhau với nhiệm vụ điều tiết phấn v&agrave; kiểm so&aacute;t dầu tr&ecirc;n da. Đặc biệt c&ocirc;ng nghệ bơm kh&iacute; gi&uacute;p giữ lớp kem nền ph&iacute;a dưới kh&ocirc;ng bị h&uacute;t phấn.</p>
', 1, 0, N'bong-dam-phan-vacosi-bp22', CAST(N'2021-08-16 21:24:35.113' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4061, N'Phấn highlight bắt sáng Catrice High Glow Mineral Highlighting', N'Catrice', N'/Uploads/images/product/pto32.jpg', N'/Uploads/images/product/pto32.jpg', 145000, N'Xu hướng bắt sáng đang là một trong những xu hướng đình đám nhất được các beauty blogger, đặc biệt là các bạn beauty blogger style Âu Mỹ lăng xê nhiệt tình. Không nằm ngoài xu hướng đó, Catrice cũng cho ra mắt sản phẩm Phấn Bắt Sáng Catrice High Glow Mineral Highlighting Powder cho nàng một khuôn mặt bừng sáng khỏe mạnh siêu "slay".', 2095, N'<p>✖️ <strong>C&Ocirc;NG DỤNG</strong>:</p>

<p>➖ Tạo khối cho gương mặt g&oacute;c cạnh v&agrave; sắc n&eacute;t hơn</p>

<p>➖ Tạo hiệu ứng để l&agrave;n da căng b&oacute;ng, mềm mịn</p>

<p>➖ Tạo da n&acirc;u nh&igrave;n rất khỏe khoắn</p>

<p>➖ Tạo điểm nhấn l&agrave;m nổi bật s&oacute;ng mũi</p>

<p>➖ Che đi quầng th&acirc;m dưới mắt</p>

<p>&nbsp;</p>

<p>✖️ <strong>HDSD</strong>:</p>

<p>➖ Khi đ&atilde; thực hiện xong c&aacute;c bước trang điểm, bạn chỉ cần d&ugrave;ng b&ocirc;ng lấy một lượng Catrice &nbsp;High Glow Mineral Highlighting vừa đủ.</p>

<p>➖ Phủ l&ecirc;n v&ugrave;ng chữ T, 2 b&ecirc;n gò má, trán, nh&acirc;n trung và cằm để tạo khối cho gương mặt, khiến chứng trở n&ecirc;n hấp dẫn v&agrave; thu h&uacute;t hơn dưới &aacute;nh s&aacute;ng mặt trời hoặc &aacute;nh đ&egrave;n.</p>

<p>➖ Catrice High Glow Mineral Highlighting cũng c&oacute; vai tr&ograve; như phấn phủ để gi&uacute;p da căng b&oacute;ng v&agrave; ho&agrave;n hảo hơn.</p>

<p>&nbsp;</p>

<p>✖️ <strong>Lưu &yacute; rằng</strong>:</p>

<p>&ndash; Bronzing l&agrave; kỹ thuật đ&aacute;nh phấn để tạo m&agrave;u da b&aacute;nh mật.</p>

<p>&ndash; Contouring l&agrave; kĩ thuật để gi&uacute;p định h&igrave;nh khu&ocirc;n mặt c&oacute; h&igrave;nh khối hơn.</p>

<p>- Đánh n&acirc;u (Bronzer) : Đ&acirc;y l&agrave; phong c&aacute;ch d&agrave;nh cho những bạn th&iacute;ch trang điểm theo phong c&aacute;ch T&acirc;y &Acirc;u, da n&acirc;u khỏi khoắn, phủ l&ecirc;n những v&ugrave;ng ch&iacute;nh của gương mặt.</p>

<p>- Đánh góc/Tạo kh&ocirc;́i (Contour) : Bước n&agrave;y sẽ gi&uacute;p gương mặt thon gọn</p>

<p>- Đánh vùng sáng (Highlight) : Bạn lấy phần dọc s&oacute;ng mũi, 2 g&ograve; m&aacute;, tr&aacute;n, nh&acirc;n trung v&agrave; v&ugrave;ng cằm.</p>
', 1, 0, N'phan-highlight-bat-sang-catrice-high-glow-mineral-highlighting', CAST(N'2021-08-16 21:34:47.417' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4062, N'Xịt Thơm Quần Áo Fabric Perfume Hàn Quốc 250ml', N'Khác', N'/Uploads/images/product/pro33.jpg', N'/Uploads/images/product/pro33.jpg', 0, N'Xịt Thơm Quần Áo Fabric Perfume là một phép cộng hoàn hảo giữa sữa dưỡng thể và nước hoa, vừa tạo hương, vừa tạo màng ẩm dễ chịu cho làn da cơ thể, Body mist thích hợp cho các chị em công sở ngồi văn phòng cả ngày.', 2113, N'<p>- Mang lại hương thơm cả ng&agrave;y.</p>

<p>- Tiệt tr&ugrave;ng v&agrave; khử m&ugrave;i mồ h&ocirc;i, m&ugrave;i thức ăn b&aacute;m, m&ugrave;i bụi bẩn.</p>

<p>- Đ&aacute;nh bay m&ugrave;i da mới, m&ugrave;i hắc nước sơn.</p>

<p>- Khử m&ugrave;i tủ gi&agrave;y, b&aacute;m m&ugrave;i v&agrave; l&agrave;m thơm đối với tất cả c&aacute;c bề mặt vải, ướp thơm tủ quần &aacute;o, l&agrave;m thơm chăn ga gối đệm mang lại giấc ngủ dễ chịu.</p>

<p>- Xịt Thơm Fabric Perfume c&oacute; độ an to&agrave;n cực kỳ cao n&ecirc;n bạn kh&ocirc;ng hề lo sản phẩm bị k&iacute;ch ứng hay mẩn đỏ trong qu&aacute; tr&igrave;nh sử dụng.</p>
', 1, 0, N'xit-thom-quan-ao-fabric-perfume-han-quoc-250ml', CAST(N'2021-08-16 21:55:11.473' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4063, N'Dưỡng Ẩm The Ordinary Natural Moisturizing Factors + HA 30ml', N'The Ordinary', N'/Uploads/images/product/pro34.jpg', N'/Uploads/images/product/pro34.jpg', 180000, N'Kem dưỡng ẩm The Ordinary Natural Moisturising Factors + HA sử dụng các yếu tố dưỡng ẩm tự nhiên, vừa bảo vệ da, đồng thời cung cấp độ ẩm cần thiết. Các thành phần dưỡng ẩm tự nhiên bao gồm amino acid, acid béo, triglycerides, urea, ceramides, phospholipids, glycerin, saccharides, sodium PCA, hyaluronic acid và các hợp chất có trong da tự nhiên.', 2103, N'<p>- Sản phẩm được nh&agrave; sản xuất giới thiệu l&agrave; kem dưỡng ẩm chuy&ecirc;n s&acirc;u với th&agrave;nh phần bao gồm hợp chất NHF (gọi tắt của th&agrave;nh tố dưỡng ẩm tự nhi&ecirc;n) l&agrave; tổng hợp của 11 loại acid amin giữ ẩm tự nhi&ecirc;n cho da như amino acid, acid b&eacute;o, triglyceride, urea, ceramide, phospholipid, glycerin, hyaluronic acid,... C&aacute;c chất phức tự nhi&ecirc;n NMF n&agrave;y cũng xuất hiện trong nhiều d&ograve;ng mask của nh&agrave; Mediheal nữa đ&oacute;.</p>

<p>- Ngo&agrave;i ra, The Ordinary Natural Moisturizing Factors HA l&agrave; sản phẩm kh&ocirc;ng chứa silicon, dầu kho&aacute;ng v&agrave; cồn n&ecirc;n khi c&oacute; l&agrave;n da nhạy cảm c&oacute; thể ho&agrave;n to&agrave;n sử dụng được nh&eacute;. Natural Moisturizing Factors + HA c&oacute; chất kem đặc xốp nhưng kh&aacute; dễ t&aacute;n. Mặc d&ugrave; c&oacute; chứa nhiều chất dưỡng ẩm nhưng kem kh&ocirc;ng g&acirc;y b&oacute;ng nhờn. Đ&acirc;y l&agrave; một điểm cộng. Thế nhưng, kem dưỡng ẩm lại kh&ocirc;ng hề mang lại cảm gi&aacute;c ẩm v&agrave; mượt m&agrave; như những kem dưỡng da cấp ẩm kh&aacute;c nhưng vẫn giữ được độ ẩm mềm mượt cho da.</p>
', 1, 0, N'duong-am-the-ordinary-natural-moisturizing-factors-ha-30ml', CAST(N'2021-08-16 21:58:18.380' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4064, N'Mascara Innisfree các dòng', N'Innisfree', N'/Uploads/images/product/pro35.jpg', N'/Uploads/images/product/pro35.jpg', 0, N'Masscara innisfree được rất nhiều chị em phụ nữ lực chọn và tin dùng bởi không chỉ hiệu quả mà giá thành cũng vừa phải chưa kể thành phần hầu hết từ thiên nhiên giúp bảo vệ đôi mắt bạn.', 2104, N'<p>✖️ Mascara Innisfree Super Longlashcara:</p>

<p>- C&oacute; đầu chuốt được thiết kế 2 mặt ri&ecirc;ng biệt gi&uacute;p mi d&agrave;i v&agrave; cong hơn.</p>

<p>- Đầu chuốt mi được thiết kế với c&aacute;c lược chải mềm v&agrave; chắc chắn gi&uacute;p mi khỏe mạnh v&agrave; kh&ocirc;ng l&agrave;m rụng l&ocirc;ng mi khi chuốt.</p>

<p>- Ngoài thi&ecirc;́t k&ecirc;́ đ&acirc;̀u cọ chải th&ocirc;ng minh, Mascara Innisfree Super Longlashcara còn giúp đảm bảo làn mi tơi đ&ecirc;̀u kh&ocirc;ng bị dính vào nhau cho nét mi tự nhi&ecirc;n, mascara kh&ocirc;ng bị vón cục và g&acirc;y nặng mi.</p>

<p>- Khả năng bám t&ocirc;́t, giữ mi lu&ocirc;n cong dài và dày tự nhi&ecirc;n mà kh&ocirc;ng sợ bị m&acirc;́t n&ecirc;́p hay nhòe đi trong su&ocirc;́t cu&ocirc;̣c vui.</p>

<p>- C&ocirc;ng thức đặc bi&ecirc;̣t d&ecirc;̃ dàng t&acirc;̉y trang với nước &acirc;́m mà kh&ocirc;ng c&acirc;̀n phải chà xát mạnh.</p>

<p>- C&ocirc;ng thức chứa c&aacute;c sợi nối đặc biệt, nhẹ tựa kh&ocirc;ng kh&iacute;, gi&uacute;p nối d&agrave;i mi nhanh ch&oacute;ng m&agrave; kh&ocirc;ng g&acirc;y cảm gi&aacute;c nặng, kh&oacute; chịu, kh&ocirc;ng g&acirc;y loang lổ hay v&oacute;n cục</p>

<p>&nbsp;</p>

<p>✖️ Mascara Si&ecirc;u Mảnh Chống Tr&ocirc;i Innisfree Skinny Microcara Zero:</p>

<p>- Độ chống tr&ocirc;i si&ecirc;u việt với chỉ số l&ecirc;n đến 97% bất kể l&agrave; nước, mồ h&ocirc;i hay nước mắt v&agrave; bền m&agrave;u đến tận 12 giờ, kh&ocirc;ng h&ecirc;̀ bị rủ và m&acirc;́t n&ecirc;́p.</p>

<p>- Thi&ecirc;́t k&ecirc;́ nhỏ gọn, đơn giản với đ&acirc;̀u chải th&ocirc;ng minh si&ecirc;u mảnh cho phép mascara có th&ecirc;̉ len lỏi v&agrave;o từng sợi mi mà kh&ocirc;ng h&ecirc;̀ g&acirc;y tình trạng vón cục m&acirc;́t tự nhi&ecirc;n.</p>

<p>Thành ph&acirc;̀n chi&ecirc;́t xu&acirc;́t từ thi&ecirc;n nhi&ecirc;n n&ecirc;n có th&ecirc;̉ an t&acirc;m sử dụng mà kh&ocirc;ng lo các v&acirc;́n đ&ecirc;̀ kích ứng ngay rụng mi. Vì hi&ecirc;̣u ứng tạo ra cho đ&ocirc;i mi cong và dày tự nhi&ecirc;n n&ecirc;n có th&ecirc;̉ sử dụng mascara này cho trang điểm hằng ngày hoặc đi học.</p>

<p>&nbsp;</p>

<p>✖️ Mascara Super Volumecara:</p>

<p>- Th&agrave;nh phần chứa &ldquo;Black Effect Complex&rdquo; với c&ocirc;ng thức đậu tương v&agrave; ngọc trai đen gi&uacute;p mi đen b&oacute;ng quyến rũ. Đồng thời gi&uacute;p mi b&oacute;ng v&agrave; khỏe hơn.</p>

<p>- Với khả năng l&agrave;m d&agrave;y mi 1 cho n&agrave;ng 1 đ&ocirc;i mi d&agrave;y dặn v&ocirc; c&ugrave;ng quyến rũ.</p>

<p>- C&ocirc;ng thức đặc biệt gi&uacute;p h&agrave;ng mi d&agrave;y l&ecirc;n m&agrave; kh&ocirc;ng g&acirc;y v&oacute;n cục, loang lổ, kh&ocirc;ng lem, kh&ocirc;ng tr&ocirc;i.</p>
', 1, 0, N'mascara-innisfree-cac-dong', CAST(N'2021-08-16 22:09:45.800' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4065, N'Tinh Chất Dưỡng Trắng Some By Mi Galactomyces Pure Vitamin C Glow Serum', N'Some By Mi', N'/Uploads/images/product/pro36.jpg', N'/Uploads/images/product/pro36.jpg', 250000, N'Some By Mi Galactomyces Pure Vitamin C Glow Serum được nhân đôi sức mạnh có công dụng cải thiện tone màu da, giúp xoá mờ vết thâm cũng như giảm thiểu khả năng hình thành tàn nhang và nếp nhăn trên da, giúp da luôn sáng khoẻ và mịn màng.', 2103, N'<p>Khối lượng: 30ml</p>

<p>Thương hiệu: Some By Mi</p>

<p>Sẩn xuất: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>- C&ocirc;ng dụng:</p>

<p>+ Tr&ecirc;n thị trường hiện n&agrave;y c&oacute; rất nhiều d&ograve;ng tinh chất với chiết xuất ch&iacute;nh từ vitamin C điển h&igrave;nh như: serum vitamin c melano cc rohto, tinh chất timeless&hellip; Tuy nhi&ecirc;n đến thời điểm hiện tại chưa c&oacute; một loại tinh chất n&agrave;o vượt mặt được serum Some By Mi Galactomyces. Khi sản phẩm c&oacute; nhiều th&agrave;nh phần đặc trưng như: + Galactomyces ferment filtrate (75%): Th&agrave;nh phần chủ đạo của sản phẩm, c&oacute; t&aacute;c dụng giải quyết nhanh ch&oacute;ng c&aacute;c vấn đề tr&ecirc;n da: Da bị xỉn m&agrave;u, n&aacute;m, sạm đen, th&acirc;m mụn, giảm thiểu nếp nhăn cho da. Đồng thời c&ograve;n gi&uacute;p cho da th&ecirc;m đ&agrave;n hồi v&agrave; khỏe mạnh.</p>

<p>+ Vitamin B3: Gi&uacute;p củng cố lớp m&agrave;ng bảo vệ tự nhi&ecirc;n của l&agrave;n da, chống lại khả năng l&atilde;o h&oacute;a v&agrave; hạn chế tiết dầu tr&ecirc;n da.</p>

<p>+ Dipropylene glycol, Butylene Glycol, Sodium Hyaluronate: Cung cấp độ ẩm cho l&agrave;n da.</p>

<p>+ Tromethamine: C&acirc;n bằng lại độ pH tự nhi&ecirc;n tr&ecirc;n da. Hydroxyethyl ethylcellulose: Kiềm dầu v&agrave; b&atilde; nhờn tiết ra tr&ecirc;n da. Allantoin: C&oacute; khả năng kh&aacute;ng vi&ecirc;m, kh&aacute;ng khuẩn, tăng cười th&ecirc;m sức đề kh&aacute;ng cho da.</p>

<p>+ Sodium Ascorbyl Phosphate: Th&agrave;nh phần gi&uacute;p da th&ecirc;m trắng s&aacute;ng, đều m&agrave;u hơn.</p>

<p>+ Vitamin C: Gi&uacute;p cải thiện c&aacute;c vấn đề tr&ecirc;n da như gi&uacute;p da trắng s&aacute;ng hơn, l&agrave;m đều m&agrave;u da, giảm th&acirc;m mụn.</p>

<p>+ C&ugrave;ng c&aacute;c th&agrave;nh phần kh&aacute;c: 10 loại vitamin, VP/VA Copolymer, Propolis Extract, Roe extract, Aronia Arbutifolia Fruit Extract, Adenosine&hellip;</p>

<p>+ Một trong những điểm cộng lớn nữa l&agrave; d&ograve;ng tinh chất n&agrave;y ph&ugrave; hợp với nhiều loại da, nhiều lứa tuổi, v&igrave; những khả năng to&agrave;n diện kh&aacute;c như chăm s&oacute;c l&agrave;n da bị mụn, điều chỉnh độ pH gi&uacute;p bảo vệ lớp m&agrave;ng ẩm của da v&agrave; tăng cường độ đ&agrave;n hồi cho da.</p>

<p>+ Đến từ một thương hiệu nổi tiếng tại H&agrave;n Quốc l&ecirc;n sản phẩm được đ&aacute;nh gi&aacute; l&agrave; an to&agrave;n, l&agrave;nh t&iacute;nh, kh&ocirc;ng g&acirc;y ra bất cứ vấn đề g&igrave; trong qu&aacute; tr&igrave;nh sử dụng.</p>
', 1, 0, N'tinh-chat-duong-trang-some-by-mi-galactomyces-pure-vitamin-c-glow-serum', CAST(N'2021-08-16 22:14:01.887' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4066, N'MÚT TÁN HỒ LÔ VACOSI PEAR BLENDER - BP06', N'Vacosi', N'/Uploads/images/product/pro37.jpg', N'/Uploads/images/product/pro37.jpg', 50000, N'Mút tán hồ lô Vacosi của thương hiệu mỹ phẩm nổi tiếng Vacosi được thiết kế cực thông minh, dùng cho mọi ngóc ngách trên mặt như khoé mũi, dưới mắt và dùng được cho cả sản phẩm dạng lỏng, dạng khô phấn nền hay phấn má.', 2096, N'<p>- Blender hồ l&ocirc; VACOSI với bề mặt mịn c&ugrave;ng c&aacute;c lỗ kh&iacute; li ti đều đặn tạo cảm gi&aacute;c mềm mại v&agrave; b&ocirc;ng xốp như nhung khi sử dụng.</p>

<p>- Blender hồ l&ocirc; VACOSI d&ugrave;ng cho phấn l&oacute;t, kem nền dạng nước hoặc dạng kem. Gi&uacute;p lớp nền đều m&agrave;u, mịn mượt, ho&agrave;n hảo cho những lớp trang điểm tiếp theo.</p>

<p>- B&ocirc;ng phấn được chia l&agrave;m 2 phần:</p>

<p>+ Phần đầu mũi nhọn v&agrave; nhỏ gi&uacute;p bạn dễ d&agrave;ng t&aacute;n kem nền hay kem che khuyết điểm v&agrave;o những phần như hốc mắt, v&ugrave;ng dưới mắt hay c&aacute;nh mũi.</p>

<p>+ Phần đầu tr&ograve;n mang lại cho bạn một lớp nền mỏng nhẹ, mịn m&agrave;ng. V&agrave; phần cong ở b&ecirc;n h&ocirc;ng miếng m&uacute;t sẽ gi&uacute;p nhấn nh&aacute; cho c&aacute;c phần trang điểm đậm hơn như tạo khối hay bronzer.</p>

<p>- Ưu điểm nổi bật:</p>

<p>+ Sản xuất theo c&ocirc;ng nghệ H&agrave;n Quốc.</p>

<p>+ Độ dẻo v&agrave; mềm mịn cao.</p>

<p>+ Kh&ocirc;ng h&uacute;t qu&aacute; nhiều kem v&agrave; kh&ocirc;ng tạo vệt khi t&aacute;n.</p>
', 1, 0, N'mut-tan-ho-lo-vacosi-pear-blender---bp06', CAST(N'2021-08-17 10:55:02.533' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4067, N'Sữa rửa mặt trà xanh matcha ROHTO Shirochasou', N'Rohto', N'/Uploads/images/product/pro25.jpg', N'/Uploads/images/product/pro25.jpg', 120000, N'Sữa rửa mặt trà xanh matcha ROHTO Shirochasou với tinh chất trà xanh matcha chiết xuất ko chỉ có khả năng làm sạch da, mà còn dưỡng ẩm cho da mịn màng, ngăn ngừa mụn và có khả năng chống lão hóa.', 2097, N'<p>🖤🖤Sữa rửa mặt tr&agrave; xanh matcha ROHTO Shirochasou🖤🖤</p>

<p>💲 Gi&aacute; lẻ: 120k</p>

<p>➡️ Thương hiệu: Rohto</p>

<p>➡️ Xuất xứ: Nhật Bản</p>

<p>➡️ Quy c&aacute;ch: 120g/ tu&yacute;p</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Cuốn tr&ocirc;i bụi bẩn như một cơn lốc xo&aacute;y, l&agrave;m sạch da tr&aacute;nh h&igrave;nh th&agrave;nh mụn do bụi bẩn. tạo điều kiện da hấp thụ c&aacute;c bước dưỡng da tốt hơn. T&iacute;nh năng n&agrave;y l&agrave; sự lựa chọn h&agrave;ng đầu của da nhờn.</p>

<p>✔️ Cung cấp độ ẩm, c&acirc;n bằng độ PH lại sau khi rửa mặt gi&uacute;p da mềm mịn căng mướt. Nếu bạn thuộc da kh&ocirc; th&igrave; ho&agrave;n to&agrave;n y&ecirc;n t&acirc;m đi nh&eacute;!</p>

<p>✔️ Tr&agrave; xanh c&oacute; c&ocirc;ng dụng dưỡng da trắng s&aacute;ng l&ecirc;n từng ng&agrave;y như một loại kem dưỡng da. Đ&acirc;y cũng l&agrave; tin vui cho l&agrave;n da sạm m&agrave;u, t&agrave;n nhang, n&aacute;m cũng c&oacute; thể cải thiện nhờ tinh chất tr&agrave; xanh.</p>

<p>✔️ Se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng hiệu quả.</p>

<p>✔️ Hỗ trợ t&iacute;ch cực cho da đang trong qu&aacute; tr&igrave;nh điều trị mụn, vi&ecirc;m nhiễm.</p>

<p>✔️ L&agrave;m giảm nếp nhăn, vết ch&acirc;n chim, cải thiện da l&atilde;o h&oacute;a.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>➖ Cho một lượng vừa đủ kem rửa mặt tr&agrave; xanh Shirochasou vừa đủ ra l&ograve;ng b&agrave;n tay.</p>

<p>➖ Cho &iacute;t nước v&agrave;o tạo bọt v&agrave; thoa đều l&ecirc;n mặt.</p>

<p>➖ Masegge nhẹ nh&agrave;ng từ trong ra ngo&agrave;i, từ tr&ecirc;n xuống dưới.</p>

<p>➖ Rửa lại mặt bằng nước sạch.</p>

<p>➖ Sử dụng h&agrave;ng ng&agrave;y để c&oacute; l&agrave;n da như mong muốn.</p>
', 1, 0, N'sua-rua-mat-tra-xanh-matcha-rohto-shirochasou', CAST(N'2021-08-17 11:00:36.567' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4068, N'SON BLACK ROUGE CREAM MATT ROUGE', N'Black Rouge', N'/Uploads/images/product/pro38.jpg', N'/Uploads/images/product/pro38.jpg', 0, N'Black Rouge Cream Matt Rouge được lấy cảm hứng từ những lá bài Tarot với thông điệp "Get your lucky - Get your Cream Matt Rouge" với những thỏi son như những chiếc bùa may mắn cho những bạn gái luôn tỏa sáng.', 2094, N'<p>Son đang HOT nhất hiện nay! 😍😍</p>

<p>BlackRouge Cream Matt Rouge</p>

<p>Mấy đợt trước em về được &iacute;t qu&aacute; trả kh&aacute;ch đặt c&ograve;n chưa đủ, nay em về nhiều rồi ạ kh&aacute;ch n&agrave;o cần ới em nha! 😘😘 #140k bảng m&agrave;u dưới cmt ạ!</p>

<p>&nbsp;</p>

<p>Bảng m&agrave;u:</p>

<p>&bull; CM01 Capella &ndash; Đỏ cam b&igrave;nh minh</p>

<p>&bull; CM02 Deneb &ndash; Cam đ&agrave;o ho&agrave;ng h&ocirc;n</p>

<p>&bull; CM03 Cassiopeia &ndash; Đỏ tươi &aacute;nh hồng rực rỡ</p>

<p>&bull; CM04 Orion &ndash; Cam san h&ocirc; &aacute;nh nude pha n&acirc;u</p>

<p>&bull; CM05 Delta &ndash; N&acirc;u đậm thuần</p>

<p>&bull; CM06 Spica &ndash; Đỏ đậm tone ấm</p>

<p>&bull; CM07 Polaris &ndash; Đỏ gạch tone lạnh</p>
', 1, 0, N'son-black-rouge-cream-matt-rouge', CAST(N'2021-08-17 11:05:34.893' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4069, N'Son Dưỡng Đổi Màu YNM Rainbow Honey Lip Balm', N'Ynm', N'/Uploads/images/product/pro39.jpg', N'/Uploads/images/product/pro39.jpg', 0, N'Son dưỡng có khả năng đổi màu tùy thuộc vào nhiệt độ da, điều kiện thời tiết và môi trường bên ngoài, sẽ có được những màu son lung linh giúp bạn thêm rạng rỡ và xinh xắn mỗi ngày ', 2107, N'<p>- Xuất xứ: H&Agrave;N QUỐC</p>

<p>- Thương hiệu:YNM</p>

<p>- Khối Lượng : 3.5G</p>

<p>&nbsp;</p>

<p>- Son Dưỡng Đổi M&agrave;u YNM Rainbow Honey Lip Balm si&ecirc;u &quot;HOT&quot; với kha chuyển đổi m&agrave;u son dưỡng YNM c&oacute; thể đổi m&agrave;u trong t&iacute;ch tắc nếu m&ocirc;i trương v&agrave; nhiệt độ sẽ biến h&oacute;a m&agrave;u son m&ocirc;i mới si&ecirc;u cưng lu&ocirc;n nh&eacute; .</p>

<p>- Thoa l&ecirc;n sau trước khi đ&aacute;nh son thỏi, c&oacute; t&aacute;c dụng như son b&oacute;ng, giữ m&ocirc;i mềm mại mịn m&agrave;ng kh&ocirc;ng vết nứt.</p>

<p>- Vừa l&agrave; mặt nạ ngủ gi&uacute;p m&ocirc;i được dưỡng mềm, hồi phục sau một đ&ecirc;m nghỉ ngơi.</p>

<p>- Gi&uacute;p bảo vệ m&ocirc;i khỏi bị kh&ocirc; do gi&oacute; v&agrave; thời tiết lạnh.</p>

<p>- B&ocirc;i l&ecirc;n m&ocirc;i bất cứ khi n&agrave;o bạn cảm thấy m&ocirc;i bị kh&ocirc;.</p>

<p>- Nếu l&agrave;m son l&oacute;t, b&ocirc;i l&ecirc;n m&ocirc;i trc khi đ&aacute;nh son m&agrave;u.</p>

<p>- Nếu l&agrave;m son b&oacute;ng, b&ocirc;i l&ecirc;n m&ocirc;i sau khi đ&aacute;nh son m&agrave;u.</p>

<p>- Với thiết kế v&ocirc; c&ugrave;ng sang chảnh rất ki&ecirc;u sa nhưng kh&ocirc;ng k&eacute;m phần lung linh bởi lớp nhũ cầu vồng bao bọc b&ecirc;n ngo&agrave;i. Th&acirc;n son h&igrave;nh trụ cầm rất chắc tay , thiết kế xinh xắn nh&igrave;n đ&atilde; thấy y&ecirc;u rồi nh&eacute;.</p>
', 1, 0, N'son-duong-doi-mau-ynm-rainbow-honey-lip-balm', CAST(N'2021-08-17 11:11:23.160' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4070, N'Dầu Gội Khô Batiste 200ml', N'Batiste', N'/Uploads/images/product/pro30.jpg', N'/Uploads/images/product/pro30.jpg', 0, N'Dầu Gội Khô Batiste Dry Shampoo 200ml có khả năng làm sạch tóc nhanh chóng, hấp thụ lượng dầu dư thừa giúp mái tóc trông sạch hơn, tạo hiệu ứng bồng bềnh, tơi và mềm mại, xịt một cái là khác biệt ngay. Tiện lợi cho những ngày du lịch, những phụ nữ/bà bầu trong thời kì kiêng cữ hay đơn giản là những ngày bận rộn không có thời gian chăm chút mái tóc nha.', 2114, N'<p>- Sẵn c&aacute;c vị:</p>

<p>Tropical</p>

<p>Blush</p>

<p>Fresh</p>

<p>Original</p>

<p>Cherry</p>

<p>&nbsp;</p>

<p>✖️ C&ocirc;ng dụng:</p>

<p>- Đặc điểm của dầu gội kh&ocirc; l&agrave; kh&ocirc;ng d&ugrave;ng nước, xịt trực tiếp l&ecirc;n t&oacute;c, n&oacute; h&uacute;t sạch mọi bụi bẩn v&agrave; dầu thừa tr&ecirc;n t&oacute;c, gi&uacute;p cho t&oacute;c kh&ocirc;, hết bết, hết dầu &amp; trở n&ecirc;n bồng bềnh đầy sức sống.</p>

<p>- Sản phẩm thật ti&ecirc;n lợi khi được sử dụng trong c&aacute;c trường hợp sau:</p>

<p>1. Bận rộn m&agrave; c&oacute; việc gấp phải đi m&agrave; chưa kịp gội đầu.</p>

<p>2. M&ugrave;a h&egrave; thời tiết n&oacute;ng nực, lại phải đội n&oacute;n bảo hiểm, t&oacute;c bệt hết lại.</p>

<p>3. M&ugrave;a đ&ocirc;ng lạnh lẽo lười gội đầu.</p>

<p>4. T&oacute;c dầu nhiều n&ecirc;n l&uacute;c n&agrave;o cũng b&ecirc;nh bết.</p>

<p>5. C&aacute;c b&agrave; mẹ sau khi sinh đang trong thời gian ki&ecirc;ng cữ</p>

<p>6. Bệnh nh&acirc;n nằm dưỡng bệnh.</p>

<p>7. Mang theo người khi đi chơi xa.</p>

<p>&nbsp;</p>

<p>✖️ Hướng dẫn sử dụng:</p>

<p>- D&ugrave;ng khi t&oacute;c c&oacute; dấu hiệu của bết d&iacute;nh hay b&oacute;ng dầu. Lắc đều sản phẩm trước khi d&ugrave;ng.</p>

<p>- Để c&aacute;ch m&aacute;i t&oacute;c khoảng 15-20cm sau đ&oacute; xịt l&ecirc;n t&oacute;c v&agrave; da đầu. Massage v&agrave; d&ugrave;ng lược tạo kiểu mong muốn.</p>

<p>- Lưu &yacute; tr&aacute;nh v&ugrave;ng mắt v&agrave; để ngo&agrave;i tầm tay trẻ em.</p>
', 1, 0, N'dau-goi-kho-batiste-200ml', CAST(N'2021-08-17 11:17:16.503' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4071, N'Bông tẩy trang LE SOIN LARETAT PUR Pháp - 500 miếng', N'Tetra Médical', N'/Uploads/images/product/pro40.jpg', N'/Uploads/images/product/pro40.jpg', 140000, N'Bông Tẩy Trang Tetra Le Soin Laretat Pur 500 miếng - sản phẩm được bán duy nhất đủ tiêu chuẩn trong các hiệu thuốc của Pháp, được cấu tạo từ 100% cotton, mềm mại và dễ chịu khi sử dụng, không hóa chất, không gây kích ứng da. Sản phẩm bông tẩy trang Tetra 500 miếng không chỉ có số lượng lớn mà còn có chất lượng tuyệt vời, an toàn, giúp chị em làm sạch mọi đồ trang điểm, làm đẹp trên da.', 2096, N'<p>- Quy c&aacute;ch: 500 miếng</p>

<p>- Thương hiệu: Tetra M&eacute;dical</p>

<p>- Sản xuất: Ph&aacute;p</p>

<p>&nbsp;</p>

<p>- Mặt b&ocirc;ng 100% cotton mềm mịn, ho&agrave;n to&agrave;n kh&ocirc;ng d&ugrave;ng ho&aacute; chất để tẩy trắng, b&ocirc;ng tương đối mỏng, thấm h&uacute;t tốt m&agrave; kh&ocirc;ng l&agrave;m phung ph&iacute; dưỡng chất, đặc biệt kh&ocirc;ng bở, xơ v&agrave; vụn khi sử dụng.</p>

<p>- Mỗi miếng b&ocirc;ng đều được chập 2 mặt vải v&agrave;o nhau, thấm h&uacute;t rất nhanh toner, lotion, điều n&agrave;y gi&uacute;p bạn tiết kiệm được mỹ phẩm khi sử dụng.</p>

<p>- Tetra M&eacute;dical l&agrave; h&atilde;ng lớn chuy&ecirc;n về sản xuất b&ocirc;ng dụng cụ y tế, v&igrave; thế sản phẩm b&ocirc;ng tẩy trang lần n&agrave;y an to&agrave;n tuyệt đối với da, kể cả da em b&eacute; sơ sinh nhạy cảm nhất.</p>

<p>- H&agrave;ng ng&agrave;y c&oacute; thể sử dụng Soin Pur để tẩy trang l&agrave;m sạch mặt, vệ sinh cơ thể cho trẻ nhỏ hay những bết thương hở tr&ecirc;n da cực kỳ đảm bảo.</p>

<p>&nbsp;</p>

<p>- Review:</p>

<p>+ Sản phẩm được đựng trong t&uacute;i gồm 500 miếng, mỗi miếng c&oacute; k&iacute;ch thước 5x5cm, v&igrave; thế kh&aacute; vừa vặn để sử dụng.</p>

<p>+ V&igrave; c&oacute; chất lượng b&ocirc;ng tốt n&ecirc;n sau khi d&ugrave;ng kh&ocirc;ng c&ograve;n hiện tượng sợ b&ocirc;ng b&aacute;m tr&ecirc;n da hay b&ocirc;ng bị bở khi gặp nước.</p>

<p>+ Đ&acirc;y l&agrave; ưu điểm lớn của d&ograve;ng b&ocirc;ng n&agrave;y so với c&aacute;c sản phẩm b&ocirc;ng vốn c&oacute; tr&ecirc;n thị trường. Một bịch b&ocirc;ng tẩy trang n&agrave;y bạn c&oacute; thể d&ugrave;ng thường xuy&ecirc;n từ 2- 3 th&aacute;ng kh&aacute; tiết kiệm chi ph&iacute;.</p>

<p>+ Sản phẩm đ&atilde; được kiểm nghiệm cũng như đ&aacute;nh gi&aacute; cao về độ l&agrave;nh t&iacute;nh, an to&agrave;n cho da, kh&ocirc;ng g&acirc;y ra bất kỳ t&aacute;c dụng phụ trong qu&aacute; tr&igrave;nh sử dụng.</p>
', 1, 0, N'bong-tay-trang-le-soin-laretat-pur-phap---500-mieng', CAST(N'2021-08-17 11:38:01.927' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4072, N'Dung Dịch Vệ Sinh Phụ Nữ Scion Feminine Wash', N'Khác', N'/Uploads/images/product/pro41.jpg', N'/Uploads/images/product/pro41.jpg', 150000, N'Dung dịch vệ sinh phụ nữ Scion Feminine Wash Nuskin là sự lựa chọn hàng đầu của các cô gái để chăm sóc cho “cô bé” hàng ngày. Sản phẩm không chứa xà phòng, làm sạch bằng tinh chất từ thiên nhiên vô cùng nhẹ dịu cho vùng da nhạy cảm,', 2099, N'<p>✔️ Với độ pH l&agrave; 3.5 gi&uacute;p bạn lu&ocirc;n cần bằng đượcc độ pH l&yacute; tưởng v&agrave; ngăn ngừa cũng như giảm thiểu c&aacute;c nguy cơ về c&aacute;c bệnh phụ khoa.</p>

<p>✔️ Giảm thiểu t&igrave;nh trạng ra kh&iacute; hư g&acirc;y bệnh.</p>

<p>✔️ Ngăn ngừa c&aacute;c nguy cơ nhiễm virus HPV &ndash; l&agrave; những mầm mống g&acirc;y ra ung thư cổ tử cung.</p>

<p>✔️ L&agrave;m sạch sẽ v&ugrave;ng k&iacute;n, hỗ trợ trị bệnh về vi&ecirc;m nhiễm phụ khoa, vi&ecirc;m lộ tuyến.</p>

<p>✔️ L&agrave;m hồng h&agrave;o v&agrave; khử m&ugrave;i v&ugrave;ng k&iacute;n, cũng như tạo cảm gi&aacute;c dễ chịu v&agrave; mềm mại cho bạn suốt cả ng&agrave;y.Đem lại sự quyến rũ, cũng sự tự tn v&ocirc;n c&oacute; của người phụ nữ.</p>
', 1, 0, N'dung-dich-ve-sinh-phu-nu-scion-feminine-wash', CAST(N'2021-08-17 15:06:39.990' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4073, N'SON MERZY THỎI', N'Merzy', N'/Uploads/images/product/pro42.jpg', N'/Uploads/images/product/pro42.jpg', 0, N' Son thỏi lì Merzy The First Lipstick là son thỏi thuộc thương hiệu Merzy với bảng màu toàn trendy mà cô nàng nào cũng nên sở hữu một cây, với bảng màu hút mắt khá tương đồng, cùng chất son vượt trội độ lên màu chuẩn, chất son mịn mướt không hề làm biến màu hay lộ vân môi. ', 2094, N'<p>🖤🖤SON MERZY THỎI🖤🖤</p>

<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>- Thương hiệu: Merzy</p>

<p>&nbsp;</p>

<p>✖️ BẢNG M&Agrave;U:</p>

<p>➡️ M&agrave;u L1 Excuse me &ndash; hồng đất, m&agrave;u cực dễ t&iacute;nh với mọi l&agrave;n da.</p>

<p>➡️ M&agrave;u L4 With me &ndash; đỏ truyền thống nhưng kh&ocirc;ng lỗi thời.</p>

<p>➡️ M&agrave;u L5 Kiss me &ndash; đỏ tươi gi&uacute;p bạn nổi bật.</p>

<p>➡️ M&agrave;u L6 Follow me &ndash; đỏ cam, sắc đỏ cam rực rỡ n&agrave;y rất th&iacute;ch hợp với những c&ocirc; bạn c&aacute; t&iacute;nh, sexy ch&uacute;ng m&igrave;nh.</p>

<p>➡️ M&agrave;u L9 Touch you &ndash; đỏ n&acirc;u, một gam m&agrave;u cực kỳ qu&yacute; ph&aacute;i v&agrave; quyến rũ</p>

<p>➡️ M&agrave;u L10 Kiss you &ndash; cam đ&agrave;o, sắc cam n&agrave;y ph&ugrave; hợp nhiều phong c&aacute;ch v&agrave; tr&ocirc;ng y&ecirc;u kiều hơn.</p>
', 1, 0, N'son-merzy-thoi', CAST(N'2021-08-17 15:11:10.403' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4074, N'Son Kem Lì Romand Milk Tea Velvet Tint', N'Romand', N'/Uploads/images/product/pro43.jpg', N'/Uploads/images/product/pro43.jpg', 0, N'Son kem lì Romand Milk Tea Velvet Tint là son kem lì của thương hiệu Romand có chất son xốp mịn, độ lên màu chuẩn, dễ tán đều trên môi cùng bảng màu ngọt ngào, mùi thơm dịu nhẹ tựa ly trà sữa hương socola ngọt ngào, êm dịu cho bạn đôi môi ngọt ngào, xinh xắn thu hút mọi ánh nhìn ', 2094, N'<p>&nbsp;</p>

<p>Xuất xứ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>- Bảng m&agrave;u:</p>

<p>01 Red Tea: M&agrave;u đỏ gạch</p>

<p>02 Chocolate Tea: M&agrave;u đỏ n&acirc;u</p>

<p>03 Cinnamon Tea: M&agrave;u đỏ hồng</p>

<p>04 Caramel Tea: M&agrave;u cam gạch</p>

<p>&nbsp;</p>

<p>- Chất son xốp đặc, kh&aacute; tương tự với chất son của d&ograve;ng Romand Zero Velvet Tint nhưng mịn v&agrave; dễ t&aacute;n hơn. Tuy nhi&ecirc;n cũng v&igrave; chất son đặc n&ecirc;n cọ son lấy lượng sản phẩm kh&aacute; nhiều. C&aacute;c n&agrave;ng cũng cần lưu &yacute; nếu t&aacute;n son qu&aacute; d&agrave;y sẽ xuất hiện hiện tượng bết lại ở l&ograve;ng m&ocirc;i v&agrave; lợn cợn nhẹ.</p>

<p>- C&oacute; chất son mịn v&agrave; mượt rất th&iacute;ch. Son c&oacute; m&ugrave;i hương tựa như ly tr&agrave; sữa hương s&ocirc;-c&ocirc;-la ngọt ng&agrave;o, kh&aacute; dễ chịu. Độ l&ecirc;n m&agrave;u của son phải n&oacute;i l&agrave; si&ecirc;u chuẩn, bất chấp nền m&ocirc;i. Son kh&ocirc;ng l&agrave;m lộ v&acirc;n m&ocirc;i, kh&ocirc;ng l&agrave;m kh&ocirc; m&ocirc;i. Độ b&aacute;m m&agrave;u chỉ tầm 3-5 tiếng. Khi tr&ocirc;i kh&ocirc;ng để lại lớp stein n&agrave;o.</p>
', 1, 0, N'son-kem-li-romand-milk-tea-velvet-tint', CAST(N'2021-08-17 15:14:13.703' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4075, N'Kem chống nắng Anesa', N'Khác', N'/Uploads/images/product/pro44.jpg', N'/Uploads/images/product/pro44.jpg', 0, N'Kem chống nắng Anesa là một trong những sản phẩm chống nắng được yêu thích hàng đầu tại Nhật Bản đến từ thương hiệu Anessa. Với bộ ba công nghệ độc quyền từ Shiseido, Anessa Perfect UV Sunscreen Skincare Milk cung cấp khả năng chống nắng vượt trội nhiều giờ liền, bảo vệ da tối ưu khỏi tác hại từ tia UV.', 2101, N'<p>Nơi sản xuất: Nhật Bản</p>

<p>&nbsp;</p>

<h2><span style="font-size:14px">C&ocirc;ng dụng chống nắng&nbsp;anessa</span></h2>

<p>- Chỉ số chống nắng rất cao (SPF 50+++) gi&uacute;p chống lại những tia UV l&agrave;m ảnh hưởng đến l&agrave;n da của bạn.</p>

<p>- Hiệu quả k&eacute;o d&agrave;i nhiều giờ sau khi thoa với c&ocirc;ng thức kh&ocirc;ng thấm nước (th&iacute;ch hợp khi đi bơi).</p>

<p>-&nbsp;<em><strong>Kem chống nắng anessa </strong></em>L&agrave;m &ecirc;m dịu da, chống lại sự g&acirc;y hại từ c&aacute;c t&aacute;c nh&acirc;n b&ecirc;n ngo&agrave;i.</p>

<p>- Gi&uacute;p da mềm mại, mượt m&agrave; với hương thơm nhẹ nh&agrave;ng.</p>

<p>- L&yacute; tưởng khi sử dụng l&agrave;m lớp l&oacute;t khi trang điểm.</p>

<p>- Sunsreen: hấp thụ tia tốt, tr&aacute;nh hao hụt vitamin D</p>

<p>- Dạng sữa n&ecirc;n kh&ocirc;ng hề b&oacute;ng nhờn,&nbsp;<em><strong>kem chống nắng anessa</strong></em>&nbsp;kh&ocirc; ngay tại chỗ (dạng sữa thường kh&ocirc; nhanh v&agrave; &iacute;t b&oacute;ng nhờn hơn dạng kem)</p>

<p>&nbsp;</p>

<p><strong>Hướng dẫn sử dụng</strong></p>

<ul>
	<li>Lắc đều trước khi sử dụng.</li>
	<li>D&ugrave;ng sau bước dưỡng da, thoa đều khắp v&ugrave;ng da cần bảo vệ.</li>
	<li>Để đạt hiệu quả cao nhất, n&ecirc;n thoa lại sau khi tiếp x&uacute;c nhiều với nước hoặc lau bằng khăn.</li>
	<li>Dễ d&agrave;ng l&agrave;m sạch với sữa rửa mặt.</li>
</ul>
', 1, 0, N'kem-chong-nang-anesa', CAST(N'2021-08-17 15:28:49.510' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4076, N'Kem Tẩy lông velvet Nga', N'Khác', N'/Uploads/images/product/pro46.jpg', N'/Uploads/images/product/pro46.jpg', 60000, N'Kem tẩy lông Velvet NgaNhờ công thức tiên tiến và kết cấu mềm cho phép bạn loại bỏ lông không mong muốn nhẹ nhàng an toàn hơn so với trước đây. Đồng thời làm dịu da trong thời gian tẩy lông.', 2099, N'<p>🖤🖤Kem Tẩy l&ocirc;ng velvet Nga🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 60K</p>

<p>✖️ Xuất xứ : Nga</p>

<p>✖️ Thương hiệu : Velvet</p>

<p>&nbsp;</p>

<p>✖️ ƯU ĐIỂM:</p>

<p>✔️ Kem Tẩy l&ocirc;ng velvet Nga đang được người d&ugrave;ng si&ecirc;u y&ecirc;u th&iacute;ch bởi t&iacute;nh năng dễ sử dụng v&agrave; gi&aacute; th&agrave;nh th&igrave; phải n&oacute;i l&agrave; si&ecirc;u vừa t&uacute;i nh&eacute; .</p>

<p>✔️ Kem t&acirc;̉y l&ocirc;ng Velvet được chiết xuất từ c&aacute;c loại hoa đồng nội gi&uacute;p nu&ocirc;i dưỡng, l&agrave;m mềm da, bảo vệ da kh&ocirc;ng bị k&iacute;ch ứng. Kem cũng c&oacute; t&aacute;c dụng l&agrave;m chậm qu&aacute; tr&igrave;nh mọc l&ocirc;ng mới tại những vị tr&iacute; đ&atilde; tẩy, giúp se khít l&ocirc;̃ ch&acirc;n l&ocirc;ng và làm sáng da.</p>

<p>✔️ Ch&uacute;ng ta h&atilde;y t&igrave;m hiểu th&ecirc;m về d&ograve;ng sản phẩm velvet tẩy l&ocirc;ng của nga n&agrave;y nh&eacute;!!</p>

<p>✔️ Kem Tẩy l&ocirc;ng velvet Nga thuộc d&ograve;ng chăm s&oacute;c da cao cấp đến từ Nga. Với chiết xuất từ tự nhi&ecirc;n kem tẩy l&ocirc;ng Velvet gi&uacute;p bạn nhẹ nh&agrave;ng l&agrave;m sạch v&ugrave;ng l&ocirc;ng kh&ocirc;ng mong muốn trong t&iacute;ch tắc, kh&ocirc;ng g&acirc;y đau đớn.</p>

<p>✔️ C&aacute;c tinh thể dưỡng da nhanh ch&oacute;ng len s&acirc;u v&agrave;o c&aacute;c tế b&agrave;o phục hồi v&agrave; nu&ocirc;i dưỡng da từ s&acirc;u b&ecirc;n trong, nhờ vậy m&agrave; c&aacute;c lỗ ch&acirc;n l&ocirc;ng lu&ocirc;n được se kh&iacute;t, l&agrave;n da của bạn trở n&ecirc;n mềm mịn v&agrave; s&aacute;ng mịn hơn.</p>

<p>&nbsp;</p>

<p>✖️ C&Aacute;CH SỬ DỤNG:</p>

<p>➖ Lấy một lượng kem vừa đủ ra th&igrave;a v&agrave; b&ocirc;i đều l&ecirc;n da.</p>

<p>➖ B&ocirc;i kem l&ecirc;n da bằng dao gạt để tẩy l&ocirc;ng v&agrave; để từ 10-15&rsquo; sau đ&oacute; l&agrave;m sạch bằng c&aacute;ch lấy đi kem đ&atilde; bội tr&ecirc;n da. Nếu như bạn chưa h&agrave;i l&ograve;ng với lượng l&ocirc;ng đ&atilde; tẩy,c&oacute; thể để số kem c&ograve;n s&oacute;t lại th&ecirc;m v&agrave;i ph&uacute;t nữa ( thời gian tối đa l&agrave; 20&rsquo;).</p>
', 1, 0, N'kem-tay-long-velvet-nga', CAST(N'2021-08-17 15:35:01.480' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4077, N'Son Kem Black Rouge Air Fit Velvet Tint Ver 3', N'Black Rouge', N'/Uploads/images/product/pro45.jpg', N'/Uploads/images/product/pro45.jpg', 0, N'Black Rouge tiếp tục làm nức lòng phái đẹp khi tung ra thị trường phiên bảng mới của dòng Air Fit Velvet Tint với tên gọi Son Kem Lì Black Rouge Air Fit Velvet Tint Version 3.', 2094, N'<p>✖️ Bảng m&agrave;u:</p>

<p>#A13 Juicy Apricot: cam đỏ</p>

<p>#A14 Peachy Red: đỏ đ&agrave;o trầm</p>

<p>#A15 Sunny Jujube: n&acirc;u &aacute;nh đỏ</p>

<p>#A16 Dried Cherry: t&iacute;m &aacute;nh đỏ</p>

<p>#A17 Bolivian Pomegranate: đỏ lạnh</p>
', 1, 0, N'son-kem-black-rouge-air-fit-velvet-tint-ver-3', CAST(N'2021-08-17 15:38:56.110' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4078, N'Tinh chất serum AHC Capture Solution Max Ampoule 50ml', N'Ahc', N'/Uploads/images/product/pro47.jpg', N'/Uploads/images/product/pro47.jpg', 0, N'Tinh chất serum AHC Capture Solution Max Ampoule của Hàn Quốc có 3 dòng, dưỡng ẩm, dưỡng trắng và chong lão hóa tái tạo da. Nếu bạn đang muốn chọn serum dưỡng chất lượng cao cấp, an toàn mà giá phải chăng thì AHC là lý tưởng nhất.', 2103, N'<p>Xuất Xứ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>1. Xanh l&aacute; (CALMING)</p>

<p>- L&agrave;m dịu da, giảm k&iacute;ch ứng, gi&uacute;p da khoẻ mạnh với c&ocirc;ng thức chứa keo ong</p>

<p>- Hỗ trợ phục hồi da tổn thương, sau điều trị</p>

<p>&nbsp;</p>

<p>2. Hồng (GLOW)</p>

<p>- Chỉ cần 1 từ &quot;Glow&quot; cũng n&oacute;i l&ecirc;n c&ocirc;ng dụng rồi phải kh&ocirc;ng ạ. V&acirc;ng ch&iacute;nh l&agrave; căng b&oacute;ng&nbsp;l&agrave;n da m&agrave; chị em n&agrave;o cũng mơ ước.</p>

<p>- Serum c&ograve;n gi&uacute;p da s&aacute;ng da nhờ c&ocirc;ng thức chứa glutathinone, cải thiện nếp nhăn</p>

<p>&nbsp;</p>

<p>3. T&iacute;m (FIRMING)</p>

<p>- L&agrave;m săn chắc da</p>

<p>- Chống chảy xệ, nếp nhăn</p>

<p>- Chứa th&agrave;nh phần Peptide - 1 th&agrave;nh phần quan trọng trong c&ocirc;ng cuộc chống l&atilde;o ho&aacute; cho da</p>
', 1, 0, N'tinh-chat-serum-ahc-capture-solution-max-ampoule-50ml', CAST(N'2021-08-17 15:43:23.197' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4079, N'Bút kẻ mắt dạ Merzy Another Me The First Pen Eyeliner', N'Merzy', N'/Uploads/images/product/pro48.jpg', N'/Uploads/images/product/pro48.jpg', 0, N'Bút kẻ mắt nước Merzy Another Me The First Pen Eyeliner là kẻ mắt nước của thương hiệu Merzy với đầu bút mềm mại giúp kẻ đường line một cách dễ dàng tạo đôi mắt sắc sảo với đường nét tinh tế lôi cuốn mọi ánh nhìn ', 2104, N'<p>- B&uacute;t kẻ mắt nước Merzy chống tr&ocirc;i l&agrave; sản phẩm trang điểm chất lượng xuất xứ từ H&agrave;n Quốc. Với thiết kế dạng b&uacute;t thanh lịch đẹp mắt, chất mực đều b&oacute;ng sang chảnh v&agrave; đầu cọ mềm mại kh&ocirc;ng g&acirc;y k&iacute;ch ứng cho v&ugrave;ng mắt, kẻ mắt Merzy gi&uacute;p bạn dễ d&agrave;ng tạo đường kẻ mắt sắc n&eacute;t ho&agrave;n hảo.</p>

<p>- B&uacute;t kẻ mắt Merzy với ti&ecirc;u ch&iacute; 3 kh&ocirc;ng: kh&ocirc;ng lem, kh&ocirc;ng tr&ocirc;i, kh&ocirc;ng thấm nước v&agrave; bền m&agrave;u đến 24h cho bạn đ&ocirc;i mắt đẹp suốt cả ng&agrave;y. Chất mực đẹp, mực ra đều, tạo độ b&oacute;ng nhẹ nh&igrave;n cực sang.</p>

<p>- Sử dụng b&uacute;t kẻ mắt Merzy để c&oacute; đường kẻ mắt ho&agrave;n hảo nhất.</p>

<p>- Kh&ocirc;ng c&oacute; th&agrave;nh phần dị ứng</p>
', 1, 0, N'but-ke-mat-da-merzy-another-me-the-first-pen-eyeliner', CAST(N'2021-08-17 15:46:20.647' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4080, N'Bộ cọ Fix 13 cây', N'Oem', N'/Uploads/images/product/pro49.jpg', N'/Uploads/images/product/pro49.jpg', 0, N'Makeup là nhu cầu cũng như là bước không thể thiếu trước khi ra đường của hội chị em hiện nay. Cọ makeup luôn là vật dụng cần thiết để hỗ trợ tối đa cho các chị em trong quá trình trang điểm. Tùy theo nhu cầu mà bạn có thể lựa chọn cho mình bộ cọ trang điểm phù hợp. ', 2096, N'<p>Bộ cọ gồm c&aacute;c cọ cơ bản: 1 cọ nền, 1 cọ t&aacute;n phấn, 1 cọ che khuyết điểm, 1 cọ tạo khối, 1 cọ mắt, 1 cọ m&iacute; mắt, 1 cọ son , 1 cọ l&ocirc;ng m&agrave;y, 1 cọ hightlight, 1 cọ phấn mắt, 1 cọ bầu mắt, 1 cọ chuốt, 1 cọ chải l&ocirc;ng m&agrave;y</p>
', 1, 0, N'bo-co-fix-13-cay', CAST(N'2021-08-17 15:49:58.630' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4081, N'MẶT NẠ NÉN MINISO NHẬT BẢN', N'Miniso', N'/Uploads/images/product/pro27.jpg', N'/Uploads/images/product/pro27.jpg', 65000, N'Mặt nạ Miniso với thành phần được chiếc xuất từ lá tre cùng các dưỡng chất chăm sóc làn da kết hợp với giấy nên giúp các dưỡng chất lan tỏa đều và được giữ chặt trên da. Làm các tinh chất dưỡng da thấm thấu tốt hơn mà không bị thất thoát nên mang lại hiệu quả tốt hơn các sản phẩm dưỡng da thoa trực tiếp lên da.', 2112, N'<p>🖤🖤MẶT NẠ N&Eacute;N MINISO NHẬT BẢN🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 65K/ g&oacute;i</p>

<p>&nbsp;</p>

<p>✖️ ƯU ĐIỂM:</p>

<p>✔️ Gi&aacute; cả th&igrave; v&ocirc; c&ugrave;ng phải chăng.</p>

<p>✔️Nhỏ gọn, xinh xinh v&ocirc; c&ugrave;ng tiện lợi. Dễ d&agrave;ng đem theo mọi l&uacute;c mọi nơi.</p>

<p>✔️ C&oacute; thể kết hợp c&ugrave;ng với sữa tươi, sữa chua, c&aacute;c loại nước hoa hồng&hellip;gi&uacute;p da hấp thu được tối đa dưỡng chất.</p>

<p>✔️ Cung cấp độ ẩm tuyệt vời.</p>

<p>✔️ Gi&uacute;p da căng tr&agrave;n nhiều sức sống.</p>

<p>✔️ C&acirc;n bằng lại độ PH cho da.</p>

<p>✔️ L&agrave;m dịu, l&agrave;m m&aacute;t da.</p>

<p>✔️ Đặc biệt l&agrave;nh t&iacute;nh với tất cả c&aacute;c loại da.</p>

<p>&nbsp;</p>

<p>✖️ C&Aacute;CH SỬ DỤNG:</p>

<p>➖ Chỉ cần cho Mặt nạ giấy n&eacute;n Miniso v&agrave;o nước hoặc lotion, toner,nước &eacute;p hoa quả, sữa tươi&hellip; trong gi&acirc;y l&aacute;t vi&ecirc;n mặt nạ nở ra l&agrave; d&ugrave;ng được ngay.</p>

<p>➖ Sau 2-3 ph&uacute;t, bạn t&aacute;ch mặt nạ ra th&agrave;nh miếng rồi đắp l&ecirc;n mặt 15-20 th&igrave; gỡ xuống.</p>

<p>➖ Vi&ecirc;n n&eacute;n mặt nạ đ&atilde; c&oacute; sẵn tinh chất dưỡng ẩm, nếu muốn th&ecirc;m dưỡng chất th&igrave; thả v&agrave;o nước hoa quả sẽ th&agrave;nh mặt nạ hoa quả, c&oacute; thể cho v&agrave;o sữa tươi ra v&agrave; đắp h&agrave;ng ng&agrave;y.</p>

<p>➖ Nếu bạn d&ugrave;ng dưỡng chất l&agrave; nước hoa hồng, serum th&igrave; kh&ocirc;ng cần rửa mặt lại với nước. C&ograve;n nếu d&ugrave;ng dưỡng chất l&agrave; nước tr&aacute;i c&acirc;y, sữa tươi&hellip; th&igrave; d&ugrave;ng nước ấm rửa mặt lại cho sạch nha.</p>
', 1, 0, N'mat-na-nen-miniso-nhat-ban', CAST(N'2021-08-17 15:52:32.683' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4082, N'Son dưỡng môi OMI 4g', N'Khác', N'/Uploads/images/product/pro50.jpg', N'/Uploads/images/product/pro50.jpg', 50000, N'Sản phẩm Son Dưỡng Môi OMI Brotherhood Menturm Medicated Lip Balm Stick giúp dưỡng ẩm cho môi, tạo hàng rào bảo vệ môi luôn mềm mại và hạn chế các tác nhân gây khô môi do tác động của thời tiết và son môi. Với tinh dầu bạc hà được bổ sung vào thành phần tạo cảm giác mát lạnh, vô cùng thư giãn khi sử dụng. ', 2107, N'<p>🖤🖤Son dưỡng m&ocirc;i OMI🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 50K</p>

<p>✖️ Xuất xứ: Nhật Bản</p>

<p>✖️ H&atilde;ng sản xuất: Omi</p>

<p>✖️ TRỌNG LƯỢNG: 4g</p>

<p>&nbsp;</p>

<p>✖️ ƯU ĐIỂM:</p>

<p>✔️ Kh&ocirc;ng chứa ch&igrave;, rất l&agrave;nh t&iacute;nh, an to&agrave;n cho da nhạy cảm</p>

<p>✔️ Kh&ocirc;ng m&agrave;u, kh&ocirc;ng m&ugrave;i, kh&ocirc;ng bết d&iacute;nh như c&aacute;c loại son dưỡng kh&aacute;c</p>

<p>✔️ C&oacute; chứa chất chống nắng c&oacute; chỉ số SPF 18+, PA +</p>

<p>✔️ Thiết kế dạng thanh s&aacute;p nhỏ gọn, m&agrave;u xanh với vị bạc h&agrave; m&aacute;t mẻ</p>

<p>✔️ Nam/ nữ đều d&ugrave;ng được</p>

<p>✔️ S&aacute;p son kh&ocirc;ng bị chảy trong thời tiết nắng n&oacute;ng</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Gi&uacute;p ngăn ngừa kh&ocirc; m&ocirc;i, chống nứt nẻ m&ocirc;i</p>

<p>✔️ Cung cấp độ ẩm, v&agrave; dưỡng chất cho l&agrave;n m&ocirc;i mềm mại trong nhiều giờ.</p>

<p>✔️ Gi&uacute;p đ&ocirc;i m&ocirc;i mềm mại v&agrave; hồng h&agrave;o 1 c&aacute;ch tự nhi&ecirc;n</p>

<p>✔️ Dạng s&aacute;p n&ecirc;n đ&ocirc;̣ bám dính cao và &acirc;̉m mượt, mùi bạc hà the mát.</p>

<p>✔️ Chống th&acirc;m m&ocirc;i nếu d&ugrave;ng hằng ng&agrave;y</p>

<p>&nbsp;</p>

<p>✖️ C&Aacute;CH SỬ DỤNG:</p>

<p>➖ Ban đầu khi sử dụng sẽ th&acirc;́y kh&ocirc;ng bám dính lắm v&igrave; son c&oacute; dạng s&aacute;p cứng, nhưng sau 1,2 lần thoa, nhi&ecirc;̣t đ&ocirc;̣ m&ocirc;i gi&uacute;p son m&ecirc;̀m ra, bám chắc vào m&ocirc;i, tạo m&ocirc;̣t lớp bảo v&ecirc;̣ &acirc;̉m mịn, m&ecirc;̀m mượt</p>

<p>➖ Xoay thỏi son để son trồi l&ecirc;n</p>

<p>➖ Thoa son l&ecirc;n m&ocirc;i từ 3 &ndash; 4 lần để phủ hết v&ugrave;ng m&ocirc;i</p>

<p>➖ Tập th&oacute;i quen thoa đều m&ocirc;i ng&agrave;y 2 lượt, mỗi lượt 3-4 lần</p>
', 1, 0, N'son-duong-moi-omi-4g', CAST(N'2021-08-17 15:55:47.267' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4083, N'Chải Mi Missha Dày Mi The Style 4D Mascara', N'Missha', N'/Uploads/images/product/pro51.jpg', N'/Uploads/images/product/pro51.jpg', 65000, N'Mascara The Style 4D Missha xuất xứ Hàn Quốc có dung tích 6g, với thành phần chủ yếu là Botanical wax giúp bạn dễ dàng có hàng mi cong, đầy quyến rũ mà không hề có cảm giác cộm, bết dính hay vón cục.  Đồng thời, cung cấp các dưỡng chất giúp bảo vệ làn mi của bạn luôn khỏe mạnh.', 2104, N'<p>✔️ Mascara The Style 4D Missha xuất xứ H&agrave;n Quốc c&oacute; dung t&iacute;ch 6g, với th&agrave;nh phần chủ yếu l&agrave; Botanical wax gi&uacute;p bạn dễ d&agrave;ng c&oacute; h&agrave;ng mi cong, đầy quyến rũ m&agrave; kh&ocirc;ng hề c&oacute; cảm gi&aacute;c cộm, bết d&iacute;nh hay v&oacute;n cục. Đồng thời, cung cấp c&aacute;c dưỡng chất gi&uacute;p bảo vệ l&agrave;n mi của bạn lu&ocirc;n khỏe mạnh.</p>

<p>✔️ Một điểm đặc biệt ở Mascara The Style 4D Missha l&agrave; c&acirc;y chải mi được thiết kế rất đặc biệt v&agrave; tinh tế với c&aacute;c sợi cọ đều gi&uacute;p c&aacute;c bạn nữ dễ d&agrave;ng trong việc tạo cho m&igrave;nh một l&agrave;n mi mỏng, đều v&agrave; đầy ấn tượng. Ngo&agrave;i ra, thiết kế nhỏ gọn kết hợp với m&agrave;u đen chủ đạo mang đến cho bạn sự sang trọng v&agrave; v&ocirc; c&ugrave;ng tiện dụng khi sử dụng v&agrave; mang theo sản phẩm</p>

<p>✔️ Về độ bền của sản phẩm th&igrave; c&aacute;c bạn c&oacute; thể y&ecirc;n t&acirc;m nh&eacute;. Chải Mi Missha c&oacute; khả năng chống tr&ocirc;i rất tốt, c&oacute; thể giữ cho l&agrave;n mi của bạn lu&ocirc;n cong, đẹp v&agrave; đầy quyến rũ trong v&ograve;ng từ 8-9 giờ ngay cả khi gặp trời mưa, mồ h&ocirc;i hoặc kh&oacute;i bụi n&ecirc;n bạn c&oacute; thể thoải m&aacute;i vui chơi m&agrave; kh&ocirc;ng cần lo lắng nữa nh&eacute;.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>- Lăn Chải mi The Style 4D Missha giữa 2 l&ograve;ng b&agrave;n tay để l&agrave;m ấm mascara để mascara &iacute;t bị v&oacute;n cục khi sử dụng.</p>

<p>- Chải cọ theo đường ziczac từ ch&acirc;n mi đến ngọn mi. C&oacute; thể lặp lại để c&oacute; hiệu quả mong muốn.</p>

<p>- D&ugrave;ng hai ng&oacute;n trỏ v&agrave; c&aacute;i cọ v&agrave;i với nhau cho n&oacute;ng sau đ&oacute; giữ v&agrave;o mi 5 gi&acirc;y fiusp cho l&ocirc;ng mi cong hơn.</p>

<p>&nbsp;</p>

<p>✖️ Tips:</p>

<p>- Để mascara lu&ocirc;n mịn v&agrave; &iacute;t bị v&oacute;n cục, trước khi sử dụng c&aacute;c n&agrave;ng n&ecirc;n d&ugrave;ng 2 l&ograve;ng b&agrave;n tay lăn đi lăn lại sản phẩm để l&agrave;m ấm nh&eacute;.</p>

<p>- Trước khi d&ugrave;ng mascara bạn n&ecirc;n d&ugrave;ng kẹp mi để cố định h&igrave;nh d&aacute;ng l&ocirc;ng mi gi&uacute;p cho việc chải được dễ d&agrave;ng hơn.</p>
', 1, 0, N'chai-mi-missha-day-mi-the-style-4d-mascara', CAST(N'2021-08-17 15:59:15.117' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4084, N'KEM NỀN CHO DA DẦU, MÀU TỰ NHIÊN TIỆP MÀU DA FIT ME', N'Maybelline New York', N'/Uploads/images/product/pro52.jpg', N'/Uploads/images/product/pro52.jpg', 0, N'Kem nền Fit Me  được thiết kế cho mọi tone da với chất kem nhẹ nhàng và chứa các thành phần dưỡng da. Sản phẩm sẽ đem đến cho bạn làn da mịn màng, tự nhiên suốt ngày ngày dài. ', 2095, N'<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>- Kem nền với c&ocirc;ng nghệ &quot;Micro Powders hạt phấn si&ecirc;u nhỏ&quot; kh&ocirc;ng dầu, kh&ocirc;ng hương liệu độc quyền cho hiệu ứng mịn l&igrave; tự nhi&ecirc;n, tiệp m&agrave;u da.</p>

<p>- Độ che phủ cao gi&uacute;p kiềm dầu v&agrave; thu nhỏ lỗ ch&acirc;n l&ocirc;ng. Lựa chọn l&yacute; tưởng cho l&agrave;n da dầu v&agrave; c&oacute; mụn.</p>

<p>- Sp c&oacute; nhiều tone m&agrave;u ph&ugrave; hợp mọi t&ocirc;ng da của phụ nữ Việt Nam.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>✖️ C&Aacute;CH SỬ DỤNG</p>

<p>- Chấm đều 5 điểm tr&ecirc;n mặt (v&ugrave;ng tr&aacute;n, mũi, cằm v&agrave; 2 m&aacute;). T&aacute;n đều lượng kem theo hướng từ trong ra ngo&agrave;i.</p>

<p>- Sử dụng kết hợp c&ugrave;ng kem che khuyết điểm v&agrave; phấn phủ FIT ME để c&oacute; hiệu ứng tốt nhất.</p>
', 1, 0, N'kem-nen-cho-da-dau-mau-tu-nhien-tiep-mau-da-fit-me', CAST(N'2021-08-17 16:07:54.550' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4085, N'KEM DƯỠNG DA DEXERYL CHỮA NẺ - CHẢM CHO BÉ', N'Dexeryl', N'/Uploads/images/product/pro53.jpg', N'/Uploads/images/product/pro53.jpg', 140000, N'Kem dưỡng da Dexeryl xuất xứ Pháp là cái tên quá nổi tiếng bởi khả năng dưỡng ẩm và chữa trị hiệu quả một số bệnh về da phổ biến như nẻ, chàm, bong tróc,...Đặc biệt, Dexeryl chữa trị bệnh Eczema cực hiệu quả. Những bé bị Eczema bôi vài lần đỡ ngay.', 2115, N'<p>- XUẤT XỨ: Ph&aacute;p</p>

<p>- DUNG T&Iacute;CH: 250g</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Kem dưỡng da, trị nẻ v&agrave; ch&agrave;m da Dexeryl tuyệt đối an to&agrave;n cho b&eacute; từ sơ sinh, kh&ocirc;ng k&iacute;ch ứng da, kể cả những b&eacute; c&oacute; l&agrave;n da nhạy cảm</p>

<p>✔️ Kem dưỡng da Dexeryl v&ocirc; c&ugrave;ng dịu nhẹ cho l&agrave;n da của em b&eacute;, đặc biệt trị bệnh Eczema một c&aacute;ch hiệu quả đến kh&oacute; tin.</p>

<p>✔️ Kem dưỡng da Dexeryl gi&uacute;p da b&eacute; lu&ocirc;n mịn m&agrave;ng, kh&ocirc;ng th&ocirc; r&aacute;p, kh&ocirc;ng nứt nẻ trong m&ugrave;a hanh kh&ocirc;, m&ugrave;a đ&ocirc;ng.</p>

<p>✔️ Kem c&ograve;n đặc biệt tốt cho c&aacute;c b&eacute; bị ch&agrave;m cơ địa, da kh&ocirc; nứt nẻ &amp; đặc biệt những b&eacute; bị eczema cả mặt, người, tay ch&acirc;n b&ocirc;i đỡ ngay.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>- Chỉ n&ecirc;n b&ocirc;i một lớp kem thật mỏng v&agrave;o ban ng&agrave;y để tr&aacute;nh hiện tượng nhờn da. B&ocirc;i kem v&agrave;o ban đ&ecirc;m sẽ gi&uacute;p kem thẩm thấu v&agrave;o da tốt hơn.</p>

<p>- Kem c&oacute; t&aacute;c dụng hiệu quả kể cả những b&eacute; đ&atilde; bị loang đỏ, hồng, sần s&ugrave;i khắp mặt. Khỏi sau 3-7 ng&agrave;y b&ocirc;i li&ecirc;n tục. B&ocirc;i 2-3 lần h&agrave;ng ng&agrave;y.</p>

<p>- Để b&eacute; khỏi nhanh hơn, c&aacute;c mẹ c&oacute; thể lấy nước ch&egrave; tươi đặc, lấy b&ocirc;ng g&ograve;n b&ocirc;i khắp mặt b&eacute;, chờ tự kh&ocirc;, kh&ocirc;ng rửa lại bằng nước lạnh, rồi mới b&ocirc;i kem th&igrave; hiệu quả &amp; thời gian khỏi được r&uacute;t ngắn xuống.</p>
', 1, 0, N'kem-duong-da-dexeryl-chua-ne---cham-cho-be', CAST(N'2021-08-17 16:18:56.960' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4086, N'Mask lột mụn đầu đen T.F.S', N'Khác', N'/Uploads/images/product/pro54.jpg', N'/Uploads/images/product/pro54.jpg', 90000, N'Mụn đầu đen là vấn đề nan giải của các bạn trẻ hiện nay, những chấm mụn đen li ti khiến ta mất tự tin khi ra đường. Mặt nạ lột mụn đầu đen Jeju Volcanic Lava Peel-Off Clay Nose Mack của The Face Shop sẽ giúp bạn giải quyết vấn đề đó ngay.', 2107, N'<h3><strong>Th&agrave;nh phần sản phẩm:</strong></h3>

<p>Sản phẩm<strong>&nbsp;</strong>c&ograve;n chứa chiết xuất từ Tre Jeju, phức hợp th&ecirc;m Akebia, hạt tr&agrave; xanh, tinh chất&nbsp;qu&yacute;t, thanh y&ecirc;n v&agrave; xương rồng chứa nhiều chất dinh dưỡng dưỡng ẩm&nbsp;da, gi&uacute;p da s&aacute;ng mịn.</p>

<p>&nbsp;</p>

<h3><strong>C&ocirc;ng dụng sản phẩm:</strong></h3>

<p><strong>The Face Shop Jeju Volcanic Lava Peel-Off Clay Nose Mask&nbsp;</strong>gi&uacute;p&nbsp;h&uacute;t sạch mụn c&aacute;m, b&atilde; nhờn v&agrave; bụi bẩn, gi&uacute;p lỗ ch&acirc;n l&ocirc;ng th&ocirc;ng tho&aacute;ng, mịn m&agrave;ng.</p>

<p>C&ocirc;ng thức mới nhanh kh&ocirc;, dễ d&agrave;ng lột khỏi da m&agrave; ko khiến da bị r&aacute;t đỏ hay tổn thương. Sản phẩm cực tốt cho c&aacute;c bạn bị mụn đầu đen, mụn c&aacute;m ở v&ugrave;ng mũi.&nbsp;</p>

<p>Sản phẩm c&oacute; th&agrave;nh phần chiết xuất từ đất s&eacute;t n&uacute;i lửa Jeju gi&uacute;p hấp thụ b&atilde; nhờn, l&agrave;m sạch v&agrave; thu nhỏ lỗ ch&acirc;n l&ocirc;ng v&ugrave;ng da mũi, ngăn ngừa mụn mọc trở lại.&nbsp;</p>

<p>Mặt nạ&nbsp;gi&uacute;p kiểm so&aacute;t nhờn v&agrave; giảm thiểu nh&acirc;n mụn h&igrave;nh th&agrave;nh, đặc biệt l&agrave; mụn đầu đen.</p>

<p>&nbsp;</p>

<h3><strong>Hướng dẫn sử dụng:&nbsp;</strong></h3>

<p>Bạn cho ra tay một lượng vừa đủ</p>

<p>Sau đ&oacute; thoa đều l&ecirc;n mũi,ở những v&ugrave;ng c&oacute; mụn đầu đen.</p>

<p>Để kh&ocirc; rồi b&oacute;c sau 10-15 ph&uacute;t.</p>
', 1, 0, N'mask-lot-mun-dau-den-tfs', CAST(N'2021-08-17 16:23:57.087' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4087, N'Phấn nén Eglips', N'Eglips', N'/Uploads/images/product/pro55.jpg', N'/Uploads/images/product/pro55.jpg', 0, N'Phấn phủ Eglips xuất xứ từ Hàn Quốc có 3 dòng sản phẩm nhỏ bao gồm Oil Cut Powder Pact, Glow Powder Pact và Blur Powder Pact với các công dụng nổi bật khác biệt. Oil Cut Powder Pact hộp trắng có khả năng kiềm dầu ổn định, Glow Powder Pact vỏ hộp hồng giúp khuôn mặt sáng bừng, căng bóng và dòng Blur Powder Pact hộp đen có khả năng hiệu chỉnh màu da, làm mờ các khuyết điểm nhỏ.', 2095, N'<p>1. Đen</p>

<p>- Phấn khi đ&aacute;nh nhiều lớp vẫn kh&ocirc;ng g&acirc;y cảm gi&aacute;c nặng mặt, đặc biệt phấn c&ograve;n l&agrave;m trắng da tự nhi&ecirc;n. Gi&uacute;p hiệu chỉnh m&agrave;u da l&agrave;m cho m&agrave;u da đều m&agrave;u v&agrave; tươi s&aacute;ng.</p>

<p>- Đặc biệt sau 5 tiếng phấn vẫn kh&ocirc;ng bị xuống t&ocirc;ng, kiềm dầu ổn, tuy nhi&ecirc;n c&aacute;c v&ugrave;ng da bị tiết nhờn nhiều như v&ugrave;ng mũi, phấn vẫn kh&ocirc;ng bị tr&ocirc;i đi.</p>

<p>- Phấn c&oacute; thể l&agrave;m mờ quầng th&acirc;m dưới mắt</p>

<p>&nbsp;</p>

<p>2. Trắng</p>

<p>- Khả năng h&uacute;t dầu của sản phẩm n&agrave;y thật đ&aacute;ng kinh ngạc, nếu bạn ưng &yacute; sản phẩm kiềm dầu cao th&igrave; m&igrave;nh tin chắc rằng đ&acirc;y sẽ l&agrave; sản phẩm mang đến cho bạn một trải nghiệm tuyệt vời, l&agrave;n da của bạn sẽ v&ocirc; c&ugrave;ng mịn m&agrave;ng v&agrave; kh&ocirc; tho&aacute;ng.</p>

<p>- Makeup cũng c&oacute; cảm gi&aacute;c rất thoải m&aacute;i, lớp phấn nhẹ t&ecirc;nh, phấn phủ thấm s&acirc;u v&agrave;o trong da, kh&ocirc;ng hề g&acirc;y nhờn r&iacute;t cho người sử dụng v&agrave; l&agrave;n da sẽ tươi s&aacute;ng hơn rất nhiều.</p>
', 1, 0, N'phan-nen-eglips', CAST(N'2021-08-17 16:28:18.737' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4088, N'Miếng wax lông Run Caili Depilatory wax (5 miếng/hộp)', N'Khác', N'/Uploads/images/product/pro56.jpg', N'/Uploads/images/product/pro56.jpg', 55000, N'Miếng wax lông Run Caili Depilatory wax được tích hợp tẩy các tế bào chết và lông trên da.', 2099, N'<p>✖️ ƯU ĐIỂM:</p>

<p>- Wax sạch l&ocirc;ng tất cả c&aacute;c v&ugrave;ng tr&ecirc;n cơ thể như m&eacute;p , n&aacute;ch , tay ,ch&acirc;n, bikini, lưng, bụng...</p>

<p>- Dễ d&agrave;ng thực hiện</p>

<p>- Cực k&igrave; nhanh ch&oacute;ng</p>

<p>- L&ocirc;ng mọc lại rất chậm v&agrave; yếu hơn ( kết hợp b&ocirc;i tinh chất triệt l&ocirc;ng sau wax để triệt l&ocirc;ng vĩnh viễn )</p>

<p>- C&oacute; th&agrave;nh phần vitamin E, tinh chất hoa c&uacute;c gi&uacute;p dưỡng ẩm, xoa dịu ch&acirc;n l&ocirc;ng sau khi wax.</p>

<p>- Cải thiện sắc tố v&ugrave;ng da dưới n&aacute;ch</p>

<p>- Thu nhỏ lỗ ch&acirc;n l&ocirc;ng</p>

<p>- Tiện lợi khi mang theo</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>&ndash; L&agrave;m sạch v&ugrave;ng da cần wax l&ocirc;ng.</p>

<p>&ndash; Độ d&agrave;i l&ocirc;ng n&ecirc;n để từ 3-5 mm để dễ d&agrave;ng wax.</p>

<p>&ndash; Ma s&aacute;t miếng s&aacute;p giữa 2 l&ograve;ng b&agrave;n tay, l&agrave;m miếng wax n&oacute;ng l&ecirc;n, lớp s&aacute;p sẽ chảy ra, gi&uacute;p dễ d&agrave;ng wax l&ocirc;ng.</p>

<p>&ndash; D&aacute;n s&aacute;p v&agrave;o v&ugrave;ng da cần loại bỏ l&ocirc;ng sau đ&oacute; nhẹ nh&agrave;ng miết mạnh tờ s&aacute;p v&agrave;o da trong khoảng 10 gi&acirc;y.</p>

<p>&ndash; Giật mạnh miếng s&aacute;p, ngược chiều l&ocirc;ng mọc.</p>

<p>&ndash; C&oacute; thể cắt nhỏ miếng s&aacute;p cho từng v&ugrave;ng da th&iacute;ch hợp, 1 miếng &aacute;p dụng nhiều lần, hoặc cho đến khi s&aacute;p kh&ocirc;ng c&ograve;n d&iacute;nh nữa.</p>

<p>&ndash; Sau khi wax nếu c&oacute; s&aacute;p wax s&oacute;t lại tr&ecirc;n da , d&ugrave;ng dầu dừa hoặc dầu tẩy trang để lau sạch v&agrave; rửa lại với nước</p>
', 1, 0, N'mieng-wax-long-run-caili-depilatory-wax-5-mienghop', CAST(N'2021-08-17 16:34:09.913' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4089, N'CỌ TÁN MẮT VACOSI SHADER DUAL BRUSH - E2E', N'Vacosi', N'/Uploads/images/product/pro57.jpg', N'/Uploads/images/product/pro57.jpg', 55000, N'Cọ Mắt Vacosi Eye Brush là dòng dụng cụ trang điểm đến từ thương hiệu mỹ phẩm Vacosi của Hàn Quốc, được thiết kế chuyên nghiệp với chất liệu lông tự nhiên mềm mịn, an toàn cho vùng da mắt nhạy cảm.', 2096, N'<p>- Cọ phấn mắt 2 đầu - E2E, được thiết kế với kiểu d&aacute;ng 1 đầu cọ dẹp, 1 đầu cọ mousse tiện lợi v&agrave; dễ sử dụng.</p>

<p>- Thiết kế 2 đầu tiện lợi: Đầu l&ocirc;ng cứng gi&uacute;p t&aacute;n m&agrave;u v&agrave; blending phấn mắt. Đầu mousse gi&uacute;p highlight xương ch&acirc;n m&agrave;y hoặc t&aacute;n m&agrave;u mắt thật sắc n&eacute;t, ho&agrave;n hảo.</p>

<p>- D&ugrave;ng với sản phẩm: dạng bột (powder), dạng kem (cream)</p>

<p>- Ưu điểm nổi bật:</p>

<p>+ Thiết kế tiện &iacute;ch 2 trong 1.</p>

<p>+ Đa chức năng v&agrave; linh hoạt khi sử dụng.</p>

<p>+ B&aacute;m phấn tốt v&agrave; mềm mại tuyệt đối cho v&ugrave;ng mắt.</p>
', 1, 0, N'co-tan-mat-vacosi-shader-dual-brush---e2e', CAST(N'2021-08-17 16:36:34.560' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4090, N'Son Kem Black Rouge Air Fit Velvet Tint Ver 5', N'Black Rouge', N'/Uploads/images/product/pro58.jpg', N'/Uploads/images/product/pro58.jpg', 0, N'Black Rouge Version 5 là bộ sưu tập mới Night Series của nhà Black Rouge với chủ đề màn đêm, thỏi son như lời bộc lộ đầy cảm xúc của màu sắc tạo nên bức tranh toàn cảnh những khía cạnh của màn đêm, đối lập giữa sự nổi loạn và nữ tính.', 2094, N'<p>&bull; A23 - Vintage Sunset: Cam nude pha n&acirc;u cổ điển</p>

<p>&bull; A24 - Campfire Night: Cam đỏ rực rỡ</p>

<p>&bull; A25 - Pink Pillow: Đỏ sậm &aacute;nh hồng mềm mại</p>

<p>&bull; A26 - Winter Moon: N&acirc;u trầm pha cam mới lạ</p>

<p>&bull; A27 - Wanderlust: Đỏ nhung t&ocirc;ng lạnh t&ocirc;n da</p>
', 1, 0, N'son-kem-black-rouge-air-fit-velvet-tint-ver-5', CAST(N'2021-08-17 16:41:35.770' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4091, N'Phấn nước Missha Magic Cushion', N'Missha', N'/Uploads/images/product/pro59.jpg', N'/Uploads/images/product/pro59.jpg', 0, N'Với khả năng che phủ cực tốt trên da, vượt trội hơn hẳn so với phiên bản cũ, cùng khả năng kiềm dầu hiệu quả, đây là sản phẩm rất thích hợp cho những làn da dầu hoặc có khuyết điểm nhưng ngại chồng nhiều lớp kem che khuyết điểm.', 2095, N'<p>- Chất kem si&ecirc;u mỏng, mềm mịn, kh&ocirc;ng g&acirc;y t&igrave;nh trạng kh&ocirc;ng đều hoặc v&oacute;n cục tr&ecirc;n da, cho d&ugrave; bạn c&oacute; dặm đi dặm lại nhiều lần th&igrave; gương mặt vẫn lu&ocirc;n mịn m&agrave;ng, da căng mịn kh&ocirc;ng t&igrave; vết</p>

<p>- Độ che phủ tốt, c&oacute; thể thay thế được cả kem l&oacute;t, kem nền, kem che khuyết điểm</p>

<p>- Độ b&aacute;m chặt tr&ecirc;n da l&acirc;u, khiến bạn c&oacute; thể tự tin hoạt động cả một ng&agrave;y trời m&agrave; kh&ocirc;ng lo bị phai phấn.</p>

<p>- Khả năng kiểm so&aacute;t dầu tốt</p>

<p>- Bổ sung chất kho&aacute;ng cho da, gi&uacute;p dưỡng cho da lu&ocirc;n trong t&igrave;nh trạng b&oacute;ng mịn, khoẻ mạnh v&agrave; bảo vệ khỏi những t&aacute;c động xấu của m&ocirc;i trường.</p>
', 1, 0, N'phan-nuoc-missha-magic-cushion', CAST(N'2021-08-17 16:44:57.013' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4092, N'Nước hoa hồng Some By Mi Galactomyces Pure Vitamin C Glow Toner', N'Some By Mi', N'/Uploads/images/product/pro60.jpg', N'/Uploads/images/product/pro60.jpg', 250000, N'Toner dưỡng trắng không chứa cồn chiết xuất từ 88% men Galactomyces kết hợp cùng vitamin C và Niacinamide mang lại hiệu quả cân bằng và dưỡng trắng tối ưu giúp da bóng khỏe tràn đầy sức sống', 2098, N'<p>Thương hiệu: Some By Mi</p>

<p>Sản xuất: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>- C&ocirc;ng dụng:</p>

<p>+ Nước hoa hồng Some By Mi Galactomyces Pure Vitamin C Glow hội tụ những th&agrave;nh phần đỉnh cao như:</p>

<p>+ Galactomyces (88%): loại men cực nhiều vitamin v&agrave; axit amin l&agrave;m da s&aacute;ng đều, s&aacute;ng khỏe. L&agrave;m đầy nếp nhăn, se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng, chống l&atilde;o h&oacute;a. Nhờ độ thẩm thấu ngay tức khắc n&ecirc;n kh&ocirc;ng g&acirc;y cảm gi&aacute;c nặng mặt, nhờn r&iacute;t.</p>

<p>+ Vitamin C (10.000ppm): th&agrave;nh phần quan trọng trong sản phẩm gi&uacute;p dưỡng trắng. Bảo vệ da ho&agrave;n hảo khỏi t&aacute;c động xấu của m&ocirc;i trường, đẩy l&ugrave;i hắc sắc tố, đem lại l&agrave;n da trắng mịn trong thời gian ngắn nhất.</p>

<p>+ 10 loại Vitamin cực k&igrave; tốt cho da (B1, B3, B5, B6, B9, B12, E, F, H, C): nu&ocirc;i dưỡng da từ s&acirc;u b&ecirc;n trong, cung cấp dưỡng chất cho da trắng khỏe bền l&acirc;u</p>
', 1, 0, N'nuoc-hoa-hong-some-by-mi-galactomyces-pure-vitamin-c-glow-toner', CAST(N'2021-08-17 16:47:34.030' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4093, N'Tinh chất chấm mụn TEA TREE', N'Khác', N'/Uploads/images/product/pro61.jpg', N'/Uploads/images/product/pro61.jpg', 0, N'Tinh dầu tràm trà tea tree trứ danh với đặc tính kháng khuẩn và thanh lọc mạnh mẽ. chiết xuất từ tinh dầu của những chiếc lá tràm trà được thu hoạch bằng tay trong chương trình Thương mại cộng đồng. Những giọt tea tree tinh khiết nhất đã trải qua 12 giờ chưng cất, được kiểm nghiệm và chứng minh mang lại làn da sạch khuyết điểm cho bạn.', 2107, N'<p>-Tinh dầu Tea tree chiết xuất từ những l&aacute; tr&agrave;m tr&agrave; tinh khiết được trồng dưới ch&acirc;n n&uacute;i Kenya v&agrave; chưng cất hơi nước 12 tiếng</p>

<p>-Cải thiện t&igrave;nh trạng da dễ bị mụn</p>

<p>-Thoa trực tiếp l&ecirc;n da</p>
', 1, 0, N'tinh-chat-cham-mun-tea-tree', CAST(N'2021-08-17 16:50:31.580' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4094, N'Mặt Nạ Freeman Feeling Beautiful', N'Freeman', N'/Uploads/images/product/pro62.jpg', N'/Uploads/images/product/pro62.jpg', 0, N'Mặt nạ Freeman Feeling Beautiful 175ml đang được rất nhiều chị em lựa chọn để giúp làm sạch sâu, lấy đi tế bào chết và bụi bẩn sâu trong lỗ chân lông. Sản phẩm chiết xuất từ thành phần thiên nhiên, với nhiều loại phù hợp cho từng loại da', 2112, N'<p>✖️ VỊ NGỌC TRAI:</p>

<p>&rArr; C&ocirc;ng dụng: Mặt nạ cung cấp kho&aacute;ng Dead Sea Minerals Facial Anti-stress Mask từ Feeling Beautiful &ndash; Freeman Beauty kh&ocirc;ng chỉ cung cấp những kho&aacute;ng chất từ thi&ecirc;n nhi&ecirc;n gi&uacute;p nu&ocirc;i dưỡng l&agrave;n da v&agrave; l&agrave;m sạch s&acirc;u c&aacute;c lỗ ch&acirc;n l&ocirc;ng, c&acirc;n bằng độ ẩm cho da, m&agrave; c&ograve;n chứa chiết xuất từ hoa Oải Hương v&agrave; Cam Bergamot l&agrave; biện ph&aacute;p hỗ trợ v&agrave; điều trị hữu hiệu nhất, đập tan mọi căng thẳng, l&agrave;m thanh sạch l&agrave;n da, mịn m&agrave;ng v&agrave; rạng rỡ tuyệt vời. Sản phẩm ph&ugrave; hợp cho tất cả mọi loại da. &rArr; Th&agrave;nh phần: Muối biển chết, Đất S&eacute;t.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>✖️ VỊ THAN HOẠT T&Iacute;NH &amp; ĐƯỜNG ĐEN (VỎ BẠC):</p>

<p>&rArr; C&ocirc;ng dụng: Mặt nạ chứa Than v&agrave; Đường Đen, c&oacute; t&aacute;c dụng gi&uacute;p thanh lọc, khử độc, h&uacute;t sạch dầu dư thừa, cặn b&atilde;, v&agrave; đồng thời tẩy tế b&agrave;o da chết. Than Hoạt T&iacute;nh (Activated Charcoal): Ch&iacute;nh l&agrave; Carbon đ&atilde; được nung n&oacute;ng n&ecirc;n nở to ra, tạo th&agrave;nh tinh thể xốp v&agrave; chứa nhiều lỗ rỗng. Nhờ v&agrave;o đặc điểm n&agrave;y m&agrave; Than Hoạt T&iacute;nh c&oacute; sức mạnh h&uacute;t hết c&aacute;c ph&acirc;n tử dầu thừa, bụi bẩn, cặn b&atilde; v&agrave;o c&aacute;c lỗ rỗng của n&oacute;. Than Hoạt T&iacute;nh vốn được sử dụng rộng r&atilde;i ở trong c&aacute;c b&igrave;nh lọc nước, mặt nạ lọc kh&iacute; độc&hellip; (n&ecirc;n kh&ocirc;ng phải nghi ngại g&igrave; về hiệu quả của n&oacute; nh&eacute;), nhưng gần đ&acirc;y được &aacute;p dụng ng&agrave;y một nhiều hơn trong mĩ phẩm l&agrave;m đẹp. Đường đen được sử dụng si&ecirc;u phổ biến trong đủ loại scrub cho mặt, m&ocirc;i, thậm ch&iacute; cho cả cơ thể. Những hạt đường li ti gi&uacute;p qu&eacute;t hết đi c&aacute;c tế b&agrave;o chết th&ocirc; r&aacute;p, x&aacute;m xỉn tr&ecirc;n bề mặt, để lại l&agrave;n da mịn m&agrave;ng v&agrave; s&aacute;ng sủa. Ngo&agrave;i ra trong đường c&ograve;n c&oacute; nhiều glycolic acid, ch&iacute;nh l&agrave; một loại AHA gi&uacute;p tẩy tế b&agrave;o chết s&acirc;u v&agrave; k&iacute;ch th&iacute;ch qu&aacute; tr&igrave;nh sản sinh ra tế b&agrave;o mới. D&ugrave;ng cho mọi loại da.</p>

<p>&rArr; Th&agrave;nh phần: Chiết xuất từ than v&agrave; đường đen.</p>

<p>&nbsp;</p>

<p>✖️ VỊ THAN Đ&Aacute; &amp; ĐƯỜNG ĐEN (VỎ ĐEN):</p>

<p>&rArr; C&ocirc;ng dụng: chứa than gi&uacute;p h&uacute;t hết lượng dầu thừa tr&ecirc;n da, bụi bẩn, cặn b&atilde; v&agrave;o c&aacute;c lỗ ch&acirc;n l&ocirc;ng v&agrave; Đường Đen gi&uacute;p qu&eacute;t hết đi c&aacute;c tế b&agrave;o chết th&ocirc; r&aacute;p, xỉn tr&ecirc;n bề mặt, k&iacute;ch th&iacute;ch t&aacute;i sinh c&aacute;c tế b&agrave;o mới gi&uacute;p da trở l&ecirc;n mịn m&agrave;ng hơn. Th&iacute;ch hợp cho mọi loại da.</p>

<p>&rArr; Th&agrave;nh phần: chiết xuất từ than v&agrave; đường đen.</p>

<p>&nbsp;</p>

<p>✖️ VỊ BƠ:</p>

<p>&rArr; C&ocirc;ng dụng: Với c&ocirc;ng thức gi&agrave;u Vitamin E, chiết xuất Bơ v&agrave; Yến Mạch, Mặt nạ FREEMAN Facial Clay Mask Avocado &amp; Oatmeal gi&uacute;p c&acirc;n bằng độ ẩm cho da, nu&ocirc;i dưỡng cho bề mặt da ng&agrave;y một l&aacute;ng mịn, mềm mại. K&ecirc;́t hợp với nu&ocirc;i dưỡng v&agrave; l&agrave;m sạch da một c&aacute;ch hiệu quả nhất.</p>

<p>&rArr; Th&agrave;nh phần: chiết xuất từ bơ v&agrave; yến mạch.</p>

<p>&nbsp;</p>

<p>✖️ VỊ CHANH: Mặt nạ đất s&eacute;t chanh kết hợp với bạc h&agrave; l&agrave;m giảm sự sưng tấy vi&ecirc;m nhiễm do mụn. Đất s&eacute;t hấp thụ dầu để giảm thiểu b&oacute;ng v&agrave; tinh chất chanh + bạc h&agrave; gi&uacute;p thu nhỏ lỗ ch&acirc;n l&ocirc;ng lớn. Th&iacute;ch hợp cho da dầu v&agrave; bị mụn.</p>
', 1, 0, N'mat-na-freeman-feeling-beautiful', CAST(N'2021-08-17 16:54:34.563' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4095, N'Tinh Chất Dưỡng Trắng Da Some By Mi Yuja Niacin Blemish Care Serum', N'Some By Mi', N'/Uploads/images/product/pro26.jpg', N'/Uploads/images/product/pro26.jpg', 265000, N'Tinh Chất Dưỡng Trắng Da Chiết Xuất Quả Thanh Yên Some By Mi Yuja Niacin 30 Days Blemish Care Serum là tinh chất thuộc dòng Yuja Niacin của thương hiệu Some By Mi đặc trị giúp giảm nám và tàn nhang kết hợp cung cấp độ ẩm sâu cho da. Chiết xuất từ 82% tinh chất trái Yuja tươi giàu vitamin C và 5% Niacinamide', 2103, N'<p>Dung t&iacute;ch: 50ml</p>

<p>Xuất xứ: H&agrave;n Quốc</p>

<p>Thương hiệu: Some By Mi</p>

<p>&nbsp;</p>

<p>1. C&ocirc;ng dụng:</p>

<p>- Gi&uacute;p phục hồi, cải thiện l&agrave;n da xỉn m&agrave;u, cấp ẩm, giảm căng thẳng cho l&agrave;n da.</p>

<p>- Cấp nước v&agrave; cung cấp dưỡng chất cho da s&aacute;ng khỏe.</p>

<p>- Hỗ trợ l&agrave;m trắng da, gi&uacute;p l&agrave;m mờ c&aacute;c vết th&acirc;m n&aacute;m v&agrave; đồi mồi.</p>

<p>- Bảo vệ l&agrave;n da nhạy cảm khỏi c&aacute;c t&aacute;c nh&acirc;n g&acirc;y hại từ m&ocirc;i trường.</p>

<p>&nbsp;</p>

<p>2. Th&agrave;nh phần</p>

<p>- 82% h&agrave;m lượng chiết xuất từ qu&yacute;t Yuja của H&agrave;n Quốc c&oacute; t&aacute;c dụng cấp nước v&agrave; nguồn dưỡng chất dồi d&agrave;o cho da ẩm mịn, s&aacute;ng khỏe.</p>

<p>- 5% h&agrave;m lượng Niacin hỗ trợ l&agrave;m trắng da, gi&uacute;p l&agrave;m mờ c&aacute;c vết th&acirc;m n&aacute;m, t&agrave;n nhang v&agrave; đồi mồi.</p>

<p>- 12 loại vitamin trong sản phẩm gi&uacute;p nạp đầy năng lượng kh&ocirc;i phục v&agrave; bảo vệ l&agrave;n da nhạy cảm khỏi c&aacute;c t&aacute;c nh&acirc;n g&acirc;y hại từ m&ocirc;i trường.</p>

<p>- Kh&ocirc;ng chứa 20 th&agrave;nh phần g&acirc;y hại, dễ g&acirc;y k&iacute;ch ứng cho da thường thấy trong mỹ phẩm.</p>
', 1, 0, N'tinh-chat-duong-trang-da-some-by-mi-yuja-niacin-blemish-care-serum', CAST(N'2021-08-17 16:56:59.863' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4096, N'Nước Hoa Hồng Muji', N'Muji', N'/Uploads/images/product/pro63.jpg', N'/Uploads/images/product/pro63.jpg', 0, N'Nước hoa hồng Muji Light Toning Water Moisture 200ml cung cấp các thành phần như tinh chất từ hạt bưởi, tinh chất rau sam chứa thành phần bảo vệ da, Polyquaternium-51 có hiệu quả dưỡng ẩm cao và đặc biệt chứa dưỡng chất hyaluronic acid giúp làn da được phục hồi, cải thiện tình trạng da bị khô và hư tổn.', 2098, N'<p>🖤🖤Nước Hoa Hồng Muji🖤🖤</p>

<p>💲 Gi&aacute; lẻ: 180k</p>

<p>&nbsp;</p>

<p>✖️ C&oacute; 2 loại:</p>

<p>- Light: Da dầu</p>

<p>- Moisture: Da kh&ocirc;</p>

<p>&nbsp;</p>

<p>✔️ Muji thương hiệu Nhật Bản sở hữu rất nhiều chuỗi cửa h&agrave;ng b&aacute;n lẻ được ưa chuộng ở khắp Ch&acirc;u &Aacute; v&agrave; ng&agrave;y c&agrave;ng ph&aacute;t triển mạnh mẽ hơn. Với phong c&aacute;ch đơn giản nhưng tinh tế, hạn chế l&atilde;ng ph&iacute; về bao b&igrave; m&agrave; ch&uacute; trọng đến c&aacute;c sản phẩm chất lượng với thiết kế tối giản, sử dụng c&aacute;c vật liệu c&oacute; thể t&aacute;i chế. Muji đ&atilde; tạo ra sự kh&aacute;c biệt cho ri&ecirc;ng m&igrave;nh v&agrave; nhờ thế, rất nhiều t&iacute;n đồ l&agrave;m đẹp đ&atilde; lựa chọn Muji để gắn b&oacute; l&acirc;u d&agrave;i.</p>

<p>✔️ Nước hoa hồng muji với hiệu quả dưỡng ẩm cao gi&uacute;p da lu&ocirc;n căng mướt v&agrave; mềm mịn trong bất k&igrave; điều kiện thời tiết n&agrave;o.</p>

<p>✔️ Với nguy&ecirc;n liệu được sử dụng ch&iacute;nh l&agrave; nước kho&aacute;ng thi&ecirc;n nhi&ecirc;n v&ocirc; c&ugrave;ng tinh khiết ở n&uacute;i Iwate Nhật Bản, c&ugrave;ng c&ocirc;ng thức kh&ocirc;ng chứa cồn, kh&ocirc;ng chất bảo quản, kh&ocirc;ng hương liệu, Nước hoa hồng muji nhật bản thật sự l&agrave; một toner th&acirc;n thiện v&agrave; l&agrave;nh t&iacute;nh với mọi loại da, kể cả da nhạy cảm.</p>

<p>✔️ B&ecirc;n cạnh đ&oacute;, Nước hoa hồng muji nhật cũng bổ sung th&ecirc;m c&aacute;c tinh chất dưỡng da như tinh chất bưởi, tinh chất rau sam c&ugrave;ng th&agrave;nh phần cấp ẩm &ldquo;si&ecirc;u việt&rdquo; Hyaluronic Acid sẽ ngay lập tức &ldquo;ủ&rdquo; nước cho l&agrave;n da, phục hồi lại l&agrave;n da kh&ocirc; r&aacute;p v&agrave; mang đến cho bạn một l&agrave;n da ẩm mượt, mọng mướt với độ ph lu&ocirc;n được c&acirc;n bằng.</p>

<p>✔️ Th&agrave;nh phần:</p>

<p>- Tinh chất từ hạt bưởi.</p>

<p>- Tinh chất rau sam chứa th&agrave;nh phần bảo vệ da.</p>

<p>- Polyquaternium-51 c&oacute; hiệu quả dưỡng ẩm cao.</p>

<p>- Hyaluronic acid.</p>

<p>&nbsp;</p>

<p>✖️ Ưu điểm vượt trội:</p>

<p>- Được l&agrave;m từ nguồn nước đặc biệt:</p>

<p>- D&ograve;ng sản phẩm chăm s&oacute;c da của MUJIRUSHI c&oacute; một điểm kh&aacute;c biệt so với c&aacute;c sản phẩm kh&aacute;c đ&oacute; l&agrave; Chất lượng nước. H&atilde;ng đ&atilde; sử dụng nước rất sạch được chảy ra từ c&aacute;c v&aacute;ch n&uacute;i đ&aacute; của tỉnh Iwate. Chỉ sử dụng nước kho&aacute;ng thi&ecirc;n nhi&ecirc;n chỉ b&aacute;n tại địa phương để tạo n&ecirc;n d&ograve;ng sản phẩm chăm s&oacute;c dưỡng ẩm to&agrave;n diện n&agrave;y.</p>

<p>- Tuyệt đối kh&ocirc;ng sử dụng bất cứ chất phụ gia n&agrave;o:</p>

<p> Kh&ocirc;ng m&agrave;u・Kh&ocirc;ng chứa dầu kho&aacute;ng・T&iacute;nh oxy ho&aacute; nhẹ・Kh&ocirc;ng chứa chất bảo quản・Kh&ocirc;ng cồn・ Đ&atilde; test độ k&iacute;ch ứng da（Khả năng bị k&iacute;ch ứng da rất &iacute;t). - Th&agrave;nh phần chiết xuất ho&agrave;n to&agrave;n từ thi&ecirc;n nhi&ecirc;n</p>

<p> Cung cấp c&aacute;c th&agrave;nh phần như tinh chất từ hạt bưởi, tinh chất rau sam chứa th&agrave;nh phần bảo vệ da, Polyquaternium-51 c&oacute; hiệu quả dưỡng ẩm cao v&agrave; đặc biệt chứa dưỡng chất hyaluronic acid gi&uacute;p l&agrave;n da được phục hồi, cải thiện t&igrave;nh trạng da bị kh&ocirc; v&agrave; hư tổn.</p>

<p>- Th&agrave;nh phần đ&aacute;ng ch&uacute; &yacute; l&agrave; Sodium Hyaluronate, thường sử dụng trong bước chống l&atilde;o ho&aacute; v&igrave; khả năng duy tr&igrave; độ ẩm cho da. Sodium Hyaluronate c&oacute; c&aacute;c hạt nhỏ hơn cả Axit Hyaluronic, gi&uacute;p n&oacute; di chuyển s&acirc;u hơn v&agrave;o da v&agrave; giữ nước nhiều hơn. Da sẽ lu&ocirc;n đủ nước, ẩm, mượt, căng mọng như được phủ một lớp sương mỏng.</p>
', 1, 0, N'nuoc-hoa-hong-muji', CAST(N'2021-08-18 09:52:52.450' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4097, N'Tinh Chất Dưỡng Trắng Serum Vitamin C Melano CC Rohto 20ML', N'Rohto', N'/Uploads/images/product/pro64.jpg', N'/Uploads/images/product/pro64.jpg', 225000, N'Serum Vitamin C Melano CC Rohto có xuất xứ từ Nhật Bản với dung tích 20ml rất hiệu quả trong việc ngăn ngừa tàn nhanh, giảm sự sản sinh sắc tố melanin – nguyên nhân gây ra vết thâm. Ngoài ra, Melano CC còn bổ sung vitamin E cho da, giúp da khỏe mạnh, giữ ẩm, ngừa mụn và làm da sáng ra từ bên trong.', 2103, N'<p>&nbsp;</p>

<p>🖤🖤Tinh Chất Dưỡng Trắng Serum Vitamin C Melano CC Rohto🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 225K</p>

<p>&nbsp;</p>

<p>✖️ Xuất xứ: Nhật Bản</p>

<p>✖️ Thương hiệu: Rohto</p>

<p>✖️ Dung t&iacute;ch: 20ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>&ndash; Tinh chất Melano CC Rohto kết hợp giữa vitamin C v&agrave; E gi&uacute;p ngăn chặn sự sản xuất melanin (t&aacute;c nh&acirc;n g&acirc;y ra vết th&acirc;m n&aacute;m, t&agrave;n nhang).</p>

<p>&ndash; L&agrave;m mờ vết sạm da, l&agrave;m mờ đốm n&acirc;u v&agrave; vết n&aacute;m.</p>

<p>&ndash; Chữa l&agrave;nh sẹo l&otilde;m hoặc t&aacute;i tạo da sau qu&aacute; tr&igrave;nh bị mụn, hỗ trợ collagen, tạo độ đ&agrave;n hồi v&agrave; săn chắc cho da.</p>

<p>&ndash; Ức chế tăng tiết nhờn, se nhỏ lỗ ch&acirc;n l&ocirc;ng.</p>

<p>&ndash; Ngăn ngừa sự xuất hiện c&aacute;c nh&acirc;n mụn mới, r&ocirc;m sảy.</p>

<p>&ndash; Giữ cho l&agrave;n da sạch, khỏe mạnh v&agrave; duy tr&igrave; độ ẩm tự nhi&ecirc;n cho da.</p>

<p>&ndash; Điều trị da bị tổn thương, da kh&ocirc;ng đều m&agrave;u do t&aacute;c hại của &aacute;nh nắng mặt trời.</p>

<p>&ndash; Gi&uacute;p duy tr&igrave; vẻ đẹp v&agrave; gia tăng tuần ho&agrave;n m&aacute;u, lấy đi oxygen hoạt h&oacute;a, ngăn chặn l&atilde;o h&oacute;a da.</p>

<p>&ndash; Nghi&ecirc;n cứu cho thấy CC Melano tốt hơn 10% so với sản phẩm c&ugrave;ng loại th&ocirc;ng thường kh&aacute;c.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>➖ Sử dụng Serum với toner:</p>

<p>+ Đ&acirc;y l&agrave; nguy&ecirc;n tắc bắt buộc bởi toner đ&oacute;ng vai tr&ograve; l&agrave;m sạch s&acirc;u hơn với những th&agrave;nh phần gi&uacute;p đẩy bụi bẩn nằm s&acirc;u tr&ecirc;n da, hạn chế t&igrave;nh trạng tắc nghẽn lỗ ch&acirc;n l&ocirc;ng, hủy hoại tế b&agrave;o da.</p>

<p>+ Toner ch&iacute;nh l&agrave; dẫn xuất gi&uacute;p đưa tinh chất của serum với c&aacute;c chất dinh dưỡng v&agrave; tinh dầu đặc trị v&agrave;o từng tế b&agrave;o da. Điều bạn cần ghi nhớ l&agrave; lu&ocirc;n lu&ocirc;n d&ugrave;ng toner trước rồi thoa serum sau.</p>

<p>&nbsp;</p>

<p>➖ Sử dụng Serum với kem dưỡng da:</p>

<p>+ Loại kem dưỡng da bạn n&ecirc;n sử dụng l&agrave; loại c&oacute; c&ugrave;ng t&iacute;nh năng với serum. Lớp kem c&oacute; c&ugrave;ng c&ocirc;ng dụng với serum n&agrave;y sẽ l&agrave; lớp &aacute;o bảo vệ đặc biệt để gi&uacute;p serum kh&ocirc;ng bị bay hơi v&agrave; da kh&ocirc;ng bị kh&oacute; chịu hay kh&ocirc;. B&ecirc;n cạnh đ&oacute;, việc phối hợp sử dụng cả serum dưỡng da v&agrave; kem dưỡng da sẽ gi&uacute;p tăng cường t&aacute;c dụng của cả hai l&ecirc;n da.</p>

<p>+ H&atilde;y nhớ thoa serum dưỡng da trước rồi thoa kem dưỡng da l&ecirc;n tr&ecirc;n, bởi nếu b&ocirc;i serum sau khi sử dụng kem dưỡng sẽ l&agrave;m giảm hiệu quả của serum v&agrave; c&aacute;c chất dinh dưỡng c&oacute; lợi kh&oacute; c&oacute; thể xuy&ecirc;n qua lớp kem dưỡng để thẩm thấu v&agrave;o da.</p>
', 1, 0, N'tinh-chat-duong-trang-serum-vitamin-c-melano-cc-rohto-20ml', CAST(N'2021-08-18 10:08:47.983' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4098, N'Son Kem Black Rouge Air Fit Velvet Tint Ver 7', N'Black Rouge', N'/Uploads/images/product/pro65.jpg', N'/Uploads/images/product/pro65.jpg', 0, N'Black Rouge Air Fit Velvet Tint Ver 7 đã bắt kịp xu hướng với tone đỏ cam thời thượng, bộ sưu tập màu son mới nhất của nhà Black Rouge với tone chủ đạo đỏ cam nhưng cách mix cực mê  mang đến 5 màu khiến nàng khó mà không yêu.', 2094, N'<p>A33: Sunset Crown - Đỏ cam</p>

<p>A34: Sensual Queen of Burnt - Cam gạch</p>

<p>A35: Sunny Side Up - Đỏ d&acirc;u</p>

<p>A36: Dust Pumpkin - Cam pha n&acirc;u</p>

<p>A37: Unrivaled Chili King - Đỏ n&acirc;u đất</p>

<p>#blackrougever7</p>
', 1, 0, N'son-kem-black-rouge-air-fit-velvet-tint-ver-7', CAST(N'2021-08-18 10:12:30.413' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4099, N'Sữa rửa mặt Hada Labo Gokujyun Hatomugi/Hyaluronic Acid Bubble Face Wash', N'Hada Labo', N'/Uploads/images/product/pro66.jpg', N'/Uploads/images/product/pro66.jpg', 0, N'Sữa rửa mặt Hada Labo tạo bọt sẵn tiện lợi, giúp tiết kiệm thời gian, chỉ cần nhấn vài ba lần là bạn đã có ngay lớp bọt bông siêu mịn, dễ dàng làm sạch sâu các bụi bẩn, bã nhờn, giảm thiểu việc hình thành mụn trên da mà hoàn toàn không gây ra cảm giác căng khô sau khi sử dụng.', 2097, N'<p>➖ Ph&acirc;n loại: V&ograve;i 160ml, tu&yacute;p 100g</p>

<p>➖ Sản xuất: Rohto, Nhật Bản</p>

<p>&nbsp;</p>

<p>✖️ Sữa rửa mặt tạo bọt Hada Labo Gokujyun Hyaluronic Acid Bubble Face Wash (LOẠI M&Agrave;U TRẮNG):</p>

<p>✔️ Với c&ocirc;ng thức dịu nhẹ c&ugrave;ng độ PH = 5 c&acirc;n bằng, ph&ugrave; hợp với mọi loại da. Sản phẩm c&oacute; bao b&igrave; l&agrave; chai m&agrave;u trắng n&agrave;y ngo&agrave;i khả năng l&agrave;m sạch tận s&acirc;u lỗ ch&acirc;n l&ocirc;ng nhờ lớp bọt nhỏ li ti c&ograve;n c&oacute; khả năng dưỡng ẩm tuyệt vời. C&ocirc;ng thức &ldquo;Super Hyaluronic Acid&rdquo; c&oacute; khả năng giữ ẩm gấp 2 lần axit hyaluronic th&ocirc;ng thường. L&agrave;n da được rửa sạch bụi bẩn, dầu thừa nhưng vẫn giữ đủ ẩm cho da mềm mịn, kh&ocirc;ng bị kh&ocirc;, căng r&aacute;t kh&oacute; chịu sau khi sử dụng.</p>

<p>✔️ Sữa rửa mặt tạo bọt Hada Labo Gokujyun Hyaluronic Acid Bubble Face Wash kh&ocirc;ng chứa cồn, kh&ocirc;ng hương liệu, kh&ocirc;ng chất tạo m&agrave;u, kh&ocirc;ng chứa silicon, an to&agrave;n dịu nhẹ cho mọi loại da.</p>

<p>&nbsp;</p>

<p>✖️ Sữa rửa mặt tạo bọt Hada Labo Gokujyun Hatomugi Bubble Face Wash (LOẠI M&Agrave;U XANH):</p>

<p>✔️ Đ&acirc;y l&agrave; sản phẩm sữa rửa mặt với c&ocirc;ng thức dịu nhẹ c&ugrave;ng độ PH = 5 c&acirc;n bằng, ph&ugrave; hợp d&agrave;nh cho da mụn. Chiết xuất từ hạt l&uacute;a mạch ngọc trai (hạt &yacute; dĩ) gi&uacute;p dưỡng ẩm, l&agrave;m trắng da. Ngo&agrave;i ra trong sữa rửa mặt Hada Labo Hatomugi c&ograve;n chứa c&aacute;c hoạt chất Dipotassium Glycyrrhizate v&agrave; 6-aminocaproic acid c&oacute; t&aacute;c dụng nhanh ch&oacute;ng l&agrave;m dịu v&agrave; l&agrave;m giảm sự k&iacute;ch ứng, tấy đỏ do mụn.</p>

<p>✔️ Sự kết hợp của acid hyaluronic, squalane, hoa Chamomile, l&aacute; Chameleon gi&uacute;p dưỡng ẩm, l&agrave;m mềm da, thu nhỏ lỗ ch&acirc;n l&ocirc;ng, &ecirc;m dịu với cả da nhạy cảm nhất.</p>

<p>✔️ Sữa rửa mặt tạo bọt Hada Labo Gokujyun Hatomugi Bubble Face Wash kh&ocirc;ng chứa paraben, kh&ocirc;ng silicon, kh&ocirc;ng hương liệu, kh&ocirc;ng chất tạo m&agrave;u.</p>
', 1, 0, N'sua-rua-mat-hada-labo-gokujyun-hatomugihyaluronic-acid-bubble-face-wash', CAST(N'2021-08-18 10:16:43.530' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4100, N'Sữa Tắm Cá Ngựa Algemarin Perfume Gel 300ml của Đức', N'Khác', N'/Uploads/images/product/pro67.jpg', N'/Uploads/images/product/pro67.jpg', 85000, N'Sữa tắm cá ngựa Algemarin được chiết xuất từ các loài hoa và vitamin thiên nhiên, cung cấp ẩm và dưỡng chất giúp da mềm mịn, đồng thời tăng cường sức sống cho làn da căng mượt,...', 2099, N'<p>➖ Xuất xứ: Đức</p>

<p>➖ Thương hiệu: Algemarin</p>

<p>➖ Dung lượng: 300ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Sữa tắm con ngựa Algemarin chứa nhiều protein gi&uacute;p chăm s&oacute;c v&agrave; bảo vệ l&agrave;n da của bạn, đồng thời mang tới một l&agrave;n da cực kỳ mịn m&agrave;ng, tươi m&aacute;t khi tắm. Với m&ugrave;i thơm cực kỳ quyến rũ mang tới phong c&aacute;ch qu&yacute; ph&aacute;i cho c&aacute;c c&ocirc; g&aacute;i</p>

<p>✔️ Sữa tắm ho&agrave;n to&agrave;n chiết xuất từ thi&ecirc;n nhi&ecirc;n cung cấp dưỡng chất l&agrave;m mềm mịn da, tăng cường sức sống cho da, dưỡng ẩm da tự nhi&ecirc;n, l&agrave;m chậm sự l&atilde;o h&oacute;a da.</p>

<p>✔️ Gi&uacute;p lưu giữ hương thơm được l&acirc;u tr&ecirc;n cơ thể, b&ecirc;n cạnh đ&oacute; sữa tắm c&ograve;n chứa 40% tinh chất dưỡng da gi&uacute;p bạn c&oacute; cảm gi&aacute;c căng mịn ngay cả trong những ng&agrave;y trời hanh kh&ocirc; nhất.</p>

<p>✔️ Sản phẩm của Algemarin c&oacute; chứa chất nhuận da gi&uacute;p tẩy c&aacute;c lớp da chết đồng thời t&aacute;i tạo tế b&agrave;o da mới mang lại cho bạn l&agrave;n da mịn m&agrave;ng tươi trẻ.</p>

<p>✔️ Sữa tắm rất đặc, kh&ocirc;ng g&acirc;y nhờn như c&aacute;c d&ograve;ng sữa tắm hiện nay. Kh&ocirc;ng cần sử dụng b&ocirc;ng tắm, chỉ cần b&ocirc;i sữa tắm khắp người, xoa đều trong v&agrave;i ph&uacute;t, dội lại vs nước l&agrave; đi hết lu&ocirc;n cả gh&eacute;t, mồ h&ocirc;i, m&agrave; kh&ocirc;ng cần k&igrave; cọ nhiều.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>Trước ti&ecirc;n, bạn l&agrave;m ướt to&agrave;n th&acirc;n, sau đ&oacute; cho 1 lượng sữa tắm trắng da c&aacute; ngựa vừa đủ ra tay hoặc b&ocirc;ng tắm hoặc đổ trực tiếp v&agrave;o bồn tắm, tạo bọt v&agrave; massage nhẹ nh&agrave;ng l&ecirc;n da. Sau đ&oacute; tắm sạch lại với nước. C&oacute; thể sử dụng sữa tắm c&aacute; ngựa h&agrave;ng ng&agrave;y. Sản phẩm d&ugrave;ng cho cả nam lẫn nữ v&agrave; mọi loại da.</p>

<p>&nbsp;</p>

<p>✖️ Lưu &yacute;: Bảo quản nơi kh&ocirc; tho&aacute;ng, tr&aacute;nh &aacute;nh nắng trực tiếp. Tr&aacute;nh tiếp x&uacute;c với mắt.</p>
', 1, 0, N'sua-tam-ca-ngua-algemarin-perfume-gel-300ml-cua-duc', CAST(N'2021-08-18 10:18:42.610' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4101, N'Kem chống nắng Sun Milk Missha 70ml', N'Missha', N'/Uploads/images/product/pro68.jpg', N'/Uploads/images/product/pro68.jpg', 0, N'Kem Chống Nắng Chống Trôi Missha All-Around Safe Block Waterproof Sun Milk SPF50+/PA++++ giúp bảo vệ tối đa lâu dài cho da dưới ánh nắng mặt trời nhờ khả năng chống thấm nước mạnh mẽ cùng chiết xuất Bạch Đàn giúp giữ cho làn da thông thoáng và tươi mát', 2101, N'<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>- Thương hiệu: Missha</p>

<p>- Dung t&iacute;ch: 70ml</p>

<p>&nbsp;</p>

<p>✖️ Soft Finish:</p>

<p>- Được đ&aacute;nh gi&aacute; 4.6 /5 tr&ecirc;n trang makeupalley - 1 trang mỹ phẩm rất uy t&iacute;n</p>

<p>- All Around Safe Block Soft Finish Sun Milk l&agrave; kem chống nắng dạng sữa dưỡng mịn v&agrave; thấm nhanh, c&oacute; chất chống nắng v&ocirc; cơ d&agrave;nh cho những hoạt động ngo&agrave;i trời, cho cảm gi&aacute;c mịn m&agrave;ng, nhẹ dịu, kh&ocirc;ng g&acirc;y k&iacute;ch ứng da, c&oacute; m&ugrave;i thơm dịu nhẹ, kh&ocirc;ng g&acirc;y cảm gi&aacute;c nhờn d&iacute;nh cho da</p>

<p>- Ph&ugrave; hợp với da thường + da hỗn hợp</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>✖️ Waterproof:</p>

<p>- L&agrave; kem chống nắng dạng sữa dưỡng mịn v&agrave; thấm nhanh, c&oacute; chất chống nắng v&ocirc; cơ d&agrave;nh cho những hoạt động ngo&agrave;i trời, cho cảm gi&aacute;c mịn m&agrave;ng, nhẹ dịu</p>

<p>- Sun Protect gi&uacute;p hấp thụ v&agrave; nu&ocirc;i dưỡng da, bảo vệ da tốt nhất dưới &aacute;nh nắng m&agrave; kh&ocirc;ng hề để lại bất cừ dư lượng dầu thừa n&agrave;o</p>

<p>- Chỉ số chống nắng SPF50+/PA++++ c&oacute; khả năng chống nắng hơn 8 tiếng v&agrave; c&oacute; thể chống được cả tia UVA, UVB</p>

<p>- C&oacute; khả năng chống thấm nước, kh&ocirc;ng tr&ocirc;i bởi mồ h&ocirc;i hay b&atilde; nhờn</p>
', 1, 0, N'kem-chong-nang-sun-milk-missha-70ml', CAST(N'2021-08-18 10:21:53.420' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4102, N'Kem dưỡng ẩm Nivea Soft Đức', N'Nivea', N'/Uploads/images/product/pro69.jpg', N'/Uploads/images/product/pro69.jpg', 120000, N'Kem dưỡng ẩm Nivea Soft là sản phẩm dưỡng da quen thuộc không chỉ riêng với phụ nữ Việt Nam mà còn được ưa chuộng rất nhiều phụ nữ Châu Âu trong mùa đông giúp cho bạn có một làn da mịn màng và láng mịn, giúp bạn có một làn da trắng dần lên để thích hợp dùng cho da trong mùa hanh khô, và là sản phẩm hữu dụng khi đi du lịch những miền giá lạnh. ', 2100, N'<p>🖤🖤 Kem dưỡng ẩm Nivea Soft Đức🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 120K</p>

<p>&nbsp;</p>

<p>✖️ Xuất xứ: Đức</p>

<p>✖️ Thương hiệu: Nivea</p>

<p>✖️ Dung t&iacute;ch: 200ml</p>

<p>&nbsp;</p>

<p>✖️C&Ocirc;NG DỤNG:</p>

<p>✔️ Dưỡng ẩm da mặt &amp; to&agrave;n th&acirc;n (Th&iacute;ch hợp cho mọi loại da)</p>

<p>✔️ Chiết xuất từ dầu Jojoba v&agrave; Vitamin E, gi&uacute;p cho bạn c&oacute; một l&agrave;n da l&aacute;ng mịn, một l&agrave;n da trắng dần l&ecirc;n.</p>

<p>✔️ Cung cấp độ ẩm v&agrave; dưỡng chất cho da, bảo vệ da khỏi hiện tượng kh&ocirc; v&agrave; nứt nẻ trong m&ugrave;a đ&ocirc;ng lạnh gi&aacute;.</p>

<p>&nbsp;</p>

<p>✖️ C&Aacute;CH SỬ DỤNG: Thoa kem nhẹ nh&agrave;ng, đều l&ecirc;n da mặt, c&aacute;nh tay, ch&acirc;n v&agrave; to&agrave;n th&acirc;n. Sử dụng h&agrave;ng ng&agrave;y.</p>
', 1, 0, N'kem-duong-am-nivea-soft-duc', CAST(N'2021-08-18 10:40:15.017' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4103, N'Kem Tan Mỡ Missha Hot Burning Perfect Body Gel', N'Missha', N'/Uploads/images/product/pro70.jpg', N'/Uploads/images/product/pro70.jpg', 140000, N'Kem tan mỡ Missha Hot Burning Body Gel Hàn Quốc thẩm thấu nhanh và không gây khó chịu cho da, không ảnh hưởng xấu đến sức khỏe cũng như dị ứng đối với da nhạy cảm, được đánh giá cao bởi là biện pháp loại bỏ mỡ thừa hiệu quả, nhanh chóng lại an toàn, giúp bạn lấy lại vóc', 2099, N'<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>- Kem tan mỡ bụng Missha H&agrave;n Quốc với th&agrave;nh phần 100% từ thi&ecirc;n nhi&ecirc;n với cơ chế gi&uacute;p đốt n&oacute;ng, ph&aacute; vỡ li&ecirc;n kết tế b&agrave;o m&ocirc; mỡ thừa, k&iacute;ch th&iacute;ch qu&aacute; tr&igrave;nh trao đổi chất, hỗ trợ l&agrave;m tan c&aacute;c acid b&eacute;o tự do, ngăn chặn h&igrave;nh th&agrave;nh chất b&eacute;o mới, tự động đẩy lượng mỡ dư thừa theo đường b&agrave;i tiết mồ h&ocirc;i, nước tiểu,&hellip; đồng thời, gi&uacute;p x&oacute;a mờ đi những vết rạn da, gi&uacute;p l&agrave;n da s&aacute;ng mịn, săn chắc hơn, nhanh ch&oacute;ng lấy lại v&oacute;c d&aacute;ng săn chắc v&agrave; trẻ trung.</p>

<p>+ Đ&aacute;nh tan lượng mỡ thừa nhanh hơn nhờ cơ chế Cool &amp; Hot (lạnh-n&oacute;ng) : Với c&ocirc;ng thức đặc biệt được nghi&ecirc;n cứu bởi c&aacute;c chuy&ecirc;n gia da liễu đ&atilde; tạo ra hiệu ứng l&agrave;m lạnh da khi vừa mới b&ocirc;i gel nhờ chiết xuất từ l&aacute; bạc h&agrave;, ngay sau đ&oacute; chiết xuất capsaicin c&oacute; trong quả ớt sẽ t&aacute;c động l&agrave;m da n&oacute;ng ấm ngay sau đ&oacute;, với cơ chế n&agrave;y gi&uacute;p lượng mỡ thừa bị ph&acirc;n giải nhanh hơn v&agrave; được đ&agrave;o thải ra ngo&agrave;i cơ thể theo đường b&agrave;i tiết như mồ h&ocirc;i, nước tiểu, ....</p>

<p>+ Kiểm so&aacute;t sự h&igrave;nh th&agrave;nh v&agrave; t&iacute;ch tụ mỡ thừa nhờ chiết xuất từ cam đắng c&oacute; trong gel tan mỡ Missha loại bỏ những độ ẩm kh&ocirc;ng cần thiết.</p>

<p>+ Đặc biệt, th&agrave;nh phần biến đổi đ&aacute; ph&aacute;t nhiệt trong c&ocirc;ng nghệ nanosomes, kết hợp với muối v&agrave; kho&aacute;ng chất, gi&uacute;p loại bỏ vết rạn da, tế b&agrave;o da l&atilde;o h&oacute;a, thư gi&atilde;n cho da, da trở n&ecirc;n mịn m&agrave;ng v&agrave; mềm mại.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>- Bước 1: Sau khi tắm, lau sạch nước c&ograve;n đọng lại tr&ecirc;n da.</p>

<p>- Bước 2: Lấy 1 lượng kem missha vừa đủ thoa l&ecirc;n v&ugrave;ng cần l&agrave;m tan mỡ (eo, bụng, đ&ugrave;i, bắp tay,&hellip;), massage nhẹ nh&agrave;ng theo chiều kim đồng hồ.</p>

<p>&nbsp;</p>

<p>✖️ Lưu &yacute;:</p>

<p>- C&oacute; thể sử dụng nịt bụng hoặc kết hợp với tập thể dục sau khi thoa kem tan mỡ bụng Missha để hiệu quả sản phẩm nhanh hơn.</p>

<p>- Ng&agrave;y d&ugrave;ng 2 lần s&aacute;ng v&agrave; tối. N&ecirc;n sử dụng tối thiểu 3 tuần li&ecirc;n tiếp trở l&ecirc;n kết hợp với thể dục sẽ đem lại hiệu quả tối ưu.</p>
', 1, 0, N'kem-tan-mo-missha-hot-burning-perfect-body-gel', CAST(N'2021-08-18 10:42:16.610' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4104, N'Nước cân bằng dành cho da dầu La Roche Posay Effaclar Astringent Lotion 200ml', N'La Roche-posay', N'/Uploads/images/product/pro71.jpg', N'/Uploads/images/product/pro71.jpg', 300000, N'Nước cân bằng giàu khoáng dành cho da dầu La Roche Posay Effaclar Astringent Lotion 200ml với thành phần chính từ nước khoáng thiên nhiên, không chứa các thành phần độc hại, làm dịu mát da và chống tại các tác nhân gây lão hóa. Sản phẩm giúp cân bằng độ pH, cấp ẩm cho da mềm mại. ', 2098, N'<p>Nước c&acirc;n bằng gi&agrave;u kho&aacute;ng d&agrave;nh cho da dầu La Roche Posay Effaclar Astringent Lotion 200ml với th&agrave;nh phần ch&iacute;nh từ nước kho&aacute;ng thi&ecirc;n nhi&ecirc;n, kh&ocirc;ng chứa c&aacute;c th&agrave;nh phần độc hại, l&agrave;m dịu m&aacute;t da v&agrave; chống tại c&aacute;c t&aacute;c nh&acirc;n g&acirc;y l&atilde;o h&oacute;a. Sản phẩm gi&uacute;p c&acirc;n bằng độ pH, cấp ẩm cho da mềm mại. La Roche Posay Effaclar Astringent Lotion c&ograve;n l&agrave; giải ph&aacute;p l&agrave;m sạch s&acirc;u đến tận lỗ ch&acirc;n l&ocirc;ng, ngăn chặn sự t&iacute;ch tụ b&atilde; nhờn c&ugrave;ng dầu thừa v&agrave; giảm thiểu t&igrave;nh trạng tắc nghẽn lỗ ch&acirc;n l&ocirc;ng g&acirc;y n&ecirc;n mụn. Sản phẩm an to&agrave;n, ph&ugrave; hợp cho những bạn c&oacute; l&agrave;n da dầu nhạy cảm, kh&oacute; chọn Toner.</p>
', 1, 0, N'nuoc-can-bang-danh-cho-da-dau-la-roche-posay-effaclar-astringent-lotion-200ml', CAST(N'2021-08-18 10:44:26.087' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4105, N'Son Kem Lì Black Rouge Half N Half Water Velvet', N'Black Rouge', N'/Uploads/images/product/pro72.jpg', N'/Uploads/images/product/pro72.jpg', 0, N'Black Rouge Half N Half Water Velvet là dòng son kem lì. Ở phiên bản này, phần thiết kế vỏ ngoài được hãng phủ một lớp Coating Rubber nhám lì, nhìn bắt mắt, sờ mịn tay. Màu sắc trên thân son là màu son + tông pastel trendy, xinh xắn. Nắp son cả 5 màu đều có màu pastel giống nhau, bên trong có khớp vặn chắc chắn.', 2094, N'<p>- Bảng m&agrave;u:</p>

<p>HV01 - Bad Peanut: Cam nude</p>

<p>HV02 - Mood Pomegranate: Đỏ hồng lựu</p>

<p>HV03 - Burnt Red: Đỏ chili</p>

<p>HV04 - Litchi Temptation: Cam ch&aacute;y</p>

<p>HV05 - Chilli Addiction: Đỏ gạch đậm</p>

<p>&nbsp;</p>

<p>- Kết cấu chất son velvet cải tiến với c&ocirc;ng nghệ New Velvet cho độ mịn m&agrave;ng gi&uacute;p mang đến cảm gi&aacute;c nhẹ mịn mướt cho đ&ocirc;i m&ocirc;i</p>

<p>- C&ocirc;ng thức Slim Fit với khả năng b&aacute;m m&agrave;u tốt gi&uacute;p son l&ecirc;n m&ocirc;i chuẩn m&agrave;u mượt m&agrave;</p>

<p>- Son c&oacute; m&ugrave;i hương Black Cherry nhẹ nh&agrave;ng ngọt ng&agrave;o</p>
', 1, 0, N'son-kem-li-black-rouge-half-n-half-water-velvet', CAST(N'2021-08-18 10:47:33.800' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4106, N'Nước Hoa Hồng Some By Mi Snail Truecica Miracle Repair Toner 135ml', N'Some By Mi', N'/Uploads/images/product/pro73.jpg', N'/Uploads/images/product/pro73.jpg', 280000, N'Nước Hoa Hồng Cân Bằng Da, Giúp Da Săn Chắc Chiết Xuất Ốc Sên Some By Mi Snail Truecica Miracle Repair Toner là nước hoa hồng thuộc dòng Snail Truecica của thương hiệu Some By Mi giúp dưỡng ẩm và phục hồi da chứa 90% dịch nhầy ốc sên và các thành phần dưỡng trắng như Niacinamide, Arbutin, Glutathione không chỉ dưỡng ẩm mà còn cải thiện tình trạng thâm mụn một cách hiệu quả', 2098, N'<p>Thương hiệu: Some By Mi</p>

<p>Xuất xứ: H&agrave;n Quốc</p>

<p>Dung t&iacute;ch: 135ml</p>

<p>&nbsp;</p>

<p>- Hỗ trợ v&agrave; th&uacute;c đẩy qu&aacute; tr&igrave;nh tự phục hồi da hư tổn nhờ sự kết hợp ho&agrave;n hảo của ốc s&ecirc;n đen v&agrave; th&agrave;nh phần độc quyền Truecica</p>

<p>- Trong bảng th&agrave;nh phần c&ograve;n c&oacute; chứa 2% Niacinamide, Arbutin, Glutathione, flower complex gi&uacute;p l&agrave;m s&aacute;ng v&agrave; đều m&agrave;u c&aacute;c v&ugrave;ng da bị xỉn m&agrave;u v&agrave; cải thiện c&aacute;c vết th&acirc;m da mụn để lại</p>

<p>- Tăng cường h&agrave;ng r&agrave;o bảo vệ da v&agrave; cải thiện c&aacute;c vết th&acirc;m mụn một c&aacute;ch nhanh ch&oacute;ng</p>

<p>- Se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng, l&agrave;m đầy c&aacute;c vết sẹo rỗ, sẹo mụn v&agrave; cải thiện cấu tr&uacute;c của da</p>
', 1, 0, N'nuoc-hoa-hong-some-by-mi-snail-truecica-miracle-repair-toner-135ml', CAST(N'2021-08-18 10:49:39.440' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4107, N'Mascara Kiss Me Heroine Nhật Bản', N'Khác', N'/Uploads/images/product/pro74.jpg', N'/Uploads/images/product/pro74.jpg', 0, N'Kiss me isehan mascara phù hợp với mọi dạng lông mi, tạo một hàng mi dài gấp 1,5 lần hàng mi vốn có. Khả năng chống nước cao và thành phần chiết xuất từ hoa cúc tác dụng giữ ẩm và dầu hoa trà làm mềm giúp bờ mi trông sẽ không bị khô hay làm cứng mi như các sản phẩm mascara thông thường khác.', 2104, N'<p>- Chuốt mi Kiss Me Heroine Mascara ghi điểm với chất mascara đều đặn, kh&ocirc;ng l&agrave;m v&oacute;n cục hay l&agrave;m nặng mi. Khả năng chống nước, l&acirc;u tr&ocirc;i, kh&ocirc;ng lem gi&uacute;p c&aacute;c n&agrave;ng y&ecirc;n t&acirc;m suốt cả buổi tiệc với đ&ocirc;i mắt lu&ocirc;n cuốn h&uacute;t.</p>

<p>- Th&agrave;nh phần c&oacute; bổ sung dưỡng chất gi&uacute;p mi chắc khỏe, kh&ocirc;ng bị g&atilde;y rụng từ s&aacute;p ong, s&aacute;p vi tinh, dầu hoa tr&agrave;, chiết xuất hoa c&uacute;c&hellip;, kh&ocirc;ng chỉ make-up cho đ&ocirc;i mi quyến rũ, Kiss Me Heroine Mascara c&ograve;n gi&uacute;p chăm dưỡng l&agrave;n mi ph&aacute;i đẹp.</p>

<p>- Thiết kế đầu cọ cong nhẹ gi&uacute;p dễ d&agrave;ng chải đều mi ở cả những g&oacute;c mắt, c&ocirc;ng thức cải tiến từ Nhật Bản gi&uacute;p giữ mi cong v&uacute;t trong thời gian d&agrave;i.</p>
', 1, 0, N'mascara-kiss-me-heroine-nhat-ban', CAST(N'2021-08-18 10:53:20.373' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4108, N'Kem nền Cellio Collagen Blemish Balm B.B SPF 40 PA+++', N'Khác', N'/Uploads/images/product/pro75.jpg', N'/Uploads/images/product/pro75.jpg', 0, N'Kem nền BB Cellio Collagen có chứa SPF 40, PA + + có tác dụng ưu việt chống tia UVA/UVB từ ánh nắng mặt trời giúp cho những làn da hô hấp dễ dàng cả ngày, ngăn ngừa sự sản sinh các vết thâm và nám, tàn nhang trên gương mặt, để giúp cho bạn có một àn da tươi tắn và mịn màng ', 2095, N'<p>- H&atilde;ng: Cellio</p>

<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>- Dung t&iacute;ch: 40gr</p>

<p>- Ph&acirc;n loại: 2 tone m&agrave;u</p>

<p>+ Tone 21: T&ocirc;ng s&aacute;ng d&agrave;nh cho những c&ocirc; n&agrave;ng c&oacute; l&agrave;n da s&aacute;ng, trắng.</p>

<p>+ Tone 23: T&ocirc;ng da d&agrave;nh cho những c&ocirc; n&agrave;ng c&oacute; l&agrave;n da tự nhi&ecirc;n, da ngăm.</p>

<p>&nbsp;</p>

<p>- Th&agrave;nh phần:</p>

<p>+ Th&agrave;nh phần chứa tới 90% Collagen tự nhi&ecirc;n chiết xuất từ da động vật ngăn ngừa mụn, t&agrave;n nhan, chống nhăn v&agrave; l&atilde;o h&oacute;a da.</p>

<p>+ Th&agrave;nh phần gi&agrave;u chất dưỡng ẩm nu&ocirc;i dưỡng da mịn m&agrave;ng, mệt mướt từ b&ecirc;n trong.</p>

<p>&nbsp;</p>

<p>- T&aacute;c dụng: Theo như tr&ecirc;n bao b&igrave; của h&atilde;ng sản xuất c&oacute; ghi th&igrave; BB Cellio c&oacute; 4 t&aacute;c dụng: L&agrave;m trắng da, Bảo vệ v&agrave; chống tia tử ngoại, chống nhăn v&agrave; chống l&atilde;o h&oacute;a, độ che phủ cực kỳ tốt.</p>

<p>+ Sử dụng BB Collagen Cellio cho bạn một lớp nền cực kỳ trắng, s&aacute;ng v&agrave; mịn m&agrave;ng.</p>

<p>+ Th&agrave;nh phần Collagen l&agrave; dưỡng chất quan trọng chống lại nếp nhăn, l&atilde;o h&oacute;a da, gi&uacute;p căng da, phụ hồi c&aacute;c vết tổn thương tr&ecirc;n da đồng thời l&agrave;m trẻ h&oacute;a l&agrave;n da. + Dưỡng ẩm da, kiềm dầu rất tốt, cho da lu&ocirc;n được mịn m&agrave;ng, ẩm mượt.</p>

<p>+ Khả năng chống nắng vượt trội với chỉ số SPF 40 PA+++ bảo vệ da khỏi t&aacute;c hại của tia UV.</p>

<p>+ BB Collio c&oacute; độ che phủ cực kỳ tốt, kh&ocirc;ng k&eacute; c&aacute;c d&ograve;ng phấn che phủ hiện nay. C&oacute; thể che được cả những nốt mụn to, lỗ ch&acirc;n l&ocirc;ng.</p>
', 1, 0, N'kem-nen-cellio-collagen-blemish-balm-bb-spf-40-pa', CAST(N'2021-08-18 10:57:06.927' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4109, N'Mặt Nạ Mắt JM-Solution Eye Patch 60 Pcs', N'Jmsolution', N'/Uploads/images/product/pro76.jpg', N'/Uploads/images/product/pro76.jpg', 0, N'Mặt Nạ Mắt Trị Thâm JM-Solution Eye Patch 60 Pcs rất thích hợp với các bạn hay phải sử dụng máy tính và thức đêm. Khi cảm thấy căng thẳng, việc đắp mắt sẽ mang lại sinh khí cho đôi mắt của bạn.', 2107, N'<p>- Quy c&aacute;ch: 60 miếng.</p>

<p>- Xuất xứ: JM Solution - H&agrave;n Quốc.</p>

<p>- Ph&acirc;n loại:</p>

<p>+ Xanh: dưỡng s&aacute;ng v&ugrave;ng mắt, giảm quầng th&acirc;m v&agrave; bọng mắt, cấp ẩm.</p>

<p>+ Đen: chống l&atilde;o ho&aacute;, xo&aacute; nhăn, cấp ẩm.</p>

<p>&nbsp;</p>

<p>✖️ CHI TIẾT:</p>

<p>- <strong>Xanh</strong>: Marine Luminious Pearl Deep Moisture Eye Patch.</p>

<p>+ &ldquo;Cứu tinh&rdquo; dưỡng ẩm v&ugrave;ng mắt đ&acirc;y rồi c&aacute;c n&agrave;ng ơi. Sản phẩm c&oacute; chứa rất nhiều dưỡng chất từ đại dương s&acirc;u (Rong biển, tảo biển&hellip;). Ngo&agrave;i c&ocirc;ng dụng dưỡng ẩm th&igrave; em ấy c&ograve;n sở hữu khả năng ngăn chặn sự l&atilde;o h&oacute;a của v&ugrave;ng da quanh mắt nữa đ&oacute;.</p>

<p>+ Chiết xuất ngọc trai c&oacute; chứa 20 loại axit amin gi&uacute;p cho bạn cải thiện kết cấu da v&agrave; bổ sung độ ẩm hiệu quả. B&ecirc;n cạnh đ&oacute;, em ấy c&ograve;n sở hữu khả năng giảm stress v&agrave; l&agrave;m s&aacute;ng v&ugrave;ng da sạm m&agrave;u. Gi&uacute;p bạn trẻ h&oacute;a v&ugrave;ng da xung quanh mắt nhanh ch&oacute;ng.</p>

<p>- <strong>Đen</strong>: Honey Luminious Royal Propolis Eye Patch.</p>

<p>+ Sản phẩm sở hữu th&agrave;nh phần mật ong được lấy tr&ecirc;n n&uacute;i Jiri c&oacute; t&aacute;c dụng dưỡng s&acirc;u v&agrave; bảo vệ da v&ugrave;ng da xung quanh mắt khỏi những t&aacute;c động xấu từ m&ocirc;i trường.</p>

<p>+ Keo ong xanh c&oacute; chứa hợp chất Artepillin C sẽ gi&uacute;p loại bỏ c&aacute;c tế b&agrave;o yếu, để l&agrave;n da bạn trở n&ecirc;n rạng rỡ v&agrave; khỏe mạnh.</p>

<p>+ Sữa ong ch&uacute;a sẽ gi&uacute;p l&agrave;m chậm qu&aacute; tr&igrave;nh l&atilde;o h&oacute;a v&agrave; cải thiện độ đ&agrave;n hồi cho da.</p>
', 1, 0, N'mat-na-mat-jm-solution-eye-patch-60-pcs', CAST(N'2021-08-18 11:02:38.680' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4110, N'Thanh lăn tẩy mụn đầu đen thần kỳ Mamonde Pore Clean Blackhead Stick', N'Khác', N'/Uploads/images/product/pro77.jpg', N'/Uploads/images/product/pro77.jpg', 150000, N'Mamonde Pore Clean Blackhead Stick chứa các thành phần tự nhiên với 99% chiết xuất từ lá rau diếp nhằm làm sạch sâu, xóa bỏ dầu thừa và mụn đầu đen, mụn cám hiệu quả.', 2107, N'<p>✖️ Ưu điểm:</p>

<p>✔️ Trị mụn đầu đen, mụn c&aacute;m</p>

<p>✔️ Kh&ocirc;ng k&iacute;ch ứng da, an to&agrave;n cho da</p>

<p>✔️ Tẩy tế b&agrave;o chết</p>

<p>&nbsp;</p>

<p>✖️ C&ocirc;ng dụng:</p>

<p>✔️ Sản phẩm với h&agrave;ng ng&agrave;n hạt massage c&ugrave;ng tinh chất chiết xuất gi&uacute;p se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng v&agrave; ngăn ngừa mụn c&aacute;m, mụn đầu đen hiệu quả, l&agrave;m sạch s&acirc;u, cho da th&ocirc;ng tho&aacute;ng v&agrave; sạch sẽ nhất. Ngo&agrave;i ra, c&aacute;c tinh chất từ gạo v&agrave; đậu n&agrave;nh c&ograve;n gi&uacute;p da bạn l&ecirc;n t&ocirc;ng.</p>

<p>✔️ Một điều nữa khiến m&igrave;nh th&iacute;ch ở sản phẩm n&agrave;y l&agrave; n&oacute; c&ograve;n được sử dụng như một sản phẩm tẩy tế b&agrave;o chết cho da. Chuẩn chức năng 2 trong 1 phải kh&ocirc;ng n&agrave;o.</p>

<p>✔️ Tuy nhi&ecirc;n, để thanh tẩy trị mụn đầu đen Pore Clean Blackhead Stick n&agrave;y c&oacute; t&aacute;c dụng tr&ecirc;n da bạn th&igrave; cần &iacute;t nhất 1-2 tuần, chứ kh&ocirc;ng hiệu quả từ lần đầu như quảng c&aacute;o. V&igrave; thế, nếu bạn mới sử dụng chỉ 1-2 lần m&agrave; chưa thấy chưa đạt hiệu quả như mong đợi th&igrave; cũng đừng nản ch&iacute; nh&eacute;.</p>

<p>&nbsp;</p>

<p>✖️ Hướng dẫn sử dụng:</p>

<p>- Bước 1: Rửa sạch mặt với sửa rửa mặt dịu nhẹ</p>

<p>- Bước 2: D&ugrave;ng Thanh lăn trị mụn Mamonde Pore Clean Blackhead Stick massage nhẹ nh&agrave;ng v&agrave; đều đặn l&ecirc;n v&ugrave;ng c&oacute; mụn c&aacute;m, mụn đầu đen trong khoảng 1-2 ph&uacute;t. Lưu &yacute; l&agrave; chỉ massage nhẹ nh&agrave;ng, tr&aacute;nh đ&egrave; mạnh qu&aacute; sẽ l&agrave;m tổn thương v&ugrave;ng da mụn.</p>

<p>- Bước 3: Rửa mặt lại bằng nước ấm</p>

<p>&nbsp;</p>

<p>✖️ Lưu &yacute;: N&ecirc;n sử dụng sản phẩm n&agrave;y kh&ocirc;ng qu&aacute; 2 lần mỗi ng&agrave;y để tr&aacute;nh g&acirc;y đau r&aacute;t hoặc g&acirc;y k&iacute;ch ứng da.</p>
', 1, 0, N'thanh-lan-tay-mun-dau-den-than-ky-mamonde-pore-clean-blackhead-stick', CAST(N'2021-08-18 11:05:54.277' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4111, N'Kem mắt Meishoku whitening eye cream 30g', N'Khác', N'/Uploads/images/product/pro78.jpg', N'/Uploads/images/product/pro78.jpg', 210000, N'Kem mắt Meshoku của Nhật tuýp màu xanh 30g bổ sung nhau thai+ vitamin E tác dụng dưỡng ẩm cho vùng da quanh mắt, trị nhăn mắt, bọng mắt và chống lão hóa cực hay.', 2107, N'<p>&nbsp;</p>

<p>- Sản xuất: Meshoku</p>

<p>- Quy c&aacute;ch: tu&yacute;p 30g</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>- Chiết xuất nhau thai c&ugrave;ng vitamin E ngấm s&acirc;u v&agrave;o da, ngăn chặn sự sản xuất melanin</p>

<p>&ndash; kẻ th&ugrave; g&acirc;y n&ecirc;n những vấn đề sắc tố tr&ecirc;n da, gi&uacute;p v&ugrave;ng da quanh mắt trắng s&aacute;ng, chống lại sự xỉn m&agrave;u.</p>

<p>+ Nhau thai v&agrave; vitamin E cũng được biết đến với khả năng chống oxi h&oacute;a, chống l&atilde;o h&oacute;a tuyệt vời. Ch&uacute;ng th&uacute;c đẩy qu&aacute; tr&igrave;nh trao đổi chất v&agrave; tăng tuần ho&agrave;n m&aacute;u dưới da.</p>

<p>+ Trị quầng th&acirc;m mắt, ngăn chặn sự xuất hiện của c&aacute;c vết đồi mồi, đốm n&acirc;u.</p>

<p>+ Cải thiện nếp nhăn, đường fine line g&acirc;y ra bởi sự kh&ocirc; da, m&aacute;u k&eacute;m lưu th&ocirc;ng.</p>

<p>+ Chất kem d&agrave;y, khả năng dưỡng ẩm tuyệt vời với collagen, glycerin.</p>

<p>+ Chiết xuất từ hạt &yacute; dĩ gi&uacute;p l&agrave;m trắng, dưỡng ẩm, ngăn ngừa sự th&ocirc; r&aacute;p của da.</p>

<p>+ Cung cấp độ ẩm, độ đ&agrave;n hồi, loại bỏ sự mệt mỏi cho đ&ocirc;i mắt.</p>

<p>+ L&agrave;m giảm sự chảy xệ, l&agrave;m săn chắc v&ugrave;ng da quanh mắt.</p>

<p>+ Cho cảm gi&aacute;c tươi m&aacute;t khi sử dụng, c&oacute; m&ugrave;i thơm nhẹ nh&agrave;ng, dễ chịu.</p>

<p>+ Sử dụng tốt cho cả v&ugrave;ng quanh miệng.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>- Sử dụng v&agrave;o bước cuối c&ugrave;ng khi chăm s&oacute;c da (sau kem dưỡng).</p>

<p>- Lấy một lượng bằng hạt gạo kem mắt Meishoku ra đầu ng&oacute;n tay.</p>

<p>- Thoa đều l&ecirc;n v&ugrave;ng da xung quanh mắt hoặc miệng.</p>

<p>- Massage v&ugrave;ng da xung quanh mắt, massage kỹ những v&ugrave;ng da kh&ocirc;, vết ch&acirc;n chim hoặc th&acirc;m quầng.</p>

<p>- Sử dụng tốt nhất 2 lần/ng&agrave;y v&agrave;o mỗi buổi s&aacute;ng v&agrave; tối.</p>
', 1, 0, N'kem-mat-meishoku-whitening-eye-cream-30g', CAST(N'2021-08-18 11:08:10.390' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4112, N'SÁP DƯỠNG ẨM VASELINE 49G', N'Khác', N'/Uploads/images/product/pro79.jpg', N'/Uploads/images/product/pro79.jpg', 45000, N'Sáp dưỡng ẩm Vaseline e giúp bảo vệ da khỏi những tác động của thời tiết và hoạt động như chất hàn gắn cho các tế bào của da, ngăn cản sự mất nước của làn da.', 2107, N'<p>🖤🖤S&Aacute;P DƯỠNG ẨM VASELINE🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 45K</p>

<p>&nbsp;</p>

<p>✖️ XUẤT XỨ: Mỹ</p>

<p>✖️ THƯƠNG HIỆU: Vaseline</p>

<p>✖️ TRỌNG LƯỢNG: 49g</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ S&aacute;p dưỡng ẩm vaseline 100% pure petroleum jelly original gi&uacute;p m&ocirc;i bạn tr&ocirc;ng sẽ quyến rũ hơn, căng mộng hơn v&agrave; tươi tắn hơn.</p>

<p>✔️ C&oacute; t&aacute;c dụng chống nứt nẻ , kh&ocirc; da, dưỡng da lu&ocirc;n mềm mại căng mọng.</p>

<p>✔️ Dưỡng da ng&agrave;y v&agrave; đ&ecirc;m, gi&uacute;p da kh&ocirc;ng bị ảnh hưởng bởi m&ocirc;i trường v&agrave; &aacute;nh nắng.</p>

<p>✔️ L&agrave;m mềm lớp sừng; l&agrave;m l&agrave;nh c&aacute;c vết thương ngo&agrave;i da do da bị kh&ocirc;, nẻ.</p>

<p>✔️ Kh&ocirc;ng chứa hoá ch&acirc;́t đ&ocirc;̣c hại.</p>

<p>&nbsp;</p>

<p>✖️ Một v&agrave;i mẹo nhỏ khi d&ugrave;ng S&aacute;p dưỡng ẩm Vaseline:</p>

<p>1. Trước khi qu&eacute;t sơn m&oacute;ng tay, bạn c&oacute; thể thoa ch&uacute;t vaseline l&ecirc;n m&oacute;ng để tạo độ b&oacute;ng v&agrave; dưỡng m&oacute;ng chắc khỏe. Ngo&agrave;i ra, c&aacute;ch n&agrave;y c&ograve;n gi&uacute;p c&aacute;c n&agrave;ng dễ d&agrave;ng loại bỏ lớp sơn m&oacute;ng cũ.</p>

<p>2. Để tẩy tế b&agrave;o chết bằng vaseline, ph&aacute;i đẹp trộn loại kem n&agrave;y với đường n&acirc;u theo tỷ lệ 1:1 rồi ch&agrave; nhẹ nh&agrave;ng l&ecirc;n m&ocirc;i trong v&ograve;ng 60 gi&acirc;y. Phương ph&aacute;p n&agrave;y sẽ lấy đi những tết b&agrave;o kh&ocirc;ng c&ograve;n hoạt động, k&iacute;ch th&iacute;ch sự ph&aacute;t triển v&agrave; nu&ocirc;i dưỡng lớp tế b&agrave;o mới tr&ecirc;n m&ocirc;i.</p>

<p>3. Thoa một lớp mỏng loại kem n&agrave;y ở ch&acirc;n t&oacute;c trước khi nhuộm t&oacute;c sẽ gi&uacute;p bảo vệ da đầu khỏi những t&aacute;c hại của h&oacute;a chất từ thuốc nhuộm.</p>

<p>4. V&agrave;o m&ugrave;a đ&ocirc;ng, chị em c&oacute; thể ngăn chặn t&igrave;nh trạng da kh&ocirc;, r&aacute;p, nứt nẻ g&oacute;t ch&acirc;n bằng c&aacute;ch &aacute;p dụng vaseline l&ecirc;n da, đặc biệt l&agrave; những nơi như khuỷu tay, đầu gối nhằm cung cấp độ ẩm cần thiết, l&agrave;m mềm da nhanh ch&oacute;ng.</p>

<p>5. Thoa kem vaseline xung quanh m&oacute;ng tay trước khi d&ugrave;ng sơn m&oacute;ng nhằm tr&aacute;nh t&igrave;nh trạng sơn bị lem v&agrave; d&iacute;nh v&agrave;o da.</p>

<p>6. Trước khi xịt nước hoa, chị em &aacute;p dụng ch&uacute;t kem vaseline v&agrave;o cổ tay, ph&iacute;a sau tai, g&aacute;y&hellip; để lưu giữ m&ugrave;i hương l&acirc;u hơn.</p>

<p>7. D&ugrave;ng chổi nhỏ chuốt l&ocirc;ng mi với vaseline nhằm k&iacute;ch th&iacute;ch mi nhanh d&agrave;i v&agrave; rậm hơn.</p>

<p>8. Nếu th&iacute;ch bơi l&acirc;u, bạn d&ugrave;ng b&ocirc;ng thấm ch&uacute;t kem vaseline rồi nh&eacute;t v&agrave;o tai nhằm ngăn chặn nước v&agrave;o tai.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>&ndash; Chỉ d&ugrave;ng để b&ocirc;i b&ecirc;n ngo&agrave;i da. Kh&ocirc;ng d&ugrave;ng cho những vết thương hở v&agrave; s&acirc;u, vết thương do th&uacute; vật cắn hoặc vết bỏng nặng.</p>

<p>&ndash; Kh&ocirc;ng được để d&iacute;nh v&agrave;o mắt. Ngưng sử dụng v&agrave; hỏi &yacute; kiến b&aacute;c sĩ trong trường hợp l&agrave;n da kh&ocirc;ng cải thiện sau khi d&ugrave;ng sản phẩm 7 ng&agrave;y. Để xa tầm tay của trẻ em.</p>

<p>&ndash; B&ocirc;i trực tiếp l&ecirc;n v&ugrave;ng da kh&ocirc;, nức bạn sẽ thấy ngay hiệu quả.</p>

<p>&ndash; B&ocirc;i s&aacute;p v&agrave;o khuỷu tay, đầu gối, mắc c&aacute;, g&oacute;t ch&acirc;n, m&oacute;ng tay hoặc m&ocirc;i.</p>
', 1, 0, N'sap-duong-am-vaseline-49g', CAST(N'2021-08-18 11:10:51.630' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4113, N'Dầu Tẩy Trang Innisfree Apple Seed Oil 150ml', N'Innisfree', N'/Uploads/images/product/pro80.jpg', N'/Uploads/images/product/pro80.jpg', 230000, N'Innisfree Apple Seed Cleansing Oil là dạng dầu tẩy trang được chiêt xuất từ nước ép táo xanh nhẹ nhàng lấy đi mọi bụi bẩn, dầu thừa, lớp trang điểm...mà không gây kích ứng có khả năng chống oxy hóa giúp trẻ hóa làn da rạng ngời, hỗ trợ làm sáng da. ', 2105, N'<p>Xuất xứ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>&ndash; Với chiết xuất dầu t&aacute;o hữu cơ tr&aacute;i c&acirc;y, dầu tẩy trang ho&agrave;n to&agrave;n loại bỏ lớp trang điểm tr&ecirc;n da, l&agrave;m sạch s&acirc;u trong lỗ ch&acirc;n l&ocirc;ng l&agrave;m da trở n&ecirc;n s&aacute;ng hơn.</p>

<p>&ndash; Khi tiếp x&uacute;c với nước, sản phẩm biến th&agrave;nh dạng kem sữa, chứa chất l&agrave;m mềm da v&agrave; bảo vệ &ldquo;h&agrave;ng r&agrave;o&rdquo; hydro-lipid tr&ecirc;n da.</p>

<p>&ndash; D&ugrave;ng được cho cả mắt v&agrave; m&ocirc;i.</p>

<p>&ndash; L&agrave;n da trở n&ecirc;n sạch sẽ v&agrave; mềm mại sau khi sử dụng, kh&ocirc;ng hề l&agrave;m kh&ocirc; da.</p>

<p>&ndash; C&oacute; hương thơm dịu nhẹ.</p>
', 1, 0, N'dau-tay-trang-innisfree-apple-seed-oil-150ml', CAST(N'2021-08-18 11:12:37.550' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4114, N'Kem chống nắng Eucerin Oil Control 50ml', N'Khác', N'/Uploads/images/product/pro86.jpg', N'/Uploads/images/product/pro86.jpg', 300000, N'Gel Chống Nắng Cho Da Nhờn Mụn Eucerin Sun Gel-Cream Dry Touch Oil Control SPF50+ là kem chống nắng bảo vệ da hằng ngày nhờ thành phần màng lọc chống nắng phổ rộng, bảo vệ da khỏi tia UVA - UVB tối ưu trong thời gian dài với SPF50+.', 2101, N'<p>- C&ocirc;ng thức chứa L-Carnitine điều tiết b&atilde; nhờn v&agrave; kết hợp 3 sắc tố hấp thụ lipid gi&uacute;p tạo lớp phủ kh&ocirc; k&eacute;o d&agrave;i tr&ecirc;n da ngay cả khi thời tiết n&oacute;ng ẩm.</p>

<p>- Kh&ocirc;ng g&acirc;y tắc lỗ ch&acirc;n l&ocirc;ng, kh&ocirc;ng chứa hương liệu v&agrave; paraben, l&agrave; lớp kem nền l&yacute; tưởng khi trang điểm.</p>

<p>- Kem chống nắng kiểm so&aacute;t nhờn cho da dầu mụn Eucerin Sun Gel-Creme Oil Control Dry Touch SPF 50+ mang c&ocirc;ng nghệ quang phổ ti&ecirc;n tiến của Eucerin gi&uacute;p ngăn chặn tia UVA / UVB v&agrave; tia HEVIS. Kem chống nắng cũng bảo vệ ADN bằng c&aacute;ch hỗ trợ cơ chế bảo vệ v&agrave; t&aacute;i tạo ADN của da.</p>

<p>- Kem chống nắng kiềm dầu Eucerin Sun Cream SPF 50+ kh&ocirc;ng c&oacute; m&ugrave;i thơm v&agrave; c&oacute; kết cấu si&ecirc;u nhẹ, kh&ocirc;ng nhờn r&iacute;t. C&aacute;c nghi&ecirc;n cứu l&acirc;m s&agrave;ng v&agrave; da liễu chứng minh th&iacute;ch hợp với l&agrave;n da nhạy cảm v&agrave; dễ bị mụn trứng c&aacute;.</p>

<p>&nbsp;</p>

<p>- Với c&aacute;c th&agrave;nh phần:</p>

<p>+ Licocalcone A &amp; CA gi&uacute;p giải quyết 80% tổn hại từ 45% tia UVA vẫn xuy&ecirc;n qua da.</p>

<p>+ Carnitine gi&uacute;p kiểm so&aacute;t dầu v&agrave; ngăn ngừa mụn được chứng minh giảm 86% b&atilde; nhờn tr&ecirc;n da mặt.</p>

<p>+ Kh&ocirc;ng chứa c&aacute;c th&agrave;nh phần g&acirc;y b&iacute;t tắt lỗ ch&acirc;n l&ocirc;ng.</p>

<p>Sản phẩm được sản xuất chuy&ecirc;n biệt cho da nhờn v&agrave; dễ bị mụn.</p>
', 1, 0, N'kem-chong-nang-eucerin-oil-control-50ml', CAST(N'2021-08-18 11:15:24.810' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4115, N'Phấn Nước April Skin Magic Snow Cushion Chống Nắng SPF 50++', N'Aprilskin', N'/Uploads/images/product/pro81.jpg', N'/Uploads/images/product/pro81.jpg', 0, N'Phấn nước AprilSkin Magic Snow Cushion SPF 50++ PA+++ 15gr có xuất xứ từ Hàn Quốc đã được cập nhật tại hệ thống mỹ phẩm chính hãng Beauty Garden. Là phấn nước tác dụng 3 trong 1, April Magic Snow Cushion SPF 50++ PA+++ vừa là phấn phủ, vừa là kem nền và vừa là kem che khuyết điểm cực tốt.', 2095, N'<p>🖤🖤Phấn Nước April Skin Magic Snow Cushion Chống Nắng SPF 50++🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 275K</p>

<p>&nbsp;</p>

<p>✖️ XUẤT XỨ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>✖️ ƯU ĐIỂM VƯỢT TRỘI:</p>

<p>+ Khả năng che phủ ho&agrave;n hảo gi&uacute;p che phủ cực tốt c&aacute;c khuyết điểm tr&ecirc;n da.</p>

<p>+ Duy tr&igrave; lớp trang điểm trong thời gian d&agrave;i m&agrave; kh&ocirc;ng xảy ra hiện tượng xuống t&ocirc;ng khiến khu&ocirc;n mặt bị tối.</p>

<p>+ Phấn tạo cảm gi&aacute;c da mướt, mượt m&agrave; kh&ocirc;ng bị m&ocirc;́c hay kh&ocirc; da.</p>

<p>+ Độ kiềm dầu tốt, ph&ugrave; hợp với cả bạn da dầu hay hỗn hợp dầu đến da thường.</p>

<p>+ Kết cấu kem mềm mỏng mịn gi&uacute;p tăng khả năng b&aacute;m tr&ecirc;n da v&agrave; kh&ocirc;ng bị bết d&iacute;nh, lớp nền cushion mỏng nhẹ, th&iacute;ch hợp với kiểu trang điểm trong suốt</p>

<p>+ Chỉ số chống nắng cao SPF 50++</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>- Trước khi sử dụng phấn nước April Skin Magic Snow c&aacute;c bạn c&oacute; thể vệ sinh mặt sạch bằng tẩy trang v&agrave; sữa rửa mặt rồi đến c&aacute;c bước dưỡng như nước hoa hồng,tinh chất...</p>

<p>- Sau đi đợi 3 -5 ph&uacute;t cho c&aacute;c chất dưỡng thẩm thấu v&agrave;o da rồi mới sử dụng phấn nước.</p>
', 1, 0, N'phan-nuoc-april-skin-magic-snow-cushion-chong-nang-spf-50', CAST(N'2021-08-18 11:19:41.453' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4116, N'Phấn nước Klavuu', N'Khác', N'/Uploads/images/product/pro82.jpg', N'/Uploads/images/product/pro82.jpg', 0, N'Phấn nước Klavuu Urban Pearlsation High Coverage Tension Cushion với  những ưu điểm tuyệt vời cùng khả năng che khuyết điểm siêu tốt. Sản phẩm có chất phấn cực mỏng và nhẹ như nước, giúp che đi được tối đa những khuyết điểm mà không hề tạo cảm giác bí da', 2095, N'<p>- Thương hiệu: Klavuu</p>

<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>- Ph&acirc;n loại:</p>

<p>+ Xanh: Da kh&ocirc;, da thường</p>

<p>+ X&aacute;m: Da dầu, da hỗn hợp</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>- Klavuu, một thương hiệu K-beauty g&acirc;y x&ocirc;n xao ở H&agrave;n Quốc với tất cả c&aacute;c celeb v&agrave; blogger l&agrave;m đẹp, được ra mắt đầu năm 2016. Mặc d&ugrave; mới xuất hiện nhưng h&atilde;ng đ&atilde; nhanh ch&oacute;ng chiếm được sự y&ecirc;u th&iacute;ch của c&aacute;c t&iacute;n đồ l&agrave;m đẹp tr&ecirc;n to&agrave;n thế giới. Klavuu l&agrave; một thương hiệu tập trung v&agrave;o sức mạnh của chiết xuất ngọc trai tự nhi&ecirc;n để l&agrave;m s&aacute;ng v&agrave; dưỡng ẩm cho da. Tất cả c&aacute;c sản phẩm của họ đều chứa ngọc trai, một trong những th&agrave;nh phần chăm s&oacute;c da đ&atilde; được thử nghiệm kiểm chứng được sử dụng trong nhiều thế kỷ để l&agrave;m s&aacute;ng v&agrave; hydrat h&oacute;a l&agrave;n da. Klavuu l&agrave;m sống lại kh&aacute;i niệm n&agrave;y nhưng cũng đẩy mạnh n&oacute; l&ecirc;n bằng c&aacute;ch kết hợp th&ecirc;m c&aacute;c xu hướng v&agrave; c&ocirc;ng nghệ chăm s&oacute;c da mới nhất.</p>

<p>&nbsp;</p>

<p>- Klavuu BLUE PEARLSATION High Coverage Marine Collagen Aqua Cushion (XANH):</p>

<p>+ Tạo hiệu ứng da căng b&oacute;ng trong trẻo như hồ nước nơi &ldquo;Ốc đảo&rdquo; Oasis</p>

<p>+ Độ cover tốt, l&acirc;u tr&ocirc;i m&agrave; vẫn đảm bảo dưỡng ẩm cho da</p>

<p>+ 3 chức năng trong 1 sản phẩm: l&agrave;m trắng, chống nắng, cải thiện nếp nhăn.</p>

<p>+ &ldquo;NẠP&rdquo; nước v&agrave; độ ẩm cho da.</p>

<p>+ Cho bạn một lớp nền như &yacute; muốn với độ cover tốt, tự nhi&ecirc;n, c&oacute; thể dặm nhiều lớp cho đến khi được lớp nền cuối c&ugrave;ng thật ưng &yacute;.</p>

<p>&nbsp;</p>

<p>- KLAVUU URBAN PEARLSATION HIGH COVERAGE TENSION CUSHION (X&Aacute;M):</p>

<p>+ Phấn nước Klavuu Urban Cushion với độ che phủ tuyệt vời, gi&uacute;p che hết mọi khuyết điểm tr&ecirc;n l&agrave;n da của bạn, để lại một lớp nền mịn đẹp tự nhi&ecirc;n.</p>

<p>+ Th&agrave;nh phần trong Klavuu Urban Cushion gi&uacute;p giữ ẩm cho da, kh&ocirc;ng để da bị kh&ocirc; r&aacute;t, bong tr&oacute;c, tuy nhi&ecirc;n lại đủ để kiềm dầu, kh&ocirc;ng để b&oacute;ng nhờn.</p>

<p>+ Klavuu Urban Cushion gi&uacute;p bạn c&oacute; thể tiết kiệm thời gian hơn rất nhiều, v&igrave; n&oacute; c&oacute; thể thay thế kem l&oacute;t, kem nền, kem dưỡng ẩm v&agrave; cả kem chống nắng.</p>

<p>+ Với chỉ số SPF50 PA+++ th&igrave; chắc chắn c&aacute;c bạn đ&atilde; đủ tự tin để ra đường m&agrave; kh&ocirc;ng cần b&ocirc;i kem chống nắng</p>
', 1, 0, N'phan-nuoc-klavuu', CAST(N'2021-08-18 11:24:24.007' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4117, N'Tinh Chất Tái Tạo Da Red Peel Tingle Serum', N'Khác', N'/Uploads/images/product/pro83.jpg', N'/Uploads/images/product/pro83.jpg', 0, N'Tinh chất tái tạo da Red Peel Tingle Serum là 1 trong những sản phẩm tẩy tế bào chết hóa học của thương hiệu So’Natural. Phương pháp tẩy tế bào chết hóa học này cho phép tinh chất len lỏi vào tận từng lỗ chân lông, đào thải tế bào chết, dầu thừa, bụi bẩn còn vương trên da, đồng thời kích thích sản sinh tế bào mới khỏe và hồng hào hơn', 2103, N'<p>- Loại da ph&ugrave; hợp:</p>

<p>+ Da dầu, da bị mụn (mụn đầu đen, mụn trứng c&aacute;, mụn bọc)</p>

<p>+ Da th&acirc;m, da sẹo mụn, da c&oacute; lỗ ch&acirc;n l&ocirc;ng to</p>

<p>+ Da kh&ocirc;, da l&atilde;o h&oacute;a, da sạm m&agrave;u, da kh&ocirc;ng đều m&agrave;u</p>

<p>&nbsp;</p>

<p>1. Chai 35ml - C&ocirc;ng dụng:</p>

<p>+ C&aacute;c dưỡng chất c&oacute; chứa trong Serum khi thẩm thấu v&agrave;o da sẽ k&iacute;ch th&iacute;ch c&aacute;c tế b&agrave;o mới&nbsp;những tế b&agrave;o chứa &iacute;t melanin hơn, gi&uacute;p t&aacute;i sinh nhanh ch&oacute;ng để thay thế lớp tế b&agrave;o cũ n&agrave;y. Trả lại cho bạn một l&agrave;n da tươi mới hơn, mịn m&agrave;ng hơn v&agrave; trắng s&aacute;ng hơn</p>

<p>+ Serum c&oacute; chứa th&agrave;nh phần AHA &amp; BHA ,chiết xuất từ c&aacute;c loại d&acirc;u rừng v&agrave; Aronia. Đ&oacute; l&agrave; nh&oacute;m c&aacute;c acid c&oacute; nguồn gốc từ thi&ecirc;n nhi&ecirc;n v&agrave; c&oacute; nhiều t&aacute;c dụng cải thiện t&igrave;nh trạng mụn, hỗ trợ điều trị th&acirc;m mụn, cải thiện đ&aacute;ng kể c&aacute;c nếp nhăn li ti v&agrave; l&agrave;m căng mịn da</p>

<p>+ Red Peel Tingle Serum gi&uacute;p kh&aacute;ng vi&ecirc;m, giảm sưng mụn, l&agrave;m mờ vết th&acirc;m sẹo mụn</p>

<p>+ Gi&uacute;p da sản sinh c&aacute;c tế b&agrave;o mới v&agrave; cải thiện bề mặt da l&agrave;m s&aacute;ng da, đều m&agrave;u da</p>

<p>+ Bảo vệ, tăng cường sự ph&aacute;t triển của biểu b&igrave;. N&acirc;ng cao chất lượng của c&aacute;c sợi Elastin v&agrave; collagen</p>

<p>+ Gi&uacute;p bạn lấy lại vẻ đẹp khỏe khoắn, tươi mới v&agrave; trẻ trung hơn một c&aacute;ch dễ d&agrave;ng, đơn giản v&agrave; tiết kiệm hơn</p>

<p>&nbsp;</p>

<p>- Th&agrave;nh phần:</p>

<p>+ AHA: Hoạt chất h&oacute;a học c&oacute; t&aacute;c dụng bong tẩy tế b&agrave;o chết tr&ecirc;n da.</p>

<p>+ BHA: Cũng l&agrave; một hoạt chất gi&uacute;p l&agrave;m sạch s&acirc;u, loại bỏ vi khuẩn, tạp chất, tế b&agrave;o chết từ s&acirc;u trong lỗ ch&acirc;n l&ocirc;ng, gi&uacute;p lỗ ch&acirc;n l&ocirc;ng th&ocirc;ng tho&aacute;ng, ngăn chặn sự h&igrave;nh th&agrave;nh mụn. N&oacute; c&ograve;n c&oacute; thể lấy đi mụn c&aacute;m, mụn ẩn v&agrave; mụn đầu đen.</p>

<p>+ Chiết xuất c&aacute;c loại d&acirc;u rừng v&agrave; Aronia: K&iacute;ch th&iacute;ch t&aacute;i tạo da bề mặt da, l&agrave;m s&aacute;ng da, hỗ trợ trị th&acirc;m mụn hiệu quả, an to&agrave;n từ tự nhi&ecirc;n.</p>

<p>+ Red Peel Tingle Serum ph&ugrave; hợp với những người c&oacute; bề mặt da th&ocirc;, sần s&ugrave;i, kh&ocirc;ng được nhẵn mịn, da bị sạm đen, c&oacute; nhiều mụn c&aacute;m v&agrave; lỗ ch&acirc;n l&ocirc;ng c&oacute; xu hướng bị to ra. Th&ocirc;ng thường, những loại da như thế n&agrave;y l&agrave; bị mất c&acirc;n bằng độ ẩm dẫn đến da bị kh&ocirc;, mất nước.</p>

<p>&nbsp;</p>

<p>2. Tu&yacute;p 20ml:</p>

<p>- Với thiết kế dạng tu&yacute;p đơn giản v&agrave; th&ocirc;ng dụng. Sẽ gi&uacute;p cho c&aacute;c n&agrave;ng dễ d&agrave;ng lấy lượng dung dịch vừa đủ để d&ugrave;ng cho da mặt, chỉ trong một lần lấy.</p>

<p>- M&agrave;u sắc hợp chất Red Peel Tingle Serum 20ml ko thay đổi. Hợp chất m&agrave;u t&iacute;m kđậm chứa đầy những dưỡng chất th&iacute;ch hợp cho da như AHA v&agrave; BHA, c&ugrave;ng những loại dưỡng chất kh&aacute;c ph&ugrave; hợp cho việc t&aacute;i sinh l&agrave;n da một c&aacute;ch nhanh ch&oacute;ng.</p>

<p>- Tuy nhi&ecirc;n, hợp chất Red Peel Tingle Serum 20ml được sản xuất với dạng ph&acirc;n tử si&ecirc;u lỏng. Dễ d&agrave;ng len lỏi v&agrave;o da gấp đ&ocirc;i so với mẫu Red Peel Tingle Serum 35ml. Điều đ&oacute; gi&uacute;p l&agrave;n da được t&aacute;i tạo một c&aacute;ch thần tốc hơn.</p>

<p>- Nếu ở mẫu Red Peel Tingle Serum 35ml n&agrave;ng sẽ cảm thấy ch&acirc;m ch&iacute;ch khi massa từ 1-2 ph&uacute;t. Th&igrave; đối với Red Peel Tingle Serum 20ml n&agrave;ng sẽ cảm thấy da m&igrave;nh phản ứng ngay trực tiếp với hợp chất. Da n&agrave;ng sẽ căng l&ecirc;n trong l&uacute;c massa v&agrave; x&atilde;y ra hiện tượng ch&acirc;m ch&iacute;ch. V&igrave; hợp chất Red Peel Tingle Serum 20ml đang hoạt động hết c&ocirc;ng xuất của m&igrave;nh. Len lỏi v&agrave;o từng lổ ch&acirc;n l&ocirc;ng tr&ecirc;n da mặt, lấy đi lượng da thừa, v&agrave; những bụi bẩn v&agrave; nhẹ nh&agrave;ng se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng. Khiến những mụn đầu đen, mụn đầu trắng cứng đầu trồi l&ecirc;n. Những mụn vi&ecirc;m kh&oacute; g&acirc;y nhức nhối, kh&oacute; chịu cho c&aacute;c n&agrave;ng sẽ được l&agrave;m dịu v&agrave; kh&ocirc; c&ograve;i</p>
', 1, 0, N'tinh-chat-tai-tao-da-red-peel-tingle-serum', CAST(N'2021-08-18 11:30:17.047' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4118, N'Kem Dưỡng Trắng Da Bông Cải Xanh Ladykin 60ML', N'Khác', N'/Uploads/images/product/pro84.jpg', N'/Uploads/images/product/pro84.jpg', 100000, N'Mùa hè nóng bức này các bạn sẽ khó chịu khi phải dùng kem lót, phấn phủ rất bí da và nặng mặt. Mà phấn dùng nhiều hại da, to lỗ chân lông thế nào ai cũng biết rồi ạ. Chỉ với 1 lớp kem mỏng các bạn đã vô cùng xinh đẹp, không lo bóng nhờn vì kem kiềm dầu rất tốt.', 2100, N'<p>&nbsp;</p>

<p>🖤🖤Kem Dưỡng Trắng Da B&ocirc;ng Cải Xanh Ladykin🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 100K</p>

<p>&nbsp;</p>

<p>✖️ Xuất xứ: H&agrave;n quốc</p>

<p>✖️ Thương Hiệu: Ladyskin</p>

<p>✖️ Trọng lượng: 60ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>&ndash; Khả năng trang điểm như kh&ocirc;ng make up ph&ugrave; hợp với c&aacute;c bạn g&aacute;i y&ecirc;u th&iacute;ch style trang điểm H&agrave;n Quốc nh&eacute;! Thoa kem l&ecirc;n trắng kiểu trong veo, nhẹ nh&agrave;ng như kh&ocirc;ng, đảm bảo d&ugrave;ng l&agrave; m&ecirc; lu&ocirc;n. Sản phẩm kh&ocirc;ng phải l&agrave;m trắng cấ.p tố.c v&igrave; đ&acirc;y ho&agrave;n to&agrave;n kh&ocirc;ng phải l&agrave; kem trộn trắng da, vậy n&ecirc;n c&aacute;c bạn c&agrave;ng d&ugrave;ng c&agrave;ng đẹp, bản chất v&igrave; kem nu&ocirc;i dưỡng da từ s&acirc;u b&ecirc;n trong.</p>

<p>&ndash; Kem dưỡng B&ocirc;ng cải xanh đang được đ&ocirc;ng đảo bạn g&aacute;i tin d&ugrave;ng v&agrave; đưa phản hồi rất t&iacute;ch cực. V&igrave; kem vừa dưỡng trắng hồng, song song lại vừa thay thế được lớp make up.</p>

<p>&ndash; Kem B&ocirc;ng cải xanh H&agrave;n Quốc c&oacute; t&aacute;c dụng vượt trội trong việc gi&uacute;p cho l&agrave;n da của bạn trở n&ecirc;n tươi s&aacute;ng. Tăng s&aacute;ng da qua nguy&ecirc;n l&yacute; cung cấp độ ẩm phong ph&uacute; v&agrave; c&aacute;c tinh chất dưỡng đặc biệt.</p>

<p>&ndash; M&ugrave;a h&egrave; n&oacute;ng bức như n&agrave;y c&aacute;c bạn sẽ v&ocirc; c&ugrave;ng kh&oacute; chịu khi phải d&ugrave;ng n&agrave;o kem l&oacute;t, kem nền hay phấn phủ g&acirc;y b&iacute; da v&agrave; nặng mặt. Hơn nữa phấn d&ugrave;ng nhiều hại cho da, l&agrave;m to lỗ ch&acirc;n l&ocirc;ng như thế n&agrave;o ai cũng biết rồi ạ. Vậy n&ecirc;n chỉ với 1 lớp kem mỏng min th&ocirc;i, l&agrave; c&aacute;c bạn đ&atilde; v&ocirc; c&ugrave;ng xinh đẹp, kh&ocirc;ng sợ b&oacute;ng nhờn da v&igrave; kem kiềm dầu rất tốt. Khi thoa l&ecirc;n kem thấm hết v&agrave;o da, kh&ocirc;ng sợ lộ ch&uacute;t v&acirc;n kem n&agrave;o, nếu nh&igrave;n v&agrave;o thậm ch&iacute; c&ograve;n kh&ocirc;ng biết bạn d&ugrave;ng kem đ&acirc;u v&igrave; qu&aacute; tự nhi&ecirc;n v&agrave; nhẹ nh&agrave;ng.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>B1: V&agrave;o buổi s&aacute;ng, l&agrave;m sạch mặt bằng sữa rửa mặt</p>

<p>B2: Dưỡng da với nước hoa hồng.</p>

<p>B3: Thoa kem dưỡng da (Lotion).</p>

<p>B4: Thoa kem trắng da b&ocirc;ng cải xanh.</p>
', 1, 0, N'kem-duong-trang-da-bong-cai-xanh-ladykin-60ml', CAST(N'2021-08-18 11:32:54.750' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4119, N'Nước Tẩy Trang Innisfree Green Tea Cleansing Water 300ml', N'Innisfree', N'/Uploads/images/product/pro85.jpg', N'/Uploads/images/product/pro85.jpg', 230000, N'Tẩy trang Green Tea Pure Cleansing Water là tẩy trang dạng nước có chức năng rửa sạch lớp trang điểm trên bề mặt da mà không gây tổn hại gì đến da. Nước tẩy trang làm sạch đối với cả những sản phẩm makeup chống trôi chống lem.', 2105, N'<p>Xuất xứ: H&agrave;n Quốc.</p>

<p>Dung t&iacute;ch: 300ml.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>- C&aacute;c d&ograve;ng sản phẩm chăm s&oacute;c da đến từ Innisfree lu&ocirc;n tạo được sức h&uacute;t cực lớn đối với t&iacute;n đồ mỹ phẩm. V&agrave; dĩ nhi&ecirc;n nước tẩy trang tr&agrave; xanh Innisfree cũng kh&ocirc;ng ngoại lệ, ch&uacute;ng được v&iacute; l&agrave; vật bất-ly-th&acirc;n của hội chị em nhờ sở hữu khả năng l&agrave;m sạch si&ecirc;u đỉnh, an to&agrave;n v&agrave; l&agrave;nh t&iacute;nh.<br />
&nbsp;</p>

<p>1. L&agrave;m sạch s&acirc;u da Green Tea Cleansing Water sở hữu c&aacute;c ph&acirc;n tử nhỏ dễ d&agrave;ng len lỏi v&agrave;o trong s&acirc;u c&aacute;c lỗ ch&acirc;n l&ocirc;ng gi&uacute;p loại bỏ mọi bụi bẩn, dầu nhờn, lớp makeup ra khỏi da dễ d&agrave;ng, đem lại cho l&agrave;n da sạch s&acirc;u, mềm mịn m&agrave; kh&ocirc;ng g&acirc;y kh&ocirc; r&aacute;p, tổn thương da.</p>

<p>2. Cấp nước, dưỡng ẩm ho&agrave;n hảo &ldquo;Beauty Green Tea&rdquo; l&agrave; một trong những th&agrave;nh phần dưỡng ẩm chuy&ecirc;n s&acirc;u được ph&aacute;t triển sau khi nghi&ecirc;n cứu 2.401 giống ch&egrave; H&agrave;n Quốc. Beauty Green Tea c&oacute; chứa h&agrave;m lượng axit amin cao &ndash; ch&iacute;nh l&agrave; m&ocirc;i trường tuyệt vời để cấp nước v&agrave; dưỡng ẩm s&acirc;u cho da.</p>

<p>3. Hỗ trợ điều trị, ngăn ngừa mụn Carotenoid v&agrave; Tocopherols c&oacute; mặt trong tr&agrave; xanh được biết tới với c&ocirc;ng dụng trị mụn, ngăn ngừa mụn h&igrave;nh th&agrave;nh v&agrave; dưỡng da khỏe mạnh.</p>

<p>4. Phục hồi tổn thương, tăng độ đ&agrave;n hồi cho da</p>

<p>+ Chiết xuất từ 100% tr&agrave; xanh nguy&ecirc;n chất được nu&ocirc;i dưỡng từ trong l&ograve;ng đất c&oacute; chứa c&aacute;c chất Linoleic Acid, Catechin, Vitamin E v&agrave; c&aacute;c chất kho&aacute;ng c&oacute; t&aacute;c dụng phục hồi độ đ&agrave;n hồi v&agrave; sự tươi trẻ cho da.</p>

<p>+ Hợp chất Linoleic acid gi&uacute;p thẩm thấu s&acirc;u v&agrave;o trong lớp hạ b&igrave; tạo li&ecirc;n kết giữa c&aacute;c lỗ hổng tr&ecirc;n tế b&agrave;o da, tạo sự đ&agrave;n hồi cho da căng mọng.</p>

<p>5. Chống oxy h&oacute;a gi&uacute;p da tươi trẻ</p>

<p>+ Tr&agrave; xanh c&ograve;n chứa c&aacute;c th&agrave;nh phần chống oxy h&oacute;a da như Polyphenol tinh khiết, Epigallocatechin Gallate (viết tắt EGCG) gi&uacute;p da trẻ h&oacute;a v&agrave; được bảo vệ chống lại qu&aacute; tr&igrave;nh oxy h&oacute;a da của m&ocirc;i trường.</p>

<p>+ Đặc biệt hơn, nhờ c&ocirc;ng nghệ Moisture-Rising Technology c&oacute; trong nước tr&agrave; xanh tươi sẽ tạo lớp r&agrave;o cản ngăn kh&ocirc;ng cho độ ẩm tho&aacute;t ra b&ecirc;n ngo&agrave;i. Từ đ&oacute; chống l&atilde;o h&oacute;a, phục hồi l&agrave;n da cho bạn sở hữu l&agrave;n da khỏe mạnh, căng tr&agrave;n sức sống.</p>

<p>&nbsp;</p>
', 1, 0, N'nuoc-tay-trang-innisfree-green-tea-cleansing-water-300ml', CAST(N'2021-08-18 11:35:26.940' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4120, N'Bộ Dầu Xả Và Dầu Gội Ogx Biotin & Collagen', N'Khác', N'/Uploads/images/product/pro87.jpg', N'/Uploads/images/product/pro87.jpg', 300000, N'Bộ Dầu Gội Và Xã Thick And Full Biotin Collagen Organix Của Mỹ  cung cấp collagen,biotin và các vitamin thiết yếu giúp tóc mềm mượt,khỏe mạnh.', 2114, N'<p>- Dung t&iacute;ch: 385ml x 2</p>

<p>- Thương hiệu: Ogx</p>

<p>- Xuất xứ: Mỹ</p>

<p>&nbsp;</p>

<p>✖️ Th&agrave;nh phần:</p>

<p>- Bao gồm c&aacute;c tinh chất collagen, ProVitamin B7, biotin v&agrave; c&aacute;c dưỡng chất giữ ẩm cho t&oacute;c</p>

<p>- Kh&ocirc;ng chứa chất bảo quản paraben v&agrave; chất tạo bọt sulfates g&acirc;y bệnh ung thư như c&aacute;c loại dầu gội th&ocirc;ng thường. Đạt ti&ecirc;u chuẩn khắt khe của cục quản l&iacute; Thực phẩm v&agrave; Dược phẩm Hoa Kỳ.</p>

<p>&nbsp;</p>

<p>✖️ C&ocirc;ng dụng:</p>

<p>- Bộ đ&ocirc;i dầu gội v&agrave; xả Organix Biotin &amp; Collagen c&oacute; hợp chất ProVitamin B7 v&agrave; biotin, tạo ra c&aacute;c chất dinh dưỡng thấm s&acirc;u, phục hồi từ b&ecirc;n trong sợi t&oacute;c.</p>

<p>- 100% Organic l&agrave; thực phẩm hữu cơ được chiết xuất ho&agrave;n to&agrave;n từ thảo dược thi&ecirc;n nhi&ecirc;n.</p>

<p>- T&aacute;c dụng l&agrave;m k&iacute;ch th&iacute;ch mọc t&oacute;c từ collagen v&agrave; c&aacute;c protein được thủy ph&acirc;n từ l&uacute;a m&igrave; gi&uacute;p t&oacute;c b&oacute;ng khỏe, d&agrave;y hơn v&agrave; tr&agrave;n đầy sức sống.</p>

<p>- Bổ sung độ ẩm cho từng sợi t&oacute;c</p>

<p>- Ngăn ngừa qu&aacute; tr&igrave;nh l&atilde;o h&oacute;a của t&oacute;c. Gi&uacute;p sợi t&oacute;c khỏe, s&aacute;ng b&oacute;ng mượt hơn nhiều lần.</p>

<p>- Bổ sung axit amin, kho&aacute;ng chất cần thiết gi&uacute;p t&oacute;c b&oacute;ng mượt v&agrave; ngăn g&atilde;y rụng.</p>

<p>- Tạo hương thơm quyến rũ v&agrave; lưu m&ugrave;i l&acirc;u hơn tr&ecirc;n m&aacute;i t&oacute;c.</p>
', 1, 0, N'bo-dau-xa-va-dau-goi-ogx-biotin-collagen', CAST(N'2021-08-18 11:37:36.710' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4121, N'Phấn Nước Lime', N'Khác', N'/Uploads/images/product/pro88.jpg', N'/Uploads/images/product/pro88.jpg', 0, N'Nếu như có một loại phấn nước nổi bần bật vì độ che phủ, được yêu thích bởi độ mướt tự nhiên khi lên da, bền màu suốt 24 giờ, kiềm dầu và có vẻ bề ngoài cực kỳ sang trọng thì đó chính là Lime Real Cover Pink Cushion.', 2095, N'<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>-Thương hiệu :&nbsp;Lime Crime</p>

<p>- Trọng lượng: 20g</p>

<p>- Ph&acirc;n loại:</p>

<p>+ Trắng: Da dầu</p>

<p>+ Xanh: Da thường, da kh&ocirc;</p>

<p>- Tone m&agrave;u:</p>

<p>10 - Da trắng, 20 - Da ngăm</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>➡️ Mặc d&ugrave; mới được ra mắt từ năm 2008 nhưng Lime comestic nhanh ch&oacute;ng tạo ra một tr&agrave;o lưu l&agrave;m đẹp tại thị trường H&agrave;n Quốc với sự tiện dụng, đa chức năng.</p>

<p>➡️ Lime Real Cover Pink Cushion kh&ocirc;ng chỉ giữ lại được hết những ưu điểm tuyệt vời của Lime Cushion đời thứ nhất m&agrave; c&ograve;n sửa lại một số điểm chưa ho&agrave;n mỹ ở thế hệ thứ 1, đem đến cho kh&aacute;ch h&agrave;ng một loại phấn nước ho&agrave;n mỹ v&agrave; theo đ&oacute;, nhanh ch&oacute;ng tạo n&ecirc;n cơn sốt với những người y&ecirc;u th&iacute;ch với c&aacute;i đẹp.</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>- C&aacute;c c&ocirc; n&agrave;ng sẽ đơn giản h&oacute;a được việc trang điểm của m&igrave;nh, với c&ocirc;ng dụng 4 trong 1: chống nắng, kem l&oacute;t, kem nền, che khuyết điểm, v&agrave; đặc biệt, cung cấp khả năng kiềm dầu cực tốt, ph&ugrave; hợp với cả c&ocirc; n&agrave;ng da dầu v&agrave; da kh&ocirc;.</p>

<p>&ndash; Phấn nước Lime Cushion H&agrave;n Quốc cho lớp nền b&oacute;ng khỏe &ndash; real cover pink cushion</p>

<p>&ndash; Calamine Powder gi&uacute;p hấp thụ dầu thừa v&agrave; l&agrave;m dịu v&ugrave;ng da đang bị tổn thương, v&igrave; vậy, sản phẩn n&agrave;y ph&ugrave; hợp với tất cả c&aacute;c loại da, từ da k&iacute;ch ứng, mụn, nhạy cảm&hellip;.</p>

<p>&ndash; Volcanic Ash (tro n&uacute;i lửa Jeju) sẽ gi&uacute;p hấp thu to&agrave;n bộ dầu thừa v&agrave; bụi bẩn, cặn trang điểm từ s&acirc;u b&ecirc;n trong lỗ ch&acirc;n ch&acirc;n nhờ khả năng hấp thu mạnh gấp 6 lần than tre.</p>

<p>&ndash; Ngo&agrave;i ra, Lime Real Cover Pink Cushion c&ograve;n được cộng điểm nhờ khả năng chống thấm nước tuyệt đối, gi&uacute;p ph&aacute;i đẹp giữ được lớp trang điểm ho&agrave;n mxy trong cả m&ocirc;t ng&agrave;y d&agrave;i v&agrave; kh&ocirc;ng phải lo lắng về mưa hay khi đi bơi, đi tắm&hellip;</p>
', 1, 0, N'phan-nuoc-lime', CAST(N'2021-08-18 11:41:52.697' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4122, N'Sữa Rửa Mặt Cho Da Mụn Some By Mi 100ml 30 Days Miracle Acne Clear Foam', N'Some By Mi', N'/Uploads/images/product/pro89.jpg', N'/Uploads/images/product/pro89.jpg', 195000, N'Sữa Rửa Mặt Tạo Bọt, Ngăn Ngừa Mụn Some By Mi AHA-BHA-PHA 30 Days Miracle Acne Clear Foam là sữa rửa mặt thuộc dòng AHA-BHA-PHA của thương hiệu Some By Mi với hoạt chất độc quyền TruecicaTM chứa nhiều thành phần thiên nhiên dịu nhẹ giúp làn da sạch sâu, lỗ chân lông được thông thoáng, hỗ trợ cải thiện làn da mụn chỉ trong 30 ngày, mang đến làn da khỏe mạnh, mềm mại, tươi sáng tự nhiên', 2097, N'<p>Thương hiệu: Some By Mi</p>

<p>Xuất Xứ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>- Th&agrave;nh phần:</p>

<p>+ Chiết xuất từ ngải cứu: cấp nước, c&acirc;n bằng &amp; l&agrave;m dịu da.</p>

<p>+ Chiết xuất từ tr&agrave;m tr&agrave;: gi&uacute;p bảo vệ, l&agrave;m dịu l&agrave;n da nhạy cảm, dễ k&iacute;ch ứng.</p>

<p>+ Chiết xuất từ rau m&aacute;: gi&uacute;p bảo vệ l&agrave;n da trước c&aacute;c t&aacute;c nh&acirc;n g&acirc;y hại từ b&ecirc;n ngo&agrave;i, l&agrave;m dịu da, hỗ trợ phục hồi da, l&agrave;m mờ sẹo mụn&hellip;</p>

<p>+ Centella powder extract: gi&uacute;p tăng cường h&agrave;ng r&agrave;o bảo vệ da v&agrave; l&agrave;m dịu da hiệu quả.</p>

<p>&nbsp;</p>

<p>- Phức hợp AHA &ndash; BHA &ndash; PHA:</p>

<p>+ AHA: thanh tẩy tế b&agrave;o chết, l&agrave;m s&aacute;ng v&agrave; đều m&agrave;u da, giảm th&acirc;m mụn, cải thiện kết cấu v&agrave; độ đ&agrave;n hồi săn chắc của l&agrave;n da.</p>

<p>+ BHA: l&agrave;m sạch s&acirc;u lỗ ch&acirc;n l&ocirc;ng, kh&aacute;ng vi&ecirc;m, kh&aacute;ng khuẩn, hỗ trợ l&agrave;m giảm mụn, điều tiết b&atilde; nhờn cho da th&ocirc;ng tho&aacute;ng.</p>

<p>+ PHA: dưỡng ẩm v&agrave; thanh tẩy tế b&agrave;o chết nhẹ nh&agrave;ng, ngăn ngừa l&atilde;o h&oacute;a da.</p>

<p>&nbsp;</p>

<p>- C&ocirc;ng dụng:</p>

<p>+ Sử dụng chất hoạt động bề mặt nhẹ dịu, l&agrave;m sạch da tối ưu m&agrave; kh&ocirc;ng g&acirc;y k&iacute;ch ứng hay kh&ocirc; r&aacute;t.</p>

<p>+ Chứa 160.200 ppm hợp chất Truecica&trade; gi&uacute;p l&agrave;m dịu, bảo vệ v&agrave; củng cố h&agrave;ng r&agrave;o bảo vệ da.</p>

<p>+ BHA (Salicylic Acid) l&agrave;m sạch s&acirc;u lỗ ch&acirc;n l&ocirc;ng, giảm b&iacute;t tắc v&agrave; mụn trứng c&aacute;, điều tiết b&atilde; nhờn cho da th&ocirc;ng tho&aacute;ng sạch mịn.</p>

<p>+ AHA &ndash; PHA thanh tẩy tế b&agrave;o chết nhẹ nh&agrave;ng, dưỡng ẩm, cải thiện kết cấu da, gi&uacute;p da săn chắc v&agrave; đ&agrave;n hồi hơn.</p>

<p>+ Kh&ocirc;ng chứa c&aacute;c th&agrave;nh phần g&acirc;y hại, an to&agrave;n v&agrave; l&agrave;nh t&iacute;nh cho mọi loại da, đặc biệt ph&ugrave; hợp cho l&agrave;n da dầu, mụn, nhạy cảm.</p>
', 1, 0, N'sua-rua-mat-cho-da-mun-some-by-mi-100ml-30-days-miracle-acne-clear-foam', CAST(N'2021-08-18 11:43:56.940' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4123, N'TẨY DA CHẾT - SỮA TẮM - DƯỠNG THỂ WHITE CONC NHẬT BẢN', N'White Conc', N'/Uploads/images/product/pro90.jpg', N'/Uploads/images/product/pro90.jpg', 0, N'Tẩy tế bào chết dưỡng trắng White Conc có tác dụng làm mềm da, đánh tan hắc tố trên da nhanh chóng giúp cho làn da trắng tự nhiên và đặc biệt không làm tổn hại cho da, đồng thời tẩy tế bào chết và tái tạo mô tế bào phục hồi làn da mềm mại mịn màng.', 2099, N'<p>1. TẨY DA CHẾT:</p>

<p>- Loại bỏ tế b&agrave;o chết v&agrave; lớp da sần s&ugrave;i th&ocirc; r&aacute;p b&ecirc;n tr&ecirc;n, đặc biệt l&agrave; ở c&aacute;c v&ugrave;ng da bị chai như khuỷu tay, đầu gối.</p>

<p>- K&iacute;ch th&iacute;ch da t&aacute;i tạo tế b&agrave;o mới.</p>

<p>- Mang lại l&agrave;n da tươi s&aacute;ng, mịn m&agrave;ng hơn.</p>

<p>- Giảm b&iacute;t tắc lỗ ch&acirc;n l&ocirc;ng, từ đ&oacute; hạn chế mụn v&agrave; giảm dầu thừa tr&ecirc;n da.</p>

<p>- Cung cấp dưỡng chất cho l&agrave;n da s&aacute;ng mịn từ s&acirc;u b&ecirc;n trong.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>2. SỮA TẮM:</p>

<p>- Với th&agrave;nh phần chiết xuất thi&ecirc;n nhi&ecirc;n, sữa tắm White Conc Body sẽ nhẹ nh&agrave;ng l&agrave;m mềm v&ugrave;ng da kh&ocirc; ở c&aacute;c vị tr&iacute; như đầu gối, khuỷu tay, g&oacute;t ch&acirc;n&hellip;</p>

<p>- Sữa tắm White Conc Body Shampoo sẽ gi&uacute;p cho việc chăm s&oacute;c da của bạn trở n&ecirc;n dễ d&agrave;ng hơn. Sản phẩm chứa vitamin C v&agrave; kho&aacute;ng chất gi&uacute;p nu&ocirc;i dưỡng da trắng hồng v&agrave; rạng rỡ tự nhi&ecirc;n.</p>

<p>- Hương thơm tươi m&aacute;t tạo cảm gi&aacute;c thư th&aacute;i dễ chịu khi tắm.</p>

<p>- Hiệu quả tr&ecirc;n cả l&agrave;n da bị ch&aacute;y nắng.</p>

<p>&nbsp;</p>

<p>3. DƯỠNG THỂ:</p>

<p>- Vitamin C tăng cường khả năng chống oxy h&oacute;a, gi&uacute;p da đẹp v&agrave; tươi trẻ mỗi ng&agrave;y.</p>

<p>- Hylaluronic Acid cấp nước, dưỡng ẩm, bảo vệ da căng mượt, ngăn ngừa kh&ocirc; da hiệu quả.</p>

<p>- Collagen gi&uacute;p da căng mịn, chắc khỏe, hồng h&agrave;o.</p>

<p>- Vitamin E tự nhi&ecirc;n gi&uacute;p hạn chế nếp nhăn, tăng cường r&agrave;o cản tia UVA, UVB c&oacute; hại từ &aacute;nh mặt trời.</p>
', 1, 0, N'tay-da-chet---sua-tam---duong-the-white-conc-nhat-ban', CAST(N'2021-08-18 15:25:32.630' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4124, N'Lăn khử mùi Scion Pure White Roll On Nuskin 75ml', N'Khác', N'/Uploads/images/product/pro91.jpg', N'/Uploads/images/product/pro91.jpg', 120000, N'Lăn khử mùi cơ thể Scion™ Pure White Roll On giúp khử mùi cơ thể và giảm mùi mồ hôi vùng da dưới cánh tay. Có chứa thành phần giúp kháng khuẩn làm giảm và ngăn ngừa mùi mồ hôi lâu dài. Với công thức dịu nhẹ, chứa các chiết xuất từ thiên nhiên và vitamin giúp phục hồi vùng da dưới cánh tay, cho làn da dưới cánh tay tươi sáng, mềm mại mang lại cho bạn tự tin suốt cả ngày.', 2099, N'<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>- Tiết chế lượng mồ h&ocirc;i tiết ra dưới v&ugrave;ng c&aacute;nh tay cho bạn cảm gi&aacute;c kh&ocirc; tho&aacute;ng.</p>

<p>- Điều tiết m&ugrave;i h&ocirc;i, m&ugrave;i hương từ thảo dược mang đến hương thơm dịu nhẹ suốt 24h.</p>

<p>- Kh&ocirc;ng d&iacute;nh m&agrave;u ố v&agrave;ng dưới v&ugrave;ng c&aacute;nh tay g&acirc;y mất thẩm mỹ.</p>

<p>- Trị h&ocirc;i ch&acirc;n dứt điểm sau một liệu tr&igrave;nh cho cả nam v&agrave; nữ.</p>

<p>- Da v&ugrave;ng c&aacute;nh trắng s&aacute;ng đều m&agrave;u hơn.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>- Lật ngược chai xuống lăn l&ecirc;n v&ugrave;ng da cần điều trị.</p>

<p>- Đậy nắp ngay sau sử dụng.</p>

<p>- Tr&aacute;nh sử dụng tr&ecirc;n v&ugrave;ng da c&oacute; vết thương hở.</p>
', 1, 0, N'lan-khu-mui-scion-pure-white-roll-on-nuskin-75ml', CAST(N'2021-08-18 15:28:29.130' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4125, N'Son Dưỡng Môi Chống Nắng Vichy Ideal Soleil SPF30+', N'Vichy', N'/Uploads/images/product/pro92.jpg', N'/Uploads/images/product/pro92.jpg', 60000, N'Son dưỡng môi Vichy được nhiều tín đồ làm đẹp chết mê với công dụng chăm môi xinh bất ngờ đến từ nước Pháp. Hãy cùng TuDienLamDep review 2 dòng son dưỡng môi đình đám của thương hiệu này là Vichy Idéal Soleil SPF30 Lip Protection Stick và Vichy Aqualia Thermal Lips.', 2107, N'<p>Trọng lượng: 4.7ml</p>

<p>Xuất xứ: Ph&aacute;p</p>

<p>&nbsp;</p>

<p>- Sản phẩm tạo một lớp m&agrave;ng bảo vệ đ&ocirc;i m&ocirc;i trước những t&aacute;c động v&agrave; tia tử ngoại từ m&ocirc;i trường. Chỉ số chống nắng l&ecirc;n đến SPF30 v&ocirc; c&ugrave;ng tuyệt vời.</p>

<p>- Chăm chỉ dưỡng m&ocirc;i hoặc d&ugrave;ng c&aacute;c son dưỡng c&oacute; SPF sẽ gi&uacute;p m&ocirc;i bạn hồi sinh v&agrave; căng đầy sức sống , V&agrave; tất nhi&ecirc;n đừng qu&ecirc;n tẩy trang m&ocirc;i h&agrave;ng ng&agrave;y c&aacute;c bạn nh&eacute; Son Dưỡng M&ocirc;i - Vichy High Protection Lip Stick kh&ocirc;ng chỉ đơn thuần l&agrave; 1 loại son dưỡng m&ocirc;i m&agrave; em ấy c&ograve;n bổ sung th&ecirc;m c&aacute;c th&agrave;nh phần glycerin, bơ hạt mỡ, axit Asiatic, Vitamin E c&oacute; t&aacute;c dụng cung cấp độ ẩm cho đ&ocirc;i m&ocirc;i lu&ocirc;n mềm mại, mịn m&agrave;ng hơn.</p>

<p>- Ngo&agrave;i ra, Son Dưỡng M&ocirc;i - Vichy High Protection Lip Stick c&ograve;n c&oacute; c&ocirc;ng dụng trị kh&ocirc; m&ocirc;i, nứt nẻ rất hiệu quả, đồng thời giảm th&acirc;m m&ocirc;i, ngăn ngừa dấu hiệu l&atilde;o h&oacute;a.</p>
', 1, 0, N'son-duong-moi-chong-nang-vichy-ideal-soleil-spf30', CAST(N'2021-08-18 15:33:56.257' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4126, N'Nước hoa hồng Dickinson''s original witch hazel', N'Khác', N'/Uploads/images/product/pro93.jpg', N'/Uploads/images/product/pro93.jpg', 235000, N'Nước hoa hồng Dickinson''s Original Witch Hazel Pore Perfecting Toner là sản phẩm có sự tích hợp từ công thức Oil-free, thành phần 100% thiên nhiên, hoàn toàn phù hợp cho các loại da như: nhờn, bị hư tổn, ửng đỏ, mỏng, dễ dị ứng, mụn và viêm.', 2098, N'<p>-Dung t&iacute;ch: 473ml</p>

<p>-Thương hiệu:&nbsp;DICKINSON&#39;S</p>

<p>&nbsp;</p>

<p>➡️ Dickinson&rsquo;s l&agrave; thương hiệu l&acirc;u đời từ những năm 1866 v&agrave; lu&ocirc;n nổi tiếng về những sản phẩm skincare lần t&iacute;nh. V&agrave; đương nhi&ecirc;n Dickinson&rsquo;s Original Witch Hazel Pore Perfecting Toner cũng l&agrave; một &ldquo;đứa trẻ tốt&rdquo; kh&ocirc;ng ngoại lệ.</p>

<p>➡️ Lu&ocirc;n đứng trong top những loại toner l&agrave;nh t&iacute;nh v&agrave; mang lại hiệu quả si&ecirc;u vi diệu, Dickinson&rsquo;s Original Witch Hazel Pore Perfectinglu&ocirc;n c&oacute; lượng rate cực cao 4.3/5 tr&ecirc;n Makeupalley với hơn 650 lượt reviews. Đ&acirc;y l&agrave; một sản phẩm c&oacute; sự t&iacute;ch hợp từ c&ocirc;ng thức Oil-free, th&agrave;nh phần 100% thi&ecirc;n nhi&ecirc;n, ho&agrave;n to&agrave;n ph&ugrave; hợp cho c&aacute;c loại da như: nhờn, bị hư tổn, ửng đỏ, mỏng, dễ dị ứng, mụn v&agrave; vi&ecirc;m.</p>

<p>➡️ Dickinson&#39;s original witch hazelc&oacute; t&aacute;c dụng ch&iacute;nh l&agrave; se lỗ ch&acirc;n l&ocirc;ng, l&agrave;m da săn chắc mịn m&agrave;ng v&agrave; sạch nhờn tuyệt đối, cho bạn bề mặt da cực kỳ kh&ocirc; r&aacute;o.</p>

<p>➡️ Sản phẩm an to&agrave;n tuyệt đối cho da kể cả l&agrave;n da nhạy cảm nhất.</p>

<p>&nbsp;</p>

<p>✖️ C&ocirc;ng dụng cụ thể:</p>

<p>- Nhẹ nh&agrave;ng l&agrave;m sạch, loại bỏ dầu thừa v&agrave; những chất cặn b&atilde; nằm s&acirc;u b&ecirc;n trong lỗ ch&acirc;n l&ocirc;ng.</p>

<p>- C&aacute;c lỗ ch&acirc;n l&ocirc;ng được cải thiện v&agrave; bớt th&ocirc; hơn.</p>

<p>- Hỗ trợ loại bỏ lớp trang điểm sạch ho&agrave;n to&agrave;n trong khi c&aacute;c loại sữa tẩy trang th&ocirc;ng thường kh&ocirc;ng lấy đi hết được. - C&acirc;n bằng da, l&agrave;m mềm v&ugrave;ng da kh&ocirc; v&agrave; kiểm so&aacute;t lượng dầu thừa cho v&ugrave;ng da tiết nhiều dầu.</p>

<p>- Cải thiện t&igrave;nh trạng da mụn, loại bỏ mụn v&agrave; củng cố texture của da.</p>

<p>- Kh&oacute;a độ ẩm để duy tr&igrave; vẻ mềm mại, tươi s&aacute;ng khi da được dưỡng ẩm đủ.</p>

<p>- KH&Ocirc;NG chứa hương thơm nh&acirc;n tạo hay Thuốc nhuộm.</p>

<p>- Sản phẩm Kh&ocirc;ng c&oacute; thử nghiệm động vật. 100% oil free.</p>

<p>- Kh&ocirc;ng c&oacute; h&oacute;a chất, paraben hay thuốc nhuộm.</p>

<p>- Được c&aacute;c b&aacute;c sĩ da liễu khuy&ecirc;n d&ugrave;ng.</p>

<p>&nbsp;</p>

<p>✖️ Th&agrave;nh phần:</p>

<p>- Witch Hazel (Hamamelis Virginiana) (All Natural), Alcohol (14%) (and), Witch Hazel (Hamamelis Virginiana) Extract ​</p>

<p>- Dickinson c&oacute; chứa th&agrave;nh phần cồn hữu cơ (l&agrave;nh t&iacute;nh) 14% .</p>

<p>&nbsp;</p>

<p>✖️ C&aacute;ch sử dụng:</p>

<p>- Sau khi rửa mặt, d&ugrave;ng miếng b&ocirc;ng tẩy trang lấy &iacute;t toner rồi lau nhẹ nh&agrave;ng tr&ecirc;n mặt. Hoặc d&ugrave;ng trước khi makeup gi&uacute;p kiểm so&aacute;t lượng dầu tr&ecirc;n da, l&agrave;m cho lớp makeup mịn m&agrave;ng hơn.</p>

<p>- C&oacute; thể sử dụng nhiều lần trong ng&agrave;y</p>

<p>- Cần d&ugrave;ng sau khi rửa mặt, tẩy trang v&agrave; trước kem dưỡng</p>
', 1, 0, N'nuoc-hoa-hong-dickinsons-original-witch-hazel', CAST(N'2021-08-18 15:37:47.237' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4127, N'Sữa Rửa Mặt Some By Mi Snail Truecica Miracle Repair Low pH 5.5 Gel Cleanser 100ml', N'Some By Mi', N'/Uploads/images/product/pro94.jpg', N'/Uploads/images/product/pro94.jpg', 195000, N'Sữa Rửa Mặt Dạng Gel Dịu Nhẹ, Giúp Da Đàn Hồi, Săn Chắc Some by Mi Snail Truecica Miracle Repair Low PH Gel Cleanser là sữa rửa mặt thuộc dòng Snail Truecica của thương hiệu Some By Mi giúp bổ sung độ ẩm, phục hồi chiết xuất từ ốc sên với độ pH 5.5 giúp làm sạch nhẹ dịu không gây khô căng phù hợp với mọi loại da đặc biệt là da mụn nhạy cảm', 2097, N'<p>- Thương hiệu: Some By Mi</p>

<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>- Trọng lượng: 100ml</p>

<p>&nbsp;</p>

<p>- Gi&uacute;p tăng cường sự tự phục hồi v&agrave; t&aacute;i tạo cho da bởi chiết xuất từ ốc s&ecirc;n đen cũng như c&aacute;c th&agrave;nh phần độc quyền của Truecica gi&uacute;p da tự t&aacute;i tạo v&agrave; phục hồi, nhanh ch&oacute;ng cải thiện c&aacute;c khuyết điểm do mụn trứng c&aacute; g&acirc;y ra v&agrave; da nhạy cảm, cho da lu&ocirc;n khỏe mạnh.</p>

<p>- Gi&uacute;p c&acirc;n bằng PH cho l&agrave;n da y&ecirc;́u với độ PH5.5 tương ứng với l&agrave;n da khỏe mạnh, b&ecirc;n cạnh đ&oacute;, sản phẩm tạo bọt d&agrave;y mịn gi&uacute;p da được l&agrave;m sạch dịu nhẹ.</p>

<p>- Mucin l&agrave; ch&igrave;a kh&oacute;a trong sức sống mạnh mẽ của ốc s&ecirc;n, kết hợp với ceramide v&agrave; c&aacute;c amino acid (TP được cấp bằng s&aacute;ng chế) gi&uacute;p tăng cường x&acirc;y dựng h&agrave;ng r&agrave;o bảo vệ da khỏi bị k&iacute;ch ứng v&agrave; c&aacute;c t&aacute;c nh&acirc;n g&acirc;y hại từ m&ocirc;i trường. Sản phẩm gi&uacute;p l&agrave;m sạch dịu nhẹ v&agrave; cung cấp độ ẩm cho l&agrave;n da nhạy cảm ngay sau khi rửa mặt.</p>
', 1, 0, N'sua-rua-mat-some-by-mi-snail-truecica-miracle-repair-low-ph-55-gel-cleanser-100ml', CAST(N'2021-08-18 15:39:29.790' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4128, N'Sữa rửa mặt Cetaphil', N'Cetaphil', N'/Uploads/images/product/pro95.jpg', N'/Uploads/images/product/pro95.jpg', 0, N'Sữa Rửa Mặt Dịu Nhẹ Cho Mọi Loại Da Cetaphil Gentle Skin Cleanser là sản phẩm đến từ thương hiệu Cetaphil của Canada,thuộc công ty dược nổi tiếng Galderma Laboratories với mạng lưới phân phối rộng khắp thế giới, được các chuyên gia da liễu bào chế với thành phần giúp da mềm mại hoàn toàn không gây kích ứng với cả những làn da nhạy cảm.', 2097, N'<p>- Xuất xứ: Canada</p>

<p>&nbsp;</p>

<p>✖️ Đ&aacute;nh gi&aacute; Cetaphil từ chuy&ecirc;n gia:</p>

<p>Julia March, chuy&ecirc;n gia chăm s&oacute;c da mặt h&agrave;ng đầu NYC cho biết rất nhiều người New York tin rằng Cetaphil rất tốt, họ c&oacute; xu hướng ho&agrave;n to&agrave;n lờ đi th&agrave;nh phần của n&oacute;. Thực tế, Cetyl alcohol l&agrave; một chất l&agrave;m mềm được d&ugrave;ng trong rất nhiều mỹ phẩm, về cơ bản l&agrave; 1 loại s&aacute;p. Propylene glycol l&agrave; một chất giữ ẩm rất phổ biến (nghĩa l&agrave; n&oacute; h&uacute;t ẩm trong kh&ocirc;ng kh&iacute; để cung cấp cho da), nhưng đồng thời n&oacute; cũng l&agrave;m tăng khả năng h&oacute;a chất x&acirc;m nhập v&agrave;o da v&agrave; m&aacute;u. Sodium lauryl sulfate l&agrave; chất tạo bọt, n&oacute; k&iacute;ch ứng da v&agrave; mắt, l&agrave;m mất đi lớp chất b&eacute;o bảo vệ da, v&agrave; parabens l&agrave; nh&oacute;m chất bảo quản đ&atilde; bị liệt v&agrave;o h&agrave;ng chất c&oacute; khả năng g&acirc;y nguy hiểm đến sức khỏe con người.</p>

<p>&nbsp;</p>

<p>✖️ ƯU ĐIỂM:</p>

<p>✔️ Về chất sữa rửa mặt: Sữa rửa mặt Cetaphil c&oacute; dạng gel kh&ocirc;ng tạo bọt n&ecirc;n nhiều người tin rằng n&oacute; an to&agrave;n cho da. Khi sử dụng mang lại cảm gi&aacute;c kh&aacute; nhẹ nh&agrave;ng, kh&ocirc;ng g&acirc;y kh&oacute; chịu, nhờn r&iacute;t hay kh&ocirc; da.</p>

<p>✔️ Về hiệu quả l&agrave;m sạch: Bởi kh&ocirc;ng tạo bọt n&ecirc;n khi sử dụng Cetaphil bạn sẽ kh&ocirc;ng c&oacute; cảm gi&aacute;c sạch da mặt lắm, thậm ch&iacute; Cetaphil chỉ ph&aacute;t huy t&aacute;c dụng đối với l&agrave;n da thường kh&ocirc;ng trang điểm, c&ograve;n với da dầu hay da hỗn hợp th&igrave; đ&ocirc;i khi rửa mặt xong rồi nhưng bạn lại thấy như chưa.</p>

<p>✔️ Bạn chỉ n&ecirc;n d&ugrave;ng Cetaphil v&agrave;o buổi s&aacute;ng hoặc buổi trưa khi da mặt kh&ocirc;ng qu&aacute; bẩn v&agrave; nhờn.</p>

<p>✔️ Về hiệu quả trị mụn: Được c&aacute;c chuy&ecirc;n gia da liễu khuy&ecirc;n d&ugrave;ng nhằm trị mụn nhưng thực sự vẫn chưa nhiều người kiểm chứng được hiệu quả trị mụn của loại sữa rửa mặt n&agrave;y. Nhiều người sau khi d&ugrave;ng c&ograve;n bị nhiều mụn hơn. Tuy nhi&ecirc;n một số người lại cho rằng độ dịu nhẹ của sữa rửa mặt khiến cho da kh&ocirc;ng bị k&iacute;ch ứng, kh&ocirc;ng l&agrave;m mất lớp bảo vệ tr&ecirc;n da v&agrave; nhờ vậy l&agrave;n da kh&ocirc;ng gặp phải vấn đề về mụn so với việc d&ugrave;ng c&aacute;c loại sữa rửa mặt tạo bọt qu&aacute; mạnh tr&ecirc;n da.</p>
', 1, 0, N'sua-rua-mat-cetaphil', CAST(N'2021-08-18 15:43:20.940' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4129, N'Nước Tẩy Trang Simple Kind To Kind Micellar Cleansing Water 200ml', N'Simple', N'/Uploads/images/product/pro96.jpg', N'/Uploads/images/product/pro96.jpg', 105000, N'Nước tẩy trang Simple Micellar Cleansing Water có xuất xứ từ UK với dung tích 198ml có hiệu quả làm sạch da “mạnh mẽ”, ngay lập tức có thể lấy đi hết bụi bẩn, bã nhờn cùng lớp make up mà không gây kích ứng trên da, kể cả những vùng nhạy cảm như mắt và môi.', 2105, N'<p>- Chứa Vitamin B3, Vitamin C. Nước tinh khiết TriplePurified Water. Hỗ trợ cấp ẩm tức th&igrave;, cho l&agrave;m da s&aacute;ng sạch ngay sau khi sử dụng.</p>

<p>- Nước tẩy trang dịu nhẹ cho da Simple Micellar Water l&agrave; nước tẩy trang sử dụng c&ocirc;ng nghệ Micellar hiệu quả v&agrave; ti&ecirc;n tiến.</p>

<p>- Những hạt bong b&oacute;ng nước Micelles th&ocirc;ng minh nhẹ nh&agrave;ng đi s&acirc;u v&agrave;o da để lấy đi những bụi bẩn, lớp trang điểm cứng đầu đồng thời đưa v&agrave;o da những dưỡng chất v&agrave; độ ẩm cần thiết, cấp ẩm tức th&igrave; cho l&agrave;n da l&ecirc;n đến 90%.</p>
', 1, 0, N'nuoc-tay-trang-simple-kind-to-kind-micellar-cleansing-water-200ml', CAST(N'2021-08-18 15:45:20.067' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4130, N'Kem Dưỡng Ốc Sên Goodal mini Premium Snail Tone Up Cream', N'Khác', N'/Uploads/images/product/pro97.jpg', N'/Uploads/images/product/pro97.jpg', 0, N'Sản phẩm kem ốc sên Goodal mini chứa các tinh chất từ ốc sên, nhâm sâm trắng và các thảo dược tự nhiên, an toàn giúp dưỡng da, làm trắng da tức thì và phục hồi làn da bị hư tổn…', 2100, N'<p>✖️ Xuất xứ: H&agrave;n Quốc</p>

<p>✖️ Thương hiệu: Goodal &ndash; Clio H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>✖️ T&Aacute;C DỤNG:</p>

<p>✔️ 20% th&agrave;nh phần từ ốc s&ecirc;n gi&uacute;p c&acirc;n bằng da, dưỡng da, giảm căng thẳng cho da, cung cấp độ ẩm v&agrave; chất dinh dưỡng phong ph&uacute; cho da, chất nhầy của ốc s&ecirc;n v&agrave;ng gi&uacute;p l&agrave;n da săn chắc v&agrave; khỏe mạnh, chăm s&oacute;c da th&ecirc;m đ&agrave;n hồi.</p>

<p>✔️ Mucin trong chất lọc nhầy từ Ốc S&ecirc;n v&agrave;ng gi&uacute;p chăm s&oacute;c da hư tổn do căng thẳng, tia cực t&iacute;m v&agrave; m&ocirc;i trường b&ecirc;n ngo&agrave;i; đồng thời gi&uacute;p da săn chắc, bừng sức sống.</p>

<p>✔️ Chiết xuất từ nh&acirc;n s&acirc;m trắng gi&uacute;p n&acirc;ng tone da một c&aacute;ch r&otilde; rệt, da sẽ trắng s&aacute;ng tức th&igrave;, kh&ocirc;ng chỉ gi&uacute;p da s&aacute;ng ngời v&agrave; đ&agrave;n hồi m&agrave; c&ograve;n l&agrave;m giảm căng thẳng cho da, giảm c&aacute;c vết n&aacute;m, t&agrave;n nhang, vết sẹo th&acirc;m&hellip;</p>

<p>✔️ Th&agrave;nh phần thảo thược dược duy tr&igrave; sự c&acirc;n bằng cho l&agrave;n da v&agrave; gi&uacute;p da rạng ngời, tinh khiết.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>➖ Rửa mặt sạch, tẩy trang, thực hiện c&aacute;c bước l&agrave;m sạch da th&ocirc;ng thường l&agrave; d&ugrave;ng sữa rửa mặt, sữa dưỡng hoặc tinh chất dưỡng, c&aacute;c bạn lấy một lượng vừa đủ sản phẩm kem ốc s&ecirc;n Goodal mini thoa l&ecirc;n da v&agrave; massage nhẹ nh&agrave;ng để kem hấp thụ v&agrave;o da.</p>

<p>➖ Sử dụng hai lần một ng&agrave;y v&agrave;o s&aacute;ng v&agrave; tối trước khi đi ngủ. Buổi s&aacute;ng c&oacute; thể d&ugrave;ng như bước kem l&oacute;t trước khi trang điểm.</p>
', 1, 0, N'kem-duong-oc-sen-goodal-mini-premium-snail-tone-up-cream', CAST(N'2021-08-18 15:49:03.367' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4131, N'Serum Balance', N'Balance', N'/Uploads/images/product/pro98.jpg', N'/Uploads/images/product/pro98.jpg', 0, N'Balance Active Formula Vitamin C Brightening Serum 30ml là tinh chất làm sáng da chứa thành phần Vitamin C được định dạng dưới dẫn xuất SAP và AA2G (dẫn xuất ít gây kích ứng cho da, nhẹ dịu, phù hợp với mọi loại da và da mụn). Kết cấu Serum C nhẹ, thẩm thấu nhanh, dưới tác động bền vững của Vitamin C và Illumiscin giúp da sáng đều màu, tăng độ đàn hồi và làm mờ các vết thâm nám.', 2103, N'<p>- Xuất xứ: Anh</p>

<p>- Dung t&iacute;ch: 30ml</p>

<p>&nbsp;</p>

<p>✖️ Balance Vitamin C:</p>

<p>- Tinh Chất L&agrave;m S&aacute;ng Da Balance Vitamin C Brightening Serum Glow &amp; Radiance l&agrave; tinh chất l&agrave;m s&aacute;ng da chứa th&agrave;nh phần Vitamin C được định dạng dưới d&acirc;̃n xu&acirc;́t SAP v&agrave; AA2G (d&acirc;̃n xu&acirc;́t &iacute;t g&acirc;y k&iacute;ch ứng cho da, nhẹ dịu, ph&ugrave; hợp với mọi loại da v&agrave; da mụn). Kết cấu Serum C nhẹ, thẩm thấu nhanh, dưới t&aacute;c động bền vững của Vitamin C v&agrave; Illumiscin gi&uacute;p da s&aacute;ng đều m&agrave;u, tăng độ t&agrave;n hồi v&agrave; l&agrave;m mờ c&aacute;c vết th&acirc;m n&aacute;m.</p>

<p>- L&agrave;m s&aacute;ng trắng da với hiệu quả tr&ocirc;ng thấy sau một thời gian ngắn, l&agrave;m mờ những vết th&acirc;m sau mụn, c&aacute;c v&ugrave;ng da kh&ocirc;ng đều m&agrave;u v&agrave; gi&uacute;p l&agrave;n da mệt mỏi trở n&ecirc;n tươi trẻ hơn.</p>

<p>- Illumiscin (chiết xuất từ l&aacute; olive, Ascorbyl glucoside, Zinc PCA): l&agrave;m s&aacute;ng da, ức chế sự h&igrave;nh th&agrave;nh phần sắc tố melanin, ngăn chặn h&igrave;nh th&agrave;nh c&aacute;c đốm n&acirc;u và lão hóa. - STAY-C 50 (Vitamin C): Th&agrave;nh phần Vitamin C bền vững c&oacute; khả năng l&agrave;m s&aacute;ng, mờ sẹo th&acirc;m v&agrave; giảm thiếu hư tổn của l&agrave;n da do &aacute;nh s&aacute;ng mắt trời g&acirc;y hại.</p>

<p>- Kết cấu dạng lỏng, thẩm thấu nhanh cung cấp tinh chất vitamin C cho da gi&uacute;p da s&aacute;ng đều m&agrave;u, tăng độ đ&agrave;n hồi v&agrave; l&agrave;m mờ c&aacute;c vết th&acirc;m n&aacute;m.</p>

<p>- Tăng cường collagen gi&uacute;p trẻ h&oacute;a l&agrave;n da, c&oacute; khả năng l&agrave;m s&aacute;ng, mờ sẹo th&acirc;m v&agrave; giảm thiếu hư tổn của l&agrave;n da do &aacute;nh s&aacute;ng mắt trời g&acirc;y hại.</p>

<p>- Sản phẩm kh&ocirc;ng chứa chất bảo quản, kh&ocirc;ng chứa paraben, kh&ocirc;ng g&acirc;y k&iacute;ch ứng, kh&ocirc;ng nhờn r&iacute;t, d&ugrave;ng được cho mọi loại da.</p>

<p>&nbsp;</p>

<p>✖️ Balance Hyaluronic:</p>

<p>- Với c&ocirc;ng thức dưỡng ẩm chuy&ecirc;n s&acirc;u đặc biệt đ&oacute; ch&iacute;nh l&agrave; th&agrave;nh phần c&oacute; chứa 5% Hyasol PF &ndash; một dưỡng chất được chứng minh c&oacute; khả năng giữ nước gấp 5 lần Hyaluronic Acid, cấp ẩm gấp 5 lần HA, chống oxy h&oacute;a gấp 4 lần so với HA.</p>

<p>- Nhờ đ&oacute; m&agrave; Balance Hyaluronic Deep Moisture Serum c&oacute; thể đ&aacute;p ứng được nhu cầu dưỡng ẩm cho da cơ bản nhất trong qu&aacute; tr&igrave;nh chăm s&oacute;c da mỗi ng&agrave;y của c&aacute;c c&ocirc; g&aacute;i.</p>

<p>- Nhờ khả năng dưỡng ẩm chuy&ecirc;n s&acirc;u đặc biệt n&agrave;y, Balance Hyaluronic Deep Moisture Serum gi&uacute;p kiềm dầu v&agrave; hạn chế tiết dầu tr&ecirc;n da hiệu quả. Loại bỏ l&agrave;n da sần s&ugrave;i, kh&ocirc; r&aacute;p mang lại cho bạn l&agrave;n da s&aacute;ng mịn, ẩm mượt, da lu&ocirc;n mọng nước.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>✖️ Balance Dragon&rsquo;s Blood:</p>

<p>- Tinh chất m&aacute;u rồng Balance Dragon&rsquo;s Blood Lifting Serum &ndash; Serum &ldquo;m&aacute;u rồng&rdquo;, sản phẩm &ldquo;nức tiếng&rdquo; được thiết kế với những th&agrave;nh phần chuy&ecirc;n biệt gi&uacute;p da săn chắc hơn, tăng độ đ&agrave;n hồi đồng thời giảm thiểu sự xuất hiện của những đường nhăn, l&agrave;m mờ những nếp nhăn, phục hồi sức sống cho l&agrave;n da v&agrave; đem n&eacute;t tươi trẻ đến cho từng đường n&eacute;t tr&ecirc;n gương mặt bạn.</p>

<p>- Được chiết xuất từ nhựa của 1 loại c&acirc;y cận nhiệt đới kỳ b&iacute; nhất h&agrave;nh tinh &ndash; 1 lo&agrave;i c&acirc;y ở đảo Socotra xa x&ocirc;i c&oacute; c&aacute;i t&ecirc;n Dragon&rsquo;s Blood, nhựa c&acirc;y c&oacute; m&agrave;u đỏ sẫm v&agrave; m&ugrave;i nồng, c&oacute; t&aacute;c dụng cực kỳ tốt về chữa l&agrave;nh, phục hồi, bồi bổ v&agrave; tăng sức đề kh&aacute;ng cho da.</p>

<p>- Tinh Chất M&aacute;u Rồng Balance Active Formula Dragon&#39;s Blood Instant Lifting Serumthực sự thần kỳ, c&oacute; khả năng chống oxi h&oacute;a Cực Kỳ Cao, l&agrave;m đầy c&aacute;c nếp nhăn n&ocirc;ng m&agrave; kh&ocirc;ng cần ti&ecirc;m botox hay trị liệu thẩm mỹ. Ngay từ thời La M&atilde; cổ đại th&igrave; việc thoa dưỡng chất c&oacute; chứa tinh chất Dragon&rsquo;s Blood l&ecirc;n da được lưu truyền như 1 phương thức l&agrave;m đẹp</p>
', 1, 0, N'serum-balance', CAST(N'2021-08-18 15:55:02.593' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4132, N'Son Merzy The First Velvet Tint Season 3 (Vỏ xanh)', N'Merzy', N'/Uploads/images/product/pro99.jpg', N'/Uploads/images/product/pro99.jpg', 0, N'Son Kem Lì Merzy The First Velvet Tint Season 3 - Ver Blue là son kem lì thuộc dòng Velvet tint của thương hiệu Merzy trở lại với phiên bản mới phủ sắc xanh mang sức hút tuyệt vời, thỏi son có màu xanh Blue xu hướng cùng với bao bì gây ấn tượng bắt mắt trẻ trung, kết cấu son nhung mịn,vỏ ngoài với sắc xanh sang trọng cùng bảng màu trendy mang đến cảm giác thời thượng, cuốn hút', 2094, N'<p>#V13: Cam nude</p>

<p>#V14: Hồng đất MLBB</p>

<p>#V15: Cam &aacute;nh n&acirc;u</p>

<p>#V16: Đỏ Chili</p>

<p>#V17: Đỏ gạch base cam</p>

<p>#V18: N&acirc;u đất Chocolate</p>
', 1, 0, N'son-merzy-the-first-velvet-tint-season-3-vo-xanh', CAST(N'2021-08-18 15:57:50.680' AS DateTime))
GO
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4133, N'XỊT CHỐNG NẮNG JM SOLUTION SUN SPRAY 180ML', N'Jmsolution', N'/Uploads/images/product/pro100.jpg', N'/Uploads/images/product/pro100.jpg', 0, N'Xịt Chống Nắng Toàn Thân JMsolution SPF50+ PA++++ Sun Spray là sản phẩm đến từ thương hiệu JMsolution Hàn Quốc. Sản phẩm ở dạng xịt giúp việc thoa và dặm lại chống nắng trở nên nhanh chóng và dễ dàng hơn, dùng được cho cả mặt và cơ thể.', 2099, N'<p>- Thương hiệu : JM Solution</p>

<p>- Thể t&iacute;ch (ml) : 180</p>

<p>- Xuất xứ : Korea</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>1. HỒNG:</p>

<p>- Xịt chống nắng jm solution marine luminous pearlsun spray chống nắng SPF 50, dạng xịt ướt kh&ocirc; thoải m&aacute;i kh&ocirc;ng nhờn với chiết xuất từ ngọc trai ở đảo jeju, dưỡng trắng v&agrave; chống oxy h&oacute;a.</p>

<p>- Chiết xuất từ hoa hồng mang lại cảm gi&aacute;c m&aacute;t lịm v&agrave; hương thơm hoa hồng nhẹ nh&agrave;ng. Gi&uacute;p bạn tho&aacute;t khỏi t&aacute;c động của &aacute;nh nắng mặt trời được nu&ocirc;i dưỡng trong khoảng thời gian 12 giờ, kh&ocirc;ng bị kh&ocirc; v&agrave; r&aacute;m nắng, đ&oacute; l&agrave; t&iacute;nh năng lớn nhất của sản phẩm n&agrave;y.</p>

<p>- SPF50 + / PA ++++ Kem chống nắng hiệu quả cao bảo vệ l&agrave;n da khỏi tia UV cường độ cao, th&iacute;ch hợp cho c&aacute;c hoạt động h&agrave;ng ng&agrave;y v&agrave; ngo&agrave;i trời.</p>

<p>- Sản phẩm phun trực tiếp tr&ecirc;n da v&agrave; rất nhanh kh&ocirc;</p>

<p>&nbsp;</p>

<p>2. XANH:</p>

<p>- Xịt chống nắng jm solution marine luminous pearl sun spray spf 50 với hiệu quả chống nắng an to&agrave;n hiệu quả gi&uacute;p cho bạn c&oacute; được lớp bảo vệ da an to&agrave;n.</p>

<p>- Xịt chống nắng jm solution marine luminous pearl sun spray c&oacute; SPF50 + / PA ++++ Kem chống nắng hiệu quả cao bảo vệ l&agrave;n da khỏi tia UV cường độ cao, th&iacute;ch hợp cho c&aacute;c hoạt động h&agrave;ng ng&agrave;y v&agrave; ngo&agrave;i trời.</p>

<p>- Xịt chống nắng jm solution marine luminous pearl sun spray Chứa axit hyaluronic v&agrave; chất chiết xuất từ ngọc trai để dưỡng ẩm cho da h&agrave;ng ng&agrave;n lần, gi&uacute;p da ẩm v&agrave; mịn m&agrave;ng.</p>

<p>- Xịt chống nắng jm solution marine luminous pearl sun spray với tinh chất chống nắng SPF 50 lần chống nắng hệ số, một cửa :heart: cao ướt ướt kh&ocirc; thoải m&aacute;i kh&ocirc;ng nhờn :heart_eyes: jeju đảo s&acirc;u Sea Pearl Extract, Mỹ trắng chống l&atilde;o h&oacute;a. gi&uacute;p bạn tho&aacute;t khỏi t&aacute;c động của &aacute;nh nắng mặt trời được nu&ocirc;i dưỡng trong khoảng thời gian 12 giờ, kh&ocirc;ng bị kh&ocirc; r&aacute;o, kh&ocirc; r&aacute;o v&agrave; r&aacute;m nắng, đ&oacute; l&agrave; t&iacute;nh năng lớn nhất của sản phẩm n&agrave;y - SPF50 + / PA +Kem chống nắng hiệu quả cao bảo vệ l&agrave;n da khỏi tia UV cường độ cao, th&iacute;ch hợp cho c&aacute;c hoạt động h&agrave;ng ng&agrave;y v&agrave; ngo&agrave;i trời.</p>

<p>️️Xịt chống nắng jm solution marine luminous pearl sun spray Chứa axit hyaluronic v&agrave; chất chiết xuất từ ngọc trai để dưỡng ẩm cho da h&agrave;ng ng&agrave;n lần, gi&uacute;p da ẩm v&agrave; mịn m&agrave;ng.</p>
', 1, 0, N'xit-chong-nang-jm-solution-sun-spray-180ml', CAST(N'2021-08-18 16:02:46.340' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4134, N'Mascara Maybelline', N'Maybelline New York', N'/Uploads/images/product/pro101.jpg', N'/Uploads/images/product/pro101.jpg', 0, N'Mascara Maybelline Magnum Big Shot Volum’ Express giúp cho phái nữ tự tin hơn bởi hàng mi dài và cong vút. Đồng thời giúp tăng độ sáng và tinh anh cho đôi mắt và sản phẩm này an toàn tuyệt đối với lens, kính áp tròng. ', 2104, N'<p>Xuất xứ: MỸ</p>

<p>Thương hiệu: MAYBELLINE</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>1. Lash Sensational Volume Express:</p>

<p>&ndash; Thiết kế đơn giản, m&igrave;nh cảm thấy em n&agrave;y c&oacute; thiết kế m&agrave;u đẹp nhất trong tất cả c&aacute;c em mascara nh&agrave; Maybelline. Cầm chắc tay, sang chảnh. Gi&aacute; cả hợp l&yacute;, c&oacute; thể dễ d&agrave;ng mua tại c&aacute;c cửa h&agrave;ng si&ecirc;u thị tr&ecirc;n cả nước.</p>

<p>&ndash; Khả năng chống thấm nước tốt, &iacute;t bị lem khi chuốt.</p>

<p>&ndash; Đầu cọ được l&agrave;m bằng chất liệu mềm mại, với sợi l&ocirc;ng với độ d&agrave;i ngắn kh&aacute;c nhau, gi&uacute;p ch&uacute;ng ta dễ d&agrave;ng chải đến những chỗ kh&oacute; chuốt nhất như g&oacute;c mắt. &ndash; Chất kem kh&ocirc; kh&aacute; nhanh, gi&uacute;p tiết kiệm thời gian khi trang điểm mắt.</p>

<p>&ndash; Gi&uacute;p mi tr&ocirc;ng d&agrave;i v&agrave; tơi mi, kh&ocirc;ng hề g&acirc;y v&oacute;n cục như những loại mascara kh&aacute;c.</p>

<p>&nbsp;</p>

<p>2. The COLOSSAL Volum Express 7x:</p>

<p>- Gi&uacute;p mi tr&ocirc;ng d&agrave;y hơn, sợi mi d&agrave;i cong, v&agrave; kh&ocirc;ng bị v&oacute;n cục tr&ecirc;n h&agrave;ng mi.</p>

<p>- Mascara Maybelline n&agrave;y l&agrave; loại chống thấm nước, chống lem, mang đến cho sợi mi bạn sự chăm s&oacute;c kỹ lưỡng với gam m&agrave;u đen huyền b&iacute; t&ocirc; điểm cho đ&ocirc;i mắt bạn th&ecirc;m cuốn h&uacute;t.</p>

<p>- Đầu chải mascara được cấu tạo bởi những sợi h&oacute;a học nhỏ li ti sẽ b&aacute;m chắc v&agrave; kh&ocirc;ng bỏ s&oacute;t sợi mi dẫu c&oacute; l&agrave; ngắn v&agrave; mỏng.</p>

<p>- Đầu cọ được thiết kế kiểu mới với nhiều l&ocirc;ng hơn v&agrave; được d&agrave;n trải khắp đầu cọ. Cấu tr&uacute;c linh hoạt của loại cọ n&agrave;y cho ph&eacute;p những l&ocirc;ng cọ c&oacute; thể uyển chuyển nương theo độ cong của từng sợi mi v&agrave; những vi sợi c&oacute; thể len lỏi, b&aacute;m v&agrave;o từng sợi mi ở mọi g&oacute;c độ.</p>

<p>- Chỉ cần xoay nhẹ đầu cọ theo chiều từ trong ra ngo&agrave;i, Mascara Maybelline The Colossal Volum Express sẽ mang lại cho bạn 1 l&agrave;n mi d&agrave;i th&ecirc;m 90% v&agrave; t&aacute;ch mi. C&acirc;y mascara Colossal gi&uacute;p bạn sở hữu một h&agrave;ng mi d&agrave;i tự nhi&ecirc;n, lấp l&aacute;nh.</p>

<p>- Th&agrave;nh phần Collagen dưỡng mi, bảo vệ v&ugrave;ng nhạy cảm nơi mắt. Bạn c&oacute; thể đeo contact len m&agrave; kh&ocirc;ng sợ bị k&iacute;ch ứng bởi mascara.</p>

<p>&nbsp;</p>

<p>3. Hyper Curl:</p>

<p>- Mascara ph&ugrave; hợp với h&agrave;ng mi mỏng, thưa v&agrave; kh&ocirc;ng được d&agrave;i. Nhờ c&ocirc;ng thức tối ưu kết hợp với đầu cọ được thiết kế dễ d&agrave;ng chải tận gốc sợi mi, gi&uacute;p mascara được bao phủ hiệu quả.</p>

<p>- C&ocirc;ng thức trong mỹ phẩm Maybelline kh&ocirc;ng thấm nước, kh&ocirc;ng lem trong nước, trong m&ocirc;i trường ẩm hay da dầu.</p>

<p>- Đầu cọ Hyper Curl mới vuốt mi cong v&uacute;t 100&ordm;, chải từng sợi cho mi tơi, d&agrave;y đều.</p>

<p>- Dạng gel đặc biệt, nhẹ, mượt giữ mi cong suốt 18h, mi d&agrave;y gấp 3 lần, kh&ocirc;ng v&oacute;n cục, kh&ocirc;ng lem, kh&ocirc;ng tr&ocirc;i.</p>
', 1, 0, N'mascara-maybelline', CAST(N'2021-08-18 16:07:26.613' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4135, N'Các loại sữa rửa mặt Innisfree', N'Innisfree', N'/Uploads/images/product/pro102.jpg', N'/Uploads/images/product/pro102.jpg', 0, N'Các sản phẩm của hãng được chiết xuất từ các thành phần tự nhiên, lấy từ chính trang trại của Innisfree tại đảo Jeju. Nhờ vậy các sản phẩm đều rất sạch và lành tính, an toàn cho người sử dụng.', 2097, N'', 1, 0, N'cac-loai-sua-rua-mat-innisfree', CAST(N'2021-08-18 16:13:17.050' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4136, N'Son Kem Black Rouge Air Fit Velvet Tint Ver 1', N'Black Rouge', N'/Uploads/images/product/pro103.jpg', N'/Uploads/images/product/pro103.jpg', 0, N'Chất son kem vô cùng mềm, mịn, mướt, bền màu lâu, không gây cảm giác nứt nẻ khô môi nhưng vẫn đủ lì tạo nên một bờ môi căng mọng đầy quyến rũ.Đầu cọ được thiết kế tối ưu phù hợp giúp lấy ra một lượng son vừa đủ tán đều trên môi của bạn. Sản phẩm có 7 tone màu vô cùng thời thượng, phù hợp với nhiều tone da.', 2094, N'<p>✖️ Bảng m&agrave;u:</p>

<p>➖ A01 - Strawberry Red : Đỏ d&acirc;u</p>

<p>➖ A02 - Dry Rose : Hoa hồng kh&ocirc;</p>

<p>➖ A03 - Soft Red : Đỏ cam ch&aacute;y</p>

<p>➖ A04 - Rasberry Syrup : Đỏ thuần</p>

<p>➖ A05 - Marmalade : Cam đỏ</p>

<p>➖ A06 - Brick Red : Đỏ đất</p>

<p>➖ A07 - Pure Crimson : Cam hồng</p>
', 1, 0, N'son-kem-black-rouge-air-fit-velvet-tint-ver-1', CAST(N'2021-08-18 16:17:26.807' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4137, N'Phấn nén Shiseido Baby powder Pressed - kiềm dầu cực tốt', N'Khác', N'/Uploads/images/product/pro104.jpg', N'/Uploads/images/product/pro104.jpg', 125000, N'Phấn phủ Shiseido kết cấu bột mịn màu trắng, nhỏ gọn, dễ sử dụng, công thức nhẹ nhàng không gây kích ứng da, ngay cả da nhạy cảm, chẳng hạn như da bé. Tạo lớp phủ tự nhiên, trắng sáng, mềm mại.', 2095, N'<p>🖤🖤Phấn n&eacute;n Shiseido Baby powder Pressed - kiềm dầu cực tốt 🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 100K</p>

<p>&nbsp;</p>

<p>✖️ Xuất xứ: Nhật Bản</p>

<p>&nbsp;</p>

<p>✖️ ƯU ĐIỂM:</p>

<p>✔️ L&agrave; loại phấn r&ocirc;m n&eacute;n được sản xuất tại Nhật Bản theo đ&uacute;ng ti&ecirc;u chuẩn y tế quốc tế, &eacute;p th&agrave;nh bột mịn, m&agrave;u trắng, dễ sử dụng, nhẹ nh&agrave;ng, kh&ocirc;ng g&acirc;y kh&oacute; chịu cho da, nhất l&agrave; l&agrave;n da nhạy cảm của trẻ nhỏ. L&agrave;m cho trẻ lu&ocirc;n cảm thấy thoải m&aacute;i, tr&aacute;nh r&ocirc;m sẩy.</p>

<p>✔️ Loại n&agrave;y cũng c&oacute; thể d&ugrave;ng cho c&aacute;c mẹ c&oacute; l&agrave;n da nhạy cảm, da dầu. L&agrave; 1 loại phấn dưỡng da l&agrave;nh t&iacute;nh, ho&agrave;n to&agrave;n kh&ocirc;ng ch&igrave; - kh&ocirc;ng m&ugrave;i, l&agrave;m s&aacute;ng da, bảo vệ l&agrave;n da khỏi kh&oacute;i bụi &ocirc; nhiễm m&ocirc;i trường.</p>

<p>✔️ Kiềm dầu cực tốt, đ&aacute;nh l&ecirc;n cực kỳ tự nhi&ecirc;n, kh&ocirc;ng trắng bệch, kh&ocirc;ng hề c&oacute; cảm gi&aacute;c l&agrave; đ&aacute;nh phấn, giữ đc cả ng&agrave;y v&igrave; l&agrave; phấn dưỡng da n&ecirc;n ngấm v&agrave;o da như kem dưỡng chứ kh&ocirc;ng như phấn make up c&oacute; ch&igrave;.</p>

<p>✔️ Đặc biệt ẻm c&ograve;n được nhiều c&ocirc; n&agrave;ng da dầu/ mụn/ nhạy cảm &quot;sủng &aacute;i&quot; nhờ th&agrave;nh phần 100% kh&ocirc;ng ch&igrave; n&ecirc;n rất l&agrave;nh t&iacute;nh v&agrave; dịu nhẹ cho da.</p>

<p>✔️ Phấn kiềm dầu cực kỳ tốt, đ&aacute;nh l&ecirc;n si&ecirc;u mịn m&agrave;ng, si&ecirc;u tự nhi&ecirc;n, kh&ocirc;ng g&acirc;y cảm gi&aacute;c trắng bệch v&agrave; kh&ocirc;ng hề c&oacute; cảm gi&aacute;c l&agrave; đ&aacute;nh phấn lu&ocirc;n ấy.</p>

<p>✔️ Phấn d&ugrave;ng rất th&iacute;ch, l&agrave;nh t&iacute;nh, mịn tự nhi&ecirc;n, v&agrave; đặc biệt l&agrave; trẻ sơ sinh d&ugrave;ng được m&agrave; kh&ocirc;ng hề c&oacute; bất kỳ phản ứng n&agrave;o.</p>

<p>✔️ Đặc biệt sản phẩm c&oacute; m&ugrave;i hương thoang thoảng như m&ugrave;i sữa em b&eacute;, khiến nhiều c&ocirc; n&agrave;ng m&ecirc; mẩn ngay từ khi mới bắt đầu sử dụng.</p>

<p>✔️ Thiết kế dạng hộp tr&ograve;n đ&uacute;ng phong c&aacute;ch đơn giản.</p>
', 1, 0, N'phan-nen-shiseido-baby-powder-pressed---kiem-dau-cuc-tot', CAST(N'2021-08-18 16:24:36.763' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4138, N'Set Innisfree 4 món', N'Innisfree', N'/Uploads/images/product/pro105.jpg', N'/Uploads/images/product/pro105.jpg', 0, N'Là dòng sản phẩm mới 2019 dành riêng cho da thường & da hỗn hợp thiên dầu & da bị mụn.Dưỡng ẩm cấp nước cho da luôn giữ độ ẩm cân bằng, đồng thời hạn chế bã nhờn hiệu quả.', 2116, N'<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>1. Green Tea Special Kit EX:</p>

<p>- Green Tea Balancing Skin (25ml): Nước hoa hồng gi&uacute;p hạn chế dầu nhờn tiết ra, se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng v&agrave; giảm mụn, lấy lại sức sống cho l&agrave;n da mệt mỏi.</p>

<p>- Green Tea Balancing Lotion (25ml): Sữa dưỡng cung cấp độ ẩm v&agrave; l&agrave;m da mềm mịn, tươi tắn rạng rỡ hơn. ️️</p>

<p>- Green Tea Seed Serum (15ml): Chiết xuất từ 100% hạt tr&agrave; xanh nguy&ecirc;n chất v&agrave; nước &eacute;p tr&agrave; xanh gi&agrave;u acid amin v&agrave; c&aacute;c kho&aacute;ng chất gi&uacute;p dưỡng ẩm v&agrave; nu&ocirc;i dưỡng da từ s&acirc;u b&ecirc;n trong, gi&uacute;p cho da khỏe mạnh.</p>

<p>- Green Tea Balancing Cream (10ml): Kem dưỡng ẩm s&acirc;u cho da th&ecirc;m mịn m&agrave;ng v&agrave; tăng cường collagen gi&uacute;p da săn chắc trẻ trung.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>2. Jeju Cherry Blossom Special Kit:</p>

<p>- Jeju Cherry Blossom Skin (15ml): C&acirc;n bằng độ pH cho da, gi&uacute;p l&agrave;m sạch da v&agrave; dưỡng ẩm da Bổ sung dưỡng chất nu&ocirc;i dưỡng l&agrave;n da trắng hồng tự nhi&ecirc;n.</p>

<p>- Jeju Cherry Blossom Lotion (15ml): Bổ sung độ ẩm, dưỡng trắng da, k&iacute;ch th&iacute;ch sản sinh collagen gi&uacute;p da đ&agrave;n hồi, săn chắc, tươi trẻ hơn. Kết cấu dạng sữa thẩm thấu nhanh, kh&ocirc;ng tạo cảm gi&aacute;c bết d&iacute;nh tr&ecirc;n da.</p>

<p>- Jeju Cherry Blossom Tone Up Cream (5ml): Dưỡng trắng, n&acirc;ng t&ocirc;ng tức th&igrave; gi&uacute;p da s&aacute;ng hồng tự nhi&ecirc;n. Chất kem m&agrave;u hồng c&oacute; thể sử dụng l&agrave;m kem l&oacute;t khi make up tiện lợi lắm lu&ocirc;n.</p>

<p>- Jeju Cherry Blossom Jelly Cream (5ml): Cung cấp độ ẩm, dưỡng chất nu&ocirc;i dưỡng da căng mịn, tăng độ đ&agrave;n hồi, chống oxy h&oacute;a v&agrave; hỗ trợ dưỡng s&aacute;ng da Chất gel trong veo như thạch, khi thoa l&ecirc;n da cảm gi&aacute;c m&aacute;t lạnh rất dễ chịu v&agrave; thẩm thấu nhanh l&ecirc;n da.</p>
', 1, 0, N'set-innisfree-4-mon', CAST(N'2021-08-18 16:29:33.170' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4139, N'CỌ MẮT VACOSI MOUSSE 02 ĐẦU CÁN ĐEN - CM13', N'Vacosi', N'/Uploads/images/product/pro106.jpg', N'/Uploads/images/product/pro106.jpg', 5000, N'Trang điểm mắt bằng cọ mousse dễ dàng sử dụng, ngay cả những bạn mới làm quen với việc trang điểm.', 2096, N'<p>- Đầu cọ thiết kế 2 đầu, b&aacute;m phấn tốt v&agrave; mềm mại tuyệt đối cho v&ugrave;ng da mắt nhạy cảm.</p>

<p>- Trang điểm mắt bằng cọ mousse dễ d&agrave;ng sử dụng, ngay cả những bạn mới l&agrave;m quen với việc trang điểm. Gi&uacute;p t&aacute;n phấn mắt dễ d&agrave;ng.</p>

<p>- D&ugrave;ng với sản phẩm: dạng bột (powder), kem (cream)</p>

<p>- Ưu điểm nổi bật:</p>

<p>Nhỏ gọn, dễ d&agrave;ng mang theo.</p>

<p>Tiện &iacute;ch, đa chức năng.</p>

<p>Chất liệu mousse &ecirc;m &aacute;i cho v&ugrave;ng da nhạy cảm.</p>
', 1, 0, N'co-mat-vacosi-mousse-02-dau-can-den---cm13', CAST(N'2021-08-18 16:32:09.463' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4140, N'Xà Phòng ForBacck', N'Khác', N'/Uploads/images/product/pro107.jpg', N'/Uploads/images/product/pro107.jpg', 110000, N'Xà Phòng Làm Giảm Mụn Lưng For Back Medicated Soap đến từ thương hiệu Pelican với khả năng diệt khuẩn và làm sạch sâu sản phẩm sẽ giúp giảm tình trạng mụn lưng hiệu quả. Sản phẩm được đánh giá khá cao trong nhóm sản phẩm hỗ trợ làm giảm mụn lưng trên các trang web bán hàng trực tiếp và review mỹ phẩm uy tín tại Nhật Bản bao gồm Amazon và Cosme. ', 2099, N'<h2>&nbsp;</h2>

<p><strong>Ưu điểm nổi bật của sản phẩm</strong>:<br />
Sử dụng Pelican For Back 135g mỗi ng&agrave;y gi&uacute;p hỗ trợ cải thiện t&igrave;nh trạng mụn ở lưng, thẩm thấu s&acirc;u v&agrave;o lỗ ch&acirc;n l&ocirc;ng, hỗ trợ thải độc da, loại bỏ b&atilde; nhờn, bụi bẩn<br />
Chứa th&agrave;nh phần chiết xuất từ rễ cam thảo, c&aacute;c th&agrave;nh phần dưỡng ẩm, cho l&agrave;n da lu&ocirc;n mềm mịn, tự nhi&ecirc;n<br />
X&agrave; ph&ograve;ng Pelican c&oacute; m&ugrave;i hương cam chanh rất dễ chịu<br />
Sử dụng Pelican For Back Medicated mỗi ng&agrave;y t&igrave;nh trạng mụn ở lưng sẽ được cải thiện r&otilde; rệt<br />
<br />
<strong>Th&agrave;nh phần ch&iacute;nh</strong><br />
Than hoạt t&iacute;nh v&agrave; b&ugrave;n kho&aacute;ng, Papain, triclosan, Glycyrrhizin Dipotssium, Glycerin&hellip;</p>

<p><strong>Hướng dẫn sử dụng</strong></p>

<p>&ndash; L&agrave;m ướt cơ thể, ch&agrave; x&agrave; ph&ograve;ng l&ecirc;n phần da bị mụn hoặc to&agrave;n bộ cơ thể.</p>

<p>&ndash; Tạo bọt, massage to&agrave;n th&acirc;n trong khoảng 3-4 ph&uacute;t.</p>

<p>&ndash; Ch&agrave; kỹ phần lưng với khăn hoặc dụng cụ ch&agrave; lưng.</p>

<p>&ndash; Rửa sạch lại v&agrave; lau kh&ocirc; người.</p>

<p>&ndash; Bạn n&ecirc;n lu&ocirc;n gội đầu trước khi tắm. V&igrave; nếu gội đầu sau, dầu gội rất dễ bị s&oacute;t lại tr&ecirc;n lưng, tạo điều kiện l&yacute; tưởng cho vi khuẩn g&acirc;y mụn ph&aacute;t triển.</p>
', 1, 0, N'xa-phong-forbacck', CAST(N'2021-08-18 16:34:22.367' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4141, N'Kẻ mắt dạ Karadium', N'Karadium', N'/Uploads/images/product/pro108.jpg', N'/Uploads/images/product/pro108.jpg', 0, N'Bút dạ kẻ mắt Karadium Waterproof Brush Liner Black là sản phẩm bút dạ kẻ mắt từ hãng mỹ phẩm Hàn Quốc Karadium, với đầu bút được thiết kế mang chất liệu dạ sáng tạo, ngòi bút thanh và gọn, bạn sẽ dễ dàng tạo dáng chuẩn cho bờ mi, làm dày đôi mi tạo chiều sâu cho đôi mắt, làm dài đuôi mi mắt, nhấn mạnh rõ đường mi mắt.', 2104, N'<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>- Đặc điểm chung: Cả 2 bản đều chống nước, chống lem, mực m&agrave;u đen.</p>

<p>- Kh&aacute;c nhau:</p>

<p>+ Vỏ trắng: N&eacute;t vẽ mảnh, đầu l&ocirc;ng mềm.</p>

<p>+ Vỏ đen: N&eacute;t vẽ to hơn, đầu l&ocirc;ng cứng hơn.</p>
', 1, 0, N'ke-mat-da-karadium', CAST(N'2021-08-18 16:37:07.273' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4142, N'Kem phục hồi da, liền sẹo Avène Cicalfate Cream 50ml', N'Khác', N'/Uploads/images/product/pro109.jpg', N'/Uploads/images/product/pro109.jpg', 230000, N'Kem Tái Tạo Và Phục Hồi Da Avene Cicalfate Repair Cream cực kì được ưa thích và tin dùng của Avene với rất nhiều review khen ngợi trên khắp các diễn đàn làm đẹp và với nhiều cô gái, đây là sản phẩm “chữa cháy” các vết sẹo mụn một cách hiệu quả nhất.', 2107, N'<p>- Thương hiệu: Avene</p>

<p>- Xuất xứ: Ph&aacute;p</p>

<p>- Dung t&iacute;ch: 50ml</p>

<p>&nbsp;</p>

<p>- Xuất hiện như một ph&eacute;p m&agrave;u &ldquo;đập tan&rdquo; nỗi &aacute;m ảnh của ch&uacute;ng ta về sẹo. Chẳng hề k&eacute;n chọn, sản phẩm nh&agrave; Avene ph&ugrave; hợp với bất kỳ l&agrave;n da n&agrave;o từ nhạy cảm. Ngay từ khi ra mắt đ&atilde; trở th&agrave;nh dược mỹ phẩm được c&aacute;c chuy&ecirc;n gia da liễu khuy&ecirc;n d&ugrave;ng trong điều trị sẹo, l&agrave;m mờ th&acirc;m tại c&aacute;c v&ugrave;ng da tr&ecirc;n cơ thể.</p>

<p>- Kem liền sẹo, l&agrave;m mờ vết th&acirc;m Avene Cicalfate Creme Reparatrice l&agrave; sản phẩm &ldquo;l&yacute; tưởng&rdquo; trong điều trị da m&agrave; bạn kh&ocirc;ng n&ecirc;n bỏ qua bởi những t&aacute;c dụng vượt trội m&agrave; em n&oacute; mang lại:</p>

<p>+ Liền sẹo nhanh ch&oacute;ng: Em n&oacute; sở hữu c&aacute;c hoạt chất &ldquo;v&agrave;ng&rdquo; trong l&agrave;ng trị sẹo, gi&uacute;p k&iacute;ch th&iacute;ch, đẩy nhanh chu tr&igrave;nh hồi phục da, l&agrave;m liền vết thương, tr&aacute;nh để lại sẹo.</p>

<p>+ Kh&aacute;ng khuẩn: C&aacute;c hợp chất Sulfate từ Kẽm v&agrave; Đồng gi&uacute;p s&aacute;t khuẩn v&ugrave;ng da tổn thương hiệu quả, ngăn chặn xuất hiện nhiễm tr&ugrave;ng tr&ecirc;n da.</p>

<p>+ L&agrave;m dịu da: C&aacute;c kho&aacute;ng chất dồi d&agrave;o được bổ sung b&ecirc;n trong sản phẩm sẽ hấp thụ v&agrave;o da, nhanh ch&oacute;ng l&agrave;m dịu, gi&uacute;p da được thư gi&atilde;n.</p>

<p>+ L&agrave;m mờ vết th&acirc;m: Cực kỳ hiệu quả với c&aacute;c v&ugrave;ng da xuất hiện sẹo th&acirc;m. Ngay lập tức c&aacute;c hoạt chất b&ecirc;n trong sản phẩm sẽ thẩm thấu v&agrave;o da, ph&aacute; vỡ c&aacute;c gốc melanin g&acirc;y n&ecirc;n th&acirc;m sạm.</p>

<p>+ Đặc biệt, s&aacute;n phẩm l&agrave;nh t&iacute;nh đến mức bạn c&oacute; thể d&ugrave;ng trong điều trị da cho trẻ nhỏ. Ch&iacute;nh những điều n&agrave;y đ&atilde; gi&uacute;p sản phẩm chiếm được l&ograve;ng tin của kh&aacute;ch h&agrave;ng v&agrave; giới chuy&ecirc;n m&ocirc;n.</p>

<p>+ H&atilde;y trang bị cho m&igrave;nh một tu&yacute;p nếu bạn đang gặp những tổn thương, c&oacute; nguy cơ để lại sẹo, hoặc đơn giản l&agrave; muốn điều trị c&aacute;c vết th&acirc;m do mụn.</p>
', 1, 0, N'kem-phuc-hoi-da-lien-seo-avene-cicalfate-cream-50ml', CAST(N'2021-08-18 16:40:26.857' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4143, N'Kem chống nắng trắng da Karadium Sun Cream SPF 50 PA+++', N'Karadium', N'/Uploads/images/product/pro110.jpg', N'/Uploads/images/product/pro110.jpg', 170000, N'Kem chống nắng trắng da Karadium Sun Cream Hàn Quốc có tác động SPF 50+ giúp bảo vệ da khỏi tác động của tia cực tím và những tác nhân xấu từ môi trường, nó giúp bạn hoàn toàn tự tin vui chơi và nô đùa dưới cái nắng của mùa hè mà không lo da bị sạm đen hay tàn nhang', 2101, N'<p>✖️ Review:</p>

<p>&ndash; Thiết kế m&agrave;u trắng bắt mắt, tu&yacute;p kem xinh xắn với đầu cho kem ra được lộn ngược gi&uacute;p kem được cho ra dễ d&agrave;ng, nắp kem m&agrave;u bạc rất sang.</p>

<p>&ndash; Sản phẩm c&oacute; m&ugrave;i thơm dễ chịu, kh&ocirc;ng gắt như c&aacute;c sản phẩm kh&aacute;c. Chất kem rất mịn, kem b&aacute;m rất l&igrave;, trong suốt tự nhi&ecirc;n, che khuyết điểm rất tốt, l&agrave;m da s&aacute;ng ngay lập tức nhưng kh&ocirc;ng bị trắng bệch m&agrave; trắng rất tự nhi&ecirc;n. Kh&ocirc;ng l&agrave;m kh&ocirc; da hay kem bị qu&aacute; lỏng như hầu hết c&aacute;c kem chống nắng kh&aacute;c.</p>

<p>&ndash; Kem nhiều dưỡng gi&uacute;p da trắng l&ecirc;n sau 1 thời gian sử dụng. Chị em c&oacute; thể d&ugrave;ng n&oacute; để l&agrave;m nền trang điểm. Lỗ ch&acirc;n l&ocirc;ng cũng đc thu nhỏ dần.</p>

<p>&ndash; Chỉ số chống nắng SPF 50+: chống nắng hiệu quả trong thời gian d&agrave;i.</p>

<p>&nbsp;</p>

<p>✖️ HDSD: C&aacute;c bạn thực hiện chăm s&oacute;c da mặt như l&agrave;m sạch da, thoa nước hoa hồng&hellip; sau đ&oacute; c&aacute;c bạn thoa kem chống nắng trắng da Karadium Sun Cream H&agrave;n Quốc l&ecirc;n. C&aacute;c bạn cũng c&oacute; thể thoa th&ecirc;m phấn nếu th&iacute;ch. N&ecirc;n thoa kem trước khi ra nắng 20 ph&uacute;t để đảm bảo chất lượng.</p>
', 1, 0, N'kem-chong-nang-trang-da-karadium-sun-cream-spf-50-pa', CAST(N'2021-08-18 20:54:37.330' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4144, N'SON MERZY KEM', N'Merzy', N'/Uploads/images/product/pro111.jpg', N'/Uploads/images/product/pro111.jpg', 0, N'Son kem lì Merzy The First Velvet Tint là son kem lì thuộc dòng Velvet tint của thương hiệu Merzy có chất son vượt trội cùng độ lên màu chuẩn, mịn mướt không hề làm bay màu hay lộ vân môi, độ bám màu hoàn hảo cùng bảng màu đa dạng và phong phú giúp đôi môi bạn luôn đẹp suốt cả ngày ', 2094, N'<p>🖤🖤SON MERZY KEM🖤🖤</p>

<p>💲 GI&Aacute; LẺ: #145k</p>

<p>-Xuất xứ: H&agrave;n Quốc</p>

<p>- Thương hiệu: Merzy</p>

<p>&nbsp;</p>

<p>✖️ BẢNG M&Agrave;U:</p>

<p>➡️ M&agrave;u V1 Bloody Mary &ndash; đỏ hồng dịu ngọt</p>

<p>➡️ M&agrave;u V2 Jack Rose &ndash; hồng san h&ocirc; nhẹ nh&agrave;ng</p>

<p>➡️ M&agrave;u V3 Cassis Orange &ndash; cam đỏ trẻ trung</p>

<p>➡️ M&agrave;u V4 Shirley Temple &ndash; hồng cam đỏ nữ t&iacute;nh</p>

<p>➡️ M&agrave;u V5 Peach Crush &ndash; hồng đ&agrave;o đ&aacute;ng y&ecirc;u</p>

<p>➡️ M&agrave;u V6 Firenze Negroni &ndash; đỏ gạch quyến rũ</p>
', 1, 0, N'son-merzy-kem', CAST(N'2021-08-18 20:59:17.973' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4145, N'Bút Kẻ Mắt Nước Không Trôi Isehan Kiss Me Heroine Make Waterproof Liquid Eyeliner', N'Khác', N'/Uploads/images/product/pro112.jpg', N'/Uploads/images/product/pro112.jpg', 165000, N'Bút Kẻ Mắt Nước Không Trôi Isehan Kiss Me Heroine Make Waterproof Liquid Eyeliner là dòng bút kẻ mắt nước được ưa chuộng nhất đến từ thương hiệu Isehan nổi tiếng của Nhật Bản. Sản phẩm sẽ là người bạn đồng hành giúp cho đôi mắt của bạn thêm to tròn, long lanh và quyến rũ thu hút mọi ánh nhìn của người đối diện.', 2104, N'<p>Xuất xứ: Nhật Bản</p>

<p>Thương hiệu: Isehan</p>

<p>Dung t&iacute;ch: 0.4ml</p>

<p>&nbsp;</p>

<p>Ưu điểm nổi bật:</p>

<p>- B&uacute;t kẻ mắt nước Isehan Kiss Me Heroine Make Waterproof Liquid Eyeliner với c&ocirc;ng nghệ đột ph&aacute; ri&ecirc;ng biệt gi&uacute;p cho kết cấu gel c&oacute; độ b&aacute;m d&iacute;nh v&agrave;o da cao, kh&ocirc;ng thấm nước n&ecirc;n d&ugrave; c&oacute; đổ mồ h&ocirc;i, rửa mặt với nước hay bất chợt gặp trời mưa th&igrave; đường eyeliner vẫn được giữ nguy&ecirc;n vẹn, kh&ocirc;ng lem, kh&ocirc;ng mờ ho&agrave;n hảo suốt cả ng&agrave;y.</p>

<p>- M&agrave;u của b&uacute;t kẻ mắt lần n&agrave;y kh&ocirc;ng những đa dạng m&agrave; c&ograve;n l&ecirc;n m&agrave;u cực chuẩn, sắc độ ấn tượng v&agrave; ph&ugrave; hợp với mọi phong c&aacute;ch từ dễ thương đến c&aacute; t&iacute;nh.</p>

<p>- Sản phẩm c&oacute; thiết kế đầu cọ mảnh, mềm mại gi&uacute;p cho ra được đường kẻ chuẩn x&aacute;c v&agrave; dễ d&agrave;ng điều chỉnh độ đậm nhạt, mỏng d&agrave;y của eyeliner theo &yacute; th&iacute;ch.</p>

<p>- Với th&agrave;nh phần c&oacute; chiết xuất từ tinh chất hoa c&uacute;c tự nhi&ecirc;n n&ecirc;n sản phẩm c&oacute; m&ugrave;i hương rất dễ chịu, kh&ocirc;ng g&acirc;y k&iacute;ch ứng da v&agrave; đem lại sự mịn m&agrave;ng tuyệt đối cho đường kẻ mắt.</p>

<p>- Lưu &yacute;: Lắc nhẹ sản phẩm trước khi sử dụng.</p>
', 1, 0, N'but-ke-mat-nuoc-khong-troi-isehan-kiss-me-heroine-make-waterproof-liquid-eyeliner', CAST(N'2021-08-18 21:02:49.227' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4146, N'Kem Lót CATRICE Prime and Fine', N'Catrice', N'/Uploads/images/product/pro113.jpg', N'/Uploads/images/product/pro113.jpg', 0, N'Kem lót CATRICE Prime and Fine Pore Refining Anti-Shine Base có tác dụng kiềm dầu, giảm độ bóng da không mong muốn, và làm se lỗ chân lông; với công thức siêu nhẹ giúp cải thiện độ bền của lớp make up, giữ lớp trang điểm lâu trôi, là sản phẩm trang điểm không thể thiếu của các chị em  đồng thời còn dưỡng da, bảo vệ da khỏi lớp make up và khói bụi từ môi trường.', 2095, N'<p>- Xu&acirc;́t xứ : Đức.</p>

<p>- Thương hi&ecirc;̣u : Catrice.</p>

<p>- Trọng lượng : 30ml.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>- Poreless Blur Primer Goodbye Pores (M&agrave;u Hồng):</p>

<p>+ hiết xuất từ ngọc trai v&agrave; vitamin E l&agrave;m cho da mịn đẹp v&agrave; đều m&agrave;u, s&aacute;ng hồng rạng rỡ. Thậm ch&iacute; chỉ cần d&ugrave;ng một lớp kem l&oacute;t cũng khiến da mặt mịn đẹp, s&aacute;ng hồng m&agrave; kh&ocirc;ng cần trang điểm th&ecirc;m nhiều.</p>

<p>+ Chất kem mềm mịn, dễ b&aacute;m v&agrave;o da m&agrave; kh&ocirc;ng g&acirc;y nhờn d&iacute;nh, kh&oacute; chịu.</p>

<p>+ Được chiết xuất từ ngọc trai v&agrave; vitamin E gi&uacute;p mang lại l&agrave;n da đều m&agrave;u, mịn m&agrave;ng. Đồng thời kem l&oacute;t được bổ sung dưỡng chất chăm s&oacute;c da, tr&aacute;nh t&igrave;nh trạng hư bị hư tổn do trang điểm qu&aacute; nhiều, mang lại cho bạn l&agrave;n da khỏe mạnh hơn, thu nhỏ lỗ ch&acirc;n l&ocirc;ng.</p>

<p>+ Được cải tiến với khả năng kiềm dầu v&agrave; giảm độ b&oacute;ng da, gi&uacute;p giữ được lớp make up l&acirc;u tr&ocirc;i trong nhiều giờ đồng hồ.</p>

<p>+ Gi&uacute;p kiềm dầu tr&ecirc;n da để lớp make up giữ được l&acirc;u tr&ecirc;n gương mặt mặt qua nhiều 1 thời gian d&agrave;i vẫn rạng rỡ m&agrave; kh&ocirc;ng lo xỉn m&agrave;u.</p>

<p>+ Kem l&oacute;t kh&ocirc;ng chỉ mang lại hiệu ứng da mịn m&agrave;ng, đều m&agrave;u m&agrave; c&ograve;n gi&uacute;p dưỡng da từ s&acirc;u b&ecirc;n trong, gi&uacute;p se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng v&agrave; mang lại l&agrave;n da khỏe mạnh.</p>

<p>&nbsp;</p>

<p>- Pore Refining Anti-Shine Base Keep Me Matt (M&agrave;u Trắng):</p>

<p>+ &agrave;nh cho da dầu, c&oacute; t&aacute;c dụng kiềm dầu v&agrave; se kh&iacute;t l&ocirc; ch&acirc;n l&ocirc;ng. Ngo&agrave;i t&aacute;c dụng giữ cho lớp trang điểm l&acirc;u tr&ocirc;i, c&ograve;n c&oacute; t&aacute;c dụng dưỡng da, bảo vệ lớp make up khỏi kh&oacute;i bụi v&agrave; da sẽ tr&ocirc;ng đẹp v&agrave; khỏe hơn khi dầu được kiểm so&aacute;t v&agrave; lỗ ch&acirc;n l&ocirc;ng nhỏ hơn.</p>

<p>+ Kiềm dầu v&agrave; v&agrave; giảm độ b&oacute;ng tr&ecirc;n da</p>

<p>+ Se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng</p>

<p>+ Bảo vệ lớp trang điểm l&acirc;u tr&ocirc;i</p>

<p>+ Mỏng nhẹ v&agrave; kh&ocirc;ng nhờn d&iacute;nh</p>

<p>+ Duỡng da</p>

<p>+ Dưỡng da, bảo vệ lớp make up khỏi kh&oacute;i bụi v&agrave; da sẽ tr&ocirc;ng đẹp v&agrave; khỏe hơn khi dầu được kiểm so&aacute;t v&agrave; lỗ ch&acirc;n l&ocirc;ng nhỏ hơn.</p>
', 1, 0, N'kem-lot-catrice-prime-and-fine', CAST(N'2021-08-18 21:05:42.313' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4147, N'Dầu gội xả - ủ tóc Tigi màu đỏ', N'Tigi', N'/Uploads/images/product/pro114.jpg', N'/Uploads/images/product/pro114.jpg', 0, N'TIGI hay còn được gọi với cái tên khác “Tony&Guy” đây là một thương hiệu chuyên về các sản phẩm chăm sóc tóc tại Mỹ. Các sản phẩm của hãng được đánh giá hàng đầu hiện nay trong lĩnh vực chăm sóc tóc. Thương hiệu này đã nhận được hơn 50 giải thưởng danh giá trong ngành công nghiệp tóc và đã có mặt ở hơn 400 Salon chăm sóc tóc chuyên nghiệp trên toàn thế giới.
', 2114, N'<p>✖️ GỘI XẢ TIGI:</p>

<p>- Dầu gội c&oacute; chứa phức hợp hạt nano si&ecirc;u nhỏ b&aacute;m v&agrave;o v&ugrave;ng t&oacute;c bị hư tổn. Nano: giống như một lớp &aacute;o cho&agrave;ng bảo vệ t&oacute;c. Những hạt nano n&agrave;y c&oacute; thể b&aacute;m d&iacute;nh v&agrave;o t&oacute;c bởi bao quanh ch&uacute;ng l&agrave; lớp m&agrave;ng t&iacute;ch điện dương (t&oacute;c t&iacute;ch điện &acirc;m).</p>

<p>- Đặc điểm kh&aacute;c biệt của dầu gội Tigi m&agrave;u đỏ với những sản phẩm chứa Silicon kh&aacute;c: Đ&oacute; l&agrave; trọng lượng những ph&acirc;n tử Silicon v&agrave; c&aacute;ch thức ch&uacute;ng b&aacute;m v&agrave;o sơi t&oacute;c kh&aacute;c nhau. Do vậy, tạo cho t&oacute;c cảm gi&aacute;c khỏe khoắn hơn v&agrave; kh&ocirc;ng g&acirc;y nặng t&oacute;c hay bết d&iacute;nh. C&aacute;c ph&acirc;n tử Sillicon sẽ b&aacute;m v&agrave;o t&oacute;c, tạo một lớp &aacute;o gi&aacute;p chắc khỏe. Từ đ&oacute; gi&uacute;p t&oacute;c b&oacute;ng khỏe, mềm mượt hơn.</p>

<p>&nbsp;</p>

<p>✖️ Ủ T&Oacute;C TIGI:</p>

<p>+ Cung cấp dưỡng chất để t&oacute;c vượt qua t&igrave;nh trạng hư tổn nặng</p>

<p>+ Cung cấp độ ẩm gi&uacute;p t&oacute;c mềm mượt, giảm xơ rối v&agrave; g&atilde;y rụng</p>

<p>+ Bảo vệ t&oacute;c trước t&aacute;c động của nhiệt độ v&agrave; m&ocirc;i trường, hỗ trợ tạo kiểu</p>

<p>+ Bạn c&oacute; biết protein l&agrave; nguy&ecirc;n liệu ch&iacute;nh để sản xuất ra lớp keratin tr&ecirc;n t&oacute;c kh&ocirc;ng? M&agrave; keratin ch&iacute;nh l&agrave; lớp biểu b&igrave; của th&acirc;n t&oacute;c, n&oacute; được v&iacute; như lớp vảy c&aacute; bảo vệ sợi t&oacute;c khỏi t&aacute;c động bất lợi của b&ecirc;n ngo&agrave;i. Căn cứ v&agrave;o đặc điểm của t&oacute;c l&agrave; lớp vảy t&oacute;c đ&atilde; bị mở tối đa v&agrave; kh&ocirc;ng c&oacute; khả năng kh&eacute;p lại, ch&iacute;nh bởi vậy, nước v&agrave; h&oacute;a chất dễ th&acirc;m nhập nhưng cũng nhanh bị tho&aacute;t ra ngo&agrave;i, v&igrave; vậy t&oacute;c dễ kh&ocirc; xơ. Một sản phẩm c&oacute; khả năng phục hồi tốt kh&ocirc;ng chỉ gi&uacute;p kh&eacute;p lại lớp vảy b&ecirc;n ngo&agrave;i th&acirc;n t&oacute;c m&agrave; c&ograve;n gi&uacute;p trị liệu, khắc phục hư tổn từ b&ecirc;n trong l&otilde;i t&oacute;c.</p>

<p>+ Hấp phục hồi TIGI &ndash; Với c&ocirc;ng nghệ phục hồi l&otilde;i t&oacute;c, mặt nạ chữa trị phục hồi protein b&ecirc;n trong, gi&uacute;p t&oacute;c khỏe hơn, giảm gẫy rụng, ngăn ngừa t&oacute;c gẫy rụng, ph&ugrave; hợp với t&oacute;c d&agrave;y, kh&ocirc; xơ hoặc hư tổn nặng. C&oacute; thể khẳng định, Hấp phục hồi TIGI chữa trị hư tổn mức độ 3 200ml ch&iacute;nh l&agrave; sản phảm gi&uacute;p việc phục hồi t&oacute;c diễn ra ho&agrave;n hảo v&agrave; to&agrave;n diện.</p>
', 1, 0, N'dau-goi-xa---u-toc-tigi-mau-do', CAST(N'2021-08-18 21:14:05.597' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4148, N'Son Black Rouge Air Fit Velvet Tint Ver.6 BLUEMING GARDEN', N'Black Rouge', N'/Uploads/images/product/pro115.jpg', N'/Uploads/images/product/pro115.jpg', 0, N'Đến hẹn lại lên, Black Rouge ra mắt bộ sưu tập mới Blueming Garden với chủ đề đầy thơ mộng, tựa khu vườn bí mật đầy sắc hoa nở rộ, như đưa bạn chạm đến những cánh hoa mềm mại đa sắc. Một bộ sưu tập đầy nữ tính và mộng mơ!', 2094, N'<p>Qu&ecirc;n 3CE Blue điii... đ&acirc;y mới l&agrave; bản Blue m&agrave; chị em n&ecirc;n sở hữu m&ugrave;a h&egrave; n&agrave;y! Black Rouge Ver.6 BLUEMING GARDEN 😍😍 Bởi v&igrave; sao:</p>

<p>A28 Đỏ cam, ánh vàng</p>

<p>A29 Đỏ hồng lạnh</p>

<p>A30 Đỏ hồng đậm</p>

<p>A31 Đỏ nâu trầm, ánh cam nhẹ</p>

<p>A32 Nâu đất thẫm</p>

<p>&nbsp;</p>

<p>- Mẫu son ho&agrave;n to&agrave;n mới, m&agrave;u son mới, nhiều m&agrave;u để lựa chọn theo sở th&iacute;ch thay v&igrave; chỉ thay mỗi vỏ đỏ th&agrave;nh xanh, chỉ 1 m&agrave;u son SpeakUp 3CE cũ đ&oacute; xưa nay kh&aacute; bị hắt hủi.</p>

<p>- Tại sao phải bỏ ra số tiền đắt gấp đ&ocirc;i chỉ để đổi vỏ đỏ th&agrave;nh xanh? Trong khi Blackrouge Blue mẫu mới em vẫn sẽ b&aacute;n gi&aacute; như mẫu cũ #135k thui nhaa 😍😍</p>

<p>- Chất son BlackRouge mẫu mới lu&ocirc;n cải tiến chất lượng so với mẫu cũ, d&ugrave;ng th&iacute;ch hơn. Trong khi đ&oacute; 3CE chỉ l&agrave; mẫu cũ từ mấy năm rồi, chất kh&aacute; ch&aacute;n, c&ograve;n thua cả 3CE Kem Cloud Lip Tint l&agrave; mẫu mới ra mắt năm ngo&aacute;i.</p>

<p>- H&agrave;ng chuẩn 100% từ H&agrave;n đầy đủ team HiddenTag thay v&igrave; săn đ&oacute;n một mẫu từ TQ m&agrave; thị trường đang tr&agrave;n lan 3CE Blue fake.</p>
', 1, 0, N'son-black-rouge-air-fit-velvet-tint-ver6-blueming-garden', CAST(N'2021-08-18 21:18:20.607' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4149, N'KEM NỀN CATRICE 24H', N'Catrice', N'/Uploads/images/product/pro116.jpg', N'/Uploads/images/product/pro116.jpg', 0, N'Kem nền Catrice HD Liquid Coverage Foundation 24h chính hãng Đức  là một dòng kem nền tuyệt vời, giá lại rất phải chăng, có mùi thơm dịu nhẹ. Tạo ra một lớp nền mỏng, đều màu, trong suốt. với công dụng vượt trội chắc chắn là giải pháp cho lớp trang điểm hoàn hảo của bạn.', 2095, N'<p>🖤🖤KEM NỀN CATRICE 24H🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 185K</p>

<p>✖️ XUẤT XỨ: Italia</p>

<p>✖️ THƯƠNG HIỆU: Catrice</p>

<p>✖️ DUNG T&Iacute;CH: 30ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Bản dupe si&ecirc;u phẩm của NudeAir gi&aacute; qu&aacute; đỗi mềm với chất lượng m&agrave; sản phẩm c&oacute; thể mang lại . Độ bền đỉnh của đỉnh c&ugrave;ng độ mỏng nhẹ , tan như nước thấm v&agrave;o da tạo một lớp nền mỏng, đều m&agrave;u, trong suốt. Một ưu điểm nữa của Catrice HD Liquid Coverage Foudation l&agrave; thời gian che phủ l&ecirc;n tới 24 tiếng đồng hồ, gi&uacute;p chị em thoải m&aacute;i hoạt động kh&ocirc;ng suốt 1 ng&agrave;y m&agrave; kh&ocirc;ng phải lo dặm lại kem tr&ocirc;i do mồ h&ocirc;i hay mưa&hellip; mang đến n&eacute;t tự nhi&ecirc;n ho&agrave;n hảo qu&aacute; ư l&agrave; h&agrave;i l&ograve;ng.</p>

<p>✔️ L&agrave; một sản phẩm drugstore nhưng chất kem m&agrave; Catrice HD Liquid Coverage Foundation mang lại kh&ocirc;ng hề k&eacute;m cạnh c&aacute;c sản phẩm kem nền high-end đ&igrave;nh đ&aacute;m đ&acirc;u nha, em ấy sẵn s&agrave;ng chiều l&ograve;ng cả những c&ocirc; n&agrave;ng da dầu/hỗn hợp thi&ecirc;n dầu kh&oacute; t&iacute;nh nhất lu&ocirc;n đấy!</p>

<p>✔️ Sản phẩm c&ograve;n được mệnh danh l&agrave; &ldquo;Second Skin&rdquo; v&igrave; c&oacute; độ che phủ HD được xem như l&agrave; lớp da thứ 2 ho&agrave;n mỹ, kh&ocirc;ng g&oacute;c chết của chị em, n&ecirc;n chỉ với một lớp kem si&ecirc;u mỏng l&agrave; c&aacute;c n&agrave;ng đ&atilde; c&oacute; l&agrave;n da căng tr&agrave;n, si&ecirc;u tự nhi&ecirc;n.</p>

<p>✔️ Đặc biệt sản phẩm che phủ được ho&agrave;n to&agrave;n khuyết điểm như mụn đỏ, n&aacute;m, t&agrave;n nhang&hellip; m&agrave; lại kh&ocirc;ng hề bị b&iacute; da v&igrave; chất kem rất mỏng v&agrave; kh&ocirc; nhanh cực kỳ. ✔️ Thời gian che phủ l&ecirc;n tới 24h đồng hồ gi&uacute;p c&aacute;c n&agrave;ng thoải m&aacute;i hoạt động suốt 1 ng&agrave;y d&agrave;i, m&agrave; kh&ocirc;ng phải lo dặm lại kem bị tr&ocirc;i do mồ h&ocirc;i hay mưa&hellip; mang đến lớp nền tự nhi&ecirc;n, qu&aacute; ư l&agrave; h&agrave;i l&ograve;ng phải kh&ocirc;ng n&egrave;.</p>

<p>✔️ Bổ sung chỉ số chống nắng SPF25 gi&uacute;p bảo vệ da khỏi tia UVA/UVB, tuy nhi&ecirc;n nếu cẩn thận hơn c&aacute;c n&agrave;ng n&ecirc;n b&ocirc;i một lớp kem chống nắng nữa nh&eacute;!</p>

<p>✔️ Điểm nhấn trong thiết kế của Catrice HD Liquid Coverage Foundation l&agrave; ống nhỏ giọt với tay cầm bằng cao su gi&uacute;p cho việc lấy kem, điều chỉnh lượng kem được dễ d&agrave;ng, đồng thời sẽ bảo quản sản phẩm được tốt hơn.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>1. D&ugrave;ng ống b&oacute;p 1 lượng sản phẩm vừa đủ rồi chấm đều l&ecirc;n 5 điểm tr&ecirc;n gương mặt v&agrave; cổ.</p>

<p>2. D&ugrave;ng tay/b&ocirc;ng m&uacute;t/cọ t&aacute;n đều kem cho tiệp v&agrave;o da.</p>
', 1, 0, N'kem-nen-catrice-24h', CAST(N'2021-08-18 21:22:57.017' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4150, N'Kem dưỡng ẩm Neutrogena', N'Khác', N'/Uploads/images/product/pro117.jpg', N'/Uploads/images/product/pro117.jpg', 0, N'Kem Dưỡng Ẩm Neutrogena Hydro Boost Water Gel với thành phần từ Hyaluronic Acid nhanh chóng mang lại cho bạn làn da ẩm mịn căng tràn sức sống. Khóa độ ẩm cho da ngậm nước trong suốt 48 giờ, duy trì làn da ẩm mượt và dẻo dai', 2100, N'<p>✖️ Water-Gel: Da dầu</p>

<p>&ndash; Kem Dưỡng Ẩm Neutrogena Hydro Boost Water Gel chứa c&ocirc;ng thức Hydration &ndash; ch&igrave;a kh&oacute;a đ&aacute;nh thức vẻ đẹp ph&aacute;t s&aacute;ng từ b&ecirc;n trong của l&agrave;n da. Chất gel nhẹ mịn dễ thẩm thấu c&oacute; thể cấp nước cho l&agrave;n da kh&ocirc; gần như cấp tốc, ho&agrave;n hảo v&agrave; trọn vẹn m&agrave; kh&ocirc;ng hề g&acirc;y bết d&iacute;nh, nhờn r&iacute;t. Tr&ecirc;n hết , c&ocirc;ng thức n&agrave;y gi&uacute;p da lu&ocirc;n duy tr&igrave; được trạng th&aacute;i ngậm nước, mềm mại mịn m&agrave;ng.</p>

<p>&ndash; Kem Dưỡng Ẩm Neutrogena Hydro Boost Water Gel l&agrave; sản phẩm rất dễ d&ugrave;ng ph&ugrave; hợp:</p>

<p>+ Da dầu hoặc dễ nhờn.</p>

<p>+ Lỗ ch&acirc;n l&ocirc;ng to.</p>

<p>+ Đang điều trị mụn.</p>

<p>+ Mới bắt đầu với skincare</p>

<p>+ Muốn tối giản h&oacute;a c&aacute;c thao t&aacute;c chăm s&oacute;c da.</p>

<p>+ Chất kem m&agrave;u xanh nhạt m&aacute;t như nước cộng với hương thơm c&acirc;y cỏ nh&egrave; nhẹ ắt hẳn sẽ đốn gục tim bạn ngay lập tức, nhất l&agrave; trong thời tiết n&oacute;ng bức hiện nay.</p>

<p>&ndash; Kem Dưỡng Ẩm Neutrogena Hydro Boost Water Gel c&ograve;n chứa c&aacute;c hạt dưỡng ẩm axit hyaluronic tinh khiết c&oacute; t&aacute;c t&aacute;c dụng cho da lu&ocirc;n mọng nước cả ng&agrave;y nhờ v&agrave;o qu&aacute; tr&igrave;nh hydrat h&oacute;a, c&aacute;c hoạt chất n&agrave;y hoạt động tương tự như miếng bọt biển tr&ecirc;n l&agrave;n da kh&ocirc; với trọng lượng 1000 lần nước.</p>

<p>&nbsp;</p>

<p>✖️ Gel-Cream: Da kh&ocirc;</p>

<p>- D&ograve;ng sản phẩm HYDRO BOOST của NEUTROGENA</p>

<p>&ndash; Neutrogena Hydro Boost Gel Cream được tung ra thị trường với chức năng giữ ẩm, phục hồi chống l&atilde;o h&oacute;a da, cấp nước ngay lập tức cho da v&ocirc; c&ugrave;ng tốt do c&ocirc;ng thức chứa Hyaluronic Acid gi&uacute;p hydrat h&oacute;a cho da, kh&oacute;a độ ẩm cho da, ngậm nước trong suốt 48 giờ, duy tr&igrave; l&agrave;n da ẩm mượt v&agrave; dẻo dai.</p>

<p>&ndash; C&ocirc;ng thức chứa Hyaluronic Acid gi&uacute;p hydrat h&oacute;a cho da. Kh&oacute;a độ ẩm cho da ngậm nước trong suốt 48 giờ, duy tr&igrave; l&agrave;n da ẩm mượt v&agrave; dẻo dai.</p>

<p>&ndash; Chất gel của gel dưỡng ẩm Neutrogena Hydro Boost Gel Cream m&agrave;u xanh tr&ocirc;ng m&aacute;t lạnh v&agrave; nhẹ t&ecirc;nh, tan v&agrave;o da v&agrave; thẩm thấu một c&aacute;ch dễ d&agrave;ng. Ho&agrave;n to&agrave;n kh&ocirc;ng để lại cảm gi&aacute;c nhờn r&iacute;t, b&oacute;ng bẩy, kh&ocirc;ng b&iacute; lỗ ch&acirc;n l&ocirc;ng.</p>

<p>+ Hyaluronic Acid tinh khiết: L&agrave; một chất c&oacute; trong da tự nhi&ecirc;n gi&uacute;p tăng độ ẩm cho da. N&oacute; hoạt động như một miếng bọt biển, hấp thụ đến 1000 lần trọng lượng của n&oacute; trong nước. V&agrave; sau đ&oacute; truyền v&agrave;o da, giữ cho da được ngậm nước v&agrave; mềm mại suốt cả ng&agrave;y.</p>

<p>+ Chiết xuất Olive: Được biết đến với khả năng hỗ trợ bảo vệ v&agrave; giữ ẩm, một chất chống oxy h&oacute;a hiệu quả. L&agrave; sự kết hợp giữa c&aacute;c axit b&eacute;o - tương tự như tấm l&aacute; chắn bảo vệ độ ẩm tự nhi&ecirc;n của da. N&oacute; t&iacute;ch hợp với h&agrave;ng r&agrave;o chắn của da (skin barrier) tạo th&agrave;nh một cấu tr&uacute;c bảo vệ da kh&ocirc;ng bị mất độ ẩm qu&aacute; mức. Đồng thời gi&uacute;p l&agrave;n da c&oacute; cảm gi&aacute;c mềm mại v&agrave; mịn m&agrave;ng m&agrave; kh&ocirc;ng nhờn d&iacute;nh.</p>
', 1, 0, N'kem-duong-am-neutrogena', CAST(N'2021-08-18 21:35:10.597' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4151, N'Kem Dưỡng Da Lô Hội Nature Repuplic Aloe Vera 92% Cao Cấp Hàn Quốc 300ml', N'Khác', N'/Uploads/images/product/pro118.jpg', N'/Uploads/images/product/pro118.jpg', 80000, N'Gel lô hội Nature Republic Aloe Vera 92% 300ml chứa chiết xuất 92 % lô hội cùng các hoạt chất khác rất an toàn cho da, kể cả làn da nhạy cảm hay da dễ nổi mụn nhất. Sản phẩm có công dụng cấp nước, dưỡng ẩm cấp tốc cho những vùng da khô, bị bong tróc đồng thời làm dịu mát những vùng da bị phỏng hay vùng da bị cháy do đi nắng.', 2107, N'<p>&nbsp;</p>

<p>🖤🖤Kem Dưỡng Da L&ocirc; Hội Nature Repuplic Aloe Vera 92% Cao Cấp H&agrave;n Quốc 300ml🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 80K</p>

<p>&nbsp;</p>

<p>✖️ XUẤT XỨ: H&agrave;n Quốc</p>

<p>✖️ THƯƠNG HIỆU: Nature Republic</p>

<p>✖️ THỂ T&Iacute;CH: 300ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG :</p>

<p>✔️ L&agrave;m m&aacute;t da, cung cấp nước cho da.</p>

<p>✔️ Giảm sự l&atilde;o ho&aacute; của da, chất nhầy của gel l&ocirc; hội c&oacute; khả năng thấm ướt, tạo ẩm độ tr&ecirc;n da gi&uacute;p da dễ đ&agrave;n hồi, giảm bớt nếp nhăn, thu hẹp những mụn cơm hay mụn nhỏ kh&ocirc; cứng mọc tr&ecirc;n da.</p>

<p>✔️ L&agrave;m k&iacute;n miệng v&agrave; nhanh ch&oacute;ng l&agrave;m liền vết thương do bị bỏng, vết phồng rộp, bị thương do bị c&ocirc;n tr&ugrave;ng cắn v&agrave; mẩn ngứa.</p>

<p>&nbsp;</p>

<p>✖️ VỚI 8 C&Aacute;CH SỬ DỤNG:</p>

<p>1. DABO Aloe Vera Cung cấp nước v&agrave; độ ẩm cho da: Thoa một lớp d&agrave;y l&ecirc;n da, để 20 ph&uacute;t rồi rửa sạch bằng nước ấm.</p>

<p>2. DABO Aloe Vera D&ugrave;ng như nước hoa hồng dạng gel gi&uacute;p se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng.</p>

<p>3. DABO Aloe Vera D&ugrave;ng như gel b&ocirc;i trơn cạo r&acirc;u tr&aacute;nh bị trầy da.</p>

<p>4. DABO Aloe Vera Gel dưỡng t&oacute;c v&agrave;o m&ugrave;a h&egrave; tr&aacute;nh việc sấy t&oacute;c l&agrave;m mất nước: N&ecirc;n b&ocirc;i ph&iacute;a đu&ocirc;i t&oacute;c để tr&aacute;nh bết t&oacute;c.</p>

<p>5. DABO Aloe Vera Thư gi&atilde;n mắt: l&agrave;m ướt hai miếng b&ocirc;ng y tế hoặc b&ocirc;ng tẩy trang, thấm gel rồi đắp l&ecirc;n mắt gi&uacute;p (Ch&uacute; &yacute;: Tr&aacute;nh để d&acirc;y v&agrave;o mắt)</p>

<p>6. DABO Aloe Vera Sử dụng như kem dưỡng m&oacute;ng: tạo độ ẩm cho m&oacute;ng v&agrave; độ b&aacute;m m&agrave;u.</p>

<p>7. DABO Aloe Vera B&ocirc;i như bodylotion cung cấp nước: Tr&aacute;nh cho da bị mất nước khi d&ugrave;ng điều h&ograve;a nhiều.</p>

<p>8. DABO Aloe Vera L&agrave;m dịu l&agrave;n da bị ch&aacute;y sau khi đi nắng hoặc tắm biển.</p>

<p>&nbsp;</p>
', 1, 0, N'kem-duong-da-lo-hoi-nature-repuplic-aloe-vera-92-cao-cap-han-quoc-300ml', CAST(N'2021-08-18 21:39:24.247' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4152, N'Miếng Dán Mụn Cosrx Master Patch', N'Cosrx', N'/Uploads/images/product/pro119.jpg', N'/Uploads/images/product/pro119.jpg', 70000, N'Với Miếng Dán Mụn Cosrx Master Patch, việc loại bỏ tận gốc lũ mụn xấu xí và cứng đầu sẽ không còn là quá khó nữa. Từ nay không còn phải bực mình mỗi khi mụn xuất hiện và để lại thâm nữa đâu nhé.', 2107, N'<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>➖ Miếng D&aacute;n Mụn Cosrx Master Patch sẽ gi&uacute;p bạn dễ d&agrave;ng l&agrave;m giảm t&igrave;nh trạng mụn sưng hiệu quả</p>

<p>➖ Miếng d&aacute;n như một lớp mặt nạ, ngăn c&aacute;ch giữa mụn v&agrave; m&ocirc;i trường</p>

<p>➖ Điều n&agrave;y sẽ ngăn ngừa việc bụi bẩn &ocirc; nhiễm hay vi khuẩn tiếp tục tiếp x&uacute;c với mụn, khiến mụn ng&agrave;y c&agrave;ng sưng to hơn</p>

<p>➖ Mỗi Miếng D&aacute;n Giảm Mụn COSRX Acne Pimple Master Patch được đ&oacute;ng k&iacute;n v&agrave; bảo quản trong t&uacute;i zip, đảm bảo vệ sinh mỗi khi sử dụng, c&oacute; chứa tổng cộng 24 miếng d&aacute;n với 3 k&iacute;ch cỡ kh&aacute;c nhau gồm:</p>

<p>- 9 miếng to đường k&iacute;nh 12mm: d&agrave;nh cho mụn bọc to.</p>

<p>- 5 miếng trung b&igrave;nh đường k&iacute;nh 10mm: d&agrave;nh cho mụn trung b&igrave;nh.</p>

<p>- 10 miếng nhỏ đường k&iacute;nh 7mm: d&agrave;nh cho mụn li ti.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>Bước 1: Rửa sạch mặt v&agrave; tay trước khi sử dụng</p>

<p>Bước 2: B&oacute;c t&uacute;i zip sản phẩm ra</p>

<p>Bước 3:</p>

<p>&ndash; Chọn một Miếng D&aacute;n Mụn Cosrx Master Patch ph&ugrave; hợp size</p>

<p>&ndash; Nhẹ nh&agrave;ng d&aacute;n l&ecirc;n nốt mụn.</p>
', 1, 0, N'mieng-dan-mun-cosrx-master-patch', CAST(N'2021-08-18 21:45:11.913' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4153, N'Serum Vitamin C 16.5 GoodnDoc 30ml', N'Goodndoc', N'/Uploads/images/product/pro120.jpg', N'/Uploads/images/product/pro120.jpg', 350000, N'Sản phẩm Vitamin C 16.5 Goodndoc dạng thân nước giúp tăng khả năng điều trị làm mờ thâm nám, tàn nhang hiệu quả. Serum Vitamin C giúp trẻ hóa da, giảm tác động oxy hóa và hỗ trợ tăng khả năng sản sinh Collagen chăm sóc da hàng ngày.', 2103, N'<p>1. C&Ocirc;NG DỤNG:</p>

<p>- Dưỡng trắng, khỏe cho l&agrave;n da bị th&acirc;m n&aacute;m, t&agrave;n nhang, mụn đầu đỏ đầu đen.</p>

<p>- Dưỡng ẩm, k&iacute;ch th&iacute;ch tổng hợp collagen, l&agrave;m mờ sắc tố th&acirc;m n&aacute;m (melanin), l&agrave;m trắng s&aacute;ng da.</p>

<p>- Chống oxi h&oacute;a, chống l&atilde;o h&oacute;a.</p>

<p>- Phục hồi t&aacute;i tạo l&agrave;n da hư tổn.</p>

<p>- Căng da, tăng đ&agrave;n hồi.</p>

<p>- Tạo l&agrave;n da mềm mại, trắng s&aacute;ng, kh&ocirc;ng g&acirc;y kết d&iacute;nh, kh&ocirc;ng l&agrave;m tắc nghẽn lỗ ch&acirc;n l&ocirc;ng.</p>

<p>&nbsp;</p>

<p>2. TH&Agrave;NH PHẦN HOẠT CHẤT:</p>

<p>- Niacinamide gi&uacute;p s&aacute;ng da, dưỡng ẩm, l&agrave;m mờ sắc tốt th&acirc;m n&aacute;m (melanin).</p>

<p>- Adenosin: chống nhăn, ngừa l&atilde;o h&oacute;a.</p>

<p>- Chiết xuất từ 8 loại b&uacute;p non thi&ecirc;n nhi&ecirc;n cung cấp c&aacute;c hợp chất dinh dưỡng gi&uacute;p da được nu&ocirc;i dưỡng khỏe mạnh, mịn mang.</p>

<p>- Giảm th&acirc;m n&aacute;m, ngừa l&atilde;o h&oacute;a, k&iacute;ch th&iacute;ch tổng hợp Collagen, căng s&aacute;ng da.</p>
', 1, 0, N'serum-vitamin-c-165-goodndoc-30ml', CAST(N'2021-08-18 21:56:22.740' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4154, N'TẨY TRANG BYPHASSE 100ML - 500ML', N'Khác', N'/Uploads/images/product/pro121.jpg', N'/Uploads/images/product/pro121.jpg', 0, N'Nước tẩy trang Byphasse của Tây Ban Nha được xem là bản dupe của tẩy trang Bioderma được sử dụng công nghệ Micellar facial cleanser/ micellar cleansing water thu hút tất cả bụi bẩn, mảnh vỡ của lớp makeup bám trên da và mang nó ra đi, giúp da sạch hiệu quả.', 2105, N'<p>🖤🖤TẨY TRANG BYPHASSE🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 60K (100ml), 120k (500ml)</p>

<p>&nbsp;</p>

<p>✖️ XUẤT XỨ: T&acirc;y Ban Nha</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Nước tẩy trang gi&uacute;p tẩy sạch hiệu quả c&aacute;c chất bẩn v&agrave; b&atilde; nhờn s&acirc;u trong lỗ ch&acirc;n l&ocirc;ng c&ugrave;ng với lớp trang điểm tr&ecirc;n da.</p>

<p>✔️ Gi&uacute;p tẩy sạch lớp trang điểm đậm, đặc biệt l&agrave; c&aacute;c sản phẩm waterproof kh&oacute; tr&ocirc;i.</p>

<p>✔️ Với c&aacute;c hạt dầu cực nhỏ gi&uacute;p tẩy sạch v&agrave; hiệu quả c&aacute;c v&ugrave;ng nhỏ tr&ecirc;n da, kh&ocirc;ng g&acirc;y bết d&iacute;nh sau khi sử dụng.</p>

<p>✔️ C&oacute; chứa nước kho&aacute;ng gi&uacute;p rửa sạch c&aacute;c chất bẩn c&ograve;n s&oacute;t lại trước khi l&agrave;m sạch với nước.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>✖️ ƯU ĐIỂM:</p>

<p>&ndash; Kh&ocirc;ng cần rửa lại với nước.</p>

<p>&ndash; C&ocirc;ng thức ho&agrave;n hảo cho c&aacute;c c&ocirc; n&agrave;ng da kh&ocirc;.</p>

<p>&ndash; Kh&ocirc;ng g&acirc;y nhờn tr&ecirc;n da.</p>

<p>&ndash; Tẩy trang chỉ với một bước.</p>

<p>&nbsp;</p>

<p>✖️ C&Aacute;CH D&Ugrave;NG: Thấm sản phẩm v&agrave;o b&ocirc;ng tẩy trang v&agrave; lau tr&ecirc;n mặt theo chuyển động tr&ograve;n đến khi n&agrave;o thấy b&ocirc;ng kh&ocirc;ng c&ograve;n m&agrave;u nữa th&igrave; dừng.</p>
', 1, 0, N'tay-trang-byphasse-100ml---500ml', CAST(N'2021-08-19 09:43:29.960' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4155, N'TẨY TẾ BÀO CHẾT MÔI SỦI BỌT SIÊU HOT BUBI BUBI LIP 12ML', N'Khác', N'/Uploads/images/product/pro122.jpg', N'/Uploads/images/product/pro122.jpg', 155000, N'Unpa Bubi Bubi Lip là giải pháp hoàn hảo để giải quyết các vấn đề về tẩy trang, tẩy chất bẩn, chất sừng và tế bào chết cho môi. Với thành phần chiết xuất từ thiên nhiên, Unpa Bubi Bubi Lip rất dịu nhẹ để bạn có thể sử dụng mỗi ngày, mang lại một đôi môi mềm mịn và hồng hào.', 2107, N'<p>🖤🖤TẨY TẾ B&Agrave;O CHẾT M&Ocirc;I SỦI BỌT SI&Ecirc;U HOT BUBI BUBI LIP🖤🖤</p>

<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>- Dung t&iacute;ch: 12ml</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>✖️ Em n&agrave;y đang l&agrave; h&agrave;ng hot b&ecirc;n H&agrave;n đ&oacute; ạ, bởi những ƯU ĐIỂM:</p>

<p>✔️ Gel sủi bọt: Sau khi thoa một lớp mỏng l&ecirc;n m&ocirc;i, gel sẽ từ từ sủi bọt li ti chứ kh&ocirc;ng giống như mấy loại tẩy da chết cho m&ocirc;i dạng hạt đ&acirc;u.</p>

<p>✔️ Dịu nhẹ v&agrave; an to&agrave;n: Em &yacute; c&oacute; th&agrave;nh phần được chiết xuất từ thi&ecirc;n nhi&ecirc;n n&ecirc;n rất dịu nhẹ v&agrave; an to&agrave;n. Kể cả với những v&ugrave;ng da nhạy cảm nhất.</p>

<p>✔️ Chiết xuất từ c&acirc;y Phỉ: Th&agrave;nh phần AHA tự nhi&ecirc;n trong C&acirc;y Phỉ sẽ l&agrave;m mềm v&agrave; tẩy đi lớp sừng đ&aacute;ng gh&eacute;t một c&aacute;ch dễ d&agrave;ng.</p>

<p>✔️ Chiết xuất từ đu đủ: Enzym ph&acirc;n giải chất đạm trong đu đủ c&oacute; t&aacute;c dụng tẩy lớp sừng vượt trội.</p>

<p>✔️ Chiết xuất quả đ&agrave;o: L&agrave;m s&aacute;ng tone m&ocirc;i xỉn m&agrave;u v&agrave; duy tr&igrave; độ ẩm cho m&ocirc;i suốt cả ng&agrave;y</p>

<p>✔️ Chiết xuất từ bưởi: Điều tiết chất nhờn v&agrave; ngăn nhiễm tr&ugrave;ng, chứa lượng vitamin C dồi d&agrave;o v&agrave; hiệu quả chống oxi h&oacute;a.</p>

<p>✔️ Chiết xuất từ rau sam: Ngăn việc h&igrave;nh th&agrave;nh sẹo v&agrave; chống vi&ecirc;m, kh&ocirc;ng k&iacute;ch th&iacute;ch hay g&acirc;y dị ứng da.</p>

<p>✔️ Em &yacute; c&ograve;n c&oacute; t&aacute;c dụng như một sản phẩm tẩy trang cho m&ocirc;i nữa đ&oacute;.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>1. B&oacute;p ra một lượng đầy v&agrave; b&ocirc;i đều l&ecirc;n m&ocirc;i. Điều chỉnh lượng t&ugrave;y theo d&aacute;ng m&ocirc;i của mỗi người.</p>

<p>2. Sau khi bọt nổi l&ecirc;n, bạn h&atilde;y chờ khoảng 5 ph&uacute;t để lớp sừng mềm đi trong th&agrave;nh phần AHA tự nhi&ecirc;n.</p>

<p>3. D&ugrave;ng đầu ng&oacute;n tay massage đều lớp bọt &ldquo;bubi bubi&rdquo; tr&ecirc;n m&ocirc;i cho đến khi bọt tan hết.</p>

<p>4. D&ugrave;ng nước hoặc khăn ướt lau sạch vụn dơ c&ograve;n s&oacute;t tr&ecirc;n m&ocirc;i.</p>
', 1, 0, N'tay-te-bao-chet-moi-sui-bot-sieu-hot-bubi-bubi-lip-12ml', CAST(N'2021-08-19 09:47:09.010' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4156, N'MẶT NẠ NGỦ MẶT LANEIGE (xanh dương 15ml)', N'Laneige', N'/Uploads/images/product/pro123.jpg', N'/Uploads/images/product/pro123.jpg', 50000, N'Sản phẩm Mặt nạ ngủ Laneige hay có tên đầy đủ là Laneige Water Sleeping Mask đến từ thương hiệu Laneige, Hàn Quốc. Các sản phẩm của Laneige cho việc chăm sóc da mặt từ tinh chất, dưỡng ẩm đến các loại mặt nạ đã không còn xa lạ với các chị em trong cộng đồng làm đẹp.', 2107, N'<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>- Thương hiệu: Laneige</p>

<p>&nbsp;</p>

<p>✖️ XANH DƯƠNG:</p>

<p>✔️ Gi&uacute;p da trở n&ecirc;n tươi mới: C&ocirc;ng nghệ thanh lọc l&agrave;n da trong khi ngủ &quot;Sleep-tox&trade;&quot; gi&uacute;p da trở n&ecirc;n tươi mới sau mỗi khi thức dậy. ️️️</p>

<p>✔️ Dưỡng ẩm da v&agrave;o ban đ&ecirc;m: C&ocirc;ng nghệ dưỡng ẩm &quot;Moisture Wrap&trade;&quot; gi&uacute;p da tr&aacute;nh t&igrave;nh trạng kh&ocirc; r&aacute;p trong khi ngủ v&agrave; tăng khả năng hấp thụ c&aacute;c th&agrave;nh phần hoạt t&iacute;nh tr&ecirc;n da. ️</p>

<p>✔️ Gi&uacute;p l&agrave;m mịn da: C&ocirc;ng thức dạng gel dịu nhẹ gi&uacute;p mịn da. ️</p>

<p>✔️ Hương thơm gi&uacute;p mang lại cảm gi&aacute;c thoải m&aacute;i v&agrave; thư gi&atilde;n: Với c&ocirc;ng nghệ m&ugrave;i thơm &quot;Sleepscent&trade;&quot; gi&uacute;p mang lại cảm gi&aacute;c thoải m&aacute;i thư gi&atilde;n.</p>

<p>&nbsp;</p>

<p>✖️ XANH L&Aacute; - DA NHẠY CẢM:</p>

<p>- Gi&uacute;p tăng cường h&agrave;ng r&agrave;o bảo vệ da</p>

<p>- Mặt nạ ngủ được chiết xuất từ Nấm Men Rừng gi&uacute;p phục hồi h&agrave;ng r&agrave;o bảo vệ da bị hư tổn, đồng thời gi&uacute;p l&agrave;n da đang mệt mỏi được nghỉ ngơi ho&agrave;n to&agrave;n.</p>

<p>- Gi&uacute;p tăng cường h&agrave;ng r&agrave;o bảo vệ da</p>

<p>- Liệu ph&aacute;p gi&uacute;p phục hồi l&agrave;n da đang mệt mỏi bằng c&aacute;ch củng cố h&agrave;ng r&agrave;o bảo vệ da với t&aacute;c dụng t&aacute;i tạo từ th&agrave;nh phần Nấm Men Rừng.</p>

<p>- Mặt nạ ngủ c&oacute; chiết xuất từ Nấm Men Rừng, với khả năng gi&uacute;p t&aacute;i tạo da c&oacute; nguồn gốc tự nhi&ecirc;n được cấp bằng s&aacute;ng chế từ AMOREPACIFIC</p>

<p>- Gi&uacute;p nu&ocirc;i dưỡng v&agrave; dưỡng ẩm cho l&agrave;n da bị tổn thương mang đến l&agrave;n da khỏe mạnh v&agrave;o s&aacute;ng h&ocirc;m sau.</p>

<p>- Chăm s&oacute;c v&agrave;o thời gian v&agrave;ng khi ngủ để c&oacute; được l&agrave;n da khỏe mạnh</p>

<p>- Mặt nạ ngủ gi&uacute;p chăm s&oacute;c l&agrave;n da bị nhạy cảm, căng kh&ocirc; v&agrave; hư tổn với sự nu&ocirc;i dưỡng chuy&ecirc;n s&acirc;u trong thời gian v&agrave;ng khi ngủ v&agrave;o ban đ&ecirc;m, khi l&agrave;n da yếu đi do mất độ ẩm v&agrave; dầu.</p>

<p>- L&agrave;n da sẽ bớt căng kh&ocirc; v&agrave; trở n&ecirc;n ẩm mượt hơn v&agrave;o ng&agrave;y h&ocirc;m sau.</p>

<p>- C&ocirc;ng thức dịu nhẹ v&agrave; an to&agrave;n khi sử dụng cho da nhạy cảm</p>

<p>- C&ocirc;ng thức dịu nhẹ gi&uacute;p l&agrave;m dịu l&agrave;n da nhạy cảm, vượt qua thử nghiệm kh&ocirc;ng g&acirc;y dị ứng cho da.</p>

<p>&nbsp;</p>

<p>✖️ C&Aacute;CH SỬ DỤNG:</p>

<p>1. Sau khi l&agrave;m sạch mặt, sử dụng nước c&acirc;n bằng da v&agrave; dưỡng da trước khi đi ngủ.</p>

<p>2. Đắp một lượng vừa đủ (đường k&iacute;nh 2.5cm) l&ecirc;n đầu mũi, m&aacute;, tr&aacute;n, cằm v&agrave; thư gi&atilde;n c&ugrave;ng với hương thơm trong 3 gi&acirc;y.</p>

<p>3. Thoa nhẹ nh&agrave;ng l&ecirc;n mặt, bắt đầu từ trong ra ngo&agrave;i.</p>

<p>4. Sau khi sản phẩm được hấp thụ, đi ngủ kh&ocirc;ng cần rửa lại mặt cho tới s&aacute;ng h&ocirc;m sau.</p>

<p>5. Sử dụng 2- 3 lần một tuần.</p>

<p>6. D&ugrave;ng nhiều hơn khi da bạn cảm thấy kh&ocirc;.</p>

<p>7. C&oacute; thể sử dụng để chăm s&oacute;c da v&ugrave;ng cổ.</p>

<p>&nbsp;</p>

<p>✖️ LƯU &Yacute; KHI SỬ DỤNG: D&ugrave;ng sữa rửa mặt v&agrave;o s&aacute;ng h&ocirc;m sau, kh&ocirc;ng sẽ rất dễ g&acirc;y mụn.</p>
', 1, 0, N'mat-na-ngu-mat-laneige-xanh-duong-15ml', CAST(N'2021-08-19 09:51:38.233' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4157, N'Phấn Tươi Đức Essence Soft Touch Mousse', N'Khác', N'/Uploads/images/product/pro124.jpg', N'/Uploads/images/product/pro124.jpg', 130000, N'Kem phấn Essence Soft Touch Mousse còn được cái nàng gọi với cái tên là kem 4 trong 1, khi sử dụng loại kem phấn này bạn sẽ tiết kiệm được 4 bước chăm sóc da cầu kì, đó chính là dưỡng da, che khuyết điểm, kem lót, kem nền. Thật tuyệt vời đúng không các bạn.', 2095, N'<p>🖤🖤PHẤN TƯƠI ĐỨC🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 130K</p>

<p>➡️ TRỌNG LƯỢNG: 16g</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Phấn tươi Mousse l&agrave; một dạng của phấn kem c&ocirc; đặc gi&uacute;p tạo lớp nền mỏng mịn, trong suốt, si&ecirc;u kh&ocirc; tho&aacute;ng v&agrave; c&oacute; khả năng che phủ ưu việt hơn những d&ograve;ng th&ocirc;ng thường kh&aacute;c.</p>

<p>✔️ Chỉ cần 1 lớp để thay thế cho tất cả c&aacute;c bước kem l&oacute;t, kem nền v&agrave; phấn phủ, đặc biệt c&ograve;n thay cả kem che khuyết điểm với khả năng che phủ tối đa m&agrave; v&ocirc; c&ugrave;ng mỏng, nhẹ.</p>

<p>✔️ Phấn tươi essence mousse kh&ocirc;ng ch&igrave;, chiết xuất ho&agrave;n to&agrave;n từ những nguy&ecirc;n liệu tươi, kh&ocirc;ng chứa chất bảo quản n&ecirc;n đảm bảo an to&agrave;n cho da.</p>

<p>✔️ Essence Soft Touch Mousse c&ograve;n c&oacute; khả năng dưỡng da giữ ẩm v&agrave; kiềm dầu v&ocirc; c&ugrave;ng hiệu quả, đồng thời cung cấp thảo mộc gi&uacute;p da tr&aacute;nh những vấn đề l&atilde;o h&oacute;a như sạm, n&aacute;m.</p>

<p>✔️ Ngo&agrave;i ra, một trong những đặc t&iacute;nh vượt trội của phấn tươi Đức so với c&aacute;c d&ograve;ng phấn kh&aacute;c đ&oacute; l&agrave; sự đ&agrave;n hồi. Nếu chẳng may l&agrave;m rơi vỡ khay phấn, bạn chỉ cần d&ugrave;ng tay ấn v&agrave; miết chặt lại l&agrave; phấn lại li&ecirc;n kết với nhau như cũ.</p>

<p>✔️ Rất th&iacute;ch hợp với những c&ocirc; g&aacute;i chuộng phong c&aacute;ch trang điểm tự nhi&ecirc;n.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>1. Sau khi l&agrave;m sạch da, chỉ cần thoa 1 lớp phấn tươi Essence Soft Touch Mousse l&ecirc;n da v&agrave; t&aacute;n đều.</p>

<p>2. Chấm th&ecirc;m phấn tươi l&ecirc;n c&aacute;c nốt mụn hoặc vết th&acirc;m để che khuyết điểm.</p>

<p>3.T&ugrave;y v&agrave;o nhu cầu sử dụng m&agrave; bạn c&oacute; thể apply th&ecirc;m c&aacute;c lớp để c&oacute; lớp make up ăn &yacute;.</p>

<p>4. Đậy nắp sau khi sử dụng.</p>

<p>5. Bảo quản nơi kh&ocirc; tho&aacute;ng, tr&aacute;nh &aacute;nh nắng trực tiếp.</p>
', 1, 0, N'phan-tuoi-duc-essence-soft-touch-mousse', CAST(N'2021-08-19 09:54:26.003' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4158, N'Nước hoa Cúc SNO Calendula Herbal Phyto Toner', N'Khác', N'/Uploads/images/product/pro125.jpg', N'/Uploads/images/product/pro125.jpg', 185000, N'Nước hoa cúc SNO Calendula Herbal Phyto chiết xuất từ hoa cúc, và cánh hoa tươi cùng hàng loạt thảo dược thiên nhiên giúp làm sạch da, giảm nguy cơ mụn trứng cá, dưỡng ẩm nhẹ nhàng với pH 6, đồng thời cải thiện bề mặt da mịn màng, tươi sáng, giảm sần sùi, nếp nhăn,...', 2098, N'<p>H&atilde;ng: SNO</p>

<p>Xuất xứ: H&agrave;n Quốc (Made in Korea)</p>

<p>Dung t&iacute;ch: 200ml</p>

<p>&nbsp;</p>

<p>- Th&agrave;nh phần &amp; c&ocirc;ng dụng:</p>

<p>+ Th&agrave;nh phần chủ đạo của sản phẩm ch&iacute;nh l&agrave; hoa c&uacute;c tươi l&ecirc;n trong chai toner SNO Calendula lu&ocirc;n c&oacute; những c&aacute;nh hoa c&uacute;c nhỏ ở dưới đ&aacute;y chai thực hiện chức năng dưỡng ẩm, l&agrave;m mềm da, kh&aacute;ng khuẩn, giảm t&aacute;c nh&acirc;n k&iacute;ch ứng da, dịu nốt mụn.</p>

<p>+ Ngo&agrave;i ra c&ograve;n c&oacute; NIACINAMIDE &amp; ADENOSINE: l&agrave;m trắng s&aacute;ng v&agrave; chống nhăn da phổ biến v&ocirc; c&ugrave;ng hiệu quả.</p>

<p>+ C&uacute;c La M&atilde;: giảm sưng tấy, nhanh liền, sẹo, kh&aacute;ng vi&ecirc;m.</p>

<p>+ Chiết xuất c&aacute;c loại thảo mộc kh&aacute;c như: x&ocirc; thơm, bạch đầu &ocirc;ng, xuy&ecirc;n ti&ecirc;u, oải hương, cam thảo, vỏ c&acirc;y liễu trắng, hương thảo: c&acirc;n bằng da, điều tiết b&atilde; nhờn v&agrave; kh&aacute;ng khuẩn, giảm mụn v&agrave; xoa dịu l&agrave;n da nhạy cảm.</p>

<p>+ Keo ong: cho l&agrave;n da căng b&oacute;ng.</p>

<p>+ Th&agrave;nh phần rau m&aacute;, l&aacute; olive, tr&agrave; xanh: dưỡng ẩm, hỗ trợ phục hồi gi&uacute;p bề mặt da trơn l&aacute;ng.</p>

<p>+ Chứa EGF gồm c&aacute;c polypeptide v&agrave; oligopeptide: gi&uacute;p kh&ocirc;i phục, sữa chữa l&agrave;n da, tăng sinh collagen đem đến l&agrave;n da mềm mịn, căng mượt v&agrave; giảm thiểu nếp nhăn.</p>

<p>+ Nhờ c&oacute; bảng th&agrave;nh phần l&agrave;nh t&iacute;nh n&ecirc;n em n&agrave;y được đ&aacute;nh gi&aacute; l&agrave; ph&ugrave; hợp với mọi chất da, kể cả da nhạy cảm. Ngo&agrave;i c&oacute; những chức năng th&ocirc;ng thường của một d&ograve;ng nước hoa hồng cơ bản, sản phẩm c&ograve;n gi&uacute;p da trở l&ecirc;n căng b&oacute;ng, l&agrave;n da đều m&agrave;u v&agrave; hạn chế tối đa c&aacute;c vấn đề như mụn, n&aacute;m, da xỉn m&agrave;u&hellip;</p>
', 1, 0, N'nuoc-hoa-cuc-sno-calendula-herbal-phyto-toner', CAST(N'2021-08-19 09:56:11.473' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4159, N'TẨY DA CHẾT HUXLEY', N'Khác', N'/Uploads/images/product/pro126.jpg', N'/Uploads/images/product/pro126.jpg', 0, N'Mặt Nạ Tẩy Tế Bào Chết Huxley Scrub Mask: Sweet Therapy chứa các thành phần được chiết xuất từ thực vật hữu cơ tự nhiên giúp lấy đi lớp tế bào chết và cặn bẩn một cách nhẹ nhàng mà không gây khô da, cho là da sáng mịn và ẩm mượt. Thành phần tự nhiên lành tính an toàn cho da.', 2107, N'<p>- XUẤT XỨ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Mặt nạ n&agrave;y cứu gi&uacute;p l&agrave;n da c&oacute; vấn đề về mụn ẩn v&igrave; n&oacute; gi&uacute;p lấy đi nhẹ nh&agrave;ng những tế b&agrave;o chết khiến cho lỗ ch&acirc;n l&ocirc;ng kh&ocirc;ng c&ograve;n bị b&iacute; tắc.</p>

<p>✔️ Chiết xuất từ tinh dầu hạt xương rồng qu&yacute; gi&aacute;:</p>

<p>✔️ C&oacute; khả năng tẩy da chết m&agrave; kh&ocirc;ng g&acirc;y kh&ocirc; hay b&agrave;o m&ograve;n da, đồng thời chống lại sự oxy ho&aacute; hiệu quả, gi&uacute;p da trở n&ecirc;n mịn m&agrave;ng, tươi s&aacute;ng, mềm mại v&agrave; căng mọng.</p>

<p>✔️ Tinh dầu hạt xương rồng: Dưỡng ẩm tối ưu, chống oxy ho&aacute;.</p>

<p>✔️ Đường: Gi&uacute;p loại bỏ lớp da chết một c&aacute;ch nhẹ nh&agrave;ng.</p>

<p>✔️ Rong biển v&agrave; dưa chuột: Ph&ograve;ng chống thất tho&aacute;t ẩm.</p>

<p>✔️ Hạt &oacute;c ch&oacute;: C&oacute; t&aacute;c dụng loại bỏ tế b&agrave;o chết.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>Sau khi rửa mặt sạch, thoa mặt nạ l&ecirc;n mặt, massage nhẹ nh&agrave;ng theo chuyển động v&ograve;ng tr&ograve;n, tr&aacute;nh v&ugrave;ng mắt, cuối c&ugrave;ng rửa sạch bằng nước ấm.</p>
', 1, 0, N'tay-da-chet-huxley', CAST(N'2021-08-19 09:59:34.997' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4160, N'Kem Dưỡng Inisfree', N'Innisfree', N'/Uploads/images/product/pro127.jpg', N'/Uploads/images/product/pro127.jpg', 0, N'Kem dưỡng da là một trong các sản phẩm không thể thiếu của chị em phụ nữ trong quá trình chăm sóc và làm đẹp. Chúng có tác dụng tạo lớp màng chắn ngăn chặn sự thoát ẩm cũng như giữ lại các dưỡng chất. Đồng thời chúng còn cung cấp độ ẩm, duy trì sự mềm mại và mịn màng cho làn da.', 2100, N'<p><em><strong>1.Kem dưỡng da Innisfree Orchid Enriched Cream</strong></em></p>

<p>Innisfree Orchid Enriched Cream l&agrave; d&ograve;ng sản phẩm được sản xuất &rdquo;<strong>d&agrave;nh cho c&aacute;c loại da kh&ocirc; v&agrave; da hỗn hợp</strong>&rdquo;. Với chiết xuất từ hoa lan được lấy từ v&ugrave;ng nguy&ecirc;n liệu đảo Jeju v&ocirc; c&ugrave;ng l&agrave;nh t&iacute;nh v&agrave; an to&agrave;n cho da nhạy cảm.</p>

<p>&nbsp;</p>

<p><em><strong>2.Kem dưỡng da Innisfree Whitening Pore Cream</strong></em></p>

<p>Innisfree Whitening Pore Cream&nbsp;&rdquo;<strong>l&agrave; sản phẩm ph&ugrave; hợp với mọi loại da</strong>&rdquo;, đặc biệt l&agrave; da kh&ocirc;. Những chị em c&oacute; nhu cầu dưỡng trắng da v&agrave; se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng th&igrave; đừng n&ecirc;n bỏ qua sản phẩm kem dưỡng da n&agrave;y của Innisfree nh&eacute;.</p>

<p>&nbsp;</p>

<p><em><strong>3.Kem dưỡng trắng da Innisfree White Tone Up Cream</strong></em></p>

<p>Kem dưỡng da Innisfree White Tone Up Cream l&agrave; sản phẩm&nbsp;m&agrave; c&aacute;c c&ocirc; n&agrave;ng mong muốn sở hữu l&agrave;n da trắng hồng kh&ocirc;ng thể bỏ qua. D&ograve;ng sản phẩm n&agrave;y &rdquo;<strong>ph&ugrave; hợp với mọi loại da&rdquo;</strong>, nhất l&agrave; da hỗn hợp v&agrave; da kh&ocirc; sẽ ph&aacute;t huy được hiệu quả nhanh hơn.</p>

<p>&nbsp;</p>

<p><em><strong>4.Kem dưỡng da Innisfree Green Tea Balancing Cream</strong></em></p>

<p>Kem dưỡng da Innisfree Green Tea Balancing Cream với th&agrave;nh phần được chiết xuất từ tr&agrave; xanh gi&uacute;p mang đến l&agrave;n da tươi trẻ, khỏe mạnh s&acirc;u b&ecirc;n trong đồng thời bổ sung dưỡng chất cho da, tạo h&agrave;ng r&agrave;o chắn v&agrave; bảo vệ l&agrave;n da của bạn khỏi những tạp chất &ocirc; nhiễm. Đ&acirc;y l&agrave; &rdquo;<strong>sản phẩm ph&ugrave; hợp với da thường</strong>&rdquo;, đặc biệt l&agrave; c&aacute;c loại da hỗn hợp.</p>

<p>&nbsp;</p>

<p><em><strong>5.Kem Dưỡng Ẩm Trắng Da dạng Gel Innisfree Jeju Cherry Blossom Jelly Cream</strong></em></p>

<p>Kem dưỡng&nbsp;l&agrave;m s&aacute;ng da Jeju Cherry Blossom Jelly &nbsp;tăng cường cấp ẩm - cấp nước cho da, cải thiện độ đ&agrave;n hồi cho da với sự chăm s&oacute;c từ Betaine c&oacute; nguồn gốc tự nhi&ecirc;n. Betaine l&agrave; dưỡng chất được chiết xuất từ củ cải đường, c&oacute; c&ocirc;ng dụng cung cấp độ ẩm cho da v&agrave; ngăn ngừa t&igrave;nh trạng da kh&ocirc;, th&ocirc; r&aacute;p gi&uacute;p da căng mịn đủ nước, cải thiện bề mặt da mềm mịn hơn.</p>
', 1, 0, N'kem-duong-inisfree', CAST(N'2021-08-19 10:14:35.350' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4161, N'Kem Dưỡng Chiết Xuất Rau Má Skin1004 Madagascar Centella 75ml', N'Skin1004', N'/Uploads/images/product/pro128.jpg', N'/Uploads/images/product/pro128.jpg', 0, N'Kem Dưỡng Hỗ Trợ Trị Mụn, Phục Hồi Da Mụn Chiết Xuất Rau Má Skin1004 Madagascar Centella Cream là kem dưỡng ẩm với thành phần chính chiết xuất từ ra má có khả năng cải thiện các vấn đề về mụn, chăm sóc và phục hồi các làn da bị tổn thương do những tác động từ môi trường bên ngoài. Với kết cấu kem mềm mại, cho làn da ẩm mịn, dễ chịu  thuộc thương hiệu Skin1004 đến từ Hàn Quốc', 2100, N'<p>1. Cream</p>

<p>- Kem dưỡng chứa th&agrave;nh phần TECA chiết xuất từ rau m&aacute; bao gồm 4 hợp chất ch&iacute;nh (Asiatic Acid/Madecassic Acid/ Asiaticoside/ Madecassoside) được lấy từ Rau M&aacute; nổi tiếng với khả năng l&agrave;m dịu chống k&iacute;ch ứng v&agrave; sửa chữa cấu tr&uacute;c da. Asiaticoside/Asiatic Acid tăng sản xuất GAGs trong Ma trận ngoại b&agrave;o ECM, tổng hợp Collagen loại I để chữa l&agrave;nh vết thương l&agrave;m đầy sẹo mụn. Madecassoside/ Madecassic Acid bảo vệ da giảm sưng đỏ, chữa l&agrave;nh vết thương, cải thiện độ ẩm, l&agrave;m s&aacute;ng da v&agrave; chống Oxy h&oacute;a.</p>

<p>- Chứa th&agrave;nh phần Niacinamide v&agrave; Adenoside vừa gi&uacute;p l&agrave;m s&aacute;ng da v&agrave; gi&uacute;p da đ&agrave;n hồi, khỏe mạnh hơn.</p>

<p>- Th&agrave;nh phần Squalane, Betaine, Erythitol đạt chứng nhận từ Ecocert (ECOCERT l&agrave; một tổ chức chứng nhận hữu cơ, th&agrave;nh lập tại Ph&aacute;p năm 1991, l&agrave; 1 trong những tổ chức hữu cơ lớn nhất thế giới)</p>

<p>- Th&agrave;nh phần SheaButter BCS OEKO-GARANTIE (l&agrave; tổ chức chứng nhận hữu cơ đầu ti&ecirc;n tại Đức, c&oacute; uy t&iacute;n tại th&igrave; trường Ch&acirc;u &Acirc;u cũng như quốc tế)</p>

<p>- Bảng th&agrave;nh phần thuộc cấp green class EWG c&oacute; thể sử dụng cho cả l&agrave;n da nhạy cảm</p>

<p>- Với c&ocirc;ng thức Oil In Water mang lại cảm gi&aacute;c đầu ti&ecirc;n l&agrave; &quot;ẩm mượt&quot;, v&agrave; cảm gi&aacute;c lưu lại tr&ecirc;n da l&agrave; &quot;mềm mại&quot;</p>

<p>- Đ&acirc;y l&agrave; b&iacute; quyết của kết cấu đặc nhưng mềm mại, kh&ocirc;ng bết d&iacute;nh v&agrave; duy tr&igrave; sự ẩm mượt trong thời gian d&agrave;i</p>

<p>*&quot;Oil In Water&quot;: L&agrave; phương ph&aacute;p tốt nhất để h&igrave;nh th&agrave;nh kết cấu mềm mịn như lụa - d&ugrave;ng Nước l&agrave;m nền v&agrave; ph&acirc;n t&aacute;n Dầu. Để c&aacute;c hạt ph&acirc;n tử dầu được bao bọc bằng độ ẩm. C&oacute; thể đồng thời cảm nhận được độ ẩm v&agrave; độ mềm mại cũng một l&uacute;c.</p>

<p>- Hương thơm c&oacute; nguồn gốc từ thi&ecirc;n nhi&ecirc;n kh&ocirc;ng chứa hương thơm nh&acirc;n tạo cho bạn cảm gi&aacute;c an to&agrave;n v&agrave; thoải m&aacute;i khi sử dụng với hương thơm nhẹ nh&agrave;ng từ tinh dầu cam v&agrave; hoa oải hương</p>

<p>&nbsp;</p>

<p>2. Soothing Cream</p>

<p>- Skin1004 Madagascar Centella Soothing Cream hiện tại đ&atilde; c&oacute; mặt tại Thế Giới skinfood chứa chiết xuất rau m&aacute; (72%) nổi tiếng với khả năng l&agrave;m dịu chống k&iacute;ch ứng v&agrave; sửa chữa cấu tr&uacute;c da, bảo vệ da giảm sưng đỏ, chữa l&agrave;nh vết thương, cải thiện độ ẩm, l&agrave;m s&aacute;ng da v&agrave; chống Oxy h&oacute;a</p>

<p>- Chứa phức hợp Ceramide th&agrave;nh phần thiết yếu cho da bao gồm Ceramide (NP), Ceramide (EOP), Ceramide (NS), Ceramide (AP) c&oacute; khả năng bảo vệ độ ẩm chống lại t&igrave;nh trạng g&acirc;y kh&ocirc; da, ngăn ngừa c&aacute;c dấu hiệu l&atilde;o h&oacute;a. Đồng thời gi&uacute;p h&igrave;nh th&agrave;nh lớp m&agrave;ng h&agrave;ng r&agrave;o bảo vệ da, tăng cường hiệu quả sức đề kh&aacute;ng của da</p>

<p>- Ngo&agrave;i ra c&ograve;n c&oacute; chức năng giảm nhiệt tức th&igrave; cho da nhờ bổ dung th&agrave;nh phần Sodium Hyaluronic Chiết xuất rễ c&acirc;y Coptis Chinensis Root Extract v&agrave; chiết xuất Cacao nh&acirc;n đ&ocirc;i khả năng dưỡng ẩm tức th&igrave; cho da, giải quyết c&aacute;c vấn đề g&acirc;y kh&ocirc; da.</p>

<p>- Ho&agrave;n th&agrave;nh kiểm tra da liễu, bảng th&agrave;nh phần thuộc cấp green class EWG c&ugrave;ng với độ pH l&yacute; tưởng 6.0 c&oacute; thể sử dụng cho cả l&agrave;n da nhạy cảm</p>

<p>- Kh&ocirc;ng chứa hương liệu, m&agrave;u tổng hợp gi&uacute;p giảm thiểu khả năng g&acirc;y k&iacute;ch ứng da</p>

<p>- Kết cấu kem c&oacute; m&agrave;u n&acirc;u tự nhi&ecirc;n từ c&aacute;c th&agrave;nh phần tự nhi&ecirc;n, mỏng nhẹ, thẩm thấu nhanh ch&oacute;ng, kh&ocirc;ng g&acirc;y cảm gi&aacute;c nhờn d&iacute;nh kh&oacute; chịu dau khi sử dụng</p>

<p>&nbsp;</p>

<p>&bull; Th&agrave;nh phần ch&iacute;nh: Centella Asiatica Extract (72%), Mentha Piperita (Peppermint) Leaf Extract, Ginger Eextract, Ceramide (NP), Coptis Chinensis Root</p>
', 1, 0, N'kem-duong-chiet-xuat-rau-ma-skin1004-madagascar-centella-75ml', CAST(N'2021-08-19 10:18:19.103' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4162, N'Kem chống nắng Some By Mi Truecica Mineral 100 SPF50+/PA+++ 50ml', N'Some By Mi', N'/Uploads/images/product/pro129.jpg', N'/Uploads/images/product/pro129.jpg', 230000, N'Kem Chống Nắng Some By Mi Truecica Mineral 100 Calming Suncream là kem chống nắng của thương hiệu Some By Mi giúp bảo vệ da khỏi các tác động từ tia UV, đặc biệt được áp dụng công nghệ độc quyền True cica từ hãng giúp mang lại hiệu quả làm dịu da đối với da nhạy cảm', 2101, N'<p>- Thương hiệu: Some By Mi</p>

<p>- Dung t&iacute;ch: 50ml</p>

<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>&nbsp;</p>

<p>✖️ C&ocirc;ng dụng:</p>

<p>- Kem chống nắng H&agrave;n Quốc Somebymi với c&ocirc;ng thức ưu việt c&oacute; chỉ số chống nắng SPF50+/PA+++gi&uacute;p bảo vệ da ho&agrave;n hảo dưới &aacute;nh nắng mặt trời, tr&aacute;nh c&aacute;c t&aacute;c hại từ tia UVA, UVB.</p>

<p>- Ngăn chặn tia UV trong 365 ng&agrave;y để giữ g&igrave;n l&agrave;n da trẻ trung v&agrave; khỏe mạnh, sử dụng kem chống nắng Somebymi mỗi ng&agrave;y d&ugrave; thời tiết n&agrave;o.</p>

<p>- Th&iacute;ch hợp cho da nhạy cảm hoặc dễ bị mụn trứng c&aacute; nhờ v&agrave;o t&iacute;nh dịu nhẹ, KH&Ocirc;NG CHỨA 20 th&agrave;nh phần c&oacute; hại đến da.</p>

<p>- Dưỡng trắng, cải thiện nếp nhăn nhờ c&aacute;c th&agrave;nh phần tr&agrave;m tr&agrave; v&agrave; 85% tinh chất dưỡng ẩm ph&ugrave; hợp với l&agrave;n da kh&ocirc;, hay mất nước.</p>

<p>- C&oacute; thể l&agrave;m lớp make-up.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>✖️ Đặc điểm nổi trội:</p>

<p>- C&ocirc;ng thức Non-Nano tạo lớp m&agrave;ng bảo vệ da khỏi tia cực t&iacute;m mạnh mẽ. Bộ lọc kho&aacute;ng chất v&ocirc; cơ 100% tạo n&ecirc;n lớp m&agrave;ng phản chiếu tia UV khi tiếp x&uacute;c với bề mặt da gi&uacute;p bảo vệ da hiệu quả.</p>

<p>- Khi aply l&ecirc;n da, kem chống nắng Somebymi như lớp kem dưỡng da trơn tru, cảm gi&aacute;c hơi m&aacute;t, đồng thời n&acirc;ng t&ocirc;ng da, c&oacute; m&ugrave;i thơm nhẹ.</p>

<p>- Kết cấu mềm mại, cảm gi&aacute;c kh&ocirc; tho&aacute;ng, dễ chịu kh&ocirc;ng l&agrave;m b&iacute; tắc ch&acirc;n l&ocirc;ng, kh&ocirc;ng g&acirc;y mụn, kh&ocirc;ng k&iacute;ch ứng da nhờ th&agrave;nh phần TruecicaTM - một trong những th&agrave;nh phần ch&iacute;nh của d&ograve;ng Somebymi cực dịu nhẹ cho da, an to&agrave;n cho da nhạy cảm, da mụn.</p>

<p>- Th&agrave;nh phần kem chống nắng Somebymi nhẹ dịu, kh&ocirc;ng chứa m&agrave;u nh&acirc;n tạo v&agrave; hương liệu, 85% tinh chất dưỡng ẩm vừa bảo vệ da vừa dưỡng ẩm cho da.</p>
', 1, 0, N'kem-chong-nang-some-by-mi-truecica-mineral-100-spf50pa-50ml', CAST(N'2021-08-19 10:20:42.083' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4163, N'Tinh Chất Dưỡng Tóc Miseen Scène Perfect Repair Hair Serum', N'Khác', N'/Uploads/images/product/pro130.jpg', N'/Uploads/images/product/pro130.jpg', 175000, N'Tinh chất dưỡng tóc Mise en scène Perfect Repair Hair Serum giúp phục hồi tóc khô, chẻ ngọn và bị hư tổn, thích hợp dùng cho chăm sóc tóc uốn, chăm sóc tóc duỗi, chăm sóc tóc nhuộm và các sản phẩm tạo kiểu tóc. Sản phẩm có khả năng bảo vệ lưu giữ mái tóc càng thêm óng mượt với hiệu ứng 3D đẹp từ mọi góc nhìn.', 2114, N'<p>✖️ Serum Miseen Sc&egrave;ne Perfect Repair Hair Serum đ&atilde; c&oacute; mặt tại hệ thống mỹ phẩm ch&iacute;nh h&atilde;ng Beauty Garden với th&agrave;nh phần ch&iacute;nh đến từ sữa ong ch&uacute;a, tinh dầu hạt Argan v&agrave; tinh chất hoa hồng gi&uacute;p dưỡng t&oacute;c kh&ocirc;ng những b&oacute;ng, mềm mượt, m&agrave; c&ograve;n d&agrave;y l&ecirc;n, khỏe l&ecirc;n, x&oacute;a đi dấu hiệu hư tổn nặng nhất đang ph&aacute; hủy ng&agrave;y dần tr&ecirc;n t&oacute;c bạn.</p>

<p>+ Dưỡng chất đến từ hạt argan gồm c&aacute;c chất dinh dưỡng, vitamin, axit b&eacute;o, axit ferulic, t&aacute;m axit b&eacute;o thiết yếu, carotenoids, chất chống oxy h&oacute;a, sterol, saponin v&agrave; polyphones cần thiết cho t&oacute;c của bạn; Đặc biệt giầu Vitamin E, th&agrave;nh phần chống oxy h&oacute;a, t&aacute;o tạo v&agrave; cung cấp dưỡng chất cho t&oacute;c kh&ocirc;.</p>

<p>+ Dưỡng chất nhờ sữa ong ch&uacute;a cho t&oacute;c: Sữa ong ch&uacute;a c&oacute; chứa 22 c&aacute;c axit amin,cung cấp c&aacute;c chất cần thiết cho từng lọn t&oacute;c. Gi&uacute;p &ldquo;sửa chữa&rdquo; những tế b&agrave;o da bị tổn thương do h&oacute;a chất, tia xạ, tia cực t&iacute;m g&acirc;y ra, lấp đầy những lỗ đứt gẫy tr&ecirc;n sợi t&oacute;c bạn.</p>

<p>+ Tinh chất đến từ hoa hồng được chứng minh l&agrave; bổ sung độ ẩm, hạt tinh dầu lăn đều tr&ecirc;n t&oacute;c, d&ugrave;ng thấm nhanh, thấm s&acirc;u từng sợi t&oacute;c, cho t&oacute;c trở n&ecirc;n th&ecirc;m su&ocirc;n mượt.</p>

<p>+ Serum tạo th&agrave;nh l&ecirc;n m&agrave;ng bảo vệ t&oacute;c trước h&oacute;a chất, c&aacute;c loại m&aacute;y tạo kiểu t&oacute;c( m&aacute;y uốn, m&aacute;y &eacute;p), v&agrave; cả trước kh&oacute;i bụi m&ocirc;i trường, &hellip; &ndash;&gt; bảo vệ trước những s&aacute;t thủ r&igrave;nh rập t&oacute;c h&agrave;ng ng&agrave;y.</p>

<p>+ Miseen Sc&egrave;ne Perfect Repair Hair Serum t&aacute;i tạo độ đ&agrave;n hồi cho t&oacute;c, trả lại cho bạn m&aacute;i t&oacute;c khỏe mạnh, b&oacute;ng mượt v&agrave; tr&agrave;n đầy sức sống.</p>

<p>&nbsp;</p>

<p>✖️ Mise en Sc&egrave;ne &ndash; thương hiệu nổi tiếng của H&agrave;n Quốc sản xuất v&agrave; giới thiệu sản phẩm chăm s&oacute;c t&oacute;c đặc biệt. một loại tinh chất dưỡng c&oacute; chất lượng cao cấp d&agrave;nh cho c&aacute;c bạn g&aacute;i c&oacute; m&aacute;i t&oacute;c kh&ocirc;,chẻ ngọn v&agrave; bị hư tổn. Sản phẩm được đ&aacute;nh gi&aacute; cao về chất lượng cũng như hiệu quả sau khi sử dụng.</p>

<p>✖️ Sản phẩm được tạp ch&iacute; Get It Beauty H&agrave;n Quốc b&igrave;nh chọn l&agrave; sản phẩm Phục Hồi T&oacute;c Tốt Nhất 3 năm li&ecirc;n tục 2012-2013- 2014.</p>

<p>&nbsp;</p>

<p>✖️ HDSD: - D&ugrave;ng cho t&oacute;c kh&ocirc; hoặc ướt đều được.</p>

<p>- Sau khi gội sạch đầu, bạn chờ t&oacute;c kh&ocirc; tầm 90%, cho tinh dầu ra l&ograve;ng b&agrave;n tay v&agrave; nhẹ nh&agrave;ng b&oacute;p xoa đều l&ecirc;n t&oacute;c.</p>

<p>- Để hiệu quả nhất, ch&uacute;ng ta c&oacute; thể sử dụng sản phẩm n&agrave;y như sau: Để t&oacute;c kh&ocirc; tự nhi&ecirc;n đến khi c&ograve;n hơi ẩm th&igrave; bơm serum dưỡng t&oacute;c ra tay rồi thoa l&ecirc;n phần t&oacute;c hư tổn (thường l&agrave; ngọn t&oacute;c) rồi sau đ&oacute; để kh&ocirc; tự nhi&ecirc;n hoặc sấy kh&ocirc; đều được. Sau đ&oacute; (khi t&oacute;c đ&atilde; kh&ocirc; hẳn), thoa một &iacute;t tinh chất nữa l&ecirc;n to&agrave;n bộ t&oacute;c để đem đến hiệu quả mềm mượt th&ecirc;m hơn.</p>

<p>- Tuy nhi&ecirc;n nếu da đầu bạn kh&ocirc;ng phải da dầu th&igrave; vẫn c&oacute; thể thoa một ch&uacute;t serum l&ecirc;n t&oacute;c khi t&oacute;c đ&atilde; kh&ocirc; ho&agrave;n to&agrave;n, để t&oacute;c mượt m&agrave; hơn, kh&ocirc;ng bị chỉa chỉa, x&igrave;a x&igrave;a k&igrave; dị nữa ạ. Nhưng bạn chỉ thoa một ch&uacute;t th&ocirc;i, v&igrave; nếu thoa nhiều khi t&oacute;c kh&ocirc; th&igrave; sẽ dễ dẫn đến t&igrave;nh trạng t&oacute;c bết đấy nh&aacute;!</p>
', 1, 0, N'tinh-chat-duong-toc-miseen-scene-perfect-repair-hair-serum', CAST(N'2021-08-19 10:23:17.563' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4164, N'Kem dưỡng Naturie skin conditioning Gel – Kem dưỡng ý dĩ 180g', N'Khác', N'/Uploads/images/product/pro131.jpg', N'/Uploads/images/product/pro131.jpg', 215000, N'Naturie Skin Conditioning Gel được đánh giá là loại kem dưỡng ẩm khá tốt, có ưu điểm thẩm thấu trên da nhanh chóng. Là một sản phẩm của Nhật và được nhiều phái nữ truyền tai nhau với bí kịp giúp da trong mướt.', 2100, N'<p>🖤🖤Kem dưỡng Naturie skin conditioning Gel &ndash; Kem dưỡng &yacute; dĩ🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 215k</p>

<p>&nbsp;</p>

<p>✖️ Xuất xứ: Nhật Bản</p>

<p>✖️ Thương hiệu: Imju</p>

<p>✖️ Trọng lượng: hộp 180g</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Sản phẩm l&agrave; một dạng gel lỏng v&igrave; th&agrave;nh phần nước chiếm tỉ lệ 81%, n&ecirc;n c&ograve;n được gọi l&agrave; serum gel Naturie. Ch&iacute;nh v&igrave; chất gel lỏng n&ecirc;n sẽ dễ d&agrave;ng thấm h&uacute;t nhanh v&agrave;o trong từng tế b&agrave;o da v&agrave; nu&ocirc;i dưỡng da từ s&acirc;u b&ecirc;n trong một c&aacute;ch tốt nhất.</p>

<p>✔️ Chiết xuất hạt Coix gi&uacute;p l&agrave;n da th&ecirc;m trắng s&aacute;ng, căng mướt đồng thời tăng độ đ&agrave;n hồi, săn chắc cho da.</p>

<p>✔️ Lớp micro-gel như m&agrave;ng dưỡng ẩm trong suốt, cho l&agrave;n da l&uacute;c n&agrave;o cũng &ldquo;ngậm nước&rdquo;, tr&aacute;nh t&igrave;nh trạng kh&ocirc; r&aacute;p, nứt nẻ da.</p>

<p>✔️ Da được chăm s&oacute;c v&agrave; dưỡng ẩm đầy đủ hạn chế được t&igrave;nh trạng l&atilde;o h&oacute;a, nhăn nheo, vết nhăn v&agrave; ngăn chặn sự h&igrave;nh th&agrave;nh c&aacute;c tế b&agrave;o g&acirc;y mụn, mụn trứng c&aacute;,&hellip;</p>

<p>✔️ Điểm cộng d&agrave;nh cho serum dưỡng Naturie l&agrave; giữ được lớp trang điểm &ldquo;ho&agrave;n hảo&rdquo; của bạn được &ldquo;bền-l&acirc;u&rdquo;, tăng th&ecirc;m phần tự nhi&ecirc;n v&agrave; rạng ngời.</p>

<p>✔️ Đặc biệt, sản phẩm Nhật lu&ocirc;n đảm bảo kh&ocirc;ng chứa cồn, chất tạo m&agrave;u, hương liệu n&ecirc;n an to&agrave;n cho bất cứ l&agrave;n da n&agrave;o, kể cả l&agrave;n da nhạy cảm.</p>

<p>✔️ Kem dưỡng Naturie c&oacute; thể sử dụng cho cả khu&ocirc;n mặt v&agrave; body.</p>

<p>&nbsp;</p>

<p><strong>HDSD:</strong></p>

<p>➖ D&ugrave;ng như 1 dạng serum dưỡng da: thoa 2 lần/ng&agrave;y, buổi s&aacute;ng v&agrave; buổi tối sau khi bạn đ&atilde; tẩy da sạch bằng nước hoa hồng (toner). Cho 1 lượng kem vừa đủ d&ugrave;ng ra l&ograve;ng b&agrave;n tay. Chấm đều l&ecirc;n c&aacute;c điểm tr&ecirc;n khu&ocirc;n mặt như mũi, tr&aacute;n, m&aacute;. Cuối c&ugrave;ng d&ugrave;ng tay t&aacute;n đều kem ra v&agrave; massage để chất kem thấm đều v&agrave;o tế b&agrave;o da.</p>

<p>➖ D&ugrave;ng như 1 loại mặt nạ dưỡng da: cho 1 lượng kem nhiều hơn l&uacute;c dưỡng da b&igrave;nh thường, thoa đều lớp kem d&agrave;y l&ecirc;n mặt. Thư gi&atilde;n khoảng 5-10 ph&uacute;t sau đ&oacute; massage lớp kem c&ograve;n lại để kem thấm đều v&agrave; nu&ocirc;i dưỡng da săn chắc, mịn m&agrave;ng hơn.</p>

<p>➖ D&ugrave;ng như 1 dạng kem dưỡng thể (body): sau khi tắm xong bạn c&oacute; thể d&ugrave;ng kem dưỡng Naturie như kem dưỡng body, thoa to&agrave;n th&acirc;n để tạo n&ecirc;n lớp dưỡng ẩm cho da th&ecirc;m mịn m&agrave;ng.</p>

<p>➖ Để đảm bảo hợp vệ sinh trong qu&aacute; tr&igrave;nh sử dụng l&acirc;u d&agrave;i, bạn n&ecirc;n d&ugrave;ng dụng cụ lấy kem ra khỏi hộp.</p>
', 1, 0, N'kem-duong-naturie-skin-conditioning-gel-kem-duong-y-di-180g', CAST(N'2021-08-19 10:26:02.720' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4165, N'CHÌ KẺ MÀY HAI ĐẦU INNISFREE VỎ ĐEN MỚI', N'Innisfree', N'/Uploads/images/product/pro132.jpg', N'/Uploads/images/product/pro132.jpg', 0, N'Chì kẻ mày Innisfree có xuất xứ từ Hàn Quốc mềm mại, dễ tán là sản phẩm rất hiệu quả mà giá thành lại rẻ sẽ giúp bạn có đôi lông mày đẹp như ý muốn. Đây là lựa chọn phù hợp nhất với những người mới tập kẻ lông mày.', 2104, N'<p>- XUẤT XỨ: H&agrave;n Quốc</p>

<p>- THƯƠNG HIỆU: INNISFREE</p>

<p>&nbsp;</p>

<p>✖️ BẢNG M&Agrave;U:</p>

<p>#No.1 &ndash; Rose Brown (N&acirc;u Nhạt)</p>

<p>#No.2 &ndash; Dark Night Sky Black (Đen)</p>

<p>#No.3 &ndash; Dreamy Dawing Gray (X&aacute;m)</p>

<p>#No.4 &ndash; Early Morning Dew Ash Brown (N&acirc;u)</p>

<p>#No.5 &ndash; Midnight Expresso Brown (N&acirc;u Đen)</p>

<p>#No.6 &ndash; Urban Brown Before Day Light (N&acirc;u Sẫm)</p>

<p>#No.7 &ndash; Honey Brow</p>

<p>&nbsp;</p>

<p>✖️ ƯU ĐIỂM:</p>

<p>✔️ T&ocirc; điểm cho gương mặt của bạn th&ecirc;m h&agrave;i h&ograve;a, xinh xắn.</p>

<p>✔️ Gi&uacute;p th&ocirc;ng tho&aacute;ng lỗ ch&acirc;n l&ocirc;ng, cho dưỡng chất được thẩm thấu v&agrave;o da tốt nhất.</p>

<p>✔️ Biến h&oacute;a nhiều phong c&aacute;ch đa dạng với ch&igrave; kẻ m&agrave;y Innisfree Auto Eyebrow Pencil, gi&uacute;p diện mạo của bạn lu&ocirc;n mới mẻ, kh&ocirc;ng bị nh&agrave;m ch&aacute;n.</p>

<p>✔️ Thiết kế nhỏ gọn với 2 đầu tiện lợi, gi&uacute;p ch&uacute;ng ta c&oacute; thể kẻ được ch&acirc;n m&agrave;y một c&aacute;ch ho&agrave;n hảo. Đầu cọ mảnh h&igrave;nh ovan gi&uacute;p người d&ugrave;ng kẻ m&agrave;y dễ d&agrave;ng, d&ugrave; l&agrave; người mới bắt đầu.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>✔️ D&ugrave;ng đầu ch&igrave; kẻ theo đường khung ch&acirc;n m&agrave;y từ ph&iacute;a đầu l&ocirc;ng m&agrave;y đến hết đu&ocirc;i.</p>

<p>✔️ D&ugrave;ng đầu chổi chuốt l&ocirc;ng m&agrave;y, chải từ từ theo chiều mọc để ch&acirc;n m&agrave;y đều m&agrave;u v&agrave; tr&ocirc;ng tự nhi&ecirc;n.</p>
', 1, 0, N'chi-ke-may-hai-dau-innisfree-vo-den-moi', CAST(N'2021-08-19 10:30:24.377' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4166, N'Dưỡng Thể Trắng Da Vaseline 50X SPF 50+ PA++++', N'Khác', N'/Uploads/images/product/pro133.jpg', N'/Uploads/images/product/pro133.jpg', 0, N'Sữa Dưỡng Thể Vaseline 50x SPF 50++ Thái Lan siêu hot, tác dụng dưỡng trắng gấp 50 lần so với các dòng dưỡng Vaseline thông thường. Tính năng thẩm thấu vượt trội giúp da nhanh chóng hấp thu 100% dưỡng chất vào da.', 2099, N'<p>- Xuất xứ: Th&aacute;i Lan</p>

<p>&nbsp;</p>

<p><strong>ƯU ĐIỂM</strong>:</p>

<p>&ndash; T&iacute;nh năng thẩm thấu vượt trội gi&uacute;p da hấp thu 100% dưỡng chất v&agrave;o da.</p>

<p>&ndash; Chỉ số chống nắng SPF 50+pa++++, chống tia UVA v&agrave; UVB</p>

<p>&ndash; Dưỡng trắng gấp 50 lần Vaseline th&ocirc;ng thường, da nhanh ch&oacute;ng l&ecirc;n tone v&agrave; mịn m&agrave;ng &ndash; Bổ sung Collagen gi&uacute;p da săn chắc, ngăn ngừa l&atilde;o h&oacute;a da.</p>

<p>&nbsp;</p>

<p><strong>C&Ocirc;NG DỤNG:</strong></p>

<p>&ndash; Gi&uacute;p da lu&ocirc;n mịn m&agrave;ng, trắng s&aacute;ng rực rỡ, đặc biệt giam nếp nhăn v&agrave; chống l&atilde;o h&oacute;a da</p>

<p>&ndash; Gi&uacute;p phục hồi hư tổn da từ s&acirc;u b&ecirc;n trong.</p>

<p>&ndash; M&agrave;ng chống nắng 3 t&aacute;c động bảo vệ khỏi t&aacute;c hại của UVA &amp; UVB</p>

<p>&ndash; Sản phẩm được kiểm nghiệm &amp; chứng nhận an to&agrave;n cho da.</p>

<p>&ndash; Trắng da</p>

<p>&ndash; L&agrave;m đều m&agrave;u da</p>

<p>&ndash; Chống nắng (UVA &amp; UVB)</p>

<p>&ndash; Giảm vết th&acirc;m</p>

<p>&ndash; L&agrave;m cho da rạng rỡ, đầy sức sống</p>

<p>&ndash; Mềm mịn &amp; săn chắc</p>

<p>&ndash; L&agrave;m mờ nếp nhăn</p>

<p>&ndash; T&aacute;i tạo da</p>

<p>&ndash; Dưỡng ẩm da hiệu quả</p>

<p>&ndash; Nu&ocirc;i dưỡng da từ s&acirc;u b&ecirc;n trong</p>
', 1, 0, N'duong-the-trang-da-vaseline-50x-spf-50-pa', CAST(N'2021-08-19 10:36:04.303' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4167, N'Son 3ce Cloud Lip Tint', N'3ce', N'/Uploads/images/product/pro134.jpg', N'/Uploads/images/product/pro134.jpg', 0, N'Son kem lì 3CE Cloud Lip Tint có chất son mềm mượt dễ tán, son set lì nhanh lên môi và giữ cho đôi môi luôn mịn màng, tạo cảm giác đôi môi mịn mượt, hoàn hảo nhẹ tựa như mây ', 2094, N'<p>Chắc hẳn ai cũng đ&atilde; nghe qua d&ograve;ng son đ&igrave;nh đ&aacute;m Cloud Lip Tint của 3CE rồi. V&igrave; từ hồi ra mắt qu&aacute; nhiều người, trang khen em n&oacute; 🥰🥰 Thiết kế đẹp, sang chảnh, chất son si&ecirc;u th&iacute;ch l&igrave;, mịn m&agrave; kh&ocirc;ng hề kh&ocirc; m&ocirc;i. V&igrave; qu&aacute; HOT n&ecirc;n hồi ra mắt em n&oacute; rất hiếm v&agrave; đắt 😭😭. Nay em n&oacute; đ&atilde; hạ nhiệt gi&aacute; tốt, vừa t&uacute;i tiền sinh vi&ecirc;n #250k kh&aacute;ch n&agrave;o từng muốn sở hữu, trải nghiệm em n&oacute; th&igrave; nhanh tay nha. H&agrave;ng c&oacute; sẵn ạ 😘😘</p>

<p>&nbsp;</p>

<p>Bảng m&agrave;u:</p>

<p>Beige Avenue: M&agrave;u cam đất</p>

<p>Needful: M&agrave;u đỏ gạch</p>

<p>Active Lady: M&agrave;u hồng cam nude</p>

<p>Macaron Red: M&agrave;u đỏ tươi</p>

<p>Live A Little: M&agrave;u đỏ đất</p>

<p>Fairy Cake: M&agrave;u hồng đất</p>

<p>Immanence: M&agrave;u đỏ trầm</p>

<p>Cutesicle: M&agrave;u hồng nude</p>

<p>Blossom Day: M&agrave;u hồng đ&agrave;o</p>

<p>Pinkalicious: M&agrave;u hồng trầm</p>

<p>Carrot Pink: M&agrave;u hồng san h&ocirc;</p>

<p>Peach Tease: M&agrave;u cam san h&ocirc;</p>
', 1, 0, N'son-3ce-cloud-lip-tint', CAST(N'2021-08-19 10:43:00.127' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4168, N'Mặt nạ Kiehl’s mini 14ml', N'Khác', N'/Uploads/images/product/pro135.jpg', N'/Uploads/images/product/pro135.jpg', 0, N'Kiehl’s là một trong những thương hiệu mỹ phẩm cao cấp được yêu thích nhất tại Mỹ, sản phẩm của Kiehl’s chưa bao giờ khiến chị em phải thất vọng.', 2107, N'<p>&nbsp;</p>

<p>- Xuất xứ: Mỹ</p>

<p>- H&atilde;ng SX: Kiehl&#39;s</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>1. Mặt nạ đất s&eacute;t thải độc Kiehl&rsquo;s Rare Earth Deep Pore Cleansing Masque 14ml:</p>

<p>Mặt nạ thải độc ph&ugrave; hợp nhất với những người c&oacute; l&agrave;n da bị mụn đầu đen, đầu trắng, hoặc lỗ ch&acirc;n l&ocirc;ng to,.. Chiết xuất từ đất s&eacute;t Amazon sẽ gi&uacute;p bạn giải quyết những vấn đề tr&ecirc;n.</p>

<p>➡️<strong> C&ocirc;ng dụng</strong>:</p>

<p>- Thanh lọc, thải độc tố cho da,</p>

<p>- Gi&uacute;p l&agrave;m sạch, lấy đi những chất bẩn từ s&acirc;u lỗ ch&acirc;n l&ocirc;ng, h&uacute;t sạch nhờn v&agrave; se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng</p>

<p>- Lấy sạch mụn c&aacute;m, mụn đầu đen sau 1 th&aacute;ng chăm chỉ sử dụng.</p>

<p>- B&ecirc;n cạnh đ&oacute;, cấp ẩm v&agrave; l&agrave;m dịu da, kh&ocirc;ng để xảy ra t&igrave;nh trạng kh&ocirc; da.</p>

<p>&nbsp;</p>

<p>2. Mặt nạ nghệ Turmeric &amp; Cranberry Seed Energizing &amp; Radiance Masque 14ml: Mặt nạ chiết xuất từ nghệ v&agrave; chiết xuất quả nam việt quất chứa chất chống oxy h&oacute;a cực cao hứa hẹn mang đến sự bất ngờ cho bạn.</p>

<p>➡️ <strong>C&ocirc;ng dụng</strong>:</p>

<p>- Cung cấp năng lượng cho l&agrave;n da tươi tắn, phục hồi l&agrave;n da bị xỉn m&agrave;u. mệt mỏi do trang điểm nhiều, thức khuya,...</p>

<p>- Tinh chất nghệ gi&uacute;p l&agrave;m sạch s&aacute;ng da, x&oacute;a mờ hắc tố melamin, đốm n&acirc;u, gi&uacute;p da s&aacute;ng dần l&ecirc;n v&agrave; hồng h&agrave;o, rạng rỡ. Cải thiện tone da (*).</p>

<p>- Nam việt quất chứa chất chống oxy h&oacute;a cực cao, bảo vệ tế b&agrave;o da trước t&aacute;c động của m&ocirc;i trường, chống l&atilde;o h&oacute;a.</p>

<p>- B&ecirc;n cạnh đ&oacute;, mặt nạ n&agrave;y c&ograve;n gi&uacute;p l&agrave;m sạch nhờn, lấy đi tế b&agrave;o chết cho da tươi s&aacute;ng, căng mịn.</p>

<p>&nbsp;</p>

<p>3. Mặt nạ ngủ Kiehl&rsquo;s Cilantro &amp; Orange Extract Pollutant Defending Masque 14ml:</p>

<p>Đ&acirc;y l&agrave; 1 trong C&aacute;c loại mặt nạ Kiehl&rsquo;s được y&ecirc;u th&iacute;ch nhất. Th&agrave;nh phần của n&oacute; được chiết xuất từ cam v&agrave; rau m&ugrave;i.</p>

<p>➡️ <strong>C&ocirc;ng dụng</strong>:</p>

<p>- L&agrave;m sạch da, loại bỏ độc tố h&oacute;a học cho da khỏe mạnh.</p>

<p>- Cung cấp ẩm v&agrave; dưỡng chất để nu&ocirc;i dưỡng da mịn m&agrave;ng tươi s&aacute;ng.</p>

<p>- Chất chống oxy h&oacute;a trong cam gi&uacute;p bảo vệ tế b&agrave;o da, chống l&atilde;o h&oacute;a.</p>

<p>- K&iacute;ch th&iacute;ch sản sinh collagen gi&uacute;p da đ&agrave;n hồi, săn chắc.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>4. Mặt nạ hoa c&uacute;c v&agrave; l&ocirc; hội Kiehl&rsquo;s Calendula &amp; Aloe Smooth Hydration Masque 14ml:</p>

<p>Th&agrave;nh phần chiết xuất từ hoa c&uacute;c v&agrave; l&ocirc; hội chăm s&oacute;c v&agrave; l&agrave;m dịu da, th&iacute;ch hợp cho da nhạy cảm, da mụn.</p>

<p>➡️ <strong>C&ocirc;ng dụng</strong>:</p>

<p>- Mặt nạ chứa dưỡng chất gi&uacute;p kh&aacute;ng vi&ecirc;m, l&agrave;m dịu da k&iacute;ch ứng, giảm vi&ecirc;m sưng cho da mụn, dị ứng.</p>

<p>- L&agrave;m sạch, diệt khuẩn, ngừa mụn.</p>

<p>- L&ocirc; hội gi&uacute;p cẩm ẩm cho da ngậm nước, căng mượt, l&agrave;m mềm v&agrave; mịn da.</p>

<p>- Se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>- Đắp mặt nạ Kiehl&rsquo;s 14ml tr&ecirc;n nền da ẩm sau khi đ&atilde; l&agrave;m sạch da bằng sữa rửa mặt.</p>

<p>- Với mặt nạ ngủ th&igrave; bạn để qua đ&ecirc;m c&ograve;n lại h&atilde;y đắp trong v&ograve;ng khoảng 10 ph&uacute;t, sau đ&oacute; rửa sạch bằng nước ấm nh&eacute;.</p>

<p>- Mặt nạ thải độc n&ecirc;n d&ugrave;ng 2 lần mỗi tuần.</p>

<p>- Bảo quản nơi kh&ocirc; r&aacute;o khi đ&atilde; vặn kỹ nắp. Tr&aacute;nh &aacute;nh nắng mặt trời.</p>
', 1, 0, N'mat-na-kiehls-mini-14ml', CAST(N'2021-08-19 10:51:18.277' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4169, N'BÔNG TẨY TRANG EMILY ĐỨC', N'Khác', N'/Uploads/images/product/pro136.jpg', N'/Uploads/images/product/pro136.jpg', 45000, N'Bông tẩy trang Emily Đức 120 miếng với thiết kế bông tròn cố định ở mép giúp bạn dễ dàng và thuận tiện thao tác khi tẩy trang.', 2096, N'<p>✖️ ƯU ĐIỂM:</p>

<p>✔️ B&ocirc;ng tẩy trang Emily 100% cotton nhập khẩu từ Đức- sản phẩm hộ trợ tẩy trang ho&agrave;n hảo.</p>

<p>✔️ B&ocirc;ng được cấu tạo từ 100% cotton nguy&ecirc;n chất, kh&ocirc;ng h&oacute;a chất t&acirc;y trắng, cực kỳ mềm mịn v&agrave; an to&agrave;n.</p>

<p>✔️ Thiết kế h&igrave;nh b&ocirc;ng tr&ograve;n với đường d&acirc;p cố định m&eacute;p, thuận tiện cho bạn tẩy trang thật dễ d&agrave;ng.</p>

<p>✔️ Miếng b&ocirc;ng rất mềm, c&oacute; m&agrave;ng bao chắc chắn để sợi b&ocirc;ng kh&ocirc;ng ch&igrave;a ra ngo&agrave;i, đồng thời gi&uacute;p b&ocirc;ng dai hơn, bền hơn.</p>

<p>✔️ Emily wattepads rất mỏng, sạch, lớp m&agrave;ng giữ cho sợi b&ocirc;ng kh&ocirc;ng v&agrave;o mắt, diện t&iacute;ch tiếp x&uacute;c lớn, bề mặt c&oacute; độ lồi l&otilde;m của miếng b&ocirc;ng gi&uacute;p tẩy trang vừa sạch vừa nhanh ch&oacute;ng.</p>

<p>✔️ D&ugrave;ng để tẩy trang, thoa nước hoa hồng cực kỳ tiện dụng, vệ sinh.</p>

<p>✔️ Đ&atilde; được kiểm định y tế về chất lượng, v&agrave; được c&aacute;c chuy&ecirc;n gia khuy&ecirc;n d&ugrave;ng.</p>
', 1, 0, N'bong-tay-trang-emily-duc', CAST(N'2021-08-19 10:53:11.730' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4170, N'Sữa dưỡng thể dưỡng ngày chống nắng Hatomugi ý dĩ SPF31 PA+++', N'Khác', N'/Uploads/images/product/pro140.jpg', N'/Uploads/images/product/pro140.jpg', 160000, N'Sữa dưỡng thể chống nắng Hatomugi SPF31 PA+++ Nhật Bản mới được tung ra thị trường đã được rất nhiều đón nhận của chị em phụ nữ. Sản phẩm vừa có tác dụng làm kem dưỡng ẩm , dưỡng trắng da vừa có tác dụng là kem chống nắng , sử dụng cho cả body và mặt đều được. Sữa dưỡng thể Hatomugi SPF31 PA+++ đang nổi đình đám nhờ công dụng siêu tiện lợi lại ở một mức giá hợp lý không thể chê vào đâu được.', 2099, N'<p>🖤🖤Sữa dưỡng thể dưỡng ng&agrave;y chống nắng Hatomugi SPF31 PA+++🖤🖤</p>

<p>💲 G&iacute;a lẻ: 160k</p>

<p>&nbsp;</p>

<p>➡️ H&atilde;ng sản xuất: HATOMUGI</p>

<p>➡️ Xuất xứ: Nhật bản</p>

<p>➡️ Quy c&aacute;ch: Chai 250ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Đ&acirc;y l&agrave; si&ecirc;u phẩm cho m&ugrave;a h&egrave; m&aacute;t lạnh với t&aacute;c dụng vừa chống nắng vừa l&agrave;m trắng da</p>

<p>✔️ Gi&uacute;p tr&aacute;nh được t&igrave;nh trạng ch&aacute;y nắng đỏ r&aacute;t khi ra ngo&agrave;i trời m&ugrave;a h&egrave;.</p>

<p>✔️ Dễ thẩm thấu ngay v&agrave;o da khi b&ocirc;i kh&ocirc;ng h&acirc;y t&igrave;nh trạng bết d&iacute;nh kh&oacute; chịu.</p>

<p>✔️ Gi&uacute;p dưỡng ẩm s&acirc;u, l&agrave;m mềm da.</p>

<p>✔️ Gi&uacute;p dưỡng da s&aacute;ng hơn, trắng hơn, x&oacute;a mờ th&acirc;m từng ng&agrave;y.</p>

<p>✔️ Gi&uacute;p l&agrave;m dịu da, chống vi&ecirc;m, cải thiện t&igrave;nh trạng mụn, trứng c&aacute;.</p>

<p>✔️ L&agrave;m mịn da, giảm sự th&ocirc; r&aacute;p tr&ecirc;n bề mặt da.</p>

<p>✔️ C&oacute; t&aacute;c dụng se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng.</p>

<p>✔️ L&agrave;m săn chắc da, chống l&atilde;o h&oacute;a, cải thiện dấu hiệu của tuổi t&aacute;c.</p>

<p>✔️ B&igrave;nh thường h&oacute;a chu kỳ sừng h&oacute;a của tế b&agrave;o da.</p>

<p>✔️ Sữa dưỡng thể l&agrave;m trắng, chống nắng Hatomugi SPF31 PA+++ kh&ocirc;ng g&acirc;y hại cho da v&igrave; th&agrave;nh phần từ hạt &yacute; dĩ &ndash; một dược liệu qu&yacute; v&agrave; c&oacute; &iacute;ch với sức khỏe v&agrave; c&ocirc;ng dụng thần kỳ trong việc l&agrave;m đẹp l&agrave;m trắng da phi thường của người Nhật</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>➖ Thoa đều l&ecirc;n da body v&agrave;o mỗi buổi s&aacute;ng l&agrave; đủ cho cả ng&agrave;y d&agrave;i nắng n&oacute;ng</p>

<p>➖ Chất lotion lỏng nhẹ v&agrave; thoa rất dễ l&ecirc;n da, tan v&agrave; thấm ngay v&agrave;o da chỉ sau 2-3s.</p>
', 1, 0, N'sua-duong-the-duong-ngay-chong-nang-hatomugi-y-di-spf31-pa', CAST(N'2021-08-19 10:55:49.093' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4171, N'Sữa rửa mặt Cerave 473ml', N'Cerave', N'/Uploads/images/product/pro138.jpg', N'/Uploads/images/product/pro138.jpg', 0, N'Sữa rửa mặt dành cho da khô và da dầu CeraVe Foaming Facial Cleanser được khuyên dùng hàng ngày vì độ dịu nhẹ cũng như khả năng thân thiện với làn da, làm sạch da nhẹ nhàng, loại bỏ dầu thừa, se khít lỗ chân lông và giảm mụn mà không gây khô căng nhờ độ pH lý tưởng.', 2097, N'<p>- Ph&acirc;n loại:</p>

<p>+ CeraVe Foaming: Glycerin tạo độ ẩm cho da, c&aacute;c hợp chất Ceramin gi&uacute;p bảo vệ v&agrave; củng cố lớp m&agrave;ng, Hyaluronic Acid tăng độ ẩm v&agrave; Niacinamide để sản sinh Ceramin.</p>

<p>+ CeraVe Hydrating: cũng c&oacute; th&agrave;nh phần như CeraVe Foaming nhưng h&agrave;m lượng kh&aacute;c nhau như Hyaluronic Acid v&agrave; Glycerin được ưu &aacute;i nhiều hơn để tăng cường độ ẩm 1 c&aacute;ch tối đa. C&aacute;c th&agrave;nh phần kh&aacute;c vẫn được giữ nguy&ecirc;n.</p>
', 1, 0, N'sua-rua-mat-cerave-473ml', CAST(N'2021-08-19 10:58:56.487' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4172, N'Toner Skin1004 Madagascar Centella 210ml (Vỏ vàng)', N'Skin1004', N'/Uploads/images/product/pro137.jpg', N'/Uploads/images/product/pro137.jpg', 290000, N'Nước Hoa Hồng Skin1004 Madagascar Centella Asiatica Toning Toner 200ml của Hàn Quốc đã mang đến cho bạn gái làn da khỏe đẹp với nhiều tác dụng tuyệt vời với công thức từ 84% tinh chất chiết xuất lá rau má từ quần đảo Madagascar Pháp - nơi loại rau má phát triển mạnh giúp hình thành sản phẩm đặc biệt dành cho da mụn, da nhạy cảm ửng đỏ, kháng viêm, giảm sưng tấy, xóa thâm nám, giảm mụn,…', 2098, N'<p>-Tăng cường sản sinh Collagen, chống l&atilde;o h&oacute;a da, dưỡng ẩm da một c&aacute;ch vượt trội, gi&uacute;p da mịn m&agrave;ng v&agrave; đều m&agrave;u hơn.</p>

<p>-Nước Hoa Hồng Madagascar c&ograve;n chứa PHA &ndash; một loại acid tự nhi&ecirc;n c&oacute; khả năng loại bỏ đi lớp tế b&agrave;o chết d&agrave;ng cho da nhạy cảm kh&ocirc;ng thể sử dụng AHA hay BHA, chống oxy h&oacute;a, k&iacute;ch th&iacute;ch t&aacute;i tạo tế b&agrave;o da, giảm nếp nhăn v&agrave; gi&uacute;p da mặt khỏe, săn chắc hơn tr&ocirc;ng thấy.</p>

<p>-Sản phẩm c&oacute; độ PH= 5.3 tương tự với độ Ph c&oacute; tr&ecirc;n da, n&ecirc;n sản phẩm kh&ocirc;ng l&agrave;m k&iacute;ch ứng da, ph&ugrave; hợp với mọi loại da đặc biệt đối với chị em c&oacute; l&agrave;n da nhạy cảm c&oacute; thể y&ecirc;n t&acirc;m sử dụng sản phẩm</p>
', 1, 0, N'toner-skin1004-madagascar-centella-210ml-vo-vang', CAST(N'2021-08-19 11:03:11.660' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4173, N'Nước hoa hồng Ý Dĩ', N'Aprilskin', N'/Uploads/images/product/pro139.jpg', N'/Uploads/images/product/pro139.jpg', 185000, N'Nước hoa hồng Naturie Skin Conditioner có xuất xừ từ Nhật Bản với dung tích 500ml  được bình chọn là lotion bán chạy nhất tại Nhật trong năm 2015, với thành phần chính được chiết xuất từ cây Ý Dĩ loại rất co nhiều tác dụng trong viêc chăm sóc da, đặc biệt là dưỡng ẩm và làm sáng da.', 2098, N'<p>🖤🖤 Nước hoa hồng &Yacute; Dĩ 🖤🖤</p>

<p>&nbsp;</p>

<p>➖ Với một con nghiện lotion mask như em th&igrave; em ấy kh&ocirc;ng thể thiếu tr&ecirc;n kệ 😎</p>

<p>➖ 500ml d&ugrave;ng tĩ t&atilde; lại rẻ m&agrave; l&agrave;nh t&iacute;nh chứ.</p>

<p>➖ Nếu chăm v&agrave;o c&aacute;c diễn đ&agrave;n l&agrave;m đẹp như em, c&aacute;c chế sẽ biết em nước hoa hồng &yacute; dĩ n&agrave;y hot v&agrave; nhiều review ca ngợi như thế n&agrave;o, nh&agrave; em c&oacute; sẵn, gi&aacute; y&ecirc;u thương lắm cho 1 chai to oạch 500ml ạ ❤️</p>

<p>&nbsp;</p>

<p>✖️ Naturie Skin Conditioner tận dụng triệt để những LỢI &Iacute;CH m&agrave; &yacute; dĩ đem lại:</p>

<p>✔️ Ngay lập tức đem đến cho da cảm gi&aacute;c tươi m&aacute;t.</p>

<p>✔️ Phục hồi v&agrave; l&agrave;m dịu l&agrave;n da bị ch&aacute;y nắng.</p>

<p>✔️ Lỏng như nước, thẩm thấu cực nhanh v&agrave; tuyệt đối kh&ocirc;ng hề d&iacute;nh nhờn.</p>

<p>✔️ Linh hoạt với nhiều c&aacute;ch sử dụng kh&aacute;c nhau. Trong đ&oacute;, sử dụng như lotion mask đem lại hiệu quả tuyệt vời nhất.</p>

<p>✔️ Tăng cường khả năng hấp thụ dưỡng chất từ c&aacute;c sản phẩm dưỡng da sau đ&oacute; như sữa dưỡng, kem dưỡng.</p>

<p>✔️ Kh&ocirc;ng chứa hương liệu, chất tạo m&agrave;u, d&agrave;i l&acirc;u.</p>

<p>✔️ Ph&ugrave; hợp với mọi loại da, đặc biệt l&agrave; da đang c&oacute; vấn đề về mụn v&agrave; lỗ ch&acirc;n l&ocirc;ng.</p>

<p>&nbsp;</p>

<p>✖️ CH&Uacute; &Yacute;:</p>

<p>➖ Thấy t&aacute;c dụng ngay lập tức khi &aacute;p dụng l&agrave;m &rdquo; lotion mask 3 ph&uacute;t &rdquo; c&aacute;c n&agrave;ng nh&eacute;.</p>

<p>➖ Tẩm ướt mask giấy hoặc b&ocirc;ng n&eacute;n v&agrave; đắp l&ecirc;n mặt 3 ph&uacute;t, sau 3 ph&uacute;t cảm nhận sự kh&aacute;c biệt ho&agrave;n to&agrave;n tr&ecirc;n da 😍</p>
', 1, 0, N'nuoc-hoa-hong-y-di', CAST(N'2021-08-19 11:06:20.127' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4174, N'Mặt nạ đất sét Dreamworks Hàn Quốc', N'Khác', N'/Uploads/images/product/pro141.jpg', N'/Uploads/images/product/pro141.jpg', 0, N'Mặt Nạ Đất Sét Bạc Hà Dreamworks I''m The Real Shrek Pack 110g Mặt Nạ Đất Sét Bạc Hà Dreamworks I''m The Real Shrek Pack 110g siêu phẩm từ xứ Hàn đã về lại rồi nha các nàng ơi. Em này chuyên trị mụn đầu đen, sợi bã nhờn, mụn ẩn và lỗ chân lông to, dùng xong da cực thích luôn nha.', 2112, N'<p>🖤🖤Mặt nạ đất s&eacute;t Dreamworks H&agrave;n Quốc🖤🖤</p>

<p>&nbsp;</p>

<p>1/ SHREK PACK - M&Agrave;U XANH</p>

<p>- Mặt nạ chứa đất s&eacute;t xanh gi&uacute;p l&agrave;m sạch b&atilde; nhờn tr&ecirc;n da</p>

<p>- Bạc h&agrave; gi&uacute;p đem lại cảm gi&aacute;c m&aacute;t lạnh, thư gi&atilde;n</p>

<p>- Bột l&aacute; neem v&agrave; tr&agrave; xanh gi&uacute;p thu nhỏ lỗ ch&acirc;n l&ocirc;ng, kh&aacute;ng khuẩn, trị mụn. Bột l&aacute; neem c&oacute; t&iacute;nh kh&aacute;ng khuẩn cực k&igrave; cao, cao gấp 10 lần l&aacute; tr&agrave; xanh nh&eacute; chị em</p>

<p>- Bột đậu đỏ gi&uacute;p tẩy da chết nhẹ, l&agrave;m mịn v&agrave; s&aacute;ng da</p>

<p>- Chiết xuất l&aacute; bạch đ&agrave;n gi&uacute;p kh&aacute;ng khuẩn, chống vi&ecirc;m, chữa l&agrave;nh vết thương</p>

<p>- Chiết xuất nha đam gi&uacute;p l&agrave;m dịu da, tăng tuần ho&agrave;n m&aacute;u, l&agrave;m l&agrave;nh vết thương</p>

<p>&nbsp;</p>

<p>2/ PINK PACK WHITE PACK- M&Agrave;U HỒNG</p>

<p>- Chứa bột Calamine (10%): giảm mẩn đỏ, k&iacute;ch ứng, kh&aacute;ng vi&ecirc;m</p>

<p>- Chiết xuất hoa hồng Đan Mạch gi&uacute;p c&acirc;n bằng lượng nước v&agrave; dầu tr&ecirc;n da, l&agrave;m mềm v&agrave; mịn da</p>

<p>- Chứa AHA chiết xuất từ hoa d&acirc;m bụt gi&uacute;p giảm thiểu da chết, l&agrave;m s&aacute;ng da</p>

<p>&nbsp;</p>

<p>3/ WHITE PACK - M&Agrave;U TRẮNG</p>

<p>- Chiết xuất gạo l&ecirc;n men gi&uacute;p dưỡng trắng da</p>

<p>- Đất s&eacute;t trắng gi&uacute;p loại bỏ b&atilde; nhờn, chất thải trong lỗ ch&acirc;n l&ocirc;ng</p>

<p>- Chiết xuất từ tr&aacute;i sung gi&agrave;u vitamin gi&uacute;p dưỡng trắng da</p>

<p>- Chiết xuất rễ hoa mẫu đơn: gi&uacute;p điều trị vi&ecirc;m, ngăn ngừa oxi ho&aacute;, tăng cường tuần ho&agrave;n m&aacute;u, sửa chữa v&agrave; phục hồi c&aacute;c tế b&agrave;o, l&agrave;m mềm v&agrave; l&agrave;m trắng da</p>
', 1, 0, N'mat-na-dat-set-dreamworks-han-quoc', CAST(N'2021-08-19 11:10:56.427' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4175, N'Kem chống nắng Innisfree', N'Innisfree', N'/Uploads/images/product/pro142.jpg', N'/Uploads/images/product/pro142.jpg', 0, N'Kem chống nắng innisfree ngày càng được nhiều phái đẹp yêu thích bởi không chỉ có nhiều lựa chọn cho từng loại da khác nhau từ da dầu, da khô đến da nhạy cảm, kem chống nắng innisfree còn lâu trôi và đem lại sự tự tin tuyệt vời cho làn da nhờ vào chỉ số SPF30/SPF50 PA+++. Thương hiệu kem chống nắng đến từ Hàn Quốc còn được biết đến với thiết kế vỏ ngoài có màu sắc nổi bật như vàng, hồng,...', 2101, N'<p>🖤🖤Kem chống nắng Innisfree🖤🖤</p>

<p>- Xuất xứ: H&agrave;n Quốc</p>

<p>- Thương hiệu: Innisfree</p>

<p>- Dung t&iacute;ch: 50ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>1. NO SEBUM: L&ecirc;n tone trắng hồng</p>

<p>- Kiểm so&aacute;t nhờn, mọi loại da</p>

<p>- Chất kem kh&ocirc;ng g&acirc;y nhờn v&agrave; b&iacute; da, kh&ocirc;ng chứa những th&agrave;nh phần dễ g&acirc;y nổi mụn.</p>

<p>- Kh&ocirc;ng g&acirc;y nặng mặt, th&iacute;ch hợp để đi l&agrave;m, đi học hằng ng&agrave;y.</p>

<p>- Thấm v&agrave;o da, kh&ocirc;ng g&acirc;y cảm gi&aacute;c nhờn r&iacute;t v&agrave; khả năng kiềm dầu tốt.</p>

<p>- Sản phẩm gi&uacute;p n&acirc;ng tone vừa cho da v&agrave; c&oacute; độ che phủ nhẹ.</p>

<p>- C&oacute; khả năng kiềm dầu ở mức kh&aacute;.</p>

<p>&nbsp;</p>

<p>2. LONG LASTING: Chống nước, bảo vệ d&agrave;i l&acirc;u, mọi loại da</p>

<p>- Chỉ số chống nắng cao, SPF 50+, PA+++, bảo vệ da khỏi c&aacute;c t&aacute;c động bởi m&ocirc;i trường b&ecirc;n ngo&agrave;i.</p>

<p>- Kem c&oacute; ưu điểm l&agrave; sau khi sử dụng sẽ cho bạn một l&agrave;n da trắng hồng, che khuyết điểm tương đối.</p>

<p>- Kh&ocirc;ng g&acirc;y nặng mặt, kh&ocirc;ng l&agrave;m b&iacute; tắc lỗ ch&acirc;n l&ocirc;ng.</p>

<p>- C&oacute; thể thay thế lớp kem l&oacute;t trang điểm hằng ng&agrave;y.</p>

<p>- C&oacute; khả năng kiềm dầu tốt.</p>

<p>&nbsp;</p>

<p>3. TRIPLE-SHIELD: Mọi loại da</p>

<p>- Chỉ số chống nắng cao, th&iacute;ch hợp d&ugrave;ng khi hoạt động ngo&agrave;i trời.</p>

<p>- Hỗ trợ cải thiện nếp nhăn, chống l&atilde;o h&oacute;a cho da</p>

<p>- Dưỡng ẩm cho da tốt</p>

<p>- Dưỡng trắng cho daKh&ocirc;ng chứa nguy&ecirc;n li&ecirc;̣u g&ocirc;́c đ&ocirc;̣ng v&acirc;̣t v&agrave; hương thơm nh&acirc;n tạo, an to&agrave;n cho da.</p>

<p>- Khả năng chống thấm nước tốt</p>
', 1, 0, N'kem-chong-nang-innisfree', CAST(N'2021-08-19 11:16:13.700' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4176, N'Kem Chống Nắng Skin Aqua Tone Up UV Essence Nhật Bản 80ml', N'Rohto', N'/Uploads/images/product/pro143.jpg', N'/Uploads/images/product/pro143.jpg', 205000, N'Kem Chống Nắng Skin Aqua Tone Up Essence Rohto Nhật Bản là sản phẩm kem chống nắng với mức giá bình dân đến từ Nhật Bản, kể từ ngày ra mắt sản phẩm luôn đứng top những sản phẩm được yêu thích nhất trên trang Cosme do người Nhật bình chọn. Không những vậy, đây cũng là dòng kem chống nắng được các bạn trẻ ở Việt Nam " mê mẩn" bởi chất kem sánh mịn, lên tone siêu siêu đẹp cùng khả năng chống nắng tuyệt vời.', 2101, N'<p>➡️ Thương hiệu: Rohto</p>

<p>➡️ Xuất xứ: Nhật bản</p>

<p>➡️ Dung t&iacute;ch: 80ml</p>

<p>&nbsp;</p>

<p>✔️ Với chỉ số SPF50+ - cực kỳ ph&ugrave; hợp với điều kiện kh&iacute; hậu Việt Nam v&agrave; c&ocirc;ng nghệ mới gi&uacute;p thấm nhanh, dưỡng da tốt, kem chống nắng SKIN Aqua sẽ kh&ocirc;ng khiến c&aacute;c chị em phải thất vọng.</p>

<p>✔️ M&ugrave;a h&egrave; l&agrave; l&uacute;c diễn ra nhiều hoạt động thể thao ngo&agrave;i trời, bơi lội, du lịch, nếu kh&ocirc;ng bảo vệ da cẩn thận sẽ l&agrave;m cho da bị sạm, nhăn, l&atilde;o h&oacute;a, thậm ch&iacute; c&oacute; nguy cơ g&acirc;y ung thư da.</p>

<p>✔️ Khi tiếp x&uacute;c với &aacute;nh nắng gay gắt, hoạt động thể thao ngo&agrave;i trời, bơi lội, du lịch, nếu kh&ocirc;ng bảo vệ da cẩn thận c&oacute; thể sẽ dẫn đến l&agrave;m cho da bị sạm, nhăn, l&atilde;o h&oacute;a, thậm ch&iacute; c&oacute; nguy cơ g&acirc;y ung thư da.</p>

<p>✔️ &Aacute;nh ngọc trai &amp; sắc t&iacute;m phớt c&oacute; trong sản phẩm ngay lập tức n&acirc;ng tone &amp; l&agrave;m da bắt s&aacute;ng &oacute;ng &aacute;nh, phản ch&iacute;u &aacute;nh s&aacute;ng đa chiều. Đ&oacute;ng vai tr&ograve; như kem l&oacute;t trang điểm (makeup base). Cực ph&ugrave; hợp với xu hướng makeup &ldquo;l&agrave;n da sương kh&oacute;i&rdquo; nhẹ nh&agrave;ng đi học, đi l&agrave;m.</p>

<p>✔️ Kết cấu nước, kh&ocirc;ng bết d&iacute;nh, nhẹ mặt tạo cảm gi&aacute;c thoa như kh&ocirc;ng, th&iacute;ch hợp với kh&iacute; hậu n&oacute;ng ẩm VN.</p>

<p>✔️ Chống nước &amp; mồ h&ocirc;i. L&agrave; kem chống nắng Vật L&yacute;.</p>

<p>✔️ Th&iacute;ch hợp cho mọi loại da.</p>

<p>&nbsp;</p>

<p>✖️ Chiết xuất từ:</p>

<p>➖ Vitamin C, Chanh D&acirc;y, Mận l&agrave;m s&aacute;ng &amp; chống oxy ho&aacute; dưới t&aacute;c hại của tia UVA &amp; UVB.</p>

<p>➖ Hồng Leo Anh Quốc gi&uacute;p c&acirc;n bằng pH, dưỡng mềm &amp; bảo vệ da, l&agrave;m s&aacute;ng da. Đặc biệt c&ograve;n l&agrave;m dịu, t&aacute;i tạo da khi bị ch&aacute;y nắng (tương tự Nha Đam).</p>

<p>➖ Hyaluronic Acid giữ nước cho da.</p>

<p>&nbsp;</p>

<p>✖️ C&aacute;ch d&ugrave;ng:</p>

<p>➡ Lắc đều lọ trước khi sử dụng.</p>

<p>➡ Thoa đều kem chống nắng l&ecirc;n da 15 ph&uacute;t trước khi tiếp x&uacute;c với &aacute;nh nắng mặt trời.</p>

<p>➡ Sau khi bơi lội hoặc ra mồ h&ocirc;i nhiều, lau kh&ocirc; rồi thoa đều lại kem l&ecirc;n da.</p>

<p>➡ Khi tham giA c&aacute;c hoạt động ngo&agrave;i trời, 4 tiếng sau bạn l&ecirc;n sử dụng lại sản phẩm</p>

<p>➡️ Sản phẩm d&ugrave;ng được cho cả mặt v&agrave; body</p>
', 1, 0, N'kem-chong-nang-skin-aqua-tone-up-uv-essence-nhat-ban-80ml', CAST(N'2021-08-19 11:18:48.807' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4177, N'Phấn nước Missha Velvet Finish Cushion SPF50+ PA+++ ( vỏ đỏ )', N'Missha', N'/Uploads/images/product/pro144.jpg', N'/Uploads/images/product/pro144.jpg', 0, N'Phấn nước Missha Velvet Finish Cushion SPF50+ PA+++ che phủ hoàn hảo, tone màu phấn tự nhiên giúp dễ dàng che phủ các khuyết điểm trên da như thâm mụn, lỗ chân lông to hay những vùng da xỉn màu, giúp mang lại lớp trang điểm rạng rỡ, mịn màng không tì vết. ', 2104, N'<p>🖤🖤Phấn nước Missha Velvet Finish Cushion SPF50+ PA+++ ( vỏ đỏ )🖤🖤</p>

<p>💲 Gi&aacute; lẻ: 170k</p>

<p>&nbsp;</p>

<p>➡️ Xuất xứ: H&agrave;n Quốc</p>

<p>➡️ Thương hiệu: MISSHA</p>

<p>➡️ M&agrave;u: #21, #23</p>

<p>➡️ Trọng lượng: 15 gram</p>

<p>&nbsp;</p>

<p>✖️ SẴN 2 TONE:</p>

<p>#21 Neutral Light Beige: M&agrave;u da d&agrave;nh cho những c&oacute; n&agrave;ng c&oacute; l&agrave;n da c&oacute; tone da s&aacute;ng hoặc hơi xanh.</p>

<p>#23 Neutral Medium Beige: D&agrave;nh cho những n&agrave;ng c&oacute; tone da ấm hơn một ch&uacute;t, cung cấp một lớp nền tự nhi&ecirc;n như &yacute;!</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>✔️ Phấn nước Missha Velvet Finish Cushion gi&uacute;p che phủ khuyết điểm ho&agrave;n hảo, che phủ mọi khuyết điểm tr&ecirc;n da gi&uacute;p chị em c&oacute; l&agrave;n da trắng s&aacute;ng mịn m&agrave;ng.</p>

<p>✔️ Chỉ số chống nắng SPF50+ PA+++ gi&uacute;p bảo vệ l&agrave;n da dưới t&aacute;c hại của ảnh nắng mặt trời.</p>

<p>✔️ Phấn nước Missha đỏ c&oacute; kết cấu mỏng mịn tự nhi&ecirc;n, khả năng giữ tone m&agrave;u tốt th&aacute;ch thức thời gian, mồ h&ocirc;i trong qu&aacute; tr&igrave;nh hoạt động.kh&ocirc;ng g&acirc;y bết d&iacute;nh kh&oacute; chịu.</p>

<p>✔️ Kh&ocirc;ng tạo độ b&oacute;ng dầu sau khi sử dụng, mang lại sự thoải m&aacute;i khi sử dụng m&agrave; kh&ocirc;ng lo bị hằn dấu của sản phẩm</p>

<p>✔️ Gi&uacute;p cung cấp độ ẩm cho da, c&ugrave;ng với th&agrave;nh phần c&oacute; t&aacute;c dụng dưỡng trắng, gi&uacute;p da mịn m&agrave;ng sau mỗi lần sử dụng.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>➖ D&ugrave;ng b&ocirc;ng phấn c&oacute; sẵn để lấy phấn, sau đ&oacute; thoa nhẹ nh&agrave;ng l&ecirc;n khắp bề mặt da v&agrave; lan dần xuống ph&iacute;a dưới cổ.</p>

<p>➖ Với những v&ugrave;ng da nhiều khuyết điểm c&oacute; thể giặm th&ecirc;m một ch&uacute;t phấn để độ che phủ tốt hơn.</p>

<p>&nbsp;</p>

<p>✖️ Lưu &yacute;: Khi lấy phấn bạn chỉ n&ecirc;n lấy lượng vừa phải &ldquo;t&aacute;p&rdquo; từng lớp, từng lớp th&ocirc;i nh&eacute;. Sẽ cho bạn một lớp nền mỏng, tự nhi&ecirc;n v&agrave; đều m&agrave;u nhất. Để bảo vệ lớp nền l&acirc;u tr&ocirc;i trong nhiều giờ đồng hồ, chị em n&ecirc;n tăng cường sử dụng th&ecirc;m phấn phủ.</p>
', 1, 0, N'phan-nuoc-missha-velvet-finish-cushion-spf50-pa-vo-do', CAST(N'2021-08-19 11:21:44.643' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4178, N'Kem Tẩy Lông Veet Pháp - 100ml', N'Khác', N'/Uploads/images/product/pro145.jpg', N'/Uploads/images/product/pro145.jpg,/Uploads/images/product/pro151.jpg', 0, N' Kem Tẩy Lông Veet Pháp 100ml chứa chiết xuất D– Panthenol hỗ trợ tẩy lông các vùng như: tay, chân, nách... đồng thời dưỡng ẩm và làm mịn da trong và sau khi tẩy lông. ', 2099, N'<p>- Xuất xứ: Ph&aacute;p</p>

<p>- Dung T&iacute;ch: 100ml</p>

<p>&nbsp;</p>

<p>- Ph&acirc;n loại:</p>

<p>+ Xanh dương: Da nhạy cảm</p>

<p>+ Hồng: Da thường</p>

<p>&nbsp;</p>

<p>➡️ Tẩy sạch l&ocirc;ng cứng, l&agrave;m nhạt m&agrave;u l&ocirc;ng, giữ da mềm mại, tẩy tận gốc lu&ocirc;n ạ. D&ugrave;ng được cả tay, ch&acirc;n, bikini.</p>

<p>➡️ Kh&ocirc;ng g&acirc;y đau đớn cho da như s&aacute;p n&oacute;ng hay m&aacute;y cạo l&ocirc;ng, kh&ocirc;ng đỏ, xước da.</p>

<p>➡️ Em n&agrave;y phải n&oacute;i cực phổ biến, hầu như chị em n&agrave;o cũng c&oacute; sử dụng qua. Ưu điểm l&agrave; si&ecirc;u dễ sử dụng, tiện m&igrave;nh c&oacute; thể tẩy ngay l&uacute;c tắm, tấy nhanh.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>❀ D&ugrave;ng th&igrave;a gạt, thoa kem đều với lượng vừa đủ để che l&ocirc;ng. Sau 5 ph&uacute;t, lấy th&igrave;a gạt để kiểm tra tr&ecirc;n một khu vực nhỏ của da đ&atilde; được phủ kem.</p>

<p>❀ Nếu l&ocirc;ng đi dễ d&agrave;ng th&igrave; tiến h&agrave;nh loại bỏ phần con lại của kem, nếu kh&ocirc;ng để th&ecirc;m tầm 2-3ph nữa. Rửa thật sạch da với nước, lau kh&ocirc;.</p>

<p>❀ Tẩy l&ocirc;ng xong th&igrave; đợi 24h mới b&ocirc;i kem dưỡng nh&eacute;. Sau 3 ng&agrave;y th&igrave; tẩy th&ecirc;m đc lần nữa r&ugrave;i nhưng thường khoảng 1 - 3 tuần mới tẩy lại nh&eacute; c&aacute;c c&ocirc; g&aacute;i</p>

<p>✖️ Lưu &yacute;:</p>

<p>✦ KH&Ocirc;NG sử dụng tr&ecirc;n mặt, ngực, đầu, nốt ruồi, chỗ da bị bỏng, sẹo, da bị k&iacute;ch th&iacute;ch hoặc ch&aacute;y nắng...</p>

<p>✦ Tr&aacute;nh tiếp x&uacute;c với mắt. Nếu kh&ocirc;ng may bị tiếp x&uacute;c th&igrave; nhanh ch&oacute;ng rửa mắt với nhiều nước trắng s&aacute;ch v&agrave; t&igrave;m đến sự tư vấn của y tế.</p>

<p>✖️ Bảo quản:</p>

<p>- Trong ph&ograve;ng, tủ k&iacute;n.</p>

<p>- Tr&aacute;nh &aacute;nh nắng mặt trời, tr&aacute;nh nơi ẩm ướt, nh&agrave; tắm.</p>
', 1, 0, N'kem-tay-long-veet-phap---100ml', CAST(N'2021-08-19 11:28:00.717' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4179, N'TẨY DA CHẾT ARRAHAN 180ML', N'Khác', N'/Uploads/images/product/pro146.jpg', N'/Uploads/images/product/pro146.jpg', 0, N'Gel Tẩy Tế Bào Chết Arrahan Peeling Gel 180ml là dòng tẩy tế bào chết đến từ thương hiệu mỹ phẩm Arrahan của Hàn Quốc, chứa các thành phần thiên nhiên giúp loại bỏ các bụi bẩn, chất độc hại, lớp tế bào chết, lớp sừng dưới da, nhất là nằm sâu trong lỗ chân lông. Từ đó sẽ thúc đẩy quá trình tái tạo da diễn ra nhanh chóng thông thoáng, dễ dàng hấp thu các dưỡng chất trong các bước tiếp theo và phát huy tối đa công dụng.', 2099, N'<p>🖤🖤TẨY DA CHẾT ARRAHAN🖤🖤</p>

<p>💲 GI&Aacute; LẺ: 80K</p>

<p>&nbsp;</p>

<p>✖️ XUẤT XỨ: H&agrave;n Quốc</p>

<p>✖️ THƯƠNG HIỆU: Arrahan</p>

<p>✖️ DUNG T&Iacute;CH: 180ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>➤ Sản phẩm thi&ecirc;n nhi&ecirc;n gi&uacute;p l&agrave;m sạch da nhẹ nh&agrave;ng, tẩy sạch da chết, tế b&agrave;o gi&agrave; nua gi&uacute;p da s&aacute;ng m&agrave;u.</p>

<p>➤ Gi&uacute;p th&ocirc;ng tho&aacute;ng lỗ ch&acirc;n l&ocirc;ng, cho dưỡng chất được thẩm thấu v&agrave;o da tốt nhất.</p>

<p>➤Hương thơm thảo dược nhẹ nh&agrave;ng, thư gi&atilde;n.</p>

<p>➤ Th&agrave;nh phần an to&agrave;n tự nhi&ecirc;n, kh&ocirc;ng g&acirc;y k&iacute;ch ứng cho da.</p>

<p>➤ D&ugrave;ng được cho da mặt v&agrave; to&agrave;n th&acirc;n.</p>

<p>&nbsp;</p>

<p>✖️ HƯỚNG DẪN SỬ DỤNG:</p>

<p>➜Bước 1: L&agrave;m ướt da.</p>

<p>➜ Bước 2: Lấy một lượng kem arrahan vừa đủ thoa đều l&ecirc;n v&ugrave;ng da cần tẩy da chết. M&aacute;t xa nhẹ nh&agrave;ng theo chuyển động tr&ograve;n từ dưới l&ecirc;n khoảng 4 -5 ph&uacute;t.</p>

<p>➜ Bước 3: Rửa sạch lại với nước.</p>

<p>&nbsp;</p>

<p>✖️ LƯU &Yacute; KHI SỬ DỤNG:</p>

<p>+ Chỉ n&ecirc;n tẩy da chết 1-2 lần/ tuần.</p>

<p>+ Sau khi tẩy da chết bạn n&ecirc;n d&ugrave;ng nước hoa hồng c&acirc;n bằng da, nếu ra ngo&agrave;i trời nắng th&igrave; n&ecirc;n d&ugrave;ng kem chống nắng để bảo vệ da khỏi t&aacute;c hại từ mặt trời nh&eacute;.</p>
', 1, 0, N'tay-da-chet-arrahan-180ml', CAST(N'2021-08-19 11:31:21.933' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4180, N'TẨY TẾ BÀO CHẾT BODY COFFEE ORGANIC SHOP', N'Khác', N'/Uploads/images/product/pro147.jpg', N'/Uploads/images/product/pro147.jpg', 110000, N'Tẩy da chết thực sự là một trong những bước chăm sóc da vô cùng quan trọng mà nhiều bạn đã bỏ quên.Chỉ với 1-2 lần tẩy da chết/ tuần, làn da của các bạn sẽ được làm sạch, bỏ đi lớp bụi bẩn và tết bào chết còn sót lại trên da khi tắm bằng sữa tắm thường không thể loại bỏ được, vì vậy cũng chống bít tắc lỗ chân lông gây ra các bệnh như viêm lỗ chân lông,...', 2099, N'<p>✖️ Xuất xứ: Nga</p>

<p>✖️ H&atilde;ng sx: Organic Shop</p>

<p>✖️ Dung t&iacute;ch:250ml</p>

<p>&nbsp;</p>

<p>✖️ C&Ocirc;NG DỤNG: Lấy đi c&aacute;c tế b&agrave;o chết đồng thời cung cấp dưỡng chất gi&uacute;p dưỡng ẩm da, t&aacute;i tạo da, gi&uacute;p bạn c&oacute; l&agrave;n da mềm mịn &amp;trắng s&aacute;ng, khỏe mạnh.</p>

<p>✖️ C&Aacute;CH SỬ DỤNG:</p>

<p>➖ Lấy một lượng kem tẩy vừa đủ d&ugrave;ng l&ecirc;n tay v&agrave; matxa l&ecirc;n cơ thể để tẩy đi c&aacute;c tế b&agrave;o chết tr&ecirc;n da của bạn.</p>

<p>➖ Sau đ&oacute; tắm lại với nước ấm hoặc sữa tắm nếu muốn.</p>

<p>➖ Tuần sử dụng 2 lần.</p>
', 1, 0, N'tay-te-bao-chet-body-coffee-organic-shop', CAST(N'2021-08-19 11:33:37.827' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4181, N'Mặt Nạ Innisfree Super Volcanic Pore Clay Mask 2x (100 ml)', N'Innisfree', N'/Uploads/images/product/pro148.jpg', N'/Uploads/images/product/pro148.jpg', 205000, N'Mặt Nạ Tro Núi Lửa Trị Mụn Đầu Đen, Chăm Sóc Lỗ Chân Lông Innisfree Super Volcanic Pore Clay Mask 2X là mặt nạ đất sét thuộc thương hiệu Innisfree, là sản phẩm nâng cấp mới nhất 2018 – được cải tiến vượt bật hơn với phiên bản cũ Innisfree Super Volcanic Pore Clay Mask. Giúp loại bỏ bã nhờn, làm sạch sâu, tiêu diệt sạch mụn cám và mụn đầu đen.', 2112, N'<p>✖️ C&Ocirc;NG DỤNG:</p>

<p>1. Giải ph&aacute;p to&agrave;n diện cho c&aacute;c vấn đề về lỗ ch&acirc;n l&ocirc;ng: Đ&acirc;y l&agrave; giải ph&aacute;p to&agrave;n diện cho c&aacute;c vấn đề như &quot;se kh&iacute;t lỗ ch&acirc;n l&ocirc;ng</p>

<p>+ kiểm so&aacute;t b&atilde; nhờn</p>

<p>+ loại bỏ tế b&agrave;o chết</p>

<p>+ loại bỏ c&aacute;c hạt bụi si&ecirc;u mịn</p>

<p>+ loại bỏ mụn đầu đen</p>

<p>+ l&agrave;m sạch s&acirc;u</p>

<p>+ l&agrave;m dịu da</p>

<p>+ cải thiện kết cấu của da</p>

<p>+ l&agrave;m s&aacute;ng da</p>

<p>+ l&agrave;m săn chắc da.&quot;</p>

<p>&nbsp;</p>

<p>2. Hiệu quả loại bỏ tế b&agrave;o chết cao gấp ba lần với tro n&uacute;i lửa</p>

<p>+ bột vỏ quả &oacute;c ch&oacute;</p>

<p>+ c&aacute;c th&agrave;nh phần AHA: Sản phẩm loại bỏ ho&agrave;n to&agrave;n tế b&agrave;o chết, mang lại l&agrave;n da mềm mại mịn m&agrave;ng, đồng thời khả năng l&agrave;m sạch s&acirc;u hiệu quả hơn gi&uacute;p nhanh ch&oacute;ng loại bỏ c&aacute;c hạt bụi si&ecirc;u mịn ra khỏi lỗ ch&acirc;n l&ocirc;ng v&agrave; chăm s&oacute;c v&ugrave;ng da bị mụn của bạn.</p>

<p>&nbsp;</p>

<p>3. Dễ sử dụng, l&agrave;m sạch lỗ ch&acirc;n l&ocirc;ng v&agrave; đem lại cảm gi&aacute;c m&aacute;t lạnh: C&ocirc;ng thức dạng kem gi&uacute;p bạn dễ d&agrave;ng sử dụng sản phẩm v&agrave; gi&uacute;p l&agrave;m sạch lỗ ch&acirc;n l&ocirc;ng m&agrave; vẫn cho bạn cảm gi&aacute;c m&aacute;t lạnh.</p>

<p>&nbsp;</p>

<p>✖️ HDSD:</p>

<p>1. Sau khi rửa mặt, thoa mặt nạ l&ecirc;n khắp mặt, tr&aacute;nh v&ugrave;ng mắt v&agrave; m&ocirc;i.</p>

<p>2. Tận hưởng cảm gi&aacute;c lỗ ch&acirc;n l&ocirc;ng m&aacute;t mẻ v&agrave; dần thu nhỏ lại trong v&ograve;ng 10 ph&uacute;t sau khi thoa sản phẩm.</p>

<p>3. Sau 10 ph&uacute;t, d&ugrave;ng tay m&aacute;t xa v&agrave; rửa nhẹ nh&agrave;ng bằng nước sạch để loại bỏ b&atilde; nhờn v&agrave; tế b&agrave;o chết c&ograve;n s&oacute;t lại tr&ecirc;n da (sử dụng 1~2 lần/tuần).</p>
', 1, 0, N'mat-na-innisfree-super-volcanic-pore-clay-mask-2x-100-ml', CAST(N'2021-08-19 11:35:34.690' AS DateTime))
INSERT [dbo].[product] ([id], [name], [brand], [image], [image_list], [price], [description], [category_id], [content], [status], [viewCount], [slug], [CreatedDate]) VALUES (4182, N'Kem Chống Nắng Omi Sun Bears Nhật Bản (Xanh, Đỏ)', N'Khác', N'/Uploads/images/product/pro150.jpg', N'/Uploads/images/product/pro150.jpg', 0, N'Kem Chống Nắng Omi Sun Bears là dòng kem chống nắng vật lý lai hóa học hiếm hoi của Nhật, đặc biệt không chứa cồn (alcohol free). Omi Sun Bears sở hữu chất kem vô cùng lỏng dễ tán, tạo ra cảm giác thông thoáng tuyệt đối như không hề có bất kì dấu vết nào trên da.', 2101, N'<p>✔️ kem chống nắng vật l&yacute; lai h&oacute;a học rất hiếm hoi của Nhật ,đặc biệt kh&ocirc;ng chứa cồn, Omi Sun Bears sở hữu chất kem v&ocirc; c&ugrave;ng lỏng dễ t&aacute;n, tạo cảm gi&aacute;c th&ocirc;ng tho&aacute;ng tuyệt đối như kh&ocirc;ng hề c&oacute; dấu vết n&agrave;o tr&ecirc;n da.</p>

<p>✔️ Omi Sun Bears kh&ocirc;ng b&oacute;ng nhờn, kh&ocirc;ng b&iacute; b&aacute;ch, rất kh&oacute; g&acirc;y mụn, n&acirc;ng tone rất nhẹ cho da nh&igrave;n v&ocirc; c&ugrave;ng &ldquo;thật&rdquo;. Hợp cho những bạn c&oacute; nhu cầu b&ocirc;i kem chống nắng kh&ocirc;ng &ldquo;lộ&rdquo;, v&iacute; như những ch&agrave;ng trai muốn tập t&agrave;nh bảo vệ da trước nắng. Omi cũng rất t&acirc;m l&iacute; khi trang bị một loại kem chống nắng b&igrave;nh d&acirc;n nhưng vẫn chống nước hiệu quả đ&aacute;p ứng đầy đủ chức năng của một kem chống nắng tốt SPF cao lại dễ mua dễ sử dụng tr&ecirc;n thị trường.</p>

<p>✔️ Cả 2 bản Omi xanh, đỏ đều d&ugrave;ng được cho da thường đến da dầu.</p>

<p>✔️ Bản m&agrave;u xanh c&oacute; th&ecirc;m Menthol (bạc h&agrave;) tạo hiệu ứng giảm nhiệt, m&aacute;t lạnh khi b&ocirc;i l&ecirc;n da v&agrave; kh&ocirc; r&aacute;o nhanh hơn bản m&agrave;u đỏ, hợp da dầu nhiều.</p>
', 1, 0, N'kem-chong-nang-omi-sun-bears-nhat-ban-xanh-do', CAST(N'2021-08-19 11:37:53.013' AS DateTime))
SET IDENTITY_INSERT [dbo].[product] OFF
SET IDENTITY_INSERT [dbo].[product_attribute_values] ON 

INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4158, N'14', 4101, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4159, N'15', 4101, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4160, N'16', 4101, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4161, N'17', 4101, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4190, N'Đỏ', 4116, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4191, N'Đen', 4116, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4196, N'Green Tea', 4118, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4197, N'Jeju Volcanic', 4118, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4198, N'Cherry Blossom', 4118, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4199, N'Bija Trouble', 4118, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4202, N'Null Set', 4120, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4203, N'Tawny Red', 4120, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4204, N'V19', 4121, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4205, N'V20', 4121, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4206, N'V21', 4121, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4207, N'V22', 4121, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4208, N'12', 4122, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4209, N'13', 4122, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4210, N'14', 4122, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4211, N'15', 4122, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4212, N'16', 4122, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4213, N'17', 4122, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4214, N'Trắng sọc xanh lá', 4123, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4215, N'Trắng không sọc', 4123, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4216, N'Xanh sọc đỏ', 4123, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4217, N'Xanh không sọc', 4123, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4218, N'Xanh', 4124, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4219, N'Vàng', 4124, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4220, N'Đỏ', 4124, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4223, N'150ml', 4126, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4224, N'300ml', 4126, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4225, N'Hồng', 4127, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4226, N'Xanh', 4127, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4227, N'Đen', 4128, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4228, N'Nâu', 4128, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4229, N'18', 4129, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4230, N'19', 4129, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4231, N'20', 4129, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4232, N'21', 4129, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4233, N'A18', 4130, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4234, N'A19', 4130, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4235, N'A20', 4130, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4236, N'A21', 4130, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4237, N'A22', 4130, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4238, N'01', 4131, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4239, N'02', 4131, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4240, N'03', 4131, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4241, N'04', 4131, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4242, N'05', 4131, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4243, N'06', 4131, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4244, N'#01 Juicy Oh', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4245, N'#02 Ruby Red', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4246, N'#03 Summer scent', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4247, N'#04 Dragon Pink', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4248, N'#05 Peach Me', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4249, N'#06 Fig Fig', 4132, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4250, N'#07 Jujube', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4251, N'#08 Apple Brown', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4252, N'#09 Litchi Coral', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4253, N'#10 NUDY PEANUT', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4254, N'#11 PINK PUMPKIN', 4132, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4255, N'#12 CHERRY BOMB', 4132, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4256, N'#13 EAT DOTORI', 4132, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4260, N'Gỗ', 4134, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4261, N'Cánh hoa', 4134, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4262, N'Đào', 4134, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4263, N'Volumecara ', 4135, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4264, N'LonglashCara', 4135, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4265, N'Microcara Zero', 4135, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4266, N'CM01', 4136, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4267, N'CM02', 4136, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4268, N'CM03', 4136, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4269, N'CM04', 4136, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4270, N'CM05', 4136, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4271, N'CM06', 4136, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4272, N'CM07', 4136, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4273, N'Hồng Nhạt', 4137, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4274, N'OR101', 4137, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4275, N'PK001', 4137, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4286, N'Tropical', 4140, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4287, N'Blush', 4140, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4288, N'Fresh', 4140, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4289, N'Original', 4140, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4290, N'Cherry', 4140, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4291, N'L1', 4141, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4292, N'L4', 4141, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4293, N'L5', 4141, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4294, N'L6', 4141, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4295, N'L9', 4141, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4296, N'L10', 4141, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4297, N'01', 4142, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4298, N'02', 4142, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4299, N'03', 4142, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4300, N'04', 4142, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4309, N'Milk 60ml', 4147, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4310, N'Gel 90ml', 4147, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4311, N'A13', 4148, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4312, N'A14', 4148, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4313, N'A15', 4148, 1)
GO
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4314, N'A16', 4148, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4315, N'A17', 4148, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4316, N'Xanh', 4149, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4317, N'Hồng', 4149, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4318, N'Tím', 4149, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4319, N'01', 4150, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4320, N'02', 4150, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4321, N'Xanh', 4151, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4322, N'Hồng', 4151, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4323, N'110', 4152, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4324, N'112', 4152, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4325, N'115', 4152, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4326, N'120', 4152, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4327, N'Đen 21', 4153, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4328, N'Đen23', 4153, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4329, N'Trắng', 4153, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4330, N'A23', 4154, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4331, N'A24', 4154, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4332, N'A25', 4154, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4333, N'A26', 4154, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4334, N'A27', 4154, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4335, N'21', 4155, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4336, N'23', 4155, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4337, N'10ml', 4156, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4338, N'2.5ml - Hiệu quả cao', 4156, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4349, N'Ngọc trai', 4159, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4350, N'Chanh', 4159, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4351, N'Bơ', 4159, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4352, N'Than hoạt tính', 4159, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4353, N'Than đá', 4159, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4356, N'Light', 4161, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4357, N'Moisture', 4161, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4358, N'A33', 4162, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4359, N'A34', 4162, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4360, N'A35', 4162, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4361, N'A36', 4162, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4362, N'A37', 4162, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4363, N'Xanh vòi', 4163, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4364, N'Xanh tuýp', 4163, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4365, N'Trắng vòi', 4163, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4366, N'Trắng tuýp', 4163, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4367, N'Soft Finish', 4164, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4368, N'Waterproof', 4164, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4369, N'HV01', 4165, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4370, N'HV02', 4165, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4371, N'HV03', 4165, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4372, N'HV04', 4165, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4373, N'HV05', 4165, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4374, N'Dài mi', 4166, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4375, N'Dày mi', 4166, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4376, N'21', 4167, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4377, N'23', 4167, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4380, N'21', 4169, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4381, N'22', 4169, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4382, N'23', 4169, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4383, N'Xanh 21', 4170, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4384, N'Xanh 23', 4170, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4385, N'Xám 21', 4170, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4386, N'Xám 23', 4170, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4387, N'Chai - 35ml', 4171, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4388, N'Tuýp - 20ml ', 4171, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4389, N'Trắng 10', 4172, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4390, N'Trắng 20', 4172, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4391, N'Xanh 10', 4172, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4392, N'Xanh 20', 4172, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4393, N'Tẩy da chết', 4173, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4394, N'Sữa tắm', 4173, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4395, N'Dưỡng thể', 4173, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4396, N'125ml', 4174, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4397, N'237ml', 4174, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4398, N'500ml', 4174, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4399, N'10ml', 4175, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4400, N'30ml', 4175, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4401, N'Vitamin C', 4176, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4402, N'Hyaluronic', 4176, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4403, N'Dragon’s Blood', 4176, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4404, N'Gold Collagen', 4176, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4405, N'V13', 4177, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4406, N'V14', 4177, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4407, N'V15', 4177, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4408, N'V16', 4177, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4409, N'V17', 4177, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4410, N'V18', 4177, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4411, N'Xanh', 4178, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4412, N'Hồng', 4178, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4413, N'Xanh - giảm thâm', 4179, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4414, N'Đen - chống lão hóa', 4179, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4415, N'Tơ mi', 4180, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4416, N'Dày mi', 4180, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4417, N'Cong mi', 4180, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4418, N'Green Tea', 4181, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4419, N'Bija', 4181, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4420, N'Jeju', 4181, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4421, N'Jeju 2x', 4181, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4422, N'A01', 4182, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4423, N'A02', 4182, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4424, N'A03', 4182, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4425, N'A04', 4182, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4426, N'A05', 4182, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4427, N'A06', 4182, 1)
GO
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4428, N'A07', 4182, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4429, N'Green Tea', 4183, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4430, N'Jeju Cherry Blossom', 4183, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4431, N'Vỏ trắng', 4184, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4432, N'Vỏ đen', 4184, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4433, N'V1', 4185, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4434, N'V3', 4185, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4435, N'V6', 4185, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4436, N'V8', 4185, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4437, N'V9', 4185, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4438, N'V11', 4185, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4439, N'Hồng', 4186, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4440, N'Trắng', 4186, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4441, N'Gội xả', 4187, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4442, N'Ủ tóc', 4187, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4443, N'A28', 4188, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4444, N'A29', 4188, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4445, N'A30', 4188, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4446, N'A31', 4188, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4447, N'A32', 4188, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4448, N'Tone 10', 4189, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4449, N'Tone 20', 4189, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4450, N'Tone 30', 4189, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4451, N'Water-gel 15g', 4190, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4452, N'Aqua-gel 50ml', 4190, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4453, N'Gel-cream 50ml', 4190, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4454, N'100ml', 4191, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4455, N'500ml', 4191, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4456, N'120g', 4192, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4457, N'30g', 4192, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4458, N'Cherry Jellycream', 4193, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4459, N'Cherry Tone-Up Cream', 4193, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4460, N'Green Tea', 4193, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4461, N'Jeju Orchid', 4193, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4464, N'01', 4195, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4465, N'02', 4195, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4466, N'03', 4195, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4467, N'04', 4195, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4468, N'05', 4195, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4469, N'06', 4195, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4470, N'07', 4195, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4471, N'200ml', 4196, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4472, N'320ml', 4196, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4473, N'Beige Avenue', 4197, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4474, N'Needful', 4197, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4475, N'Active Lady', 4197, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4476, N'Macaron Red', 4197, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4477, N'Live A Little', 4197, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4478, N'Fairy Cake', 4197, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4479, N'Immanence', 4197, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4480, N'Cutesicle', 4197, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4481, N'Blossom Day', 4197, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4482, N'Pinkalicious', 4197, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4483, N'Carrot Pink', 4197, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4484, N'Peach Tease', 4197, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4485, N'Kiehl’s Đất Sét', 4198, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4486, N'Kiehl’s Hoa Cúc', 4198, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4487, N'Kiehl’s Thải Độc', 4198, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4488, N'Kiehl’s Nghệ', 4198, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4489, N'Kiehl’s Bơ', 4198, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4490, N'Xanh lá', 4199, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4491, N'Bạc hà', 4199, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4492, N'Cream', 4200, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4493, N'Soothing Cream', 4200, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4494, N'Xanh', 4201, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4495, N'Trắng', 4201, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4496, N'Hồng', 4201, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4497, N' Long Lasting', 4202, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4498, N'Triple-shield', 4202, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4499, N'No Sebum Tone Up ', 4202, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4500, N'21', 4203, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4501, N'23', 4203, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4502, N'Xanh dương', 4204, 0)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4503, N'Hồng', 4204, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4504, N'Xanh dương bản nội địa', 4204, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4505, N'Táo', 4205, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4506, N'Chanh', 4205, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4507, N'Đông y', 4205, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4508, N'Than', 4205, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4509, N'Aroma', 4205, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4510, N'Xanh', 4206, 1)
INSERT [dbo].[product_attribute_values] ([value_id], [name], [attribute_id], [status]) VALUES (4511, N'Đỏ', 4206, 1)
SET IDENTITY_INSERT [dbo].[product_attribute_values] OFF
SET IDENTITY_INSERT [dbo].[product_attributes] ON 

INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4101, N'Romand', 4036)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4116, N'Vacosi', 4037)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4118, N'Innisfree', 4038)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4120, N'3CE', 4033)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4121, N'Merzy', 4039)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4122, N'Romand', 4041)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4123, N'NHH', 4042)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4124, N'Kem AHC', 4043)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4126, N'XK Vichy', 4050)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4127, N'Bộ Cọ 8 cây', 4051)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4128, N'Gel Tonymoly', 4046)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4129, N'Romand', 4054)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4130, N'Black Rouge', 4055)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4131, N'Son Phytotree', 4056)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4132, N'Son Tint', 4058)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4134, N'Xịt thơm', 4062)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4135, N'MASCARA', 4064)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4136, N'Black Rouge', 4068)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4137, N'YNM', 4069)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4140, N'Gội khô', 4070)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4141, N'Merzy thỏi', 4073)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4142, N'Romand', 4074)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4147, N'Loại', 4075)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4148, N'BLACKROUGE', 4077)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4149, N'SERUM AHC', 4078)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4150, N'Merzy', 4079)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4151, N'FIX', 4080)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4152, N'Fit Me', 4084)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4153, N'PHẤN NÉN', 4087)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4154, N'Black Rouge', 4090)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4155, N'MISSHA', 4091)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4156, N'Loại', 4093)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4159, N'Mặt Nạ Freeman', 4094)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4161, N'TONER MUJI', 4096)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4162, N'Màu', 4098)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4163, N'SRM HADALABO', 4099)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4164, N'Kcn Missha', 4101)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4165, N'Black Rouge', 4105)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4166, N'Kiss Me', 4107)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4167, N'Cellio', 4108)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4169, N'APRIL SKIN', 4115)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4170, N'Klavuu', 4116)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4171, N'Red Peel', 4117)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4172, N'CUSHION LIME', 4121)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4173, N'White Conc', 4123)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4174, N'Srm Cetaphil', 4128)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4175, N'Goodal', 4130)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4176, N'Serum Balance', 4131)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4177, N'Merzy', 4132)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4178, N'XỊT JM', 4133)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4179, N'Mặt Nạ Mắt JM', 4109)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4180, N'Maybeline', 4134)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4181, N'Loại', 4135)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4182, N'SON BLACKROUGE', 4136)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4183, N'Innisfree', 4138)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4184, N'Karadium', 4141)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4185, N'Merzy', 4144)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4186, N'Catrice', 4146)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4187, N'Tigi', 4147)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4188, N'Black Rouge', 4148)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4189, N'Catrice', 4149)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4190, N'Kem Neutrogena', 4150)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4191, N'TT BYPHASSE', 4154)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4192, N'Tdc Huxley', 4159)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4193, N'Loại', 4160)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4195, N'Chì mày', 4165)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4196, N'Dung tích', 4166)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4197, N'3CE', 4167)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4198, N'Mặt Nạ Kiehl’s', 4168)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4199, N'Cerave', 4171)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4200, N'Skin1004', 4161)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4201, N'Mặt Nạ', 4174)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4202, N'KCN INNISFREE', 4175)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4203, N'Missha', 4177)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4204, N'Tẩy Lông Veet', 4178)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4205, N'Tdc Arrahan', 4179)
INSERT [dbo].[product_attributes] ([attribute_id], [name], [product_id]) VALUES (4206, N'KCN Omi', 4182)
SET IDENTITY_INSERT [dbo].[product_attributes] OFF
SET IDENTITY_INSERT [dbo].[skus] ON 

INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4137, 160000, 4036, N'STR-JL-14', N'{"Romand":"14"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4138, 160000, 4036, N'STR-JL-15', N'{"Romand":"15"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4139, 160000, 4036, N'STR-JL-16', N'{"Romand":"16"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4140, 160000, 4036, N'STR-JL-17', N'{"Romand":"17"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4169, 200000, 4037, N'CV-8-R', N'{"Vacosi":"Đỏ"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4170, 200000, 4037, N'CV-8-B', N'{"Vacosi":"Đen"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4175, 245000, 4038, N'HHI-GT', N'{"Innisfree":"Green Tea"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4176, 270000, 4038, N'HHI-JV', N'{"Innisfree":"Jeju Volcanic"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4177, 245000, 4038, N'HHI-CB', N'{"Innisfree":"Cherry Blossom"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4178, 245000, 4038, N'HHI-BT', N'{"Innisfree":"Bija Trouble"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4181, 220000, 4033, N'SK3CE-LL-NS', N'{"3CE":"Null Set"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4182, 220000, 4033, N'SK3CE-LL-TR', N'{"3CE":"Tawny Red"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4183, 190000, 4039, N'SKL-M-V19', N'{"Merzy":"V19"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4184, 190000, 4039, N'SKL-M-V20', N'{"Merzy":"V20"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4185, 190000, 4039, N'SKL-M-V21', N'{"Merzy":"V21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4186, 190000, 4039, N'SKL-M-V22', N'{"Merzy":"V22"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4187, 160000, 4041, N'SKL-RM-12', N'{"Romand":"12"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4188, 160000, 4041, N'SKL-RM-13', N'{"Romand":"13"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4189, 160000, 4041, N'SKL-RM-14', N'{"Romand":"14"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4190, 160000, 4041, N'SKL-RM-15', N'{"Romand":"15"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4191, 160000, 4041, N'SKL-RM-16', N'{"Romand":"16"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4192, 160000, 4041, N'SKL-RM-17', N'{"Romand":"17"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4193, 210000, 4042, N'NHH-HL170-WG', N'{"NHH":"Trắng sọc xanh lá"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4194, 210000, 4042, N'NHH-HL170-WN', N'{"NHH":"Trắng không sọc"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4195, 210000, 4042, N'NHH-HL170-GD', N'{"NHH":"Xanh sọc đỏ"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4196, 210000, 4042, N'NHH-HL170-GN', N'{"NHH":"Xanh không sọc"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4197, 205000, 4043, N'KD-AHC-50-G', N'{"Kem AHC":"Xanh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4198, 205000, 4043, N'KD-AHC-50-Y', N'{"Kem AHC":"Vàng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4199, 205000, 4043, N'KD-AHC-50-R', N'{"Kem AHC":"Đỏ"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4202, 175000, 4050, N'XK-V150', N'{"XK Vichy":"150ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4203, 250000, 4050, N'XK-V300', N'{"XK Vichy":"300ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4204, 60000, 4051, N'BC-O-P', N'{"Bộ Cọ 8 cây":"Hồng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4205, 60000, 4051, N'BC-O-B', N'{"Bộ Cọ 8 cây":"Xanh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4206, 105000, 4046, N'KM-TM-BL', N'{"Gel Tonymoly":"Đen"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4207, 105000, 4046, N'KM-TM-BR', N'{"Gel Tonymoly":"Nâu"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4208, 160000, 4054, N'STR-JL-18', N'{"Romand":"18"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4209, 160000, 4054, N'STR-JL-19', N'{"Romand":"19"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4210, 160000, 4054, N'STR-JL-20', N'{"Romand":"20"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4211, 160000, 4054, N'STR-JL-21', N'{"Romand":"21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4212, 135000, 4055, N'SK-BR-A18', N'{"Black Rouge":"A18"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4213, 135000, 4055, N'SK-BR-A19', N'{"Black Rouge":"A19"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4214, 135000, 4055, N'SK-BR-A20', N'{"Black Rouge":"A20"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4215, 135000, 4055, N'SK-BR-A21', N'{"Black Rouge":"A21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4216, 135000, 4055, N'SK-BR-A22', N'{"Black Rouge":"A22"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4217, 130000, 4056, N'SKL-P-01', N'{"Son Phytotree":"01"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4218, 130000, 4056, N'SKL-P-02', N'{"Son Phytotree":"02"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4219, 130000, 4056, N'SKL-P-03', N'{"Son Phytotree":"03"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4220, 130000, 4056, N'SKL-P-04', N'{"Son Phytotree":"04"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4221, 130000, 4056, N'SKL-P-05', N'{"Son Phytotree":"05"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4222, 130000, 4056, N'SKL-P-06', N'{"Son Phytotree":"06"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4223, 160000, 4058, N'STL-RJl-01', N'{"Son Tint":"#01 Juicy Oh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4224, 160000, 4058, N'STL-RJl-02', N'{"Son Tint":"#02 Ruby Red"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4225, 160000, 4058, N'STL-RJl-03', N'{"Son Tint":"#03 Summer scent"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4226, 160000, 4058, N'STL-RJl-04', N'{"Son Tint":"#04 Dragon Pink"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4227, 160000, 4058, N'STL-RJl-05', N'{"Son Tint":"#05 Peach Me"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4228, 160000, 4058, N'STL-RJl-06', N'{"Son Tint":"#06 Fig Fig"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4229, 160000, 4058, N'STL-RJl-07', N'{"Son Tint":"#07 Jujube"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4230, 160000, 4058, N'STL-RJl-08', N'{"Son Tint":"#08 Apple Brown"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4231, 160000, 4058, N'STL-RJl-09', N'{"Son Tint":"#09 Litchi Coral"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4232, 160000, 4058, N'STL-RJl-10', N'{"Son Tint":"#10 NUDY PEANUT"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4233, 160000, 4058, N'STL-RJl-11', N'{"Son Tint":"#11 PINK PUMPKIN"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4234, 160000, 4058, N'STL-RJl-12', N'{"Son Tint":"#12 CHERRY BOMB"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4235, 160000, 4058, N'STL-RJl-13', N'{"Son Tint":"#13 EAT DOTORI"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4239, 110000, 4062, N'XT-FP-G', N'{"Xịt thơm":"Gỗ"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4240, 110000, 4062, N'XT-FP-CH', N'{"Xịt thơm":"Cánh hoa"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4241, 110000, 4062, N'XT-FP-D', N'{"Xịt thơm":"Đào"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4242, 140000, 4064, N'MI-V', N'{"MASCARA":"Volumecara "}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4243, 140000, 4064, N'MI-L', N'{"MASCARA":"LonglashCara"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4244, 140000, 4064, N'MI-MZ', N'{"MASCARA":"Microcara Zero"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4245, 140000, 4068, N'SBR-CM01', N'{"Black Rouge":"CM01"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4246, 140000, 4068, N'SBR-CM02', N'{"Black Rouge":"CM02"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4247, 140000, 4068, N'SBR-CM03', N'{"Black Rouge":"CM03"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4248, 140000, 4068, N'SBR-CM04', N'{"Black Rouge":"CM04"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4249, 140000, 4068, N'SBR-CM05', N'{"Black Rouge":"CM05"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4250, 140000, 4068, N'SBR-CM06', N'{"Black Rouge":"CM06"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4251, 140000, 4068, N'SBR-CM07', N'{"Black Rouge":"CM07"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4252, 115000, 4069, N'SD-YNM-P', N'{"YNM":"Hồng Nhạt"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4253, 115000, 4069, N'SD-YNM-OR', N'{"YNM":"OR101"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4254, 115000, 4069, N'SD-YNM-PK', N'{"YNM":"PK001"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4265, 120000, 4070, N'DGK-T', N'{"Gội khô":"Tropical"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4266, 120000, 4070, N'DGK-B', N'{"Gội khô":"Blush"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4267, 120000, 4070, N'DGK-F', N'{"Gội khô":"Fresh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4268, 120000, 4070, N'DGK-O', N'{"Gội khô":"Original"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4269, 120000, 4070, N'DGK-C', N'{"Gội khô":"Cherry"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4270, 150000, 4073, N'SMT-L1', N'{"Merzy thỏi":"L1"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4271, 150000, 4073, N'SMT-L4', N'{"Merzy thỏi":"L4"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4272, 150000, 4073, N'SMT-L5', N'{"Merzy thỏi":"L5"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4273, 150000, 4073, N'SMT-L6', N'{"Merzy thỏi":"L6"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4274, 150000, 4073, N'SMT-L9', N'{"Merzy thỏi":"L9"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4275, 150000, 4073, N'SMT-L10', N'{"Merzy thỏi":"L10"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4276, 160000, 4074, N'SKL-RM-01', N'{"Romand":"01"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4277, 160000, 4074, N'SKL-RM-02', N'{"Romand":"02"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4278, 160000, 4074, N'SKL-RM-03', N'{"Romand":"03"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4279, 160000, 4074, N'SKL-RM-04', N'{"Romand":"04"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4288, 460000, 4075, N'KCN-AS-M', N'{"Loại":"Milk 60ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4289, 430000, 4075, N'KCN-AS-G', N'{"Loại":"Gel 90ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4290, 135000, 4077, N'SK-BR-A13', N'{"BLACKROUGE":"A13"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4291, 135000, 4077, N'SK-BR-A14', N'{"BLACKROUGE":"A14"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4292, 135000, 4077, N'SK-BR-A15', N'{"BLACKROUGE":"A15"}')
GO
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4293, 135000, 4077, N'SK-BR-A16', N'{"BLACKROUGE":"A16"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4294, 135000, 4077, N'SK-BR-A17', N'{"BLACKROUGE":"A17"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4295, 195000, 4078, N'SR-AHC-G', N'{"SERUM AHC":"Xanh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4296, 195000, 4078, N'SR-AHC-PK', N'{"SERUM AHC":"Hồng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4297, 195000, 4078, N'SR-AHC-P', N'{"SERUM AHC":"Tím"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4298, 100000, 4079, N'BKM-MZ-01', N'{"Merzy":"01"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4299, 100000, 4079, N'BKM-MZ-02', N'{"Merzy":"02"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4300, 95000, 4080, N'CF-13-B', N'{"FIX":"Xanh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4301, 95000, 4080, N'CF-13-P', N'{"FIX":"Hồng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4302, 210000, 4084, N'KN-MNY-110', N'{"Fit Me":"110"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4303, 210000, 4084, N'KN-MNY-112', N'{"Fit Me":"112"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4304, 210000, 4084, N'KN-MNY-115', N'{"Fit Me":"115"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4305, 210000, 4084, N'KN-MNY-120', N'{"Fit Me":"120"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4306, 155000, 4087, N'PN-E-BL21', N'{"PHẤN NÉN":"Đen 21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4307, 155000, 4087, N'PN-E-BL23', N'{"PHẤN NÉN":"Đen23"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4308, 155000, 4087, N'PN-E-WT', N'{"PHẤN NÉN":"Trắng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4309, 135000, 4090, N'SK-BR-A23', N'{"Black Rouge":"A23"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4310, 135000, 4090, N'SK-BR-A24', N'{"Black Rouge":"A24"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4311, 135000, 4090, N'SK-BR-A25', N'{"Black Rouge":"A25"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4312, 135000, 4090, N'SK-BR-A26', N'{"Black Rouge":"A26"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4313, 135000, 4090, N'SK-BR-A27', N'{"Black Rouge":"A27"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4314, 135000, 4091, N'PN-MH-21', N'{"MISSHA":"21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4315, 135000, 4091, N'PN-MH-23', N'{"MISSHA":"23"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4316, 165000, 4093, N'CM-TT-10', N'{"Loại":"10ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4317, 165000, 4093, N'CM-TT-25', N'{"Loại":"2.5ml - Hiệu quả cao"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4328, 145000, 4094, N'MN-FM-NT', N'{"Mặt Nạ Freeman":"Ngọc trai"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4329, 145000, 4094, N'MN-FM-C', N'{"Mặt Nạ Freeman":"Chanh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4330, 145000, 4094, N'MN-FM-B', N'{"Mặt Nạ Freeman":"Bơ"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4331, 145000, 4094, N'MN-FM-THT', N'{"Mặt Nạ Freeman":"Than hoạt tính"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4332, 145000, 4094, N'MN-FM-TD', N'{"Mặt Nạ Freeman":"Than đá"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4335, 205000, 4096, N'NHH-MJ-L', N'{"TONER MUJI":"Light"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4336, 205000, 4096, N'NHH-MJ-M', N'{"TONER MUJI":"Moisture"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4337, 135000, 4098, N'SK-BR-A33', N'{"Màu":"A33"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4338, 135000, 4098, N'SK-BR-A34', N'{"Màu":"A34"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4339, 135000, 4098, N'SK-BR-A35', N'{"Màu":"A35"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4340, 135000, 4098, N'SK-BR-A36', N'{"Màu":"A36"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4341, 135000, 4098, N'SK-BR-A37', N'{"Màu":"A37"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4342, 155000, 4099, N'SRM-HL-XV', N'{"SRM HADALABO":"Xanh vòi"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4343, 155000, 4099, N'SRM-HL-XT', N'{"SRM HADALABO":"Xanh tuýp"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4344, 155000, 4099, N'SRM-HL-TV', N'{"SRM HADALABO":"Trắng vòi"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4345, 155000, 4099, N'SRM-HL-TT', N'{"SRM HADALABO":"Trắng tuýp"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4346, 215000, 4101, N'KCN-MH-SF', N'{"Kcn Missha":"Soft Finish"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4347, 215000, 4101, N'KCN-MH-WP', N'{"Kcn Missha":"Waterproof"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4348, 140000, 4105, N'SKL-BR-HV01', N'{"Black Rouge":"HV01"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4349, 140000, 4105, N'SKL-BR-HV02', N'{"Black Rouge":"HV02"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4350, 140000, 4105, N'SKL-BR-HV03', N'{"Black Rouge":"HV03"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4351, 140000, 4105, N'SKL-BR-HV04', N'{"Black Rouge":"HV04"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4352, 140000, 4105, N'SKL-BR-HV05', N'{"Black Rouge":"HV05"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4353, 230000, 4107, N'MC-KM-DIM', N'{"Kiss Me":"Dài mi"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4354, 230000, 4107, N'MC-KM-DYM', N'{"Kiss Me":"Dày mi"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4355, 155000, 4108, N'KN-CL-21', N'{"Cellio":"21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4356, 155000, 4108, N'KN-CL-23', N'{"Cellio":"23"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4359, 275000, 4115, N'PN-AS-21', N'{"APRIL SKIN":"21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4360, 275000, 4115, N'PN-AS-22', N'{"APRIL SKIN":"22"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4361, 275000, 4115, N'PN-AS-23', N'{"APRIL SKIN":"23"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4362, 305000, 4116, N'PN-KV-B21', N'{"Klavuu":"Xanh 21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4363, 305000, 4116, N'PN-KV-B23', N'{"Klavuu":"Xanh 23"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4364, 305000, 4116, N'PN-KV-GR21', N'{"Klavuu":"Xám 21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4365, 305000, 4116, N'PN-KV-GR23', N'{"Klavuu":"Xám 23"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4366, 335000, 4117, N'TCTT-C35', N'{"Red Peel":"Chai - 35ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4367, 300000, 4117, N'TCTT-T20', N'{"Red Peel":"Tuýp - 20ml "}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4368, 275000, 4121, N'PN-LM-W10', N'{"CUSHION LIME":"Trắng 10"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4369, 275000, 4121, N'PN-LM-W20', N'{"CUSHION LIME":"Trắng 20"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4370, 275000, 4121, N'PN-LM-B10', N'{"CUSHION LIME":"Xanh 10"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4371, 275000, 4121, N'PN-LM-B20', N'{"CUSHION LIME":"Xanh 20"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4372, 260000, 4123, N'DTTT-TDC', N'{"White Conc":"Tẩy da chết"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4373, 220000, 4123, N'DTTT-ST', N'{"White Conc":"Sữa tắm"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4374, 235000, 4123, N'DTTT-DT', N'{"White Conc":"Dưỡng thể"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4375, 150000, 4128, N'SRM-CTP-125', N'{"Srm Cetaphil":"125ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4376, 205000, 4128, N'SRM-CTP-237', N'{"Srm Cetaphil":"237ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4377, 300000, 4128, N'SRM-CTP-500', N'{"Srm Cetaphil":"500ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4378, 75000, 4130, N'KD-GD-10', N'{"Goodal":"10ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4379, 270000, 4130, N'KD-GD-30', N'{"Goodal":"30ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4380, 145000, 4131, N'SR-BL-VC', N'{"Serum Balance":"Vitamin C"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4381, 145000, 4131, N'SR-BL-H', N'{"Serum Balance":"Hyaluronic"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4382, 145000, 4131, N'SR-BL-DB', N'{"Serum Balance":"Dragon’s Blood"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4383, 145000, 4131, N'SR-BL-GC', N'{"Serum Balance":"Gold Collagen"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4384, 190000, 4132, N'SMZ-V13', N'{"Merzy":"V13"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4385, 190000, 4132, N'SMZ-V14', N'{"Merzy":"V14"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4386, 190000, 4132, N'SMZ-V15', N'{"Merzy":"V15"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4387, 190000, 4132, N'SMZ-V16', N'{"Merzy":"V16"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4388, 190000, 4132, N'SMZ-V17', N'{"Merzy":"V17"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4389, 190000, 4132, N'SMZ-V18', N'{"Merzy":"V18"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4390, 145000, 4133, N'XCN-JM-B', N'{"XỊT JM":"Xanh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4391, 145000, 4133, N'XCN-JM-P', N'{"XỊT JM":"Hồng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4392, 160000, 4109, N'MNM-JM-G', N'{"Mặt Nạ Mắt JM":"Xanh - giảm thâm"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4393, 160000, 4109, N'MNM-JM-B', N'{"Mặt Nạ Mắt JM":"Đen - chống lão hóa"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4394, 150000, 4134, N'MC-MB-TM', N'{"Maybeline":"Tơ mi"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4395, 125000, 4134, N'MC-MB-DM', N'{"Maybeline":"Dày mi"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4396, 125000, 4134, N'MC-MB-CM', N'{"Maybeline":"Cong mi"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4397, 160000, 4135, N'SRM-INF-GT', N'{"Loại":"Green Tea"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4398, 160000, 4135, N'SRM-INF-B', N'{"Loại":"Bija"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4399, 160000, 4135, N'SRM-INF-J', N'{"Loại":"Jeju"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4400, 160000, 4135, N'SRM-INF-J2', N'{"Loại":"Jeju 2x"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4401, 135000, 4136, N'SK-BR-A01', N'{"SON BLACKROUGE":"A01"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4402, 135000, 4136, N'SK-BR-A02', N'{"SON BLACKROUGE":"A02"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4403, 135000, 4136, N'SK-BR-A03', N'{"SON BLACKROUGE":"A03"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4404, 135000, 4136, N'SK-BR-A04', N'{"SON BLACKROUGE":"A04"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4405, 135000, 4136, N'SK-BR-A05', N'{"SON BLACKROUGE":"A05"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4406, 135000, 4136, N'SK-BR-A06', N'{"SON BLACKROUGE":"A06"}')
GO
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4407, 135000, 4136, N'SK-BR-A07', N'{"SON BLACKROUGE":"A07"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4408, 140000, 4138, N'CB-INF-GT', N'{"Innisfree":"Green Tea"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4409, 140000, 4138, N'CB-INF-JCB', N'{"Innisfree":"Jeju Cherry Blossom"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4410, 100000, 4141, N'KM-KRU-W', N'{"Karadium":"Vỏ trắng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4411, 100000, 4141, N'KM-KRU-B', N'{"Karadium":"Vỏ đen"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4412, 145000, 4144, N'SK-MZ-V1', N'{"Merzy":"V1"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4413, 145000, 4144, N'SK-MZ-V3', N'{"Merzy":"V3"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4414, 145000, 4144, N'SK-MZ-V6', N'{"Merzy":"V6"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4415, 145000, 4144, N'SK-MZ-V8', N'{"Merzy":"V8"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4416, 145000, 4144, N'SK-MZ-V9', N'{"Merzy":"V9"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4417, 145000, 4144, N'SK-MZ-V11', N'{"Merzy":"V11"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4418, 135000, 4146, N'KL-CTE-P', N'{"Catrice":"Hồng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4419, 135000, 4146, N'KL-CTE-W', N'{"Catrice":"Trắng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4420, 410000, 4147, N'DG-TG-GX', N'{"Tigi":"Gội xả"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4421, 225000, 4147, N'DG-TG-UT', N'{"Tigi":"Ủ tóc"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4422, 135000, 4148, N'SBR-V6-A28', N'{"Black Rouge":"A28"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4423, 135000, 4148, N'SBR-V6-A29', N'{"Black Rouge":"A29"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4424, 135000, 4148, N'SBR-V6-A30', N'{"Black Rouge":"A30"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4425, 135000, 4148, N'SBR-V6-A31', N'{"Black Rouge":"A31"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4426, 135000, 4148, N'SBR-V6-A32', N'{"Black Rouge":"A32"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4427, 185000, 4149, N'KN-CT-T10', N'{"Catrice":"Tone 10"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4428, 185000, 4149, N'KN-CT-T20', N'{"Catrice":"Tone 20"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4429, 185000, 4149, N'KN-CT-T30', N'{"Catrice":"Tone 30"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4430, 140000, 4150, N'KDA-NTG-WG', N'{"Kem Neutrogena":"Water-gel 15g"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4431, 280000, 4150, N'KDA-NTG-AG', N'{"Kem Neutrogena":"Aqua-gel 50ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4432, 280000, 4150, N'KDA-NTG-GC', N'{"Kem Neutrogena":"Gel-cream 50ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4433, 60000, 4154, N'TT-BPS-100', N'{"TT BYPHASSE":"100ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4434, 120000, 4154, N'TT-BPS-500', N'{"TT BYPHASSE":"500ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4435, 290000, 4159, N'TDC-HL-120', N'{"Tdc Huxley":"120g"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4436, 100000, 4159, N'TDC-HL-30', N'{"Tdc Huxley":"30g"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4437, 290000, 4160, N'KD-IF-CJ', N'{"Loại":"Cherry Jellycream"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4438, 290000, 4160, N'KD-IF-CTC', N'{"Loại":"Cherry Tone-Up Cream"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4439, 250000, 4160, N'KD-IF-GT', N'{"Loại":"Green Tea"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4440, 390000, 4160, N'KD-IF-JO', N'{"Loại":"Jeju Orchid"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4443, 65000, 4165, N'CKM-INF-01', N'{"Chì mày":"01"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4444, 65000, 4165, N'CKM-INF-02', N'{"Chì mày":"02"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4445, 65000, 4165, N'CKM-INF-03', N'{"Chì mày":"03"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4446, 65000, 4165, N'CKM-INF-04', N'{"Chì mày":"04"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4447, 65000, 4165, N'CKM-INF-05', N'{"Chì mày":"05"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4448, 65000, 4165, N'CKM-INF-06', N'{"Chì mày":"06"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4449, 65000, 4165, N'CKM-INF-07', N'{"Chì mày":"07"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4450, 120000, 4166, N'DTTD-VL-200', N'{"Dung tích":"200ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4451, 170000, 4166, N'DTTD-VL-320', N'{"Dung tích":"320ml"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4452, 220000, 4167, N'ST-3CE-BA', N'{"3CE":"Beige Avenue"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4453, 220000, 4167, N'ST-3CE-N', N'{"3CE":"Needful"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4454, 220000, 4167, N'ST-3CE-AL', N'{"3CE":"Active Lady"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4455, 220000, 4167, N'ST-3CE-MR', N'{"3CE":"Macaron Red"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4456, 220000, 4167, N'ST-3CE-LAL', N'{"3CE":"Live A Little"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4457, 220000, 4167, N'ST-3CE-FC', N'{"3CE":"Fairy Cake"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4458, 220000, 4167, N'ST-3CE-I', N'{"3CE":"Immanence"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4459, 220000, 4167, N'ST-3CE-C', N'{"3CE":"Cutesicle"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4460, 220000, 4167, N'ST-3CE-BD', N'{"3CE":"Blossom Day"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4461, 220000, 4167, N'ST-3CE-P', N'{"3CE":"Pinkalicious"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4462, 220000, 4167, N'ST-3CE-CP', N'{"3CE":"Carrot Pink"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4463, 220000, 4167, N'ST-3CE-PT', N'{"3CE":"Peach Tease"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4464, 185000, 4168, N'MN-KH-MN-DS', N'{"Mặt Nạ Kiehl’s":"Kiehl’s Đất Sét"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4465, 185000, 4168, N'MN-KH-MN-HC', N'{"Mặt Nạ Kiehl’s":"Kiehl’s Hoa Cúc"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4466, 185000, 4168, N'MN-KH-MN-TD', N'{"Mặt Nạ Kiehl’s":"Kiehl’s Thải Độc"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4467, 185000, 4168, N'MN-KH-MN-N', N'{"Mặt Nạ Kiehl’s":"Kiehl’s Nghệ"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4468, 185000, 4168, N'MN-KH-MN-B', N'{"Mặt Nạ Kiehl’s":"Kiehl’s Bơ"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4469, 430000, 4171, N'SRM-CRV-G', N'{"Cerave":"Xanh lá"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4470, 430000, 4171, N'SRM-CRV-BH', N'{"Cerave":"Bạc hà"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4471, 270000, 4161, N'KDRM-SK-C', N'{"Skin1004":"Cream"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4472, 270000, 4161, N'KDRM-SK-SC', N'{"Skin1004":"Soothing Cream"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4473, 185000, 4174, N'MNDS-DW-G', N'{"Mặt Nạ":"Xanh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4474, 185000, 4174, N'MNDS-DW-W', N'{"Mặt Nạ":"Trắng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4475, 185000, 4174, N'MNDS-DW-P', N'{"Mặt Nạ":"Hồng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4476, 205000, 4175, N'KCN-INF-LL', N'{"KCN INNISFREE":" Long Lasting"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4477, 205000, 4175, N'KCN-INF-TS', N'{"KCN INNISFREE":"Triple-shield"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4478, 205000, 4175, N'KCN-INF-TU', N'{"KCN INNISFREE":"No Sebum Tone Up "}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4479, 160000, 4177, N'PN-MH-21', N'{"Missha":"21"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4480, 160000, 4177, N'PN-MH-23', N'{"Missha":"23"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4481, 105000, 4178, N'KTL-VT-B', N'{"Tẩy Lông Veet":"Xanh dương"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4482, 105000, 4178, N'KTL-VT-P', N'{"Tẩy Lông Veet":"Hồng"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4483, 105000, 4178, N'KTL-VT-BND', N'{"Tẩy Lông Veet":"Xanh dương bản nội địa"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4484, 80000, 4179, N'TDC-ARH-T', N'{"Tdc Arrahan":"Táo"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4485, 80000, 4179, N'TDC-ARH-C', N'{"Tdc Arrahan":"Chanh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4486, 80000, 4179, N'TDC-ARH-DY', N'{"Tdc Arrahan":"Đông y"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4487, 80000, 4179, N'TDC-ARH-TH', N'{"Tdc Arrahan":"Than"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4488, 80000, 4179, N'TDC-ARH-A', N'{"Tdc Arrahan":"Aroma"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4489, 85000, 4182, N'KCN-OM-B', N'{"KCN Omi":"Xanh"}')
INSERT [dbo].[skus] ([id], [price], [product_id], [sku], [sku_attributes]) VALUES (4490, 85000, 4182, N'KCN-OM-R', N'{"KCN Omi":"Đỏ"}')
SET IDENTITY_INSERT [dbo].[skus] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [username], [displayName], [email], [avatar], [password], [CreatedDate], [ResetPasswordCode]) VALUES (3, N'longden', N'Long Đen', N'longden214@gmail.com', N'/Uploads/images/avatar/anhnen.jpg', N'6663063e5ed1ab996ae5dbf73bdaaa22', CAST(N'2021-06-22 15:12:00.160' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__category__72E12F1BB15D843D]    Script Date: 11/9/2021 8:53:19 PM ******/
ALTER TABLE [dbo].[category] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__users__F3DBC572A4FE089E]    Script Date: 11/9/2021 8:53:19 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([id])
GO
ALTER TABLE [dbo].[product_attribute_values]  WITH CHECK ADD FOREIGN KEY([attribute_id])
REFERENCES [dbo].[product_attributes] ([attribute_id])
GO
ALTER TABLE [dbo].[product_attributes]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[skus]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
/****** Object:  StoredProcedure [dbo].[sp_account_login]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_account_login]
 @username varchar(100),
 @password varchar(255)
 as
 begin
	select * from users where username = @username and password = @password
 end


GO
/****** Object:  StoredProcedure [dbo].[sp_category_list]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_category_list]
	@search nvarchar(255)
 as
 begin
	if	@search = ''
		select * from category order By id desc
	else
		select * from category WHERE dbo.fuConvertToUnsign1(name) LIKE N'%' + dbo.fuConvertToUnsign1(@search) + '%'  order By id desc
 end


GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAttribute]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_InsertAttribute]
	@name nvarchar(255) ,
	@product_id int
AS  
BEGIN  
 INSERT INTO product_attributes(name,product_id) VALUES(@name,@product_id)  
 DECLARE @attribute_id INT  
 SET @attribute_id=@@IDENTITY  
 SELECT @attribute_id AS attribute_id  
END

select * from product_attributes


GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAttributeValues]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertAttributeValues]
	@name nvarchar(255),
	@attribute_id int,
	@status bit
AS  
BEGIN  
 INSERT INTO product_attribute_values(name,attribute_id,status) VALUES(@name,@attribute_id,@status)  

 DECLARE @value_id INT  
 SET @value_id=@@IDENTITY 
 SELECT @value_id AS value_id  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertProduct]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_InsertProduct]
	@name nvarchar(255) ,
	@brand nvarchar(255) ,
	@image varchar(255),
	@image_list text,
	@price float ,
	@description nvarchar(max),
	@category_id int,
	@content nvarchar(max),
	@status bit,
	@slug nvarchar(255)
AS  
BEGIN  
 INSERT INTO product(name,brand,image,image_list,price,description,category_id,content,status,slug) VALUES(@name,@brand,@image,@image_list,@price,@description,@category_id,@content,@status,@slug)  
 DECLARE @Id INT  
 SET @Id=@@IDENTITY  
 SELECT @Id AS id  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertSku]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_InsertSku]
	@sku varchar(255),
	@product_id int,
	@price float,
	@sku_attr nvarchar(max)
AS  
BEGIN  
 INSERT INTO skus(sku,price,product_id,sku_attributes) VALUES(@sku,@price,@product_id,@sku_attr)  
 DECLARE @Id INT  
 SET @Id=@@IDENTITY 
 SELECT @Id AS id  
END

GO
/****** Object:  StoredProcedure [dbo].[sp_product_list]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_product_list]
	@search nvarchar(255)
 as
 begin
	if	@search = ''
		select * from product p 
		order By p.id desc
	else
		select * from product p
		WHERE dbo.fuConvertToUnsign1(p.name) LIKE N'%' + dbo.fuConvertToUnsign1(@search) + '%' 
		order By p.id desc
 end
GO
/****** Object:  StoredProcedure [dbo].[sp_product_search]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_product_search]
	@search nvarchar(255)
 as
 begin
		select * from product WHERE dbo.fuConvertToUnsign1(name) LIKE N'%' + dbo.fuConvertToUnsign1(@search) + '%' and status = 1
 end

GO
/****** Object:  StoredProcedure [dbo].[sp_search_result]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_search_result]
	@search nvarchar(255),
	@orderby varchar(255)
as
begin
	select * from product
	WHERE dbo.fuConvertToUnsign1(name) LIKE N'%' + dbo.fuConvertToUnsign1(@search) + '%'
	ORDER by CASE WHEN @orderby='id-desc' THEN id END DESC,
			 CASE WHEN @orderby='name-asc' THEN name END ASC,
			 CASE WHEN @orderby='name-desc' THEN name END DESC,
			 CASE WHEN @orderby='price-asc' THEN price END ASC,
			 CASE WHEN @orderby='price-desc' THEN price END DESC
end
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProduct]    Script Date: 11/9/2021 8:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateProduct]
	@id int,
	@name nvarchar(255),
	@brand nvarchar(255) ,
	@image varchar(255),
	@image_list text,
	@price float ,
	@description nvarchar(max),
	@category_id int,
	@content nvarchar(max),
	@status bit,
	@slug nvarchar(255)
AS  
BEGIN  
 update product set name = @name,brand = @brand,image = @image,image_list = @image_list,price = @price,description= @description,category_id = @category_id,content = @content,status = @status,slug = @slug where id = @id
 
 select id from product where id = @id
END
GO
