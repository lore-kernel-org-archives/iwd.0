Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521121;
	b=GSerkuw4S5Yf+XAGmErgtzw2eAHS8VrNmQ9NkfCdoVf8LfKBrrJnSdJWC9kMJ5OuGrMY
	 M7EtFixK0RCRtk1boNet/6RV952jmKdPjjdMp9Bg9jwZhl9Y27lqFScyrvlZzVzadyE64
	 Gu/QcUkUW0e+k5WUS6dDTu8E2xjJWQDTtBSakHGRIR+EZyRiOZJKyd1OIHrkFV5DViyco
	 xCckERsVG77fCJSx1V4nQDrHrsdyuthkqC2lbrq/LaJy+w3GYF5SAnDI+fsCQGr5U0Mz4
	 ozbdLLYz0OMFvSdwP3oR5Vg44yYd3QCmH54hmTrtunBcydFoyekRFhiLxLtkI1lzimg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521121;
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
	bh=NUwa+5Bk8XUWpE/ZLDoKTBe3j23flAQWzHpC5xmu/C4=;
	b=ToDO0vrEYPP1YH1rXbuZUrlnRp8K5712GSsKcJ0ECyfk28oHFkvKBCfGEUW2F1ZwsO3l
	 o99prAhvUTsZ0a0dgre0dAZ9eT5+0KYidqAvA/lp+GefvrQzoLMerrK9CZFJdNUnW7lgu
	 YSqsOxn+TWreIM2Ms8nDJvQvHNUVRL+NHVKwhlbyNBBhupKT2VddVkvoZ7phVge16+MC9
	 DuuEJp/8FO6OrUqL1n8E392tGrhYn7DIrtruCA3CJxbD79ufmdZSqVL/bJi9ByGdQNjSG
	 zcADdTvyJuAxdu2czIdX2DGZlb8/x+LC+b8sWUgUGYzfch3+HB0QZ31q46OULWmTogw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=MT0XFXog;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.82
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021082.outbound.protection.outlook.com [40.107.130.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2D606A31E
	for <iwd@lists.linux.dev>; Tue, 24 Nov 2026 11:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEC2D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=MT0XFXog
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oN4jUiuu+oBN8qSy0RGseghp+s1SBDuqa8vvn+JEzlGfV3sHYiUuNd//x5EHjOdygVzMrQuXm1YsKz1AVTeCXJVKu0zBb7IX6J5uaF1OoPwmEpblQ9HR7Z2hxH+yI9zXMbKvN+RJALQkf0rModNe7mkL1FyoNcqJnQXDvo5FnAmxNtYvyfiPtiRxzp0khGjI8+d16LjUYLnnE53o4IVZ9/eP6dvDg4CYltT9GZ7DReryGeaysJMwZ0ur+zEsHsQ1wE7g4DhxfgxNrgWduvhKLKCdFsmbBlJ8caMLgoUaNwsnFp9FNRMbnzqtPPbIygJ8DvtkWtu8bPSEDpc7qxFPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUwa+5Bk8XUWpE/ZLDoKTBe3j23flAQWzHpC5xmu/C4=;
 b=lmXUvRLzMRE0IjMukzA6aU/RCq/Hjtco+oH18wgoKo50f6l766evFEzmXCwLolHV63SoU96hMxjSee+R3eSUkCXf2Q7KbBmmBAyvqgL2LI6aShRTbDMckdPIuxru1LZLz1gCCzCYAZVdurjeOTrco/gqUpknDdWbzCXlfSxJD9YYlXmKn2Q+mAWNIPGZ1ZBaEeYGJ+ag46RuOU7FuiEi+Ly4jxueaCNFXqUMSpjOPen6D1c9kzDaIgGoQzgRKCS+75zwoEJza5Wid7283yuOefNH3e66idHUcDqWzvmE+DMBXokIFuRAI9bwZ66ymE6DwBGLXP0NoTOH7Ybn7/Hk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUwa+5Bk8XUWpE/ZLDoKTBe3j23flAQWzHpC5xmu/C4=;
 b=MT0XFXogqxBBjDNO/xHwwbL1cKFRsHm1dRZz/Ly4lOWliR2+twml89rzul4tORUv3yKnYowqMAram0YygSY8zzGPt5DF7UGH367yDVw/1gac1SDJ9dk7S5lc05Y8X0fGKJvvDjoSczBBdWm9CNMJWb6VT7nIhpu3Me4J2DIW4Fc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI0PR08MB10711.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 11:51:55 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:51:54 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: iwd@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	prestwoj@gmail.com,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 3/7] unit: add EAP-TLS ServerCertHash tests
