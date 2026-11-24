Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521123;
	b=KLweocCi/LJf0Ns78NvVdpNyoJFasjUeHfv5MTCORQRspJUNR+CY+/jTwNbDvfgFlfgM
	 GaezA15h2hIylWhhN9h8MuFbp416qL0haS6K7JqURE3HQRAH6fyEOacCKHnWhna0E2VMB
	 CVKASei79hbnLyR/OSl0bVSJxRcMdRe5HppetmdFeDNb+4hwKqfn6PE1mMoh8fjhRG+0r
	 JZetkghdLWPfU+TNToDmaOanMQCuvqraIHbL4W/ln35y1fMf/1FVHF5wr32LlZNj2A4zj
	 SPDsbGTIuFCdqcYd3OvubGKw6l/AD9mejtMaGLXwYMlRibPJGSwnHhYU8r2TxIq5jgQ==
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
	bh=c2wn4tFGkr0873wLbiHmDxcLhI5Zm7QUj1dpUrgdeEc=;
	b=z+VFMZsMBna9WFQCU8KFiDfJhM1o22DZOHIdqGNthR2E0t4picEvgi41rKxMg13QbPoY
	 eUGQjurAiEvoo4elRCrXYfvF7DVZpvJ2z+VuEBKJ1O4I/7pj3L/Ay+mhuglDByEgTcgTu
	 8ExQCKR2wDNbmogzz1wppfV+gZKa56BoN6qGQZfYpDHFVQ0jND6UwgWXMiYc5LUy9yqdu
	 qpX7gKuHCavF7fxawiS/mvfWxHEziQ0GmWZlJhjEHhOs6ZqYs9ORx2ekg9qWqbfdRV9Yq
	 CsW4d/QrO4oL/CdZBd4dNh5BXxflMvK7D0w559JKDQuKsT2MGV+9npR0IverXu6gGFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=JSjGik82;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.82
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021082.outbound.protection.outlook.com [40.107.130.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D258606A32C
	for <iwd@lists.linux.dev>; Tue, 24 Nov 2026 11:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D258606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=JSjGik82
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSy9hlYOloQAItBV01FCAL/aQM2TX1wCUT/4011dIsgKwIGHBF9bLE0O/4vUm++otwSlXJ6wsMqiPwKi/IBSTfuGR+Ixwc2Lq195NjID4DOiSIRURarhetFp51koHHQqQXd3dIpBnQo1I1vyHGZ48V7RuY6NSj709v3uRexKuU4DJV6j/lbWOe/8HKuV/qh2nb/uw0fy8mHSfD23mlYaf26WJpkasNtLUDlICBzdcDJ3cPDcYdcM40W72WW6R0E38h/92IgyhgtfvB/vueVUKZ6GDFvYAZD6F5elN+DZw6rCkD3nJtXRro/whrqDUHcQIqq0QSsk4W2BOIU4eSfrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2wn4tFGkr0873wLbiHmDxcLhI5Zm7QUj1dpUrgdeEc=;
 b=hrnss6erkBV0DfhKFbZV1ieyCoajBLaOMQryVD2Ec0f7Ei5UY9l/WsqeIHlJ96TAVfCG80Voodww/o7CevrHkILkbo+mBHwimC6WLXFloie5Rj87ZJiJ7teuBt2zKmJh0ErMWVNsJeOBBQhF9uog//iWnR7qw0YiIPsyGyOf+aus5EXkekiuUOTSFQ1MEGMRu7wKPPbRmeceK1P7tjia6+p7V6yJcQKrZUU52mW95/guwfZ8bgqZ7pNA9f2GEIt7Bn4kgydxwUPeZDEG9LsD38EHhiaDUPx9nadjYvKIgSbo5EkSTyAY0q6SdwrGSqcTerUSH1WaFfVk6rGVW/MumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2wn4tFGkr0873wLbiHmDxcLhI5Zm7QUj1dpUrgdeEc=;
 b=JSjGik82kvKsxyEiynPTDCTqebH0K4KoS/S5R9G3HFdObXjfSTaIhjjMEUpg2Jc2qtXvAoXIIhFmR+N/Zvh69QHLhM1mC6411I/36C+WvFkejkUMQU1vgosKPNCj3hpxRSXeB7XvB82Yil/9JWXdvNXIj0VyNQ+JdhFDuVzKKgU=
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
Subject: [PATCH 5/7] station: add Certification signal
Date: Tue, 24 Nov 2026 12:51:44 +0100
Message-ID: <20261124115146.1281715-6-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::11) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 7b57dd27-2529-437f-de50-08df4a215762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|786006|376014|366016|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rlfX/edpyhR23zpfY2s68G/ITzTPoah0sTeYAXW3ObwapvCaIbZuOPOAyxIqXi51dXDddXeURp3h6FX95Ez3R3Jgo2ibkIpJyhTs9II657CC6Nf9GoJManhlZiiSYHTDpXDjnevbllpPkVFbFS6OHy4CWtIKMxM07RcjqUJ7Rm8A92AgbOSl0FIdzolRXHShCAxH/6GNLRVox+N+VV/HNWsc1UiaXrH7Mb8SbyiBs60v3tsenKXsq4FT7i00ltNhhYt56JG4kAX+pqifthKk7T5LtQmNVOcpjid1r2jOSNk0IZwrf/VYUL/50mdtlGLah2kP/uvgZ2dGt3vaavURBjldI7nFCyzEkhOb8il+h+rW6M9jO/pQO2aLee8TNzmB4PFP3tXb0wSZtrv63MaX54MVuc1Lb1gnKtlZWB6bwLF1QVWQdD8cl3likCosYkBo8LlnflwtyhzWkd1ocixE9NX0MLmXM2v/05cGkPHKbbGDC0FNIUiYhR3q1/LLJRQXVF5xJeP/WnhGLxlTfwvn4z77D7L11sJndWdYMHgiAJzQDm3+Pjyt9gmhzHapcwAeFiwvPHm4FTNULmwpK+h0s1WuRCuUpBXyZkSxqIRcbgKSPNY9kpmE+BZrGoqiBcUEncqb4hitnOoav99jit3Sn4Hzm4icWxtEjOVbTJhoVsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(786006)(376014)(366016)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OeriLlngJPSaYurXq/zUaehCZgQASqBXEAyz2GH6kupJopOyMW498eGZD5p1?=
 =?us-ascii?Q?BtfapewLqyY3PQfB7BfIw8KAhFBhCZ3fCucNM03HdsJ3XtAd8ulUS7Qgfsq+?=
 =?us-ascii?Q?5lG77GacFHfBy6WMF74E6jaQYQosdLk55X0nZM8S8DGEj1ETfQPrEjKIbUEw?=
 =?us-ascii?Q?bL1pcaw+n7xrx34WO3ii6oKAMeQjSeT6gNRCHY5N8Bs0G6MTg5KqfxzQQV9S?=
 =?us-ascii?Q?JE4fGvKJWO8QGicGAssApRp1SJ9KhbD77CIGd7T7iD9+lrR6n62+L3g9Fkzc?=
 =?us-ascii?Q?zJmuyc2cma6bKUcfoJ9N3iqhpZGpCxehWa4gOFPW4N3JD4kMAF+tT/KsKpvX?=
 =?us-ascii?Q?3k7p5WCwucLaInZC35R5/H2eT2s4woqH3FQXkW7oddTii+ICmOTiqJ5qRQ9J?=
 =?us-ascii?Q?evsv+Lo0quBFg+K53DW2vGTT+xuv8c0O7OWaLDmkxKIy/Pz6uDb6wJgvjzgQ?=
 =?us-ascii?Q?zAVKN3PjtDaFyAiJm8cwMXlJvb97prwc9wRqcSZWrhKVXgpWVaIRVQLeVgsY?=
 =?us-ascii?Q?vVnQsUCK1/otNinyYpqXLnyBPRM5L1Z+3QekLp63W+g60wB5pIkHsyoldDpk?=
 =?us-ascii?Q?UFOHHnCsJ92VYaDbm13iqXxnWPrSjcwWCLXQ9ql4qHIV+x0QLhgGcul63PKK?=
 =?us-ascii?Q?hSmUXoC9d9T6aFRBTdStS2CLEQmy7hmnj/LQchwC95gKoToylRG0SdGQotjL?=
 =?us-ascii?Q?9mewLDGFhq4zkT4GYVmwoSlsaBoxhhP+dbs7MzP686+RgTUCWYe247djA5AO?=
 =?us-ascii?Q?19LwGPcR9L6kDKROh5XF9ZFbOOMDibsFIXcZHAp28OKJdFYF3JwT1Vhfznl4?=
 =?us-ascii?Q?Zl3psjhhqtwMccnw+8KkwJt1D6FPKVStAp7a0f1ZG8aYVvT9arUD4Z/iHX9R?=
 =?us-ascii?Q?uGfUOJzomib+PxyOH0D8Nx9jZHxw/eY2gp6/cfN/NsEI4Smg7+wqu5a5DOo4?=
 =?us-ascii?Q?j3SnXB7ggRgH950A6ZyPxvcJN/yBnU0GhIypdJg3aLCQGYbUTEPUS1HSB9qI?=
 =?us-ascii?Q?ofzxH0ETSmt/2myak85cRn7pFsStLpppu2kjY43kWMAJmar7hzZTJIJCgSQB?=
 =?us-ascii?Q?G8JnH21BJkaXD7eB0jA1SULJ90sh5B+6aQ+OGUXQ9CiWpTacr0YcK98f2HLE?=
 =?us-ascii?Q?cHct/QLV5p+YXE2lVKQSYtkmoBjdV5Eo6n+GY/U2VV1AQZPnHn6+kBjsLvLI?=
 =?us-ascii?Q?vXh3i+auIDQLwS7OnO8K9oQfIMrDqhxoMgRxPc38x25EGT+WnlYEwhKbf7NZ?=
 =?us-ascii?Q?Yih0eHC7C/dbdGQ7NptPYlHNiM8XkXo5SjBK5zISAYzNoX8OtkwwXQfhlGTP?=
 =?us-ascii?Q?WDKKK6gIhe8Ea+Jv9gzIJxRmurZYRbEiBxB/YHvqQT6tlVBdcnnbprH6W65h?=
 =?us-ascii?Q?DdLmVCHYpWGUFErTNCENCEvXYICZT8slnd6Fiy5cJr/o+5FtoCkZo2WXFrRe?=
 =?us-ascii?Q?xsYES0N37p4W9OokUR8s3roEvA2mHh4vnF0nfDr/lPTJNsol73N0POvqWHMN?=
 =?us-ascii?Q?BKCcXPuVJCYtgV/t8tnMh49trkQdPlRDrjvVlciUygvZTpO+0evw2RhywrJS?=
 =?us-ascii?Q?ggOeyEl3VPFd/ZJMsfJud3mfPcLdhIslY10b4HkeWJVlUQ1oyCwK1AoKpd0F?=
 =?us-ascii?Q?ksSZo8mc9HbCerZW6kA7t18ZeNVT8Xh8qSd205N2Lz3Hd/q0Vp1i3V44U16k?=
 =?us-ascii?Q?+riMtQYBsohIh+UUpRs6vG4JcG0W39RY5dkWN6unr0YGrj8hqWVAQmPnwliI?=
 =?us-ascii?Q?NyBwMZdkZti93TOXeehbBz9bzeP3H0SSzhO6cHfZkZ7UzKIXqBWu?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b57dd27-2529-437f-de50-08df4a215762
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:51:57.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oG7hk+ju1pXldAhEUa+/NNyqr3DWD9dL7ct8pTwljLQwda8SwDaKTnLO2fMGdMWLeRH0B5q+l9kYRBXjwP/RXEtK+xeTQO5jGulvcU871MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711

