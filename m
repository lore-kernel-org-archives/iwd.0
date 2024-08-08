Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315E19006A
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138962; cv=none; b=oHfx0Xu8sp97upy+z0rqHA7IDHKJozN46+XzuZL8Tovk/mCQO/2NaBDtLQGiyvz2R/XPdt6fqlJn31xdchdJKVBj/wMUwmmvMmn0d3FRIMOKGD4YlwSJc1sb7/R5M2+tvvgUwf+zwvtVL5zXtDvk98Yk8qRa1KRGE5YUKxV3wDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138962; c=relaxed/simple;
	bh=gL9/hIUNpJ2gfMcRa9bEN2H3UC2GFGEkTGsnaA/OVZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhc43vttsV+ioJZjYb5w2IGTsSsxqcJvE9zvCMVpqNGjtfo68FJp+vkyqQCbglpvN+KvXq2l+a1XNg0/lyYRsWIVor/Y7EM8apRzJGJWweraRUgs3a016uqPBIGPk9F36AQsrHuLy0YB3Aa3DtxhowUmpM15Cv6/R3WoJs1esTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFBqB/Er; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFBqB/Er"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ff1cd07f56so10963945ad.2
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138960; x=1723743760; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB9jcrzhXsSqkcbekdX4625JgVZH0PgLdblAKSVBN44=;
        b=WFBqB/ErlMX+8WuPw79HW4k4GWhlWpVutc65h1qizgsuM9jvKTic6tbem2LCI7JYpW
         3MjEWb3fzPX4EMbzNFj+lnKeXe4vqYWhghThwTSiFIN8ftl3IbG0ghYXpkyWu2Fos/Gk
         QCCED18ro2l0prCw6XQx6UOHS+/2QN7WdsiOwJMNm49kIbEmc+f09mp2i1ga1Jdwpm3x
         iDY1iYQCNU6+72apq5N1OWE9GMbxYJEIWliS6SmXrcxzpnBi9oac4Nc4in2y4+OTsDc0
         XdE35Eydg/BvMLF4BL4gXjdYGhl4DReg6r8CpIAM48DBgMRFT3twdze3dDs4IXHxH8ll
         smlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138960; x=1723743760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB9jcrzhXsSqkcbekdX4625JgVZH0PgLdblAKSVBN44=;
        b=LZVd6C+upg9Pf/GZWN7u40CeNSs+AV42T6oKNHawb3JEUF9K86Hvm4hrt7mIJGo+JR
         86+GNEfL/Php+2Jb9GWF82vtCQKWz4nCYrE/urfnJRkprNBVTr2Q9BovP/h/73bhSJJS
         ahUgTgcxEMypmBcDpDV8HsI0EGJixxpgqwPBXIgAg4rwN6HKhK3WBZD6NJ1vzOaa1X8A
         Uo7orZAcljNZqS0hZQfB8LCj99SLdkU2643viK97SDMGUMx0y+D32GdQJy8md2aD4hMC
         91U9yahyrN3W8GmbuSXDDe96Bf95Vr4lpJULeklqgZ5TJnXYOnVvo3PEwM1uTVaWJDMj
         bEeg==
X-Gm-Message-State: AOJu0YxXQ0AvbuVFMjbMZ5SUT+oZXvVea+MO+PgmUJ4NeLIP8jeI7fXr
	8W4unh1K5czVf+xQQ2ayfsl+1DKoNxzCOm5VzxYa/wqx91Njs/ee1f16VQ==
X-Google-Smtp-Source: AGHT+IEyp+tdtzEb13mFdrrDwpRpDCjKe7haXFtWPqU4RNyFXjJU3+VLrGcsWGft7l0Q2JEQbHIOxw==
X-Received: by 2002:a17:902:cecd:b0:1fc:2e36:511a with SMTP id d9443c01a7336-20095244225mr34269625ad.14.1723138959693;
        Thu, 08 Aug 2024 10:42:39 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 02/13] network: Add BasicServiceSet object
Date: Thu,  8 Aug 2024 10:42:25 -0700
Message-Id: <20240808174236.218750-2-prestwoj@gmail.com>
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

This adds a new DBus object/interface for tracking BSS's for
a given network. Since scanning replaces scan_bss objects some
new APIs were added to avoid tearing down the associated DBus
object for each BSS.

network_bss_start_update() should be called before any new BSS's
are added to the network object. This will keep track of the old
list and create a new network->bss_list where more entries can
be added. This is effectively replacing network_bss_list_clear,
except it keeps the old list around until...

network_bss_stop_update() is called when all BSS's have been
added to the network object. This will then iterate the old list
and lookup if any BSS DBus objects need to be destroyed. Once
completed the old list is destroyed.
---
 src/network.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/network.h |   4 ++
 2 files changed, 125 insertions(+), 1 deletion(-)

v2:
 * Reworked to use network_bss_{start,stop}_update

diff --git a/src/network.c b/src/network.c
index 09099fac..9c197731 100644
--- a/src/network.c
+++ b/src/network.c
@@ -75,6 +75,7 @@ struct network {
 	struct l_ecc_point *sae_pt_20; /* SAE PT for Group 20 */
 	unsigned int agent_request;
 	struct l_queue *bss_list;
+	struct l_queue *old_bss_list;
 	struct l_settings *settings;
 	struct l_queue *secrets;
 	struct l_queue *blacklist; /* temporary blacklist for BSS's */
@@ -1129,12 +1130,97 @@ bool network_update_known_frequencies(struct network *network)
 	return true;
 }
 
