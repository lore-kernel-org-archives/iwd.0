Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521116;
	b=WAsXFF6e+wYEfN5IX35Az99AJTHKSXJiqm6eH9gKQT3aX0vn8aYN9HrD8Grgu9Oyzr2Y
	 UwUKfqeD7Ty6kK2CgRNk1F4JhnUp78t9e+rVdINcX3HbU0QDBTxOmqgfl2agE40ETgVx8
	 f/jbPcTN1p1Zt6+jhUBjl1Vxa/89/4TPKQ4b3IwiwWeOYWw7qeXnyCPTJCncwy4JYDatT
	 AF/uvWvr4Wc4OTMpsKS2+ut/lVQz9msDPAFsPgR4FTGI3cqtA3B9g8eky3mWHx9SPa5mu
	 G2HSEG2UtCq+8/AXa2uX25AFLuqu1EESas6W5KB9vNagjQm8bwDYMP2kmT4frsa263A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521116;
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
	bh=bUMMfsjjFgk9igvwBDeQ484sI/70DRi2rjPJ3qRbu/0=;
	b=aCtFwGl15T2KNiPWp7OS6c+Z5dIkcUqD8nV44Iz3+bbWBdgJQ9k4ePatUdV11TgkPCR4
	 +msuRpUOetAiztf0IhP0R9t6Y8M6OmDajgMsY4GDdwoWo5l40KKV+6BuKwuqbEe0IX0Nc
	 +ZJdYydGhbMUr0lk/2d2c4BHOEU9slbiIWJeNmt78wiVVnSI/67xIHyZIc4IHaKJL1LJO
	 dWfkEH6oRrRpPnlj+WE0vFm9Jk7HH6mP1CsakjUu5XJBAI1BAg1nNjh1JJDxoD40+d4NV
	 OL8adnKquQ+w5ZNRgVE+NVsAN60ytRSF9D0r7peW30ty4RGLKYrYNq39OZ4EkYtsRhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b="HWS/sm89";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.109
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021109.outbound.protection.outlook.com [52.101.65.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17E606A330
	for <iwd@lists.linux.dev>; Tue, 24 Nov 2026 11:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA17E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=HWS/sm89
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFNtABnF/17nD3wnrpB7BM4RJeTqLUoEEiWX9RbcgFOp7RCqXqu7kn8qY4ZCCOFkjTTZtHt9KZ6X5sd9VR8n50MZ0iASU6qAUPTaJZNxupvOz2sggbpQS4yWZMXtzYCIhxOIAKmYXmN/CR++Ni1hJGCWrLz504ppEuwPBq2TaZbkxppbMzhszp+1SC4cm1M6EHTysInHm0Ry4HTGcq+qd+8ACBQBx2y0OJvhHOsk96qXZgFCEtqPiqnRMita/ootiqwxVoEKyRaJsGu3sSGcbPxjf9f5maVqeF8NtI4fqqyfidGQsnVMb92bNytL+1ZypoPFIUBSCW7kThHv4aD1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUMMfsjjFgk9igvwBDeQ484sI/70DRi2rjPJ3qRbu/0=;
 b=k9KnghPzvEBgdBvK4F3oXOSx2WkS30YnixMsX3R1bkPrpxnThBYrTPMDqCI4JJHhAUtSMdq5x5qMlrdqYUNGzefWOOitjiRQ7ksXK94FRt9gyVFouT+WAoPkR+VjtlQItk9HZsRPwVpGC6cvMN1tiBg5T6ge3NRFPgF2fxn6/AG0gAXpFtrmTJdiHhvxjVFNuloXScSz4ks2FqwNWqiotF/pcD/eEE7LwQCtc2nu+AkfUzB9qhQIBBFG63gq4aVX/fBTfwmGZ06R+lj+ZAR6ZmQpJTTZr92YGJEEwf9DeCMgoaBJ/f/huHs5npfmqko+Feigdo38lFcdnSzhvXCJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUMMfsjjFgk9igvwBDeQ484sI/70DRi2rjPJ3qRbu/0=;
 b=HWS/sm89AojnJ2tgvR8mzT4BQD1qHT612SRL75ygoumRxWTBKUyLxQk4eOVfL/qWD0b5NCPziJOc7yW571E/tE0TBgRs9TSwBZUpInBCmnk4goCa47nRCUOMY+IDVSk1MEj3HXEB+bp7ChcPzLkMOvc9A62PdZi7RPax+61S7to=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI0PR08MB10711.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 11:51:52 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:51:52 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: iwd@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	prestwoj@gmail.com,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 1/7] eap-tls: add ServerCertHash setting
