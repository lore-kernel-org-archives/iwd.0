Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521123;
	b=zKoYRMqQYXp8Q1FAt6HMF1kYghffnI3jX/WU5xzCzhcvA3H2sGIslkuAh6FJr3wC9LGE
	 kcLky7/B3e/K46Qzv1exKgHDsfWI+u1dc1jV6K98PpsNRRwv8uie6K12LuzaGm3iz1uPz
	 BKcl/2MAEKZg5y6J7i+0ZDQQjSYX0E6lh9UZnJ4yGTuk04vD+V5t1uqrtqg0i2mLfiDFm
	 70cPCQuwRzNGEg0arvxi5Fwh9VhtwqMeKv8NgQfcne518Gm4NPG7qQivJscAfno0cy0TO
	 4Duv7juMFSwQn2S/7eh34W1m4Wwy3/TmfExvy17vEARqSAdeIpYo+KJoJcKQXqSNasg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521123;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=48c0npSOK95CiscrVyP4ZuKGR53q+ct4pVUYwzGQK3Q=;
	b=g0EYFjT+Bh8TN4+wZKl1D9h6s11t4NSveVrU3j4NcJb/XGhd9pOMp8fDUjpvJO25+WhC
	 r3srBxIQsc8xZTN+hlXTpzoKfGZYzVGJr0jXsDz66kaGPaqxOQWGuCfIDtGNmhMdZc35H
	 KDzdcN32X17BkgolifzZFVs3+sySk+Acq2j1ERROM+x27rjY+7ldAvR2YxYpWq8yY2s+q
	 eNjNEaG1Z+GXcJ7iQGmwbmcVx4+80EsV1CYTJZ9qQlFIkiR5QgkpAw+ktcR4Q4vWrVVSE
	 y61pt2yviXBy3xk27ffYYwu8bFoKCDInldXsVa4X7ZrYAOSFaP7EXkCXD3qAYmU9MLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=kNxIQxKT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.82
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021082.outbound.protection.outlook.com [40.107.130.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F27606A332
	for <iwd@lists.linux.dev>; Tue, 24 Nov 2026 11:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64F27606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=kNxIQxKT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9QjP5+43GWGum5v7Q4hgYYOC9fZtD8sKBeBxCBOJzfok1a7gvG31foUM/m8q7CdNm//pZkbiuHOw2b466LfcWrwdh4Npd8wfYPbxe4ZwZXbyalvZdpRXCm1HgLcj7A2KUhnzUfFTT0EqnvqCTsp9HpvWma7HXuUxiVwfJjRYr1SIm6HhnZjMfyxovgHJxK/HR0XY5IqKjqKYhZjyEo2Cz4+7Igj2QXAjpDjLjjCuK0VzCqYrVqrL9dQC7xbjJDrtuBi/5fiLhPC38d42Ozi+YbQdNQ5q946qpNouMTJS5/pmTdyPpV8ZM4WGs0hvEgvLDLN0SdmjHmrwLEa+0TK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48c0npSOK95CiscrVyP4ZuKGR53q+ct4pVUYwzGQK3Q=;
 b=A5oGOCSbOXjT8BfUv2x/bBry3Q8eFzN55F8R2Am7laHKf25YvOv5biAFQHxcxacrcWqYMHz/CieeYl4dS0KWu/TESHJ2WXrV8+lALIspYr4vrvJggtvQ4orB5hpwijZr36W3kLq1578ATrTYpbx1SCUgvNSa5knQZK53dQ0ptXCmhv56QpOsXd5jw0LvVkuLAo9oYriC0fBW1oWtAmQoN7fgNpGDP0bT6KjjjW80CwnCbY+MGAE0i1TYKZckZXz2DP751cTPzZiwW/ITvdcF76U9OnEKLEVx1K0eao2AhY/I66E5HFVH2UIpWXVl8dW3s2whN/X2LkGgxGofhhkwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48c0npSOK95CiscrVyP4ZuKGR53q+ct4pVUYwzGQK3Q=;
 b=kNxIQxKTYqxv9zAxX66mWikPDNyp54CnBlH32WR2dERyOeE4B+JJ41ADZAOnr5Ws0oTT95JMoRLzEFSvZ8oU6MBLgerBkegscPLIuwHEbiFgd7fgM+CCcPDfDj17/EzNngXkbHjXj4KFSf+GQx0imO9ajVX8K0Hi9bpCQozsq3Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI0PR08MB10711.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 11:51:58 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:51:58 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: iwd@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	prestwoj@gmail.com,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 6/7] doc: document Station Certification signal