Date: Tue, 24 Nov 2026 12:51:42 +0100
Message-ID: <20261124115146.1281715-4-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::13) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 18eb3353-21f2-40bd-0e96-08df4a215606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|786006|376014|366016|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|22082099003|261009221227099003|261009223327099003|261009220027099003|261009221727099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GI0VdAqpfCk9mUNgiIqF99LX7IWcv2Y3YbguVuzFW37bzc0DBhzNZ3MscmdVHSvfh76NjybWVm+LgoV28d2qIzA329OzEDCN1U5tK+un5vtqHpLhj8bn6rGI88pu6yFGO4jqg36JO7yAxbKvuk3ZLa/p1St3/WJa5DB+ghEOKvA25jfLV95OdJojMyRx8QrLvPdYoDE/WjAw7KXwd2RNLvpX/DpsiOk9EZUTGnuemLOcJYcvRSPfxUaPW17bX5NT/+5RagpjN8Owy+a81DQUg83h9URLFSHHfTiMmvSZB2zHshM6a2EjJQTwU0ZglJAD81mRKklcWI1+iprSJTEP3CmVxDVb1Ip1mMcXVVXf55ZQtupNED2+iOpbMB3gpN2shgCU5wx2MBY4wXNxre6a/zVs0WRpPPbSWyInGNopKE+VD3EGer9YugvQP028+eNf+tgzRzdOecIDicFXcuXsQ4UxpImBxyl3sNlgzTKSUOAoVP3Amo3AvZ2K5Q0xnIm3acpJsw+rBSmCEzfbpwBGhFk6mLLGf6ZRUj7KIF5EUs3vzqmhZjN6raOWLymxRolNaa13qGdEcfy7529gJv48TMalOWcXah1QvJCkw/aWBi+EvDuCsI15c1goSoX//CnjS0wf6SLmXiL8z2GiQT7rJb5XO5CKQPsuDQLI4cFbeoM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(786006)(376014)(366016)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009221727099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5IZLCJv39v1Yrq73OIjbXPlP1zyV8ohAn6TZIODBaOqhu9ozt+Cx5nCVPhVv?=
 =?us-ascii?Q?vOnAyqMUDmljwvu+DxQNYHSjxYOdpwJXOddzEBvTfaUft+hHjRX0+l3pwcvo?=
 =?us-ascii?Q?OLV5C4HrblUcdmrsHwGk4VT5JsrU38vv2Wnnb8mOMT75Xfxr93KUZh2H9Xcr?=
 =?us-ascii?Q?dwEBFX4sRh7IGFrLBSb6Sl4xisLreIRHJ/id4fYsVCmcLUPRR545yXE3wTG6?=
 =?us-ascii?Q?xjJE7xxELjjocXYDCBFFqp8CMMudsUvmSBNqQN1bO5hlc41e5SUEYwGANpzL?=
 =?us-ascii?Q?IS8S9yPFRXcWo1F46sdNgfbRxt1W2X08SrzPMLj6A303q7Y8ZVeGFUdMLnEL?=
 =?us-ascii?Q?Qp2llHzf8CRhTvHDKoAdhjoRs82Xy7jvjofju8oNsDwlSiylhVR5QZv4PXdC?=
 =?us-ascii?Q?Rqk1bOVyW3Nycr98cy3ujCpqOQFfQyzexcz0ml/lw4r+yvU6f83B1UpDN3Z4?=
 =?us-ascii?Q?MUujdbrU/7K1yqlsEfadenN0du3m+3xBtd6GlLGZbxRCif5tQEv7USAep+fR?=
 =?us-ascii?Q?a1c8gzZ8KWx3STrGd1kGabL6IM2W7+jwjz8svAvCWJRePJC1S+eD9HPNbioY?=
 =?us-ascii?Q?amc3KZhsLZsm5fmqPk1vMzb/Qm3bhZ2D+6Zu8CthXfaNlurJuLza+rDfOh/T?=
 =?us-ascii?Q?cpSMy2BURUG4Y3vT+nQpzB5+d3pq3rcZ4+3tCVz07NJF9nGjRtRPIPpfeARY?=
 =?us-ascii?Q?yqOB0nX6A4XBTy2qc8UzgNbg0Y8mkkA0SBpXl3xdA4FRgr8s0OsDTJ+2KvHc?=
 =?us-ascii?Q?G2IC5Qfujaqqs2MgfGqmlJJkxjJH9Ol7V1teBkG/nBaIouMMQKg/Dnn6ZPbI?=
 =?us-ascii?Q?H/xYKdvlqvTuC26t9g93uPcFcUUIrTQDEXO5hzpYyOzLiJ0xK7mGw8o9G6Gj?=
 =?us-ascii?Q?jiNTtTB6YVWMUL3Hj6xAQXr3lsjsLhWDiD8CKCqQX3MdG+G4lXv9Db3wrE+6?=
 =?us-ascii?Q?YmoKr58EQpiYLBl+3GYpMOx8CeL4bwnEz3yOmvGHG80rx7zuml/48rLNUBao?=
 =?us-ascii?Q?0kaX7Vzce0/l5v0Cl6nkMH39p/Do5CyAcbuZwUbAnXjqafYVEXLDPFKbwled?=
 =?us-ascii?Q?QZY9A1e94svvhX1q5tguhBlNL5sHnSk6WpfIwPl9xhB95bovB+UpkXvmN0h7?=
 =?us-ascii?Q?+Fftz9gj5PdfuWz1ZsuXdkP1u9if3UhyN687uLxblj9YkJrmta9xzuRchz/Z?=
 =?us-ascii?Q?KQXTQwz53TgGAFdItBkiW/ZQOg0p2Nkhwc2Qjxwuqp0XnObEsMerbl8taOcy?=
 =?us-ascii?Q?tlikN62+lWnfmAOIOG/PmfZCJELbqut+hmVmxoR6/ijklOaRCce9RgdpdWCL?=
 =?us-ascii?Q?KOfA3jFPY6VxIo1N1V1fejBlBQ2TFumzz9kCDlNyT1WW/d7CgCxIDUi6vZYn?=
 =?us-ascii?Q?FSiBFC39rxnmTmrT6LjTAaTxtlIynaowr9LsLAbknre/L/CESkJRyaRE6G65?=
 =?us-ascii?Q?uy7C3uabHmHwuRQVX4kG9EoG1Ethqs+7IV9ETgKgNWjvjpMtd5mAwnlGu2n8?=
 =?us-ascii?Q?qoYVIKrYr/uE8j/HUCzgH5zhllzaWJi59YuWIiZY3YVMnRxZk5rzd6oj0hzr?=
 =?us-ascii?Q?+uzPegyTmpM3wcy++F2ldQg5U1nOAeGDms0GnFAgHmm2VM32MqfxE4HTHSYI?=
 =?us-ascii?Q?C9Z/EAMHtDFZvz/hQ9fJOHo5ld3JlRNt8NoEYrfhi5gKNOCXIWiYzHgV5q4b?=
 =?us-ascii?Q?qH1HbLzr0AkqcJryOPO2sder/MrguEvvrcLKUcWWN/FloUzmtt98jJJC5fZW?=
 =?us-ascii?Q?llYIm0CskenjgDN3PXY1lW4JHAtN9CYTdeb/olZSXaKxn8fFlyDs?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eb3353-21f2-40bd-0e96-08df4a215606
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:51:54.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQxmeGe/wIOWhzes43zuOVq9pSn86fpyKHQjMJ8S2g0WBQhgzroklsyn7G3MJmQKqKIdWtL2jztrLG8mM4LeKa36MsLq8aRffStnAPup1fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 unit/test-eapol.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 49f7aac5..b3c291c3 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -3240,6 +3240,94 @@ static void eapol_sm_test_eap_tls_subject_bad(const void *data)
 	l_settings_free(config);
 }
 
