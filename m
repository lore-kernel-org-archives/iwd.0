Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39F4206B
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477585; cv=none; b=JOzu398WVghjGu9CQdtNIrlmKswUkVgZPWmR0VRAxH4pRvHMYRt/HXiLsw1sSUrHn82PWsBHbfMUTnFhA4ARjvjPXQtGER9JtpgFo+rkUnt67SeB/1qab10MmvlIBZDzOiJLADeQbSGyOuXlTmL4qcR2lSEaKmFP8Q+s91AdnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477585; c=relaxed/simple;
	bh=pqdBjKO/n0yherFc3LdRMjLcAkwQUGBTlVcfYCI9kUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fpolDtvAIhaPJZujQ7GF9Up/4HdX78toQgKgq0VjC1Xk00G4VGkuXW72fhvxjxK3qXSP0jcu0iwHVPxSmw3PxVaINFm/sDXOWxyB6suTFAWCvMzYplS8fpLmp0QwHUXRII9unfuUCltFPLfClJtalLKCw25OhqnOjTylPeDQHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv+aqfXh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv+aqfXh"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efa16aad9so5832848e87.0
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477581; x=1724082381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rumi3IyiN5PbTLljvftiS4o5QJk04XrHqIyr253wL1o=;
        b=dv+aqfXhDWDyhyY7/lkIygr/9DLfx8pa07LaVTTpasJOV3GdUr20dm+hj9O8sQZWHY
         UhqnA9Fecs9sn1/4ECeWq3leMTfMcmFSajEJQunvu8uxcZ8Y02/9HvaixDlE96jYNbNO
         vTuH6o2FuMUw09By3ZLymk2yH418TJe7hSXFnEs8YtFY0VidL3k3cX/JFv5j9YN27pwZ
         BkFilMoyNulQEBqiQNQoZehkZEVEK5HQvZW81wh+RuLT70tfmF2jGNNJyP8DpAjsC89B
         okIN/BR8+P4cZyXA/4H9Ocnnarlx9LZdzT4DUCv7uzJ79jdUpM1m59bKCgIccRsalg5i
         VaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477581; x=1724082381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rumi3IyiN5PbTLljvftiS4o5QJk04XrHqIyr253wL1o=;
        b=kyPONbKoORveS8U1j9CKarKnWP+HsqpouwIWg/5CZaqEv4LeAG6whrwRZD3NvcEfMO
         76RiH7NmxSnvvlrjUoXfn3rNXOG3hcmz0K1x1R5bFCsnM1H1OTJmY+hFQ4+TstyOD6GH
         Srol6iRUX9PwsNKe+XbNePUt/tx+I/TOItfB8OwGCLdLRMlPxJxeAaPIsEwHEzcpmbA2
         D0kiB9BEwzhoR0QnuM1ypGfSne9Ip+Xr2BB7MeNO6hD0RUyYglEWVkdAxaztUxbBVnec
         /Wgb44QRzWEfcFt0Jdfwvkbm/qX0Xd1QYC+rXvfGn1xrylB7vCF2lwQWZo2/ZIv4qLXK
         8F1A==
X-Gm-Message-State: AOJu0YxIF2UQBpGqsAx0efKbebdi9AvZMURcGtS9zWs9/Mj0jAxbB1el
	6gjOWEwZk1iEb5lA4Qt/WyEtFmo0l6NK2ETHnVVXlsn1Mw1Nteexcf/LSA==
X-Google-Smtp-Source: AGHT+IFjBqY94dAlECblHPEPDdk2ArC1V7Y0uONIfeZwcpmm/Rjhpq1xRXMwGMUZ3bcQh46u7erWQA==
X-Received: by 2002:a05:6512:239e:b0:52b:c27c:ea1f with SMTP id 2adb3069b0e04-532136a47b2mr420337e87.55.1723477580876;
        Mon, 12 Aug 2024 08:46:20 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 02/13] network: Add BasicServiceSet object
Date: Mon, 12 Aug 2024 08:46:02 -0700
Message-Id: <20240812154613.126522-2-prestwoj@gmail.com>
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
 src/network.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/network.h |   6 +++
 2 files changed, 137 insertions(+), 1 deletion(-)

