Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521123;
	b=DBcFL7Zk7TT5YcQ07WQgRijosUtiq7Tuy21MOZAj5FR2OsMnQVQEjqAl9m3wDZmStgJ+
	 nSotpod6gU2vjC1lI4G/qivXEFxjpkfwUAw9xyFWoE/I525KnDhYodNnLtKMyilDLJrY9
	 Wrzgoz3Tov4G4P3Ihl9Vu6V7yj8ffzLgeqVgOxRzsa6yGNDG/T7AVddx0uZXNSnwGBRmU
	 6JxGj9PMqMfl2tdexR7gcwg4e65GH2hnEEX1do8u/KmNsBV74Wbil3W/D1oglUqOW4LKp
	 jC9qoCAEWoV0ivjpQ1N2iODnBb+B7zh23tHvZCqhnwD1rk5Lx6Gn2q86kg2jlAFqKGw==
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
	bh=/LCr5LBZtYEFL5/7CzGy3AExVDvLsuTojMolkKpW/p4=;
	b=WtAUbU6XGSuf/HTtikn6B1p/P2cXYDVgWvViICPjiib60RprJjZ5d3dGE4ltYq2XRMYP
	 nG+l5iE4msZBq2TUJMrFRE+bClXMZVocsqcfbqU/Gwrs1Ta8Kh7JtlmzIcD/k2vr1mRYv
	 0juNEj30/3C0N/LCKioc+F9ckNtd1XsdZ5PvpNygWiZAWOxm1KpAR8BHha9P6c4bP1YAB
	 J8fTwuhRdXT93ynEb7aWMGhQF5kYIesfbyY5HXphJL6E48AINq4LJyIuBxS3gTMC5wDI5
	 IYwQyGdSWpFYvF/qM9mHOnVwE9Qd1lCOxoVN1HbGWHxE23X2pj0XS/T2Zg3wQtEya/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=sfis1IJA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.88
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021088.outbound.protection.outlook.com [52.101.65.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96A606A327
	for <iwd@lists.linux.dev>; Tue, 24 Nov 2026 11:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E96A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=sfis1IJA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRr4ml6RsJbmMzcD4t5y/ayMr3jWd79BTQpJNWpUD5sYP6aYram5lcy/e17DDjBAPAJsoNrN2R+2mercusi12+AMbBbEKj4a3lnD7jXYPRKNvK4MoLTYPh0byJBWLy045s0N7e2ARIvjPW5Ixaix3vAqtMf82TfpXmInXNL0i7CRLjVShHlPYdYm/orXx8oJKEqvHCD3OfhHfW5zsl3eS62H+Y2lboFUiLvMt7bD8uj+zLs3rNvicp1mHxS21ZfiididQPDLWc/1t/z5ZZrmc3lxJB4ej6ZCc+zFG3xnLaSavNmQ7grN6N902/4pMMmg93S8EbT4A+chL5tRU1HYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LCr5LBZtYEFL5/7CzGy3AExVDvLsuTojMolkKpW/p4=;
 b=bgyB79URBM0/qZU6J45FjbMBwQE9NT5ic1fRynlwnN6P1cz20Uh2YMXCryrH4OIkjnRTFbKyFFRDYwhXMZESgVV9M7rHHOmR/KQ3eKenu86kf5WY5Cc/a6zyHT0X1LVGBDXGKwICZZRP1PV4/EX8jFV/EMgnqnvkwPw8yukB1OyYYEDkJHAytdHs5qjAWUi+qtVMKk1cuaHyUdBVCPjBJUdU/rIm0hHH/njogu/HyeH4/vp7B1G8xMctLfl8gvYEwd51lLJyeFeYlW+Fln19454K+C3zGsQZnFuk8RrHRFJU6D6CEheAqZVrDwd4DP0W7+B8AJlAisW/p9BHMfqkRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LCr5LBZtYEFL5/7CzGy3AExVDvLsuTojMolkKpW/p4=;
 b=sfis1IJABzxVz+E9FuU6ltB9Q2tFrCIB0vYyuEFg7S1fFWR8wga842ZsUMWwBuUDVnFYk4Lawmj9sW+uzh7XzP2y8MoHsk59oNQM1PR4X5egbq3J+C9j0TMNGhiS3zpR3ldcNeH1w9xhIExoJJ43hCDexqDSVQSEvak7pT6sjGk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by AS8PR08MB6616.eurprd08.prod.outlook.com
 (2603:10a6:20b:319::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 11:51:59 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:51:59 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: iwd@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	prestwoj@gmail.com,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 7/7] unit: check EAP-TLS server certificate events
Date: Tue, 24 Nov 2026 12:51:46 +0100
Message-ID: <20261124115146.1281715-8-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0014.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::19) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|AS8PR08MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 750e56d9-fd60-4456-49b2-08df4a2158ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|10070799003|376014|366016|23010399003|1800799024|10067099003|11063799006|261102123227099003|56012099006|261022105027099003|261026121527099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qcTeJghjHyGi9V+V05W/atviRlIX2j/8ARFhDQwsRD2vgfKBU+yESaNb97VKfdvBXjFBPdB3oeITAZZjG7X5t1O7BWRs0tJKLAqEXlYrzLMFv40yDDrM0eQ9yHeozklp+QUqdBYooeBUONg4GB6dz8F/lMgorHAGNE0mONiehrtTHKLBK7QVzNM09fU1cupAkArdiiLfKGuvEauzDFMW12m/8ILvK+q4MdgS+X1+CGkWUyHFR/3wPZmqW+wTdXMZ6MoIM43zqLOMmoN/l2RY9f0IpKjb+KOn6qkMEwbwfbFuK22IJXHk7In6hHzJGzm8TVs5X3jLBrmKjQEIaIKrdfKa9ReCkmQaMY0+5VF49fGf/uj5LVhQQiShD1+VZ3D9RPMHKEfkdbKT9az3Gs8WAIJfu4OvHd+1i3ipRs+ggYej0QNgf2Ds/1tTl6FszRm6sgylglRe8IZYKI4DzDEwTgamTBC4lvBOURHXzRt65fj7hDXbzhk+yy9BK/Plo/gG0y1W1tv/vVonhS7+ZWybIUNV0NZIOHHqJvvuRs4UwCyFg7buRCRWgA12GBr9SEjCjPV1K16F1QxWQ36nYUxMASlOuicvQkDfXGPUpJngUM1HzUDJmDORoGLBWqMKlAcbYdRvUf9nYRsZ1bggaXUjYqNNTh7dI9EXmSswqRSIXEE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(10070799003)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(261102123227099003)(56012099006)(261022105027099003)(261026121527099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?69JHA7GDK2Fh4Ots0BNFYeiP57AYnmVC9Bjok22RI4HwQXLyBjKKmH1bp+sy?=
 =?us-ascii?Q?Tu7wHk7vGWZZMY9phbP+GsB1oF7mKAvwAmJJJYqAfhoMIXmftsrsunjAQvX3?=
 =?us-ascii?Q?i2KTSRMxNqVMw7Lsc02Hw/K715Jo42c4kNKKJd6GgceMpD5M529gjl0zq/5N?=
 =?us-ascii?Q?7g6JvMnu5q7Q+qgrmlJ2mtdDtLoVbbiYkkmJxkeqWtudlTk8dn3vBb6mSxxN?=
 =?us-ascii?Q?j6GiK5KwmBOeVnYVtjrYgvELkU7TwXOWqIxri5Gat1x4Qoj3dt1mKHf6PFmk?=
 =?us-ascii?Q?NytwEEtZtoBK2AORBbzchIgYmEp2KDTODyibCWXyJsoqlgAAqNzmMf1+5T4b?=
 =?us-ascii?Q?c3Tk1pzXUJ0H3IFcc8Ae1WharS6fHY7d/v93bngANtS0wPbUdkMlBSHWWluO?=
 =?us-ascii?Q?NfHARqX1xfH61J5CxSIrhNa3p+1bs2QZ4wMAUvkIJ8/kfOrOJgQkRGs4C8M9?=
 =?us-ascii?Q?QIXsoO7IDcbCSqJfIl53Uq5YL0mTwfyK3x6qABFcirOULGKKBx1ktoQ5u85R?=
 =?us-ascii?Q?/8AwVVgJ3qaq0yKTCi95IY5TBpmVR1+dFhGJ6vNeCIbxm2ltG77NBpJWKGD0?=
 =?us-ascii?Q?rnLOONq24vC8R02i9nEX6fWf1aZYRqI4cFxHoMlXe2IKP9oqkjaQu4jn6VKd?=
 =?us-ascii?Q?wr5oUW6Zg7RthbggGV/Fjyn3AA+rCgS81bS4LBLcu4FUfapCWw4tJ6B7Dolk?=
 =?us-ascii?Q?slCqshs9uss/tD/KhvIJs9AJnmGYBCnT9gkrOPDm+2nrzfHOKLDJWjiqQS2x?=
 =?us-ascii?Q?7FugxYW5quVUUOMS/D9uPPkegh2mZA3DS8fR93PajymoqFgyVMd0+5Niw1zI?=
 =?us-ascii?Q?BlPOyCHV3pVoKcp/KWX75ywH6aFSTHOqo38oDOXB05OJrF3YduXwCY0aGxOX?=
 =?us-ascii?Q?poa9zcBDr73mmdUQ8CV0twDXZiDaMIR2deLG2SmNSFPAR3ZPMzX9oUIX81PY?=
 =?us-ascii?Q?dPywGBTbi3IcGDDKjdOwkK80tSDkOYnus3/NYO7EFkhqDm2C1fWAiDs4eYYJ?=
 =?us-ascii?Q?6OQnAgaMKEl66ihm6+9MocMSWD0jOr5fB9QsnHZ+KzdiQfBnrMu9o5y4IZHj?=
 =?us-ascii?Q?5bM8bkviNv7JqC3lSVVxrKz7udw9Z+icHcB7ygcXt9ZjuiGDXIo9s0qrT6DU?=
 =?us-ascii?Q?kN7OtoDYiqehs4qovRcSXr62r45qxl4GBM6RRZmKjOV/F/22T3hdL3P6fekw?=
 =?us-ascii?Q?kKGdymVXyDnnXjE0Yqyn31Dl8LuuSFQVGHNk8Gw6nk3T8tU8050xzwd/K02i?=
 =?us-ascii?Q?16mZJ61wUqwlJJKTpWJ2L8kJxNDVOetTvaw/KHCTsMEItKRueX4O0juk0Frf?=
 =?us-ascii?Q?b3KY0z29QBRL/2eVktjvo1zABKRCLP/NtN+oNqGeIr8lGv0/RYyeQP2gQb2L?=
 =?us-ascii?Q?AufDym25uNVJ84LfOsETHYjq2v5Wsj5nc0wljCg4XwhproY4iMQ+3VMrLlON?=
 =?us-ascii?Q?6tFL0b7q3vWanA7hOS2lVBwSdPDzGQEkrovBeowRLtJm4IroGZhW+w/RueaS?=
 =?us-ascii?Q?jf6oCizyhzjxZvAQMqJFk4n+A5Klo+GSIFrRT4mQUhz0aNe+512MoWwDEEQs?=
 =?us-ascii?Q?QS289l4Y/T1xJAdE5twa2WjEO0hDzf3492eRsadBir8UDqCOcSythmUmXno9?=
 =?us-ascii?Q?bUH7xt4tb2eMqJxMuLp0EoBKDCTjhO956wiqcP+1xSer89GDvZ+ZSh4wLImA?=
 =?us-ascii?Q?feuPlFDVDIYFzmocrDdyOCGbLQSWIlkSFxNn6+HjeEBYJH6TaSyTwEKn5eSe?=
 =?us-ascii?Q?MP01+9hunaWMlnbm+KUgd5WOqscEqxKf521QnFasEjT4POa2bsya?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 750e56d9-fd60-4456-49b2-08df4a2158ce
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:51:59.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0Aq+XK2xS+lMcdHFBE1Xvyt4TH917XhCaSQd691NzdOdzL89KZHqSQB8SpeqJGhNx6D36SAlMy+SUwiD9cInFj+kugvCJU9qB5Gl2fMCmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6616

Check that the EAP-TLS handshake tests receive a server certificate
event for every certificate, that the server's own certificate comes
last and that its subject and SubjectAltName entries are correct.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 unit/test-eapol.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index b3c291c3..b8ab1164 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -25,6 +25,7 @@
 #endif
 
 #include <stdio.h>
+#include <stdarg.h>
 #include <string.h>
 #include <assert.h>
 #include <sys/stat.h>
@@ -37,6 +38,7 @@
 #include "src/ie.h"
 #include "src/eap.h"
 #include "src/eap-private.h"
+#include "src/eap-tls-common.h"
 #include "src/handshake.h"
 
 /* Our nonce to use + its size */
@@ -77,6 +79,7 @@ struct test_handshake_state {
 	struct handshake_state super;
 	const uint8_t *tk;
 	bool handshake_failed;
+	bool server_cert_seen;
 };
 
 static void test_handshake_state_free(struct handshake_state *hs)
@@ -2878,14 +2881,41 @@ static void test_handshake_event(struct handshake_state *hs,
 {
 	struct test_handshake_state *ths =
 			l_container_of(hs, struct test_handshake_state, super);
+	const struct eap_tls_server_cert *cert;
+	va_list args;
+
+	va_start(args, user_data);
 
 	switch (event) {
 	case HANDSHAKE_EVENT_FAILED:
 		ths->handshake_failed = true;
 		break;
+	case HANDSHAKE_EVENT_EAP_NOTIFY:
+		if (va_arg(args, unsigned int) != EAP_TLS_EVENT_SERVER_CERT)
+			break;
+
+		cert = va_arg(args, const struct eap_tls_server_cert *);
+
+		/* The server's own certificate (depth 0) must come last */
+		assert(!ths->server_cert_seen);
+		assert(cert->cert && cert->cert_len);
+		assert(cert->cert_hash && strlen(cert->cert_hash) == 64);
+
+		if (cert->depth)
+			break;
+
+		assert(!strcmp(cert->subject, "/O=Foo Example Organization"
+				"/CN=Foo Example Organization"
+				"/emailAddress=foo@mail.example"));
+		assert(cert->altsubject &&
+			!strcmp(cert->altsubject[0], "DNS:foo.example.org"));
+		ths->server_cert_seen = true;
+		break;
 	default:
 		break;
 	}
+
+	va_end(args);
 }
 
 static void eapol_sm_test_tls(struct eapol_8021x_tls_test_state *s,
@@ -3138,6 +3168,7 @@ static void eapol_sm_test_tls(struct eapol_8021x_tls_test_state *s,
 	assert(verify_install_tk_called);
 
 done:
+	assert(ths->server_cert_seen);
 	__handshake_set_install_tk_func(NULL);
 
 	if (sm)
-- 
2.53.0

