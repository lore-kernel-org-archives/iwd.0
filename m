Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0B13D8A3
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138964; cv=none; b=X3YPqBlGNoGx5wrjLJDBeSxJENL7RYytuNDMff5ZBspc38wnL6FalQ9MN5WM+TVwH/EIRZ4NgXtY8El3HIctP1/lZ4DvKuw0aPdg0w4vgNB/zHcr3yVMrI8IQRb4+apY3VT4i6nY2PgS7JVEAuq8l4CnKbEu64M9ie4ik4duZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138964; c=relaxed/simple;
	bh=sxzA+Nn8SPaD0oyBawBuAc/3DvERKrGuBuR6LXQXaic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvV9wdnLouoJA38qeUil90fLWrY+8zQRcLnBItQBj+BsJ8e1BaG57rjXLjNzdttUsZD5eAext1qqqiu0c8NTr/COSxA3lAZhZLT+u0htNNPXRAImm9yOtK1h+pypd0xkGak5KbSSNAj3xmdrVW4XT4UyjqilYlGcLkcq1/dl1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci422hLQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci422hLQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc56fd4de1so8636235ad.0
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138962; x=1723743762; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zstXg2qUq099OLrjj87QlBwGeHGsG3dbckKiWwSxEbc=;
        b=ci422hLQiLWGHip0x2vU2ojvJW4tR60ifcsLtSLSKj+Cw9boJSP5O8QN8oaaWDXn8t
         H0mA2pa+2eONcZFbAnOxlDD8RvPctk5z2n5+/dlltdKBoVDADHs2AeTqJI+vhufk7lva
         eUgVZk8JcwUab/3jTeYbqrIXwGKr36oC6JOEcGrirneInpGTvlTaP+Ob1V3RDvrSOkX4
         +0kp9cB7gyFVJnE9OVxkC+msDEYEskCGINtnwIpd/5iOl1Yuz1e3HKzEbpSNX2eFuXJc
         dLVA6YfQ7ps9pNm3VlTmHFWTcrTzPo1dOmP23dDGATaY8s9peJgoA1cc83Utw15nqKjX
         bs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138962; x=1723743762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zstXg2qUq099OLrjj87QlBwGeHGsG3dbckKiWwSxEbc=;
        b=EG1T/LFmEyPvSvy/omB7x5jglU4lmH1OS3bNgCVxEW40CcCkHEgYSS1UPtNo3VyLSd
         NKwUiZq/6J6wcIC2xQCzCgnPCGbKKnMH+5wGnLewucEyUbNHulXNC6WQymcD2HY5YfHo
         2Y4XsNxpqU4OnKza64fGGfCkMhAmJPA/rz3uh/ekW2Ao9t6K3nbrPwJwcPATCUk7JVgp
         6DMIQUZDXFfzwhAgLI1Jx5mRUC2ApLL9U6bQpOYVpeG+Jq9hFNUgBqSFpH16vGouJDmv
         NvIBg0p/1yp+O5iVk91bSfkumPW35RqsbFb8FRZmVKmO8knE3cDcvtJ+IgqpARimaJpC
         kV7Q==
X-Gm-Message-State: AOJu0YwpAQS/LScRJOh3vTlPdutieBzwF/4og/6vIzxiWO0xqdaWiHRJ
	C9C28Tyf/hKAui0WAk3JFXfDXw0QtB8TtgaCSKZ9jErI+TOzz6XHyYbASQ==
X-Google-Smtp-Source: AGHT+IGqwE1wRRm2eTSD6jotEq/wzvvPlu/kusf5zHGJp6ew5EmsuSH43J/+na45l5wwsKbARGiwcw==
X-Received: by 2002:a17:902:e5c2:b0:1fd:8f7b:1e88 with SMTP id d9443c01a7336-2009681bff6mr46350775ad.12.1723138961592;
        Thu, 08 Aug 2024 10:42:41 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 04/13] network: add ExtendedServiceSet DBus property
Date: Thu,  8 Aug 2024 10:42:27 -0700
Message-Id: <20240808174236.218750-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808174236.218750-1-prestwoj@gmail.com>
References: <20240808174236.218750-1-prestwoj@gmail.com>
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

v2:
 * Renamed BasicServiceSets to ExtendedServiceSet

diff --git a/src/network.c b/src/network.c
index 9c197731..35e7ba4a 100644
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
 
@@ -1176,6 +1179,9 @@ static bool network_register_bss(struct network *network, struct scan_bss *bss)
 					L_DBUS_INTERFACE_PROPERTIES, bss))
 		return false;
 
+	l_dbus_property_changed(dbus_get_bus(), network->object_path,
+				IWD_NETWORK_INTERFACE, "ExtendedServiceSet");
+
 	return true;
 }
 
@@ -1950,6 +1956,28 @@ static bool network_property_get_known_network(struct l_dbus *dbus,
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
@@ -2249,6 +2277,9 @@ static void setup_network_interface(struct l_dbus_interface *interface)
 
 	l_dbus_interface_property(interface, "KnownNetwork", 0, "o",
 				network_property_get_known_network, NULL);
+
+	l_dbus_interface_property(interface, "ExtendedServiceSet", 0, "ao",
+				network_property_get_extended_service_set, NULL);
 }
 
 static bool network_bss_property_get_address(struct l_dbus *dbus,
-- 
2.34.1

