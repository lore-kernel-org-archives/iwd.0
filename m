Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A372652B0
	for <iwd@lists.linux.dev>; Fri, 29 Aug 2025 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453510; cv=fail; b=IHYi526mdx1TAR+XA0CILyvH1llVj0K85m5qxXqx8vxXN0ahZynuNsG3+GlTugtwz29pgQqxoOFizUIScrMQiBIn/XpNsLgvm0N4Yi2MQlp1fIEmpOexVanp4C5YMqp+ws0K8vaL4mIBc8g9sM/vKLTMZ4FjFHr2ye7Lp35H9co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453510; c=relaxed/simple;
	bh=Z3hibthR3mHA7zOq4JO3LNOAoVrBsbSxfKPOMd+Y3MA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To; b=iQ8i8cGmwWxX6JWGHMwYYobqYKWjJRBel2LvxPyUJMyhzXp8wMtgOuey+oYWve3QtyCMTX+X6E2b6j4Fc2dHi04j52V9O7RjMj2vvbz/+u2rbzUFoW8KFy4yhEyXtWpgEVHw96cP+vHaXlilJz4dwjXrTvOuK0jGLzwC7ctPlD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=HlOEspF0; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="HlOEspF0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tU9k+Oa6oLopifh1P1od0hn39007ogV+RuSvpwZdzO3624WtYOqvaJ97OD+Wgvv7dAYvZ1lJ9MpLI7pRF+sznRaZ2RUJrM/6Xk9jpvNKuKKk0h9tAWGDqQ6Cb4DIUXwqmULEufyvnMyMHCA8szfPuJoXz2BCvc8rRzby6TYsx0hDOhiWFpCtl7bJXTIaTtx0W4kbYJhOgRr1NdsINkmwbz9FGJGcOy7A7bOJJv9WRa2RFoUMArI696MFy18X/6ANDYL0U8EAy8Mh+wR64PQcJ5ESq/v0RO4gXX63fsSLjr5dYkQoO+Ln4jrwYvsbDZbel3Mjpwz0GSHxFpzr9XZyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKHmIPMrAqDMk6Y3G7iUCUGfOzOFOeg2NYbLIojFBp8=;
 b=bkNeryvNJ6NGfNF/2Vcqm4gtTA0zU3TSZp128/6VfnxYQ4AY71GwCdbqfN4ftIqYyyuNeGfgUi2ifS99PGbmfRvOJqWQ0OQoG46NpM0yv11kaMSIyWsQBR973e5YxDINZJpeGNEhZ9ZDdCSic39BcBlaT/MtiAr4ucftM/KUIi5+jGdRF03G9Lm0U7KTlyFwpyPe3oJCirVfjTktyG9c89rshnsjBGnS4RKlIWDlKRcuWgRQAYOXghIMjSdu894vSZjeNm0rGUvwxm680keWnjCGlJ15g8TfelVuuf5oWw6R0wqJdX+U3C9ItcvAjz5cJa8N+BP65WqHiEqHFDPZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKHmIPMrAqDMk6Y3G7iUCUGfOzOFOeg2NYbLIojFBp8=;
 b=HlOEspF0+ZiWAjuFYhmFw63/kn029J9P5HlvLISXGphEOjc1fqLp1XnqXrRZ6/ip7CLI0MaohfPnnBR04uXqxFy19FxaBqujSE0FURqVTlzmlZ7WtxsillarjHT8pFZoBg5fraHI/32jexX8FIotpaH6MPg57ttpiugkwDGXmk0=