Emit the certificates of the server's chain, as reported during
EAP-TLS, EAP-TTLS and EAP-PEAP authentication, with a Certification
signal.  The signal has the same name, keys and order as the
Certification signal of wpa_supplicant, so that network managers can
use the same code for both.

This allows a network manager to show the server's certificate to the
user and to pin it on first use (TOFU), for example with the
ServerCertHash setting.

station_append_byte_array() is moved up, so that the signal can be
emitted without a forward declaration.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 src/station.c | 94 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 20 deletions(-)

diff --git a/src/station.c b/src/station.c
index 8fcf8c70..c3579d34 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1149,6 +1149,72 @@ void station_set_scan_results(struct station *station,
 	station_autoconnect_start(station);
 }
 
+static void station_append_byte_array(struct l_dbus_message_builder *builder,
+					const char *name,
+					const uint8_t *bytes, size_t len)
+{
+	size_t i;
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', name);
+	l_dbus_message_builder_enter_variant(builder, "ay");
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i = 0; i < len; i++)
+		l_dbus_message_builder_append_basic(builder, 'y', &bytes[i]);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
+/* Same name and dictionary keys as wpa_supplicant's Certification signal */
+static void station_emit_certification(struct station *station,
+				const struct eap_tls_server_cert *cert)
+{
+	struct l_dbus_message *signal;
+	struct l_dbus_message_builder *builder;
+	char **name;
+
+	signal = l_dbus_message_new_signal(dbus_get_bus(),
+					netdev_get_path(station->netdev),
+					IWD_STATION_INTERFACE, "Certification");
+	builder = l_dbus_message_builder_new(signal);
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	dbus_append_dict_basic(builder, "depth", 'u', &cert->depth);
+
+	if (cert->subject)
+		dbus_append_dict_basic(builder, "subject", 's', cert->subject);
+
+	dbus_append_dict_basic(builder, "cert_hash", 's', cert->cert_hash);
+	station_append_byte_array(builder, "cert", cert->cert,
+					cert->cert_len);
+
+	if (cert->altsubject) {
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's',
+							"altsubject");
+		l_dbus_message_builder_enter_variant(builder, "as");
+		l_dbus_message_builder_enter_array(builder, "s");
+
+		for (name = cert->altsubject; *name; name++)
+			l_dbus_message_builder_append_basic(builder, 's',
+								*name);
+
+		l_dbus_message_builder_leave_array(builder);
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_dbus_send(dbus_get_bus(), signal);
+}
+
 static void station_reconnect(struct station *station);
 
 static void station_handshake_event(struct handshake_state *hs,
@@ -1187,9 +1253,13 @@ static void station_handshake_event(struct handshake_state *hs,
 		network_set_transition_disable(network, td, len);
 		break;
 	}
+	case HANDSHAKE_EVENT_EAP_NOTIFY:
+		if (va_arg(args, unsigned int) == EAP_TLS_EVENT_SERVER_CERT)
+			station_emit_certification(station,
+				va_arg(args, const struct eap_tls_server_cert *));
+		break;
 	case HANDSHAKE_EVENT_COMPLETE:
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
-	case HANDSHAKE_EVENT_EAP_NOTIFY:
 	case HANDSHAKE_EVENT_P2P_IP_REQUEST:
 	case HANDSHAKE_EVENT_REKEY_COMPLETE:
 		/*
@@ -5315,6 +5385,9 @@ static void station_setup_interface(struct l_dbus_interface *interface)
 				station_dbus_signal_agent_unregister,
 				"", "o", "path");
 
+	l_dbus_interface_signal(interface, "Certification", 0, "a{sv}",
+				"certification");
+
 	l_dbus_interface_property(interface, "ConnectedNetwork", 0, "o",
 					station_property_get_connected_network,
 					NULL);
@@ -5788,25 +5861,6 @@ static struct l_dbus_message *station_property_set_autoconnect(
 	return l_dbus_message_new_method_return(message);
 }
 
-static void station_append_byte_array(struct l_dbus_message_builder *builder,
-					const char *name,
-					const uint8_t *bytes, size_t len)
-{
-	size_t i;
-
-	l_dbus_message_builder_enter_dict(builder, "sv");
-	l_dbus_message_builder_append_basic(builder, 's', name);
-	l_dbus_message_builder_enter_variant(builder, "ay");
-	l_dbus_message_builder_enter_array(builder, "y");
-
-	for (i = 0; i < len; i++)
-		l_dbus_message_builder_append_basic(builder, 'y', &bytes[i]);
-
-	l_dbus_message_builder_leave_array(builder);
-	l_dbus_message_builder_leave_variant(builder);
-	l_dbus_message_builder_leave_dict(builder);
-}
-
 static void station_append_bss_list(struct l_dbus_message_builder *builder,
 					const struct l_queue_entry *entry)
 {
-- 
2.53.0

