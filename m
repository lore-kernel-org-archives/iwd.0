Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896FA185E7B
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477589; cv=none; b=jjeEE/n32E7tfGavvZuhUx8WQ+5e22FT/8palKBZWiGo2TKq5ftUOWKk1x1TRhqploG4iLKXkC8sYfl6AVMltSL+IpxZ5Xg4n6m36ITzkfhBAPTzAv25+/UJbKB4SDGNu17VU2Ta6ZgdQhxzjJZsjeXiY7pmKlg1RjWHrWzSX30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477589; c=relaxed/simple;
	bh=vd+0BqQGeL6d0wePw8NmZkbxGlTy6GR6pLjRff/+NPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QMOgEIuDeg5mFuzP6grJpWkRfXburthVu+byOA9EyrUga8HDF8EyTXt5IKHnqhylEZxuBXHVzbBMstMdFW2xJxbLePXIUEkXIDTYpR+G+Hsj2zL3w5jDAmfEShu3losDkG5/oKiBKkcMlcvssNzYnUCpjft3s8yflSVLBwP9Fw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/IlqC8H; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/IlqC8H"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so581662e87.0
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477585; x=1724082385; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puoGti0I0USP52+eg3CGOIm4RrSQTQJscRkup9urEAE=;
        b=J/IlqC8HKAAtQVAUQ94kVPI0wQj6ObHwFTXzejEY/aIdagVGujiFELb5tA4QJnty6b
         XlyIc0wJIUUF18fM5YWhj5hlo1tYkQiekcUj48Qzt0ooMLOB+0Bpe864J9uUS5ay2K1J
         pPT1RHAQWHFDxoIR3deY+CsbunTVm9gmJU2NZeqGfJFGc+kKYlXF22ZD+YXoYWV3aBO9
         0JEhCAMnZx71KMpAPdc08gF22QNu3dXmYjEfBEbUPoOsuiPh0zGyHR16vRsfP27IAPNH
         2HFPjJcwauY6mGZOsVHeB8UT5T8kGwFuZm82QyqEgC2T/N+skP8uaQC5Nt+aieaZ/mVx
         MOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477585; x=1724082385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puoGti0I0USP52+eg3CGOIm4RrSQTQJscRkup9urEAE=;
        b=BmXAi3+FI5CKRXGLVI2gpKEV8PiZ5Boj4GmzVNd41FfXQLt+REmdJ79Az3n/IPDfRg
         p2wUROJYlHxQ0w3wVVeCMwLxnCPrh+0+6B4f8lSm5wuWs1SROp+wXJH60j7t+TpYE1aQ
         LHOpdrRRiMQAji6fMbPZq06Fg80g/nATVXWgxr0OslWZY7I3WdutzPtD435suZY0MYDV
         X8y2GzSCNjYsScMv3uEN/W2n0hcb1bXe6MDi3TYUUTVXPNSBv6s0Zb9csIErKjMR27m2
         8pdDviBp/+ln199TWLzMXtNYDuOKqkwPAxeU7fIPYwuRczK13uUS6fynjlnJioM2IHg6
         51zw==
X-Gm-Message-State: AOJu0YzZpJotB8n/hzbuOlWbsRghBkuZltWWmGUyRXg4wGLpfdiTknZ6
	HeRc4794uzrTLbNiE9+Hk6EbunfOLkQGT6t96E8UgFLlVO8kJYNGRxWIqw==
X-Google-Smtp-Source: AGHT+IFg6KYFvKIhSLTuW00DeOCF0NRlL7OeD0W3ReaTYhJgrXefYCtQjPd8MBp54vITpKgcaintfQ==
X-Received: by 2002:a05:6512:b22:b0:530:d088:2348 with SMTP id 2adb3069b0e04-5321369714emr371626e87.54.1723477584904;
        Mon, 12 Aug 2024 08:46:24 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 04/13] network: add ExtendedServiceSet DBus property
Date: Mon, 12 Aug 2024 08:46:04 -0700
Message-Id: <20240812154613.126522-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
References: <20240812154613.126522-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This contains a list of all BasicServiceSet objects (paths) that
exist for a network.
---
 src/network.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/network.c b/src/network.c
index 8c16d9a6..76238e56 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1149,6 +1149,9 @@ static bool network_unregister_bss(void *a, void *user_data)
 	l_dbus_unregister_object(dbus_get_bus(),
 					network_bss_get_path(network, bss));
 
+	l_dbus_property_changed(dbus_get_bus(), network->object_path,
+				IWD_NETWORK_INTERFACE, "ExtendedServiceSet");
+
 	return true;
 }
 
@@ -1174,6 +1177,9 @@ static bool network_register_bss(struct network *network, struct scan_bss *bss)
 					L_DBUS_INTERFACE_PROPERTIES, bss))
 		return false;
 
+	l_dbus_property_changed(dbus_get_bus(), network->object_path,
+				IWD_NETWORK_INTERFACE, "ExtendedServiceSet");
+
 	return true;
 }
 
@@ -1960,6 +1966,28 @@ static bool network_property_get_known_network(struct l_dbus *dbus,
 	return true;
 }
 
+static bool network_property_get_extended_service_set(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct network *network = user_data;
+	const struct l_queue_entry *e;
+
+	l_dbus_message_builder_enter_array(builder, "o");
+
+	for (e = l_queue_get_entries(network->bss_list); e; e = e->next) {
+		struct scan_bss *bss = e->data;
+		const char *path = network_bss_get_path(network, bss);
+
+		l_dbus_message_builder_append_basic(builder, 'o', path);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
 bool network_register(struct network *network, const char *path)
 {
 	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
@@ -2259,6 +2287,9 @@ static void setup_network_interface(struct l_dbus_interface *interface)
 
 	l_dbus_interface_property(interface, "KnownNetwork", 0, "o",
 				network_property_get_known_network, NULL);
+
+	l_dbus_interface_property(interface, "ExtendedServiceSet", 0, "ao",
+				network_property_get_extended_service_set, NULL);
 }
 
 static bool network_bss_property_get_address(struct l_dbus *dbus,
-- 
2.34.1