Received: from AS9PR06CA0502.eurprd06.prod.outlook.com (2603:10a6:20b:49b::27)
 by AS8PR02MB10410.eurprd02.prod.outlook.com (2603:10a6:20b:5bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Fri, 29 Aug
 2025 07:45:05 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:49b:cafe::85) by AS9PR06CA0502.outlook.office365.com
 (2603:10a6:20b:49b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 07:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 07:45:05 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 29 Aug
 2025 09:45:04 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 29 Aug 2025 09:45:04 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 9AA9BA05
	for <iwd@lists.linux.dev>; Fri, 29 Aug 2025 09:45:04 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 96B12287A999; Fri, 29 Aug 2025 09:45:04 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Subject: [PATCH v2 0/3] Improve roam scan strategy
Date: Fri, 29 Aug 2025 09:43:38 +0200
Message-ID: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACpasWgC/3WNywrCMBBFf6XM2pFM7Muu/A/pIsTRziJJSUqol
 P67seDS5Tlwz90gcRROMFQbRM6SJPgC+lSBnYx/McqjMGilG1VTjTEYh8kaj+LmGDI79ktCpYl
 a29m6vRCU8Rz5KesRvo+FJ0lLiO/jJ9PX/pLNv2QmVEi61x2rvu2vzc2sks42OBj3ff8ADozVO
 LsAAAA=
X-Change-ID: 20250414-roam-scan-improvements-02116c7c4631
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|AS8PR02MB10410:EE_
X-MS-Office365-Filtering-Correlation-Id: db63aab4-c9e2-4b5a-9011-08dde6cff814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEp1bVF3RkFqaWo2cHFubVdDV1A0b0xxc0hhME1XODR3dFlIWERVVDR0NjJX?=
 =?utf-8?B?dHgyeXl3M0VLYk5MYzNRb1RoSGxMakFNaGs1Qk1STmFzYlBwNi9jSk1ydWFH?=
 =?utf-8?B?SlB2MERUKzRFYnA3VFp6NnNIbGx5VStlMjhOc2ZKTEN3eVZabmJkZWtsdUY4?=
 =?utf-8?B?WHplNG9qTWhFdkhsZE9DMFJjbFJqNnhKU250R0JhY3o1NytJWVZBWnNiMUFK?=
 =?utf-8?B?M1RBWUUwZTBkOTZlQUNHbE44emFVR2hwOWtnNHg0VkJoajVyd3VwenhxNjRz?=
 =?utf-8?B?M0FIUm9ReU43TUpmTnhKYytJSUQxaHZmMFdqTVhVTGQzS1JpQ0ZTMTQwS3ZY?=
 =?utf-8?B?akNhUnZ6M1ErS2dPdG5WVzE1L0pHa3ltS1g0L0Q1VE1hTnRUcUZOdU14RFp5?=
 =?utf-8?B?Nno1QVQ5d2hSSS93QTVSaGtoYXJrdk92OG5XaE5ZTmxpc1FDSGVLcjlvTnRv?=
 =?utf-8?B?SVUwSnl3aWVLUnd4K3JiREc0LzRLTWtMTFZZQnU4aVlaRlhhVjk2UmU1ck9y?=
 =?utf-8?B?aHpKMzRRYWpIdmNneDRMVExIUkJCZDlKR0h5NncxaDNzY3hEVys5ZDM4YmZk?=
 =?utf-8?B?d3F1K0NON1MwOUIvOVgxRXc5K1VOYWQzR1d5aitIb2svOWE4WDJwQVJQQ1Ni?=
 =?utf-8?B?T3N2dnR6Rmo5TFUwMkFGdllKZklsdFhWNGg5eityQ1Y0MWVHbmlpSU4yTTA1?=
 =?utf-8?B?MEFZeU56SFd4UUt6N1pzVlJXZTI3KzdyTzdZSnBJd0dZQmpIOUFUeGdnOXB3?=
 =?utf-8?B?blZtT0QwRkFjYzIzSk9QQ0EzTGxHdHhKNGpleFEvRzd0VnN3YjNzTnFXSUVn?=
 =?utf-8?B?dFBrWTJtNCt1b1NMcVk2VnpTRlJjR3dmY0UyVDlUVWJYbmgzT0xFWWlyTEFm?=
 =?utf-8?B?aks3VFR4TTA2bkdnUGZIdE1yUklnazRZYnh2S056RlpQcHJ6WStFS09TeHBR?=
 =?utf-8?B?QkFpUFVpMllNM2F0ci8rTUplR2g2WWRiKzZQbkJPSkJXQm5Pa2tJNFlmUWxV?=
 =?utf-8?B?ZnhCdFpKcjVlcko2TXliZ3VULzdVR3Rob1k0R3Bpd2JtZXBwVE44Y0tqVTA0?=
 =?utf-8?B?bVg0NUlEWG1KaHRlZ1Y2eHhwZGQ2RHlHaCsvaFV3c1NGWkoxVEFCanZpUkJp?=
 =?utf-8?B?T2lHUkNzSlI4ZEgxc01aaVlTdGZ5QTB6MVVyQ0Rrckt6cVc3akl2akxWQUQv?=
 =?utf-8?B?aEFxbks5VklxQUNGUnppVUNVNzVNRUw3REhpUUQrUHRzY2h1aVUzVjliNDZq?=
 =?utf-8?B?VzZ4NzdFbEdQaE9qV3U0VGc1NTBldTd2TGRqZ1doaC9EVmRVYXB0N2VDdVVS?=
 =?utf-8?B?VlR0MmF6aStpWWk4NUJ4cHFST05KQ0dTaUNCamtxTEtnR1Y0a28yV2syd0xz?=
 =?utf-8?B?L29heTFlWXVHSkUvQlg2V1dnL1NSRzRJWjg3ZXJFNXNYMEZLUll5UGkyTUVM?=
 =?utf-8?B?MWFBK2p0b0tPYlNmb0R5VTZpckM2Z0JldnJuLzB4aURKcjRzTjcyUkxXWjc2?=
 =?utf-8?B?WVYyVnRDdmtoR0MwN2g0RWZhRmprZHRmYUFGWjd0K25CK2paaFpzaE9rYm9w?=
 =?utf-8?B?Mi9jZytVWHR6bDQyd1JUWHY3REQzMlVEYkRPU3NmZGFYbXFRVURnLzl3OVdl?=
 =?utf-8?B?MnFCdVpxL0tNMU5XUmdhWnRIUlJOTWNvSU9rRi8rdHNjMDdlaHF1S3ltTG9i?=
 =?utf-8?B?L2pRNEc0NFJJblJFYWQyTzlnZFdqUVB2YTRKU1BMaEkvL0dkWU1MV3hxY09x?=
 =?utf-8?B?SmlkMHE0b1ZqQVMwd2VYWUVKbS9Gc2FJUEZWTkxOWHNiekVlaThuRWRHVmRq?=
 =?utf-8?B?U0g5R2tCUkkyT0hUS1l3RzBqZUowNVY4cE4zWS9pYW5rck5MeDFwcjdEaHBx?=
 =?utf-8?B?MEVlTDZKMGFHa1ViTEhWTTRFU3N1Z05tcU9JN2w2MWhEZzRHVlY0dTVMdFRt?=
 =?utf-8?B?ZkNtcWNVUm53TklWREpKQ2owR2JMMzArNDVaZUxFZW5CVlNzSEhteDZ5Z0dN?=
 =?utf-8?B?eTlaN05mYlA1ZWhNUm1xMDVXTUF3S2J6UERzeDFqWlJReEdlcjZ5dTVxT0Nq?=
 =?utf-8?Q?sWU8IE?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:45:05.0094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db63aab4-c9e2-4b5a-9011-08dde6cff814
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10410

I recommend looking at the diff in a side-by-side viewer, the patch
files are looking far more complicated than they actually are...

This is attempt #2 at improving roaming. This removes the previous
timestamp-based approach and instead uses a simple list to keep track of
which frequencies have been scanned in the current roam attempt.

The main idea is to make station_start_roam() the central point for all
roaming. When some function wants to trigger a roam, it calls
station_start_roam() that takes care of all scan logic.

In my own testing I've noticed a big improvement in connection stability
when running around a building. There might be edge-cases I've missed
though, as I don't have a setup to test all different functionality.

Happy to hear your thoughts on this approach and if it can be improved.

Thanks,
Alexander

---
Changes in v2:
- Removed code that tracked scan frequency timestamps
- Added code to track which frequencies have been scanned
- Link to v1: https://lore.kernel.org/r/20250415-roam-scan-improvements-v1-0-12827e086895@axis.com

---
Alexander Ganslandt (3):
      util: add scan_freq_set_size function
      station: improve scan_freqs_order channel subsets
      station: improve roam scan strategy

 src/station.c | 350 +++++++++++++++++++++++++++++++++-------------------------
 src/util.c    |  11 ++
 src/util.h    |   1 +
 3 files changed, 209 insertions(+), 153 deletions(-)
---
base-commit: 3760a49650b39edd623a85a2b9d51645b52d004a
change-id: 20250414-roam-scan-improvements-02116c7c4631

Best regards,
-- 
Alexander Ganslandt <alexander.ganslandt@axis.com>

