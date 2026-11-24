Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521122;
	b=r/m7nVILBLlNzwRLEGF72E44upogPbBwusSChTdHag86IOX42Bwt9J84u9GduLTdJhAg
	 l//slA+dGew601oTReR+7YKuP+oDWMvL+Fr//HiW8coufxcQeCqS71rvbmryith2Okh7u
	 F4G/cFyhXhdudtRQoITjfHczCMqHTuyBpV0mURpCffn2B9QRG0wuUogxmjCdDY896R8B8
	 Z9NABv6wep9kz7xStifaKoHtXE149i0oyHke/twQyvsGnPxmT8EduCBJJW2nQwPpVCwuy
	 E8A/xG6JOPXyYb1ktOk4gapsEN0PBBJ34oArczWlf/QDhFL3rijwqnoBAr9BRQBn2IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521122;
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
	bh=Cn4kMwp5bzfORbT1hgf9tbHxFfpZv9Z5e2MWm+aBl5o=;
	b=ZOjUmcOHE38gWo/uBb1fidyDA0czcwaFbbw6KhTXn/7gUjPbCdYUu4YJuRh521+95QqX
	 pQSPY/tUw+lr+f5zPiagisk21M3NdNxZ8dfbpV2G96NkVv/pwSDmdGjPf2eNi0Akcb5aD
	 rGhrZkUoZQkWg3vGYobETcxY2wBpMkJSLBEpkVNwoLhOWJ9YH4P4pU5zCdfnWr1JpOzDf
	 +CzWvaXcJhuw2rajhM14mW9t0KQXtIe8bbhRBDnk5ytaIlNmZAnEEV5m5Cdi/rDZTD9Nd
	 Fq1t8F+MdB8/PqSnLLHuFcGcv0s2uLDkep8hc/xgpVK1cE8EcTU6bOIBWeXVZdhtK4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=F2isDaFs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.82
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021082.outbound.protection.outlook.com [40.107.130.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C5606A322
	for <iwd@lists.linux.dev>; Tue, 24 Nov 2026 11:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA3C5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=F2isDaFs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg7Z545owe9RDx+M4Q8sQCTpTbTH/zTABJv47pqVg0BdZDF0L6wmsYwv/CMX/frtg5bwbUU7xeV4hy8poCbyrWe3+71f9wUTvZyLFsaJSxr/wyNfIE2KKs0XcTF5IMlYofInwNty0uMwYBgcy3zjf8BL0hDXEBgSgKC7HvrYHLwYq5AJY8dwi26/MUark0NDaGDGO0ul//MtUYb6dgrsuQzLaHVcD/YLr2N5HWwivhu6JIOxpB+O77UqpGcZ6vi1t4USUzDtPQnOyuMd2f/+1zA2wO2bjrqYiFw13ymXwxoTwRe+oozq04haXdcAVTvDI3eHuMHQXbZvAa/Z9QLWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn4kMwp5bzfORbT1hgf9tbHxFfpZv9Z5e2MWm+aBl5o=;
 b=IlhvkGoy5XLIBKs5EkYcEvHPNyld08E46cxWUUHWhpWQnYbiv2EVPrW/GEUGQScDegth6u//Ay1UpubW72iLTn0wiuwSRn6aNV7zi8iRm00TlWaxwzh/KAAp1LtnSP75fhbJ6UrjCLvkDScPWbDmwiCLc+SD9lZl+Wg8UGTdmKQHiDMOap1ZlbEfJvBisU74BnfdZH2ZqcSMxsY8mVm+KI8zhQWI5XueV5gdftY6Hf9TOYI4EVWfj9RgOcuXyEUmCZ8exWPmNXRdwWu88MzuSIcuXnVWp1zag7wvy9ozlhZR3LcIWZBWGAbQZeCeu58AbDYwjZVYSNqJWip5rX1WPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn4kMwp5bzfORbT1hgf9tbHxFfpZv9Z5e2MWm+aBl5o=;
 b=F2isDaFsD8BHfwVFp7Ysva6EVKhNM/G4W8CqeBu137ObuyCE5HbdXmzTTWa1Ns7koMVmsZ9KYd7kgR30B44hZn2HaR+HfGypWQBlwRbDj53NVxdjxgTjm/JjZ8Z1kdYiRTbyk70IqkNcAu1ypel6xWZC8zgfQvS3+fWrT0YVq8M=
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
Subject: [PATCH 4/7] eap-tls: report the server certificate chain
Date: Tue, 24 Nov 2026 12:51:43 +0100
Message-ID: <20261124115146.1281715-5-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::20) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: de5aa53d-fa41-417d-dcd6-08df4a2156a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|786006|376014|366016|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R0zLIHqQB82RAWQyKnjX5eXeQyHlM8cNbYR3WzZysnQ3rnNAEC55urxRSKOJpEp5/sS2FC3uUCNYfRqcCFq4c94uBIhAKLabVN5dc0ndkhUaWCmxKMl6CAI8O0Yzh8XjAFx4XgkeIn3ExZulBxXaC1U5I+sGg1LJY0XZCJXoX0nZtJdQIiaEDKewObDPVGJxjDISjG5cO2EJvfqMbXorOwWuAXpcEGvOU5/SxaEf/x/0Vw9DqhYI56hSrPxDzMfTdJ4L4pJCD6jWgLvaoDTT5AKwlzhM8g8JtE93UhFKSLasnHH5cteCUcONU8Q+E/7EBdvX4C8kspUXwq41Xy3MhuQu3xEM+ZzVszWpRfkhFzEVnpCu2I1TkMALiUw34EalcUaJp6HdDB/XiXoNn+ObtNm0V6kNWb4TeMA+/bSTCLZ03v87NPC8ZgmGTVmY/4cuUm2ajKayk3ox/DJrApOlmkJTleQPg5UegeYAR9WIS80TlBi66zxNTHMCG7IjIID7V7Z3xgPKzXQnw4hUxdlCzHAqEPREsf0jBusu65AeqSdGqZ8mfE5MF/jqgnt2DiOdqlTaZjrb4KVWky8kysv1LAjfdltQTDPF936mH2fI+H5DMtv2UpuzTR+MeJMhf9VKmriBw2zwip/x91sX7U5LcELeKlZUtm1Uitks0vh4P5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(786006)(376014)(366016)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2uzAWjDGoAtwkIrPstm6O3+K2FC2AJk7a7R318q8FsS/zTEiVGJAa1epi3t/?=
 =?us-ascii?Q?DUS3pBRo/wh7Az1698aO+M0g70Eu6Ff5sYgM7ANQABaKJhao+rP7sz2bLrNN?=
 =?us-ascii?Q?oZRZiR3OOckk+14jD+AlyNoDeLDiu2b/i/XjMFjQnx3LU7ty2YmcJXvBm0Ub?=
 =?us-ascii?Q?oEDvqdpC9Bn753pK4R2JUgwffqY3WqMouK/YEgqE+Gl8rrgRQg4aQu+hIA3k?=
 =?us-ascii?Q?kbnhXsKmaD2cDezhLPE87yNR5lwhB+aYgLgN4roqGTuAm9S23O7oJf4uW5b+?=
 =?us-ascii?Q?0fvCpmqP+q1wAgAK7r75bH0lVADJ+S1kSsb+z+kPKR6dwBl4Sh5IcoNcCrhI?=
 =?us-ascii?Q?kEHvcn4bN9tcBXw8VRiXD5cNd5wB3jeNyJTMCAXB8jgAruRuYvgAETF0xuC3?=
 =?us-ascii?Q?6nKmnMt4q9h8cIzPIin/BkXtAgB8asvl4sx+FsX3XXJM3TZSWjb4fY9e6Xto?=
 =?us-ascii?Q?fIQPx9IG7quDQEYR7aNzKkWCi5pShnA8O86EiR9crKNgjGFok4cQAkpVY7Yn?=
 =?us-ascii?Q?dCz3R+CEq568xXOBZHXmuJsmucyvBAkDFzT9uxbSB8aO4gtc4kTbY4P1kZ0D?=
 =?us-ascii?Q?J56pygAce0p7OTy4vY/Rjx9BikBhzh4ob/ghnb5SaE5ZoRO6cduOmH/2lSXn?=
 =?us-ascii?Q?oASCV3r7fTdGl9+V441faJBbKTM3YESJTeXAYnPPmoZsNicnqzEK9mwJbC4G?=
 =?us-ascii?Q?zemZoNmPza4vMDeRE7pJk2GH7818Awfso+hUhsB6kvNp73EkybqyfNiLZchG?=
 =?us-ascii?Q?hmFc2cBDb3ohSOuOsn20JaIEmpxGsbR1yIUPFBHLi3b+VBGx0XhF2b7LGiDz?=
 =?us-ascii?Q?pQp4q5Kvh+2ch3ImX+/Xj3mprB83C47L3M6l6dgkdTzL5JPu9s2Lo9DEp4O5?=
 =?us-ascii?Q?1rGp07pWQ8xydJSSXLzbSBsMMt8SmcJMsNeC/qejZ623+8iGbiOJCrtWvlU1?=
 =?us-ascii?Q?ZBhWUbmj4aZlit41wGZIabNzP12uimjceeUMNG8ASVLfxrPAImkpbq4+1Fjm?=
 =?us-ascii?Q?Kk0gy5+v6553Hoexx6jhfkASSJW2IYUHLTUTim5GFz9KksGQcUCDJVpxIvIp?=
 =?us-ascii?Q?k3KrVdGRwQ5DPYRJEeZmVe/n5w5JOamwcgt8TS5xu1RxHPe3d3HvOYrVUAc9?=
 =?us-ascii?Q?4hGfC3O3T9M7AhrMBdkB4Dd/AR1Z4E1QAZ8zZlgD8y6YaSLmgvob+5ackT3C?=
 =?us-ascii?Q?7++LROfxXYMusIIEnMao8mqNvazhX9+pGrPSfrKGaPxP7YBKJJw/adxiMw1R?=
 =?us-ascii?Q?gXn00Yqo6HFnlHeNI4KLTFytqj10HxJ2YSAclc4XDs6q9QrhNCJMzecZPfJr?=
 =?us-ascii?Q?/yBtldJfXXKXajWIhyYJ5nLw4U0ebaRje4WFNPT+5wemdvmRPkWgFgM/Nuxr?=
 =?us-ascii?Q?o9nCxfWboKprkuCwRe14Lz9dN+uJjr1xUfz9SCyPL1Bof/r3FN9w/a6r49uH?=
 =?us-ascii?Q?0T3Z3deqweiurgkvEt/f0kQGxEOvC/KLLDNVst678TfSWSL/OcDipI/ePK6o?=
 =?us-ascii?Q?oLl4SWjhfkMpkK8dO7q760dxXYgUvYCDe6iQZQ7o0XWJH05vvGQ6YeAVmPWg?=
 =?us-ascii?Q?3vWFd5c7cf90xug6Y4c8/sbb4dR+1WIH6nrjXRgqXXftYfuREDw6osRi12lT?=
 =?us-ascii?Q?ZL5jyTrUT3BZC47OVgXZ2T0rDzL6y6PBDqvIj6ADoiF97LTFmnZxEZ0/MTiQ?=
 =?us-ascii?Q?jLIiE3s2VNxsu6FXjIJ7AbclLscD41Nl3Nkh/mxH2Cxi2GV0YVvnv9x/VUYM?=
 =?us-ascii?Q?wTsAzJg+Vf+ZFdBI5P0HtgPCVVVJ4yAKBWZmlq9RwTEBeYB5WGz8?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: de5aa53d-fa41-417d-dcd6-08df4a2156a6
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:51:55.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnV+WDnfl61qQqvh4POMj231jOkoxt9EZWLVExu5biBH49xA+fl7LCZUHfvIoH1P2fFCGBafIp2yrZk023wSiGgfmDSw6Riww2lzOK5cJeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711