+const char *network_bss_get_path(const struct network *network,
+						const struct scan_bss *bss)
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
+static bool network_register_bss(struct network *network, struct scan_bss *bss)
+{
+	const char *path = network_bss_get_path(network, bss);
+	struct scan_bss *old;
+
+	/*
+	 * Due to station issuing multiple scan requests we may already have
+	 * this BSS data registered. Remove it from the old_bss_list
+	 */
+	old = l_dbus_object_get_data(dbus_get_bus(), path, IWD_BSS_INTERFACE);
+	if (old == bss)
+		return l_queue_remove(network->old_bss_list, bss);
+	else if (old)
+		return l_dbus_object_set_data(dbus_get_bus(), path,
+						IWD_BSS_INTERFACE, bss);
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
+void network_bss_start_update(struct network *network)
+{
+	network->old_bss_list = network->bss_list;
+	network->bss_list = l_queue_new();
+}
+
+void network_bss_stop_update(struct network *network)
+{
+	const struct l_queue_entry *e;
+
+	/*
+	 * Update has finished, clean up any BSS's from the old list that have
+	 * been registered on DBus.
+	 */
+	for (e = l_queue_get_entries(network->old_bss_list); e; e = e->next) {
+		const struct scan_bss *old = e->data;
+		const struct scan_bss *bss;
+		const char *path = network_bss_get_path(network, old);
+
+		bss = l_dbus_object_get_data(dbus_get_bus(), path,
+						IWD_BSS_INTERFACE);
+		/*
+		 * The lookup matched the user data of an old BSS. This should
+		 * be unregistered from DBus
+		 */
+		if (bss && bss == old)
+			l_dbus_object_remove_interface(dbus_get_bus(), path,
+							IWD_BSS_INTERFACE);
+	}
+
+	l_queue_destroy(network->old_bss_list, NULL);
+	network->old_bss_list = NULL;
+}
+
 bool network_bss_add(struct network *network, struct scan_bss *bss)
 {
 	if (!l_queue_insert(network->bss_list, bss, scan_bss_rank_compare,
 									NULL))
 		return false;
 
+	network_register_bss(network, bss);
+
 	/* Done if BSS is not HS20 or we already have network_info set */
 	if (!bss->hs20_capable)
 		return true;
@@ -1168,6 +1254,8 @@ bool network_bss_update(struct network *network, struct scan_bss *bss)
 
 	l_queue_insert(network->bss_list, bss, scan_bss_rank_compare, NULL);
 
+	network_register_bss(network, bss);
+
 	/* Sync frequency for already known networks */
 	if (network->info) {
 		known_network_add_frequency(network->info, bss->frequency);
@@ -1190,7 +1278,12 @@ void network_bss_list_clear(struct network *network)
 
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
@@ -1899,6 +1992,9 @@ static void network_unregister(struct network *network, int reason)
 
 void network_remove(struct network *network, int reason)
 {
+	l_queue_foreach_remove(network->bss_list,
+				network_unregister_bss, network);
+
 	if (network->object_path)
 		network_unregister(network, reason);
 
@@ -2155,6 +2251,24 @@ static void setup_network_interface(struct l_dbus_interface *interface)
 				network_property_get_known_network, NULL);
 }
 
+static bool network_bss_property_get_address(struct l_dbus *dbus,
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
+	l_dbus_interface_property(interface, "Address", 0, "s",
+					network_bss_property_get_address, NULL);
+}
+
 static int network_init(void)
 {
 	if (!l_dbus_register_interface(dbus_get_bus(), IWD_NETWORK_INTERFACE,
@@ -2162,6 +2276,11 @@ static int network_init(void)
 		l_error("Unable to register %s interface",
 						IWD_NETWORK_INTERFACE);
 
+	if (!l_dbus_register_interface(dbus_get_bus(), IWD_BSS_INTERFACE,
+					setup_bss_interface, NULL, false))
+		l_error("Unable to register %s interface",
+						IWD_BSS_INTERFACE);
+
 	known_networks_watch =
 		known_networks_watch_add(known_networks_changed, NULL, NULL);
 
@@ -2179,6 +2298,7 @@ static void network_exit(void)
 	event_watch = 0;
 
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_NETWORK_INTERFACE);
+	l_dbus_unregister_interface(dbus_get_bus(), IWD_BSS_INTERFACE);
 }
 
 IWD_MODULE(network, network_init, network_exit)
diff --git a/src/network.h b/src/network.h
index 17dfcca8..f27329a9 100644
--- a/src/network.h
+++ b/src/network.h
@@ -67,8 +67,12 @@ int network_can_connect_bss(struct network *network,
 						const struct scan_bss *bss);
 int network_autoconnect(struct network *network, struct scan_bss *bss);
 void network_connect_failed(struct network *network, bool in_handshake);
+void network_bss_start_update(struct network *network);
+void network_bss_stop_update(struct network *network);
 bool network_bss_add(struct network *network, struct scan_bss *bss);
 bool network_bss_update(struct network *network, struct scan_bss *bss);
+const char *network_bss_get_path(const struct network *network,
+						const struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
 void network_bss_list_clear(struct network *network);
 struct scan_bss *network_bss_list_pop(struct network *network);
-- 
2.34.1