v3:
 * Pass the scan frequencies to stop_update() to avoid removing
   BSS's that weren't on the frequencies scanned.

diff --git a/src/network.c b/src/network.c
index 09099fac..8c16d9a6 100644
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
@@ -1129,12 +1130,107 @@ bool network_update_known_frequencies(struct network *network)
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
+	 * If we find this path in the object tree update the data to the new
+	 * scan_bss pointer, as this one will be freed soon.
+	 */
+	old = l_dbus_object_get_data(dbus_get_bus(), path, IWD_BSS_INTERFACE);
+	if (old)
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
+void network_bss_stop_update(struct network *network,
+				const struct scan_freq_set *limit_freqs)
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
+
+		/*
+		 * Don't remove BSS's who's frequencies were not in the set.
+		 * This happens due to scan subsets (i.e. from station) so some
+		 * BSS's won't be seen since the frequency is not being scanned.
+		 * These BSS's will get cleared out eventually if they have
+		 * actually disappeared.
+		 */
+		if (!scan_freq_set_contains(limit_freqs, bss->frequency))
+			continue;
+
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
@@ -1168,6 +1264,8 @@ bool network_bss_update(struct network *network, struct scan_bss *bss)
 
 	l_queue_insert(network->bss_list, bss, scan_bss_rank_compare, NULL);
 
+	network_register_bss(network, bss);
+
 	/* Sync frequency for already known networks */
 	if (network->info) {
 		known_network_add_frequency(network->info, bss->frequency);
@@ -1190,7 +1288,12 @@ void network_bss_list_clear(struct network *network)
 
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
@@ -1899,6 +2002,9 @@ static void network_unregister(struct network *network, int reason)
 
 void network_remove(struct network *network, int reason)
 {
+	l_queue_foreach_remove(network->bss_list,
+				network_unregister_bss, network);
+
 	if (network->object_path)
 		network_unregister(network, reason);
 
@@ -2155,6 +2261,24 @@ static void setup_network_interface(struct l_dbus_interface *interface)
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
@@ -2162,6 +2286,11 @@ static int network_init(void)
 		l_error("Unable to register %s interface",
 						IWD_NETWORK_INTERFACE);
 
+	if (!l_dbus_register_interface(dbus_get_bus(), IWD_BSS_INTERFACE,
+					setup_bss_interface, NULL, false))
+		l_error("Unable to register %s interface",
+						IWD_BSS_INTERFACE);
+
 	known_networks_watch =
 		known_networks_watch_add(known_networks_changed, NULL, NULL);
 
@@ -2179,6 +2308,7 @@ static void network_exit(void)
 	event_watch = 0;
 
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_NETWORK_INTERFACE);
+	l_dbus_unregister_interface(dbus_get_bus(), IWD_BSS_INTERFACE);
 }
 
 IWD_MODULE(network, network_init, network_exit)
diff --git a/src/network.h b/src/network.h
index 17dfcca8..b27158ee 100644
--- a/src/network.h
+++ b/src/network.h
@@ -30,6 +30,7 @@ struct network;
 struct scan_bss;
 struct handshake_state;
 struct erp_cache_entry;
+struct scan_freq_set;
 
 void network_connected(struct network *network);
 void network_disconnected(struct network *network);
@@ -67,8 +68,13 @@ int network_can_connect_bss(struct network *network,
 						const struct scan_bss *bss);
 int network_autoconnect(struct network *network, struct scan_bss *bss);
 void network_connect_failed(struct network *network, bool in_handshake);
+void network_bss_start_update(struct network *network);
+void network_bss_stop_update(struct network *network,
+				const struct scan_freq_set *freqs);
 bool network_bss_add(struct network *network, struct scan_bss *bss);
 bool network_bss_update(struct network *network, struct scan_bss *bss);
+const char *network_bss_get_path(const struct network *network,
+						const struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
 void network_bss_list_clear(struct network *network);
 struct scan_bss *network_bss_list_pop(struct network *network);
-- 
2.34.1