Date: Tue, 24 Nov 2026 12:51:40 +0100
Message-ID: <20261124115146.1281715-2-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0066.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::9) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a3bac1de-3be4-4205-bf51-08df4a2154a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|786006|376014|366016|261026135527099003|261026140227099003|261026130827099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261021133027099003|261021135927099003|261022105027099003|261022075727099003|261022115727099003|261022113327099003|261021130227099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hPQuz6qprxqXq33QVrcc9SRAmT5m/PFlg5yK6v6ZXY9kG1EiPuxKRm0UW3mXRbD4fUmtm3I3EDAqxhnNnBXJ+iJRoDgNUUXtJWD4XwvMsLPQYZKfc9P3kqA6zQf1pZ76cL63JJr7DFNXXTHnvCHCNEwtURTQQnZ9B8cuqtP9hRswiH50g5ZwzIQmqWC3um/dvv6AVQ/+bLpQqVy0oOIBg0V+kwP8HIgNQt8w464jfVgHR2nE8zb9RJ2ReESh1ca0+IS/Y8rxrT/gHatTMa/tFTfpYVyfxVGO6FMq/l4HTUgk5EFgt7rvJHLnlPDlc1QizMgNGEX3T4q/mEKvDq8+PwKViKDCR3KB0xCoKVyxuBa+J2OUjFMnrSzfzDHUKHIq6+bo11Gy5wMLBskBAcnzRg7trjmPKbwoWaILR3zlBj91viN8Bao8+nY9739R+KMd5+HCw8jIXUZlVq9maq3R1yeCdHRMFaZA8i+jQrGHqdRFCq9UI7u8tNs9ekM8dJT5D2PpmgkOxjE8v5jDEmsDE1uusUHf5t9rPUXevGfLv8gF1Txo7eZD1gRLMYLJcH/8vp/lEDlIeUzjetJrEPO8VdqOpJFnpYgRNckw7KMp10KEKskLFuWLHgwlLBfsPgJIbfl5ZomBVn3HzxrDADvqq0mA6OjHDfYztxpt6opMzcg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(786006)(376014)(366016)(261026135527099003)(261026140227099003)(261026130827099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021133027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261022115727099003)(261022113327099003)(261021130227099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g1aBqj13sgDSQyAWEdstUX1XNsw9RcvDGqjJCFRWdH4YVUJSdrBYsn5FH4Mn?=
 =?us-ascii?Q?cOJCHIWET65iOObgCEuQisFJO3ckN/OgteZg893wDTXD6Pu9ainSpbbGqQQL?=
 =?us-ascii?Q?RkCbQNWGu0HGJBYWaUSjCAOMFRyAT+YGpIX1yX9rMsDWn6KpZ4/ERHkxF/Kv?=
 =?us-ascii?Q?teCN0I1/OsYCO7KFqYTjHP8FdDq5evJeCvKlHyFLv9psGzHZOxC2laNRKmQa?=
 =?us-ascii?Q?n7dza1ugiPVkNF8/fc9nsVxUn8tKp5A4+qLLx2RqALEqGLpUNMWBE7Lq+5AJ?=
 =?us-ascii?Q?xodZi/hEjSiPM1k8iuEDNPct1mrmnXQ1T7uNRG/R9/ab8zs0Ta+EXiTgXVPg?=
 =?us-ascii?Q?+FiK39s+TfcZrmkRr+Kr2g8Zoai6CkH7Qz8sxs3Z5tQzUKW86V7btORV+xe0?=
 =?us-ascii?Q?AsNU6LsoXQu8Y/t0gnl86wZ++E1/IS5FoOwRfm8L6NRh9Bih5x0KiDoD/8O6?=
 =?us-ascii?Q?GQVVRJlxqbYeptBi7BAiqx82phslCEE5EnEslaHxhAY1wK1AIR/rLhu2gI+L?=
 =?us-ascii?Q?fhWU5e4lpCEdhwwmFCnrUfk/6mf9UZJZpQGKUD2gy9/MbfrpuJZUjlCwFG8N?=
 =?us-ascii?Q?R4flMJi1EpnoeQvI6YQ/2xmDOJjqIZn8wdIWReLuUJOGTrghdDZNmEEA53T2?=
 =?us-ascii?Q?+9NtAJFQkHCuCnDPxtqUz/BrazSeULnRCnXQI9fqyfh6Xoh8Trb03lvsR4R8?=
 =?us-ascii?Q?dktpsW7osaTA/v0JYyQfewnvADNV6p2dOxUlPz3u0Z9R6csk98WdiDJPmw/J?=
 =?us-ascii?Q?vrB1pQbvMAaTnH//+bvjdtvJDX6drKA4Htc4sCdWF4wbIQ0jdgXp5qEQAXnW?=
 =?us-ascii?Q?MDAgLhhST9zzznKuVMfqCXE2O/5gkLDKtE9VV6g6nKnWNaAenZjrS5QqL01r?=
 =?us-ascii?Q?/3krnnLrmkvbgXb24dYB6tIaeMka3HQA/9g/P8onibcaG4XfaIXNOcurFwrI?=
 =?us-ascii?Q?b8sLPB77CPwKeAa64WpbYq9MxWO7Iyq9+DYbGKmQzhdUk24VHD9l0eO5wTLa?=
 =?us-ascii?Q?e/JHK8C2X25nIabq41tNT6GcBE+84xXd/YugnZtdrCA8GhIYKv1S82wQb0k3?=
 =?us-ascii?Q?H5wbMZrE0SLSqPpwv2xt2QG8x5OVIhgyVoqARRe9QwnJbKK+pWNDy1tEO9pG?=
 =?us-ascii?Q?CC37Yy38EllgvI4TRIqO/uuhnqUY/k9aHXxAc0sYQBFlY2DA6Ciz/2qB41HL?=
 =?us-ascii?Q?umIy6C+N3cQCbHUHflLbMuafqQ+l50i5dNkyBMBxTUP69JWp2/n/Ta7wBmnL?=
 =?us-ascii?Q?DXKv57OR1y31JBS1KBP8kDjha8k6SIIEcNx/EHcyO4Dmt3gzOwVimS3Gulc7?=
 =?us-ascii?Q?uIEeRYQSwLol2vKR+pGEDGKW7BqqQtUpIduQWRy6DiCg2FJ4ltPr3SJBruOT?=
 =?us-ascii?Q?jjbCHmQbU4yZ7jOMtO8XhwujMG8x8pcASXz8yWflB32bhP+IFV/E4ctnbjqE?=
 =?us-ascii?Q?fKl16b5eGZrCgCOeRhSDUTF1VtWb6aFNtjfUNMtTd/DMOOjoutO4qqHz74fH?=
 =?us-ascii?Q?tUKXX2A9cq85zeuSTT3u5DV/E451mCg2Zpb8s2WUf3PoUPRaeAWb2Rvs758n?=
 =?us-ascii?Q?g2IBqcF+Nwrv1rVhlU2k6lDmXmpc6cPOewU/KtdmFygcQZSZnqBN8CRk/aOk?=
 =?us-ascii?Q?NNbRLnZz/nHe7aww1fdADpHpChJRTQtkyzTQo8nTss5wzoEURiKz+64/wqsx?=
 =?us-ascii?Q?7hFGRDqJJ/T2W6uHlCMqlwZp+ZW5RvmkqP+Q3nv2ZFz/kV5S8IydGiHY88gi?=
 =?us-ascii?Q?dZ8dFmIFzjX43/HOYnfd6gZBFQIQowYIAkfyP3D3ZgJ5i6SCDMVr?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bac1de-3be4-4205-bf51-08df4a2154a4
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:51:52.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOQ5xC+2wFe+S8stuThoTu7FXvNK8Mozi6FTkNhZox2Yq68VokD/18Cp3KKe76GbgLZVTe1huskjtZStBPNGqOTErafmF7DbEpbhkDxLFws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711

Add an EAP-{TLS,TTLS,PEAP}-ServerCertHash setting that pins the
authenticator's server certificate by the SHA256 hash of its DER
encoding.  This authenticates the server without a CA certificate, for
example after the user accepted the certificate on first use.  When a
CA certificate is set as well, both checks must pass.

ServerDomainMask can now also be used together with ServerCertHash
instead of a CA certificate.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 src/eap-tls-common.c | 62 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 10358700..e7c3cb17 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -117,8 +117,10 @@ struct eap_tls_state {
 	bool tunnel_ready:1;
 	bool tls_session_resumed:1;
 	bool tls_cache_disabled:1;
+	bool server_cert_pinned:1;
 
 	struct l_queue *ca_cert;
+	uint8_t server_cert_hash[32];
 	struct l_certchain *client_cert;
 	struct l_key *client_key;
 	char **domain_mask;
@@ -290,7 +292,8 @@ static void eap_tls_tunnel_ready(const char *peer_identity, void *user_data)
 	eap_tls->tls_session_resumed =
 		l_tls_get_session_resumed(eap_tls->tunnel);
 
-	if (eap_tls->ca_cert && !peer_identity) {
+	if ((eap_tls->ca_cert || eap_tls->server_cert_pinned) &&
+			!peer_identity) {
 		l_error("%s: TLS did not verify AP identity",
 			eap_get_method_name(eap));
 		eap_method_error(eap);
@@ -690,6 +693,10 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 		eap_tls->ca_cert = NULL;
 	}
 
+	if (eap_tls->server_cert_pinned)
+		l_tls_set_server_cert_hash(eap_tls->tunnel,
+						eap_tls->server_cert_hash);
+
 	if (eap_tls->domain_mask)
 		l_tls_set_domain_mask(eap_tls->tunnel, eap_tls->domain_mask);
 
@@ -931,6 +938,19 @@ static bool is_embedded(const char *str)
 	return false;
 }
 
+/* SHA256 of the server's DER-encoded certificate as 64 hex digits */
+static bool eap_tls_parse_server_cert_hash(const char *value, uint8_t *out)
+{
+	size_t len;
+	_auto_(l_free) uint8_t *hash = l_util_from_hexstring(value, &len);
+
+	if (!hash || len != 32)
+		return false;
+
+	memcpy(out, hash, 32);
+	return true;
+}
+
 static struct l_queue *eap_tls_load_ca_cert(struct l_settings *settings,
 						const char *value)
 {
@@ -1010,6 +1030,7 @@ int eap_tls_common_settings_check(struct l_settings *settings,
 	char setting_key[72];
 	bool have_cacerts = false;
 	const char *domain_mask_str;
+	const char *hash_str;
 	L_AUTO_FREE_VAR(char *, value);
 
 	snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
@@ -1027,18 +1048,34 @@ int eap_tls_common_settings_check(struct l_settings *settings,
 		have_cacerts = true;
 	}
 
+	snprintf(setting_key, sizeof(setting_key), "%sServerCertHash", prefix);
+	hash_str = l_settings_get_value(settings, "Security", setting_key);
+	if (hash_str) {
+		uint8_t hash[32];
+
+		if (!eap_tls_parse_server_cert_hash(hash_str, hash)) {
+			l_error("%s must be a SHA256 hash in hex (64 digits)",
+				setting_key);
+			return -EINVAL;
+		}
+
+		have_cacerts = true;
+	}
+
 	/*
-	 * Require CACert if ServerDomainMask is present.  If the server
-	 * certificate is not being checked against any trusted certificates
-	 * there's no point validating its contents and we wouldn't even
-	 * receive the subject DN from ell, because it may be freely made up.
+	 * Require CACert or ServerCertHash if ServerDomainMask is present.
+	 * If the server certificate is not being checked against any trusted
+	 * certificates there's no point validating its contents and we
+	 * wouldn't even receive the subject DN from ell, because it may be
+	 * freely made up.
 	 */
 	snprintf(setting_key, sizeof(setting_key), "%sServerDomainMask",
 			prefix);
 	domain_mask_str = l_settings_get_value(settings, "Security",
 						setting_key);
 	if (domain_mask_str && !have_cacerts) {
-		l_error("%s was set but no CA Certificates given", setting_key);
+		l_error("%s was set but no CA Certificates or server "
+			"certificate hash given", setting_key);
 		return -EINVAL;
 	}
 
@@ -1063,6 +1100,7 @@ bool eap_tls_common_settings_load(struct eap_state *eap,
 	struct eap_tls_state *eap_tls;
 	char setting_key[72];
 	char *domain_mask_str;
+	const char *hash_str;
 	bool bool_val;
 
 	L_AUTO_FREE_VAR(char *, value) = NULL;
@@ -1083,6 +1121,18 @@ bool eap_tls_common_settings_load(struct eap_state *eap,
 		}
 	}
 
+	snprintf(setting_key, sizeof(setting_key), "%sServerCertHash", prefix);
+	hash_str = l_settings_get_value(settings, "Security", setting_key);
+	if (hash_str) {
+		if (!eap_tls_parse_server_cert_hash(hash_str,
+						eap_tls->server_cert_hash)) {
+			l_error("Invalid %s %s", setting_key, hash_str);
+			goto load_error;
+		}
+
+		eap_tls->server_cert_pinned = true;
+	}
+
 	snprintf(setting_key, sizeof(setting_key), "%sServerDomainMask",
 								prefix);
 	domain_mask_str = l_settings_get_string(settings, "Security",
-- 
2.53.0