Send an EAP_TLS_EVENT_SERVER_CERT event for every certificate in the
chain received from the authentication server, from the highest depth
down to the server's own certificate (depth 0).  The certificates are
reported before the chain is verified, so they are also reported when
the verification then fails.

Each event carries the certificate, its SHA256 hash in the same form as
the ServerCertHash setting takes, its subject and its SubjectAltName
entries.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 src/eap-tls-common.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 src/eap-tls-common.h | 18 ++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index e7c3cb17..f34f892c 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -260,6 +260,59 @@ static void eap_tls_tunnel_debug(const char *str, void *user_data)
 	l_info("%s: %s", eap_get_method_name(eap), str);
 }
 
+struct eap_tls_certchain_walk {
+	struct eap_state *eap;
+	unsigned int depth;
+};
+
+static bool eap_tls_count_cert(struct l_cert *cert, void *user_data)
+{
+	struct eap_tls_certchain_walk *walk = user_data;
+
+	walk->depth++;
+	return false;
+}
+
+static bool eap_tls_report_server_cert(struct l_cert *cert, void *user_data)
+{
+	struct eap_tls_certchain_walk *walk = user_data;
+	struct eap_tls_server_cert info = { .depth = --walk->depth };
+	_auto_(l_free) char *subject = l_cert_get_subject_str(cert);
+	_auto_(l_free) char *cert_hash = NULL;
+	_auto_(l_strv_free) char **altsubject = l_cert_get_altnames(cert);
+	struct l_checksum *sha256 = l_checksum_new(L_CHECKSUM_SHA256);
+	uint8_t hash[32];
+
+	info.cert = l_cert_get_der_data(cert, &info.cert_len);
+
+	if (!sha256 || !l_checksum_update(sha256, info.cert, info.cert_len) ||
+			l_checksum_get_digest(sha256, hash, 32) != 32) {
+		l_checksum_free(sha256);
+		return false;
+	}
+
+	l_checksum_free(sha256);
+
+	/* Same form as wpa_supplicant: lowercase hex, no separators */
+	cert_hash = l_util_hexstring(hash, 32);
+
+	info.subject = subject;
+	info.cert_hash = cert_hash;
+	info.altsubject = altsubject;
+
+	eap_method_event(walk->eap, EAP_TLS_EVENT_SERVER_CERT, &info);
+	return false;
+}
+
+static void eap_tls_tunnel_certchain(struct l_certchain *chain,
+					void *user_data)
+{
+	struct eap_tls_certchain_walk walk = { .eap = user_data };
+
+	l_certchain_walk_from_leaf(chain, eap_tls_count_cert, &walk);
+	l_certchain_walk_from_ca(chain, eap_tls_report_server_cert, &walk);
+}
+
 static void eap_tls_tunnel_data_send(const uint8_t *data, size_t data_len,
 								void *user_data)
 {
@@ -653,6 +706,9 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 		return false;
 	}
 
