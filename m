Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B891EA11
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:00 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id h2so14402203pgp.4
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5BVp7TOrkkbkapuyuqyANloReXrKYsVuuTSBHRDunE=;
        b=OWV61OlSrVbZTHRzWG0JkmzvYkGx//3UT/Aq5iAEFEJU/LAeIopn8vaFtaTW26J4Aj
         3N42bKjaOUoTkVwN6wl+c79jxpX/ZYuf05sgeAcAJkFKS7ZO5lRrt7VPrIGnh56VNyzE
         bd2MPoHDSzg98+rX/kG5KPGEYK9hXw738xiBgeJTrrXbXgGMydKqlvdFsBrqHecCEBJA
         xrxrfQx68n3wio7cO/LBV5SCZvC2Ml1Nvv1zH41+zj3M3QkFFy1bI1H/ec0Uytjpcat2
         UenWPs/goz/bQPNAJVe9uMYZhSGc+LBOtHsxdAPkGzMQLIx6L9mSEq3JfwU5baMjUWEw
         vAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5BVp7TOrkkbkapuyuqyANloReXrKYsVuuTSBHRDunE=;
        b=cN4X+Z6YQr+sti6NGSgsKH5B2RfST5z9ywM4FIlpzoa/G52VrVbus+Dl+2sOCLEmyX
         bxgafN4IrNYVDgYbvTjIxh4D4v5yg9frYALFAVK52KuQ/FA/vgiTzAu4bvZNQOsyw2XU
         RbDF96FZReyQ26tY3NRNPqKWLXUhtSlLr0lAzBVFOnhwKge5DFU/VM2pIwBOc/t+5J0G
         8GBWuhmDpb2LJEOdRegYqTW24ivlOq1+duE/DvmogoBdaTU88qZK1iJE52c0lopuQRhu
         9lsqNAUcjOr4dott6vEwglAdKHhR8HZ9Z7yXPD3D8Egds8JiDETbOLGXHgVfkXCDv8ju
         tclA==
X-Gm-Message-State: ACrzQf3YghhvabbGJGdU2rq+bo1Lmv+/IrCOf/Izh0rD2Cl1D23A+80i
	4cyjSMw8uUobRLhLetsFOKfKC3Dx3yE=
X-Google-Smtp-Source: AMsMyM432jYEn4kJPPvoehkyvFvGLrLVnrDUTh/RUJ4anxCV7l7Q1RA3LhqFoxM5oMvHH9o+AkqCWQ==
X-Received: by 2002:aa7:8189:0:b0:56c:f424:bbfe with SMTP id g9-20020aa78189000000b0056cf424bbfemr21439490pfi.70.1667333879858;
        Tue, 01 Nov 2022 13:17:59 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:17:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/17] client: add ap support for PairwiseCiphers/GroupCipher
Date: Tue,  1 Nov 2022 13:17:39 -0700
Message-Id: <20221101201747.143379-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/ap.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/client/ap.c b/client/ap.c
index 4ce727de..f444a12c 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -37,6 +37,8 @@ struct ap {
 	char *name;
 	bool scanning;
 	uint32_t freq;
+	char *pairwise;
+	char *group;
 };
 
 static void *ap_create(void)
@@ -51,6 +53,12 @@ static void ap_destroy(void *data)
 	if (ap->name)
 		l_free(ap->name);
 
+	if (ap->pairwise)
+		l_free(ap->pairwise);
+
+	if (ap->group)
+		l_free(ap->group);
+
 	l_free(ap);
 }
 
@@ -151,11 +159,67 @@ static const char *get_freq_tostr(const void *data)
 	return str;
 }
 
+static void update_pairwise(void *data, struct l_dbus_message_iter *variant)
+{
+	struct ap *ap = data;
+	char *value;
+
+	if (ap->pairwise)
+		l_free(ap->pairwise);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+		ap->pairwise = NULL;
+
+		return;
+	}
+
+	ap->pairwise = l_strdup(value);
+}
+
+static const char *get_pairwise_tostr(const void *data)
+{
+	const struct ap *ap = data;
+
+	if (!ap->pairwise)
+		return "";
+
+	return ap->pairwise;
+}
+
+static void update_group(void *data, struct l_dbus_message_iter *variant)
+{
+	struct ap *ap = data;
+	char *value;
+
+	if (ap->group)
+		l_free(ap->group);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+		ap->group = NULL;
+
+		return;
+	}
+
+	ap->group = l_strdup(value);
+}
+
+static const char *get_group_tostr(const void *data)
+{
+	const struct ap *ap = data;
+
+	if (!ap->group)
+		return "";
+
+	return ap->group;
+}
+
 static const struct proxy_interface_property ap_properties[] = {
 	{ "Started",  "b", update_started,  get_started_tostr },
 	{ "Name",     "s", update_name, get_name_tostr },
 	{ "Scanning", "b", update_scanning, get_scanning_tostr },
 	{ "Frequency", "u", update_freq, get_freq_tostr },
+	{ "PairwiseCiphers", "s", update_pairwise, get_pairwise_tostr },
+	{ "GroupCipher", "s", update_group, get_group_tostr },
 	{ }
 };
 
-- 
2.34.3