Date: Tue, 24 Nov 2026 12:51:45 +0100
Message-ID: <20261124115146.1281715-7-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::12) To MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16)
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Post: <mailto:iwd@lists.linux.dev>
List-Help: <mailto:iwd+help@lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iwd+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|VI0PR08MB10711:EE_
X-MS-Office365-Filtering-Correlation-Id: ac17580a-1292-4de3-54e7-08df4a215813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|786006|376014|366016|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ROqV9DfphLmp1/+XSf230h9BKbU1Lyq0CJKL5Lo3rKEnCDV0+MvMojah0iXTnhSrhitbcJ47o4LiCv2tI4WFtDBztv0w/n4DHF5JqRTz/Sbe/9uPnkaLm2kNzfvSTp/k2qZf33ZlNU+Zhox/YCEwkYShoWt26Qz0zz8S6w5pzyuOS8NYzxdlQS36OOHO6I3hA+q/l1f2wU0UkEOpHwP1uMN6a00/sZ3dJb0q4ZB4BCFiSBqURyaI1UTIIYAQRfbm+74rfBBYDsIJK3VrF+VnIPa7W3quYL1yqOneitIEDA4Sf4Vw9f73TiqW5vg+LKuJ/g4h5CTrU4y5G1y9uMXiBZzJiYWJefCmXGtJh7yAf6ax5WuJGP4ZjEgQG74VU0koazOfL6zhQovrQxnJSEh1K0muzFqIqtVLydTD/17retBu4lsNWyxR5nYdIm5NVRZ4Dg20G1pudyqqnSdtf9c9kUQI6s1Ebnj784APYMANmT4w7/OKZ6QUskSAj3qZK8xGvAZgcpliHrj5UbF0cr/S5bjAEeQ/vWXF5RJD97l88FRjKlBiUQU+m4nHLw/mj1DjiNzpNCwpegcm2iR4U7x4BMmga8ctTJ2N0KPjR/+X0Nn1I7hf3zFFwhwPpoP1FkLTbdAGIGaN97/0GeoN5kCAZGXMNswBN/8/oQ7LA5AjJh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(786006)(376014)(366016)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e4MVtwy5BFqzDyh7lWyUo4OSMo4SXbmnZBY+DaoXepyQHr7UJZ29GfxDcNGp?=
 =?us-ascii?Q?d/QC5jpezd51V+SMZtvIdsVFMPlISOFLhlK4cg+xvu7B+LSCgfsf4g4YXeel?=
 =?us-ascii?Q?R/gtBXtCQNQhQSGt1z1rAfQlFQh4bupLP0FvDcoC9+OWWbKRaP7zVaOeeoRC?=
 =?us-ascii?Q?axmwVaPQgNA0GXKT/vmZZTHczNt5CZtrwY2rm2BlJZLNeUcB1IoH4GGrbNKZ?=
 =?us-ascii?Q?qBZnYYwVyC8cqQDZir5SUu6fY0m27kLrNONft9CuwZQIl1Cx0mfOtxf6TR2S?=
 =?us-ascii?Q?dormpkPbikebNOhSju2NHV00JD0T1aitVVMGaH6C/2mnj4AhgPHv3JFpncvQ?=
 =?us-ascii?Q?vE25UimqgdqaWPtzP4OWi+hCIoh4DL/Xn5Uz1sAOWn41nU4y060OJPAGLwtL?=
 =?us-ascii?Q?xOe7UXj0r51Da9P1oBDTofZ1fGfFRYrCvHCj1i7GCO5KhqCQdA1b2ZLQ02u4?=
 =?us-ascii?Q?XpdIXCAdveHMliAjhJhZOR6HdjS4tRSIuUau51P6DPGfocNuUFTrog/9VAeA?=
 =?us-ascii?Q?JFEQWKUvGVw0xQG4I5VyVmJsEbeAAeCHvH48bYelb4YRzkvbrZpV79i2/UYa?=
 =?us-ascii?Q?LLvshvcg8NUGgjJBpGUGxluEyeBOCWsGHicw6g9qnUcZB/3IElg89Fh2wP3a?=
 =?us-ascii?Q?m1n1rGrWBzlEMQusNmrzTe4nHID4OV9H7yJGT24eFEb22ESftbVoX/z/Q+0U?=
 =?us-ascii?Q?cHYg9SeD9Dea2aYQv5CxO/N3xXKsXyyC3t8XjniPQYDzXoeubgC39CtBj+ZA?=
 =?us-ascii?Q?BBH7x4ISifD6nXpArxTzVYYuH5KwQsYdfGxVJBDi5pjkIi93ehnCRk9Mrgg0?=
 =?us-ascii?Q?jcNimU1RYDz0kIJ1PCE48JybZicfAwuWIvT765i6kGHuP4RpdJEkKhwqwTu1?=
 =?us-ascii?Q?tCO8f0s2AANdv1IR4p22VJcWzG+zH+3kkQ4uEfqGEYkrWQ7OsbIn+NH6PB1K?=
 =?us-ascii?Q?A4QwH76BnPqcnn45Y4EK+xfJ0UBIHnIpo3NZktE8aON22h/JPUuOB5JX+iBY?=
 =?us-ascii?Q?GIca8cAqXESXTun7cfXc8B2KuIPNNYX9jzYyNiPWhtohEzfh0lWckMMhJJLy?=
 =?us-ascii?Q?WnnFln1CPYbsNJDdRqfawe3ji6EL9C0UzKRyox5mpKdIUBRQtu+nm6GPzN7f?=
 =?us-ascii?Q?NPZEIRBWmtVuhvGAuijNBwD1Sr8K4pfbDmlC1RhnIMwjSEKV4Eq4cmc5pJr+?=
 =?us-ascii?Q?DJmb2NM+89bAERKPC9TArGs/lbT2bIFjh5hvYH9JnqQRZPzFgYqLxSOr+pbo?=
 =?us-ascii?Q?85ORaN6dzmQHd8muTcGutBlKODaPDZunQ4TBsh4c7BFRCd7QadyP6nZXa3Y9?=
 =?us-ascii?Q?4YfYB90N3KeQKhaxWwCweLBnq5uqirDGLxCJ3r7MLOo+AdwNsaqeTzg/6ue1?=
 =?us-ascii?Q?JEUqzbx8FYr+vzFMpjNOqXrN2+8Mrp1QJ/sl8fefOwK0CengOQ2nHx6+MDEZ?=
 =?us-ascii?Q?6Ox35W3Cv0NtUBKb4PLU89gjjB5GBy2Esg1EghMKWq4D7uP8G+RpCjIm1Ho8?=
 =?us-ascii?Q?dUd6QNDtA2leRnEKwt1OKDL05hZXDnVIvMz4mI/thx3w1nAxsqpDR1GrTLn2?=
 =?us-ascii?Q?eGH7evYIkvNKFOZnZ6WoXEvu1aYolwfhKLdoBpbmgdkHf0KGrkj2nMSzvmrs?=
 =?us-ascii?Q?Flt0hdP6etwpvkIoy+8fedY3IluIFpAER4MIonLdLuSUEhepYYfTG8b3gwbi?=
 =?us-ascii?Q?P5rc6vs+PCot5bkFVPmvnU/LgnvSFkjtLPO0aVcJ2Vib/i6PziOjwAuBtmbf?=
 =?us-ascii?Q?afCORpt/uTAgRXG3+YVFzpDuD6Ju3jrsLPh620f+Y2F5BZE3498h?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: ac17580a-1292-4de3-54e7-08df4a215813
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:51:58.2880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEYgqzqzYIaL6PiWSRPzTkgxbtNWOJxrKAG4ApjCYILszqvbb2pfWBMI7YKzu3YbUqMyvqIet1TkzlsmPrYZqBMGEmR74YD2KAIf+EE4Cx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 doc/station-api.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/station-api.txt b/doc/station-api.txt
index f56ea03c..4d6bf2ce 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -135,6 +135,35 @@ Methods		void Scan()
 			Possible Errors: [service].Error.InvalidArguments
 					 [service].Error.NotFound
 
+Signals		Certification(dict certification)
+
+			Sent during EAP-TLS, EAP-TTLS and EAP-PEAP
+			authentication once for every certificate in the
+			chain received from the authentication server, before
+			the chain is verified, so it is also sent when
+			verification then fails.  Certificates are sent from
+			the highest depth (closest to the CA) down to the
+			server's own certificate (depth 0), which is always
+			last.  Same name and keys as wpa_supplicant's
+			Certification signal:
+
+			uint32 depth - position in the chain, 0 for the
+				server's own certificate
+
+			string subject - subject DN, e.g. "/O=Org/CN=name"
+				(omitted if it can't be parsed)
+
+			string cert_hash - SHA256 hash of the DER-encoded
+				certificate, lowercase hex, the same value
+				EAP-*-ServerCertHash takes
+
+			array{byte} cert - the DER-encoded certificate
+
+			array{string} altsubject - SubjectAltName entries,
+				in the certificate's order,
+				as "EMAIL:...", "DNS:..." or "URI:..."
+				(omitted if there are none)
+
 Properties	string State [readonly]
 
 			Reflects the general network connection state.  One of:
-- 
2.53.0

