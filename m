Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB04383BB
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226466; cv=none; b=hNu+ZyEgwCZYe/rUOBYqLEqjwD5ob3F6kIPUBgiRFqoIChWZp0vKjnEiehnwnTTHtg/7aByWpg4mnLSFhHta544Ql/aS7WCXzENxAh2nRCGnSIHiJAxGznAWHvOK6e1HBPof0mDXgmpQbYkY7SIR+zGZukVP/3Y8sXOBRhP3SRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226466; c=relaxed/simple;
	bh=tE1oPQWVihS3KgRcp0W7qjXXYgvg9I24Pc0Q3cXcVcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dlUiz39NWoZ/NOqC7QiEQykBo5Z1BsprkMps/U5k1ykT2VS0283gitmz/2guybaDo3whMz6Jjg1yFGyar7+p0XhuVCmBDiR2STeCvHfTq+jcmKMAcEoO375DoMJ//aCHUQmgyD1jbJ/zVIG78H3kpnK01iHAQE41e4kB1GTS91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8IAmtCY; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8IAmtCY"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-787a843003eso76958985a.0
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 09:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226464; x=1709831264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yf773ksS3tov4wwzk+sbY6n8l5P0JeUuOe0/KuXJYJw=;
        b=d8IAmtCY6nik40iix8NsWSyGN/N6kYCsHnlUgL/ajtfQcaW/3QOoswtUF7l0PxPws7
         9JwdnEQ9ATbEoC15qN31+fUGxJw9ub1teVs5aaWfruOnkF1igaZik0MromR4UeZdfdh/
         mZsNjBIUfKamxeJJwxiuBKPxtRsrzHeBNyz2gy9iE0KTmZ+CUcopE6mod8nxVuuazKa/
         Vmn4TPNe8bt6akRrvyitxyCLaPB2WV7n2phYLUW058bU+os5ulHvkwUFSZ+t0bGjQBv6
         OKV8RMrx12lLYkH1N4MFy62UjFpWGGYSZuQjwZ2FpJXxzLAaxbNhmD5kwO7FF6PR84bn
         x/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226464; x=1709831264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yf773ksS3tov4wwzk+sbY6n8l5P0JeUuOe0/KuXJYJw=;
        b=kfKh9og86RcBMIedRjtpngpdH/kD58RLy3GeJMVd6GL8CB/naw/h2eW1YNR2RgKoMM
         bmDhxYrVz0vySkD2jf6t29sSEShdR1BfwPSq4mLMAQAMQZ1jprRT7wWMrjxt3tGTKb8z
         Y3Y+OonjkTVowBlXZfhdjifL39Yn80ciSxvdJ/dThwttsZ+jfdh5kM7Ma25ZF08+HtM7
         KgyIzzwaBJo2u7BjLkmGSTrEN+FEZBc0m24GGuM4ipdfW19wF+RdBYCy+MMTEDu+L/U4
         VjDse+nWz4kWYQUjmqjbsvwmf9i16yB35KXflqIXDIXh2xv+dsoXA7YuUr/o/r230Xgx
         pDlg==
X-Gm-Message-State: AOJu0YwxFVotNJ8PwNK7GRM7LcJsxkqY0guQ18QSkfdUIQdiT0XncRdK
	yUeGBhg7cCG/fF/oqyr9j8+4O+w+tyO3xqrNo6qx6hj1y7UewTv0pcQlNPDY
X-Google-Smtp-Source: AGHT+IHF0xkLYLOgsw2XWbFRj69US14RZ1yYMSAxg/a7E2yb+nFf9zQ3a0waoJRFzmfAjHIKh0azqw==
X-Received: by 2002:a05:620a:2944:b0:787:fd70:77 with SMTP id n4-20020a05620a294400b00787fd700077mr2415119qkp.40.1709226463837;
        Thu, 29 Feb 2024 09:07:43 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id pj36-20020a05620a1da400b00787fd080d28sm697415qkn.74.2024.02.29.09.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:07:43 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] p2putil: initialize all parsing structures to zero
