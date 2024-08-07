Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261514037F
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054482; cv=none; b=YXFQusdEM4sq/Vqh3NlLE2nlg9J53QyH/8pdWB23qX3B0zd95Ch2QrYgPe9wKNlcSZXpS1uNJOnjP0HNjKF55XLljuKzxArnq2OBPFBzA0qU3yHdBCM6WpeIkxXliWPXCqKS8fTeoFDm1jbgX7ksg41pD/fmMcsRugkfZlzWClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054482; c=relaxed/simple;
	bh=+NeUWG4b3aw4f/0O8akwoFwPYs3u1BgWwH+wGzKNr70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PErQdp0zq5ln7QdTFJVcrt2wcfSrfzSEah8n9KrHQNBlec+Pw6zsmD0JINGw8g8R0Xq8Jmud/D82pJgSSxZsW50KHv8biVICtko07EQAORBHpq01j0NiumxilA3XbbB6JBAlrgFuSSHwu2llDDq8JWR1HrDdVRAaqBxgO9wnsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuK9A416; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuK9A416"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d5f6c56fso11382285a.0
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054479; x=1723659279; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8vlcHvkLRBlXCihbzDH6huS7z5YKVVoKdSUr3X8dXs=;
        b=AuK9A416x/xsz//SyMG7fHJMbZ8pRPkgSNrl6Hn4omqZM15jizFhuXHGs0/f5Uo6GI
         zTBDIaHr8cmLekYKsO8RR6VMstSuNCZqzeVxwYRqgJh3yB6UGpp1NiPblSYPBN17Ufwm
         EVVZYgfZuvp6uQeMrhhpXx9m9CMuv++tvYaGmG8QVQW3DdL58Jnw6BoNef8yaAUeuSu9
         6AxGUcHVTO7j7Tc1CCeejUdfAiyHqPP7DeiiccxF5fKOYuwNxTrlP+/TYqwK1p8tIcBW
         A5aqXARm2fQQ8PkedoZjCKGNz46keuMLHx/VXKOVYmldtQrBNdQDtYKC4F2b3KJUZMN/
         DBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054479; x=1723659279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8vlcHvkLRBlXCihbzDH6huS7z5YKVVoKdSUr3X8dXs=;
        b=JyKsydnxcGVAJkrpVYQaRyy9tpKBh0sSn0ekV8GceuTf6KzTVTxTTb5mh+Di8m7srt
         sfZjXBIzDF18v3qJ0rITKQH/eQHdj1dQ3IqE3A/Y/RDUUOdeAHdgxyUtISaWYeaUh0X5
         ms41tjCOxadp5cTxnc55aHxn1XhTE/s8WcyZLqBNlsSSJvg3gsdT+ZhlgWzcAWiG+Snx
         ILDw+6aHQE8KIUcmAbZJSUkVG1JGkcIO8/M10UeEhWNHHJmeLOpat7dNWXWpa1MGMwY/
         JIxxCOy5FazZx4F2m8a0Sjf5/NhxftyLSrmFILrMuOE0iVcllkZ+uZhzchINznmGs4FS
         0NoA==
X-Gm-Message-State: AOJu0Yz+2wUu0QjMdezCCJK9k49DZVXia++kUI4qooQAmzj6zznjJeEH
	f2YiMgCf+BGzIsKiA09KKbQacg93wESNOO6oDce8nCLasG1LcXNvgE2Yow==
X-Google-Smtp-Source: AGHT+IG5xAwBltASPoNIeDhizsFCOYwVmkZ1rAcaE46cXNZPcf+EIl0Io5RvW1iryg8tc7744Cr2MQ==
X-Received: by 2002:a05:620a:1905:b0:7a1:d9a1:b9b with SMTP id af79cd13be357-7a34efc9a32mr2525544785a.60.1723054478938;
        Wed, 07 Aug 2024 11:14:38 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/14] network: implement net.connman.iwd.BasicServiceSet
Date: Wed,  7 Aug 2024 11:14:18 -0700
Message-Id: <20240807181427.170515-5-prestwoj@gmail.com>
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

This ties the addition/removal of scan_bss objects from a network
object to BasicServiceSet objects. If a "new" object is added when
one with the same address already existed, no DBus object changes
are made (only the user data is updated with the new scan_bss).

Currently the only property on a BasicServiceSet object is the
"Bssid".
---
 src/network.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++---
 src/network.h |  2 ++
 2 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/src/network.c b/src/network.c
index c63d53b8..e3f5bee8 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1136,13 +1136,64 @@ static bool match_addr(const void *a, const void *b)
 	return memcmp(bss->addr, b, 6) == 0;
 }
 