+static void eapol_sm_test_eap_tls_server_hash(bool good)
+{
+	static const char *config_fmt = "[Security]\n"
+		"EAP-Method=TLS\n"
+		"EAP-Identity=abc@example.com\n"
+		"EAP-TLS-ServerCertHash=%s\n"
+		"EAP-TLS-ClientCert=" CERTDIR "cert-client.pem\n"
+		"EAP-TLS-ClientKey=" CERTDIR "cert-client-key-pkcs8.pem\n";
+	struct eapol_8021x_tls_test_state s = {};
+	struct l_settings *config = l_settings_new();
+	struct l_certchain *chain =
+		l_pem_load_certificate_chain(CERTDIR "cert-server.pem");
+	struct l_checksum *sha256 = l_checksum_new(L_CHECKSUM_SHA256);
+	const uint8_t *der;
+	size_t der_len;
+	uint8_t hash[32] = {};
+	L_AUTO_FREE_VAR(char *, hex) = NULL;
+	L_AUTO_FREE_VAR(char *, config_8021x) = NULL;
+
+	assert(chain && sha256);
+
+	if (good) {
+		der = l_cert_get_der_data(l_certchain_get_leaf(chain),
+						&der_len);
+		assert(l_checksum_update(sha256, der, der_len));
+		assert(l_checksum_get_digest(sha256, hash, 32) == 32);
+	}
+
+	l_checksum_free(sha256);
+	l_certchain_free(chain);
+
+	hex = l_util_hexstring(hash, 32);
+	config_8021x = l_strdup_printf(config_fmt, hex);
+	l_settings_load_from_data(config, config_8021x, strlen(config_8021x));
+
+	s.app_data_cb = eapol_sm_test_tls_new_data;
+	s.ready_cb = eapol_sm_test_tls_test_ready;
+	s.disconnect_cb = eapol_sm_test_tls_test_disconnected;
+	s.method = EAP_TYPE_TLS;
+	s.expect_handshake_fail = !good;
+
+	eapol_sm_test_tls(&s, config);
+
+	l_settings_free(config);
+}
+
+static void eapol_sm_test_eap_tls_server_hash_good(const void *data)
+{
+	eapol_sm_test_eap_tls_server_hash(true);
+}
+
+static void eapol_sm_test_eap_tls_server_hash_bad(const void *data)
+{
+	eapol_sm_test_eap_tls_server_hash(false);
+}
+
+static void eapol_sm_test_eap_tls_server_hash_invalid(const void *data)
+{
+	static const char *values[] = {
+		"0123",						/* too short */
+		"zz00000000000000000000000000000000000000000000000000000000000000",
+		"hash://server/sha256/"
+		"0000000000000000000000000000000000000000000000000000000000000000",
+	};
+	unsigned int i;
+
+	eap_init();
+
+	for (i = 0; i < L_ARRAY_SIZE(values); i++) {
+		struct l_settings *config = l_settings_new();
+		struct l_queue *missing = NULL;
+
+		l_settings_set_string(config, "Security", "EAP-Method", "TLS");
+		l_settings_set_string(config, "Security", "EAP-Identity",
+					"abc@example.com");
+		l_settings_set_string(config, "Security",
+					"EAP-TLS-ServerCertHash", values[i]);
+
+		assert(eap_check_settings(config, NULL, "EAP-", true,
+						&missing) == -EINVAL);
+		assert(!missing);
+
+		l_settings_free(config);
+	}
+
+	eap_exit();
+}
+
 static const uint8_t eap_ttls_eap_identity_avp[] = {
 	0x00, 0x00, 0x00, 0x4f, 0x40, 0x00, 0x00, 0x1c, 0x02, 0x00, 0x00, 0x14,
 	0x01, 0x61, 0x62, 0x63, 0x40, 0x65, 0x78, 0x61, 0x6d, 0x70, 0x6c, 0x65,
@@ -4058,6 +4146,13 @@ int main(int argc, char *argv[])
 				eapol_sm_test_eap_tls_subject_good, NULL);
 	add_pkcs8_test("EAPoL/8021x EAP-TLS subject name mismatch",
 				eapol_sm_test_eap_tls_subject_bad, NULL);
+	add_pkcs8_test("EAPoL/8021x EAP-TLS server cert hash match",
+				eapol_sm_test_eap_tls_server_hash_good, NULL);
+	add_pkcs8_test("EAPoL/8021x EAP-TLS server cert hash mismatch",
+				eapol_sm_test_eap_tls_server_hash_bad, NULL);
+	add_pkcs8_test("EAPoL/8021x EAP-TLS invalid server cert hash",
+				eapol_sm_test_eap_tls_server_hash_invalid,
+				NULL);
 	add_pkcs8_test("EAPoL/8021x EAP-TLS embedded certs",
 				eapol_sm_test_eap_tls_embedded, NULL);
 
-- 
2.53.0