Date: Thu, 29 Feb 2024 09:07:33 -0800
Message-Id: <20240229170734.1498918-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229170734.1498918-1-prestwoj@gmail.com>
References: <20240229170734.1498918-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since these are all stack variables they are not zero initialized.
If parsing fails there may be invalid pointers within the structures
which can get dereferenced by p2p_clear_*
---
 src/p2putil.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index faf151a5..c90810e5 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -776,7 +776,7 @@ done:
 /* Section 4.2.1 */
 int p2p_parse_beacon(const uint8_t *pdu, size_t len, struct p2p_beacon *out)
 {
-	struct p2p_beacon d = {};
+	struct p2p_beacon d = {0};
 	int r;
 
 	r = p2p_parse_attrs(pdu, len,
@@ -797,7 +797,7 @@ int p2p_parse_beacon(const uint8_t *pdu, size_t len, struct p2p_beacon *out)
 int p2p_parse_probe_req(const uint8_t *pdu, size_t len,
 			struct p2p_probe_req *out)
 {
-	struct p2p_probe_req d = {};
+	struct p2p_probe_req d = {0};
 	int r;
 
 	r = p2p_parse_attrs(pdu, len,
@@ -828,7 +828,7 @@ int p2p_parse_probe_req(const uint8_t *pdu, size_t len,
 int p2p_parse_probe_resp(const uint8_t *pdu, size_t len,
 				struct p2p_probe_resp *out)
 {
-	struct p2p_probe_resp d = {};
+	struct p2p_probe_resp d = {0};
 	int r;
 
 	r = p2p_parse_attrs(pdu, len,
@@ -853,7 +853,7 @@ int p2p_parse_probe_resp(const uint8_t *pdu, size_t len,
 int p2p_parse_association_req(const uint8_t *pdu, size_t len,
 				struct p2p_association_req *out)
 {
-	struct p2p_association_req d = {};
+	struct p2p_association_req d = {0};
 	int r;
 
 	r = p2p_parse_attrs(pdu, len,
@@ -876,7 +876,7 @@ int p2p_parse_association_req(const uint8_t *pdu, size_t len,
 int p2p_parse_association_resp(const uint8_t *pdu, size_t len,
 				struct p2p_association_resp *out)
 {
-	struct p2p_association_resp d = {};
+	struct p2p_association_resp d = {0};
 	int r;
 
 	r = p2p_parse_attrs(pdu, len,
@@ -939,7 +939,7 @@ int p2p_parse_disassociation(const uint8_t *pdu, size_t len,
 int p2p_parse_go_negotiation_req(const uint8_t *pdu, size_t len,
 					struct p2p_go_negotiation_req *out)
 {
-	struct p2p_go_negotiation_req d = {};
+	struct p2p_go_negotiation_req d = {0};
 	int r;
 	struct p2p_go_intent_attr go_intent;
 	uint8_t *wsc_data;
@@ -1001,7 +1001,7 @@ error:
 int p2p_parse_go_negotiation_resp(const uint8_t *pdu, size_t len,
 					struct p2p_go_negotiation_resp *out)
 {
-	struct p2p_go_negotiation_resp d = {};
+	struct p2p_go_negotiation_resp d = {0};
 	int r;
 	struct p2p_go_intent_attr go_intent;
 	uint8_t *wsc_data;
@@ -1062,7 +1062,7 @@ error:
 int p2p_parse_go_negotiation_confirmation(const uint8_t *pdu, size_t len,
 				struct p2p_go_negotiation_confirmation *out)
 {
-	struct p2p_go_negotiation_confirmation d = {};
+	struct p2p_go_negotiation_confirmation d = {0};
 	int r;
 
 	if (len < 1)
@@ -1096,7 +1096,7 @@ error:
 int p2p_parse_invitation_req(const uint8_t *pdu, size_t len,
 				struct p2p_invitation_req *out)
 {
-	struct p2p_invitation_req d = {};
+	struct p2p_invitation_req d = {0};
 	int r;
 	uint8_t *wsc_data;
 	ssize_t wsc_len;
@@ -1151,7 +1151,7 @@ error:
 int p2p_parse_invitation_resp(const uint8_t *pdu, size_t len,
 				struct p2p_invitation_resp *out)
 {
-	struct p2p_invitation_resp d = {};
+	struct p2p_invitation_resp d = {0};
 	int r;
 
 	if (len < 1)
@@ -1185,7 +1185,7 @@ error:
 int p2p_parse_device_disc_req(const uint8_t *pdu, size_t len,
 				struct p2p_device_discoverability_req *out)
 {
-	struct p2p_device_discoverability_req d = {};
+	struct p2p_device_discoverability_req d = {0};
 	int r;
 
 	if (len < 1)
@@ -1210,7 +1210,7 @@ int p2p_parse_device_disc_req(const uint8_t *pdu, size_t len,
 int p2p_parse_device_disc_resp(const uint8_t *pdu, size_t len,
 				struct p2p_device_discoverability_resp *out)
 {
-	struct p2p_device_discoverability_resp d = {};
+	struct p2p_device_discoverability_resp d = {0};
 	int r;
 
 	if (len < 1)
@@ -1234,7 +1234,7 @@ int p2p_parse_device_disc_resp(const uint8_t *pdu, size_t len,
 int p2p_parse_provision_disc_req(const uint8_t *pdu, size_t len,
 				struct p2p_provision_discovery_req *out)
 {
-	struct p2p_provision_discovery_req d = {};
+	struct p2p_provision_discovery_req d = {0};
 	int r;
 	uint8_t *wsc_data;
 	ssize_t wsc_len;
@@ -1309,7 +1309,7 @@ error:
 int p2p_parse_provision_disc_resp(const uint8_t *pdu, size_t len,
 				struct p2p_provision_discovery_resp *out)
 {
-	struct p2p_provision_discovery_resp d = {};
+	struct p2p_provision_discovery_resp d = {0};
 	int r;
 	uint8_t *wsc_data;
 	ssize_t wsc_len;
@@ -1389,7 +1389,7 @@ error:
 int p2p_parse_notice_of_absence(const uint8_t *pdu, size_t len,
 				struct p2p_notice_of_absence *out)
 {
-	struct p2p_notice_of_absence d = {};
+	struct p2p_notice_of_absence d = {0};
 	int r;
 
 	if (len < 1)
@@ -1411,7 +1411,7 @@ int p2p_parse_notice_of_absence(const uint8_t *pdu, size_t len,
 int p2p_parse_presence_req(const uint8_t *pdu, size_t len,
 				struct p2p_presence_req *out)
 {
-	struct p2p_presence_req d = {};
+	struct p2p_presence_req d = {0};
 	int r;
 
 	if (len < 1)
@@ -1437,7 +1437,7 @@ int p2p_parse_presence_req(const uint8_t *pdu, size_t len,
 int p2p_parse_presence_resp(const uint8_t *pdu, size_t len,
 				struct p2p_presence_resp *out)
 {
-	struct p2p_presence_resp d = {};
+	struct p2p_presence_resp d = {0};
 	int r;
 
 	if (len < 1)
-- 
2.34.1