+	l_tls_set_peer_certchain_cb(eap_tls->tunnel, eap_tls_tunnel_certchain,
+					eap);
+
 	if (getenv("IWD_TLS_DEBUG")) {
 		l_tls_set_debug(eap_tls->tunnel, eap_tls_tunnel_debug, eap,
 									NULL);
diff --git a/src/eap-tls-common.h b/src/eap-tls-common.h
index bfc23c08..722f7fff 100644
--- a/src/eap-tls-common.h
+++ b/src/eap-tls-common.h
@@ -23,6 +23,24 @@
 typedef struct l_settings *(*eap_tls_session_cache_load_func_t)(void);
 typedef void (*eap_tls_session_cache_sync_func_t)(const struct l_settings *);
 
+enum eap_tls_event {
+	EAP_TLS_EVENT_SERVER_CERT	= 0x000d0001,
+};
+
+/*
+ * Sent once per certificate of the server's chain, highest depth (closest
+ * to the CA) first and the server's own certificate (depth 0) last, like
+ * wpa_supplicant's Certification signal.
+ */
+struct eap_tls_server_cert {
+	unsigned int depth;
+	const char *subject;
+	const char *cert_hash;
+	const uint8_t *cert;
+	size_t cert_len;
+	char **altsubject;
+};
+
 enum eap_tls_version {
 	EAP_TLS_VERSION_0               = 0x00,
 	EAP_TLS_VERSION_1               = 0x01,
-- 
2.53.0