+const char *network_bss_get_path(struct network *network,
+						struct scan_bss *bss)
+{
+	static char path[256];
+
+	snprintf(path, sizeof(path), "%s/%02x%02x%02x%02x%02x%02x",
+			network->object_path, MAC_STR(bss->addr));
+
+	return path;
+}
+
+static bool network_unregister_bss(void *a, void *user_data)
+{
+	struct scan_bss *bss = a;
+	struct network *network = user_data;
+
+	l_dbus_unregister_object(dbus_get_bus(),
+					network_bss_get_path(network, bss));
+
+	return true;
+}
+
+static bool network_register_bss(struct network *network, struct scan_bss *bss,
+					bool update)
+{
+	const char *path = network_bss_get_path(network, bss);
+
+	if (update)
+		return l_dbus_object_set_data(dbus_get_bus(),
+					network_bss_get_path(network, bss),
+					IWD_BSS_INTERFACE, bss);
+
+	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
+						IWD_BSS_INTERFACE, bss))
+		return false;
+
+	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
+					L_DBUS_INTERFACE_PROPERTIES, bss))
+		return false;
+
+	return true;
+}
+
 bool network_bss_add(struct network *network, struct scan_bss *bss)
 {
-	l_queue_remove_if(network->bss_list, match_addr, bss->addr);
+	bool removed = l_queue_remove_if(network->bss_list,
+					match_addr, bss->addr) != NULL;
+
+	if (!l_queue_insert(network->bss_list, bss,
+				scan_bss_rank_compare, NULL)) {
+		/* This is essentially impossible... */
+		if (L_WARN_ON(removed))
+			network_unregister_bss(bss, network);
 
-	if (!l_queue_insert(network->bss_list, bss, scan_bss_rank_compare,
-									NULL))
 		return false;
+	}
+
+	L_WARN_ON(!network_register_bss(network, bss, removed));
 
 	/* Done if BSS is not HS20 or we already have network_info set */
 	if (!bss->hs20_capable)
@@ -1194,8 +1245,10 @@ static bool scan_bss_prune_missing(void *a, void *user_data)
 	struct scan_bss *bss = a;
 	struct network_prune_data *data = user_data;
 
-	if (!l_queue_find(data->new_list, match_addr, bss->addr))
+	if (!l_queue_find(data->new_list, match_addr, bss->addr)) {
+		network_unregister_bss(bss, data->network);
 		return true;
+	}
 
 	return false;
 }
@@ -1213,7 +1266,12 @@ void network_bss_list_prune(struct network *network, struct l_queue *new_list)
 
 struct scan_bss *network_bss_list_pop(struct network *network)
 {
-	return l_queue_pop_head(network->bss_list);
+	struct scan_bss *bss = l_queue_pop_head(network->bss_list);
+
+	if (bss)
+		network_unregister_bss(bss, network);
+
+	return bss;
 }
 
 struct scan_bss *network_bss_find_by_addr(struct network *network,
@@ -1931,6 +1989,8 @@ void network_remove(struct network *network, int reason)
 	if (network->info)
 		network->info->seen_count -= 1;
 
+	l_queue_foreach_remove(network->bss_list,
+				network_unregister_bss, network);
 	l_queue_destroy(network->bss_list, NULL);
 	l_queue_destroy(network->blacklist, NULL);
 
@@ -2178,6 +2238,24 @@ static void setup_network_interface(struct l_dbus_interface *interface)
 				network_property_get_known_network, NULL);
 }
 
+static bool network_bss_property_get_bssid(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct scan_bss *bss = user_data;
+
+	l_dbus_message_builder_append_basic(builder, 's',
+					util_address_to_string(bss->addr));
+	return true;
+}
+
+static void setup_bss_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_property(interface, "Bssid", 0, "s",
+					network_bss_property_get_bssid, NULL);
+}
+
 static int network_init(void)
 {
 	if (!l_dbus_register_interface(dbus_get_bus(), IWD_NETWORK_INTERFACE,
@@ -2185,6 +2263,11 @@ static int network_init(void)
 		l_error("Unable to register %s interface",
 						IWD_NETWORK_INTERFACE);
 
+	if (!l_dbus_register_interface(dbus_get_bus(), IWD_BSS_INTERFACE,
+					setup_bss_interface, NULL, false))
+		l_error("Unable to register %s interface",
+						IWD_BSS_INTERFACE);
+
 	known_networks_watch =
 		known_networks_watch_add(known_networks_changed, NULL, NULL);
 
@@ -2202,6 +2285,7 @@ static void network_exit(void)
 	event_watch = 0;
 
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_NETWORK_INTERFACE);
+	l_dbus_unregister_interface(dbus_get_bus(), IWD_BSS_INTERFACE);
 }
 
 IWD_MODULE(network, network_init, network_exit)
diff --git a/src/network.h b/src/network.h
index 29bc57ee..62ed834b 100644
--- a/src/network.h
+++ b/src/network.h
@@ -69,6 +69,8 @@ int network_autoconnect(struct network *network, struct scan_bss *bss);
 void network_connect_failed(struct network *network, bool in_handshake);
 bool network_bss_add(struct network *network, struct scan_bss *bss);
 bool network_bss_update(struct network *network, struct scan_bss *bss);
+const char *network_bss_get_path(struct network *network,
+						struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
 void network_bss_list_prune(struct network *network, struct l_queue *new_list);
 
-- 
2.34.1

