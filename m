Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B581419B5
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054482; cv=none; b=hpBFlWhiJATn/d/r+8ybFct6vrMMbPaB00julg4ywxlHjosmWUfFqYvTTs99O2NjsZyXi76Ik532siY7Dg93YzKN7xesgZl3vCgwgEpek9MRlbi4y47S/iMx1lcwn/+4Br79CkE2ZD4KwhWp8+NuCSc7uJgrIovH7TAiYPGK0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054482; c=relaxed/simple;
	bh=tUiwgvABs1PQlUMkgd+Br9XGUtlTxxMkDu2jdpRaoqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eqnjv3HkqC5l/d1HL6KIW7z3l3sUIQNyw58u4LTGi4e54+p/2gqls5MBhAN7TAMkcN7/O45HSdg+AUZyGc9QtJLQICrUcc7B9P1amN7mVAfHQjOZPUnKMQjJrdOn1UQEpbu2u4vFR87puWQrwgpcSUR0MwNvr/9/k6OG5N3Ku/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivgt4V11; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivgt4V11"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d984ed52so11825985a.0
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054480; x=1723659280; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73PjugG9a/l1hgYVyBZ+7l0sBvHgdOZi/iYNDy6S7Bg=;
        b=Ivgt4V11bZ93Dz0mxyLou+Ce3zDRtzTuSSl6XFgH8dTzMuhoC9iuuDR+/UBLiJvI4d
         Ud95FMxHLoNhlAs6KEOe/Iy6vZIOJCfIYDklRMoHTLGeulu8fAESdcF9uJ1BdypXPTjU
         52Y8h53/KXgNpKOCQDF97F4hAPTq3O2Xe4z88hK51oDSJk6AYvkhLMq1URHIxbPXYJXf
         Z5gvuyUL9Os4nXVNH9rHM7QJyPqA2y/txjfecWtAcVkTvw9CDQhPJo1y4/KhLS4i0IJQ
         GIz0wCDWR64h5QOcedWafijghBWOjv4GxvCUiQZElAYB0x6fqkTLt3krYzGx1YXFJTyH
         DbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054480; x=1723659280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73PjugG9a/l1hgYVyBZ+7l0sBvHgdOZi/iYNDy6S7Bg=;
        b=hCrm3ore8HqCD7KwLTVx23zZ/hCedclhCEzRgoY7egbZGMt3VNhxm3NF22wMTXGH/f
         oPOq1BGUA/D/31ppSJPvXnTaa5UGQ/vPYGTBwMsJFFAhsJ2Od3Z/XFJr9Em5op7jmPwc
         nv/oYNT2uzf628L5LbAoS02aV6w2NrzH7fQ5/9aRyUgdK6ftJT+eDk8xgfI9lIr82djM
         /YHU9OAp5v0V2RMUco2IGGeTknVXQIXeKLweBMgo6j+V79PIjNWRuWigyGwap8Qxa6lu
         ILb3uqaDgKGH4G2sFKn21k3MRwkcPUmvywyym39C/TFUxQKdcw8G7figBHDgjGOTyovD
         cBPg==
X-Gm-Message-State: AOJu0YxrtFvcSSP4TWaxaeXZwt4k17ZxI8LIXTfd7yPgLVeNnshrp0Va
	lumlgqi8LOQqs0G9bEPa4Wg1n7nEAeeK2RIrwyZl2allymQpCxr/0FdiKg==
X-Google-Smtp-Source: AGHT+IEyXqWFyN7/Ob93QWhHwPx56X9fPO/seZvYEAOECkWCubKEtd47QTIPzY+vt1k5iau9K51Apw==
X-Received: by 2002:a05:620a:40d3:b0:79d:7423:d040 with SMTP id af79cd13be357-7a34efac181mr2278006285a.54.1723054480092;
        Wed, 07 Aug 2024 11:14:40 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/14] network: add BasicServiceSets property on the network object
Date: Wed,  7 Aug 2024 11:14:19 -0700
Message-Id: <20240807181427.170515-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will hold an array of object paths pointing to each
BasicServiceSet object.
---
 src/network.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/network.c b/src/network.c
index e3f5bee8..de56eaaf 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1176,6 +1176,9 @@ static bool network_register_bss(struct network *network, struct scan_bss *bss,
 					L_DBUS_INTERFACE_PROPERTIES, bss))
 		return false;
 
+	l_dbus_property_changed(dbus_get_bus(), network->object_path,
+				IWD_NETWORK_INTERFACE, "BasicServiceSets");
+
 	return true;
 }
 
@@ -1938,6 +1941,28 @@ static bool network_property_get_known_network(struct l_dbus *dbus,
 	return true;
 }
 
+static bool network_property_get_basic_service_sets(struct l_dbus *dbus,
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
@@ -2236,6 +2261,9 @@ static void setup_network_interface(struct l_dbus_interface *interface)
 
 	l_dbus_interface_property(interface, "KnownNetwork", 0, "o",
 				network_property_get_known_network, NULL);
+
+	l_dbus_interface_property(interface, "BasicServiceSets", 0, "ao",
+				network_property_get_basic_service_sets, NULL);
 }
 
 static bool network_bss_property_get_bssid(struct l_dbus *dbus,
-- 
2.34.1

