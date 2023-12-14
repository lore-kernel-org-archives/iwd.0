Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375167E6A
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtR0cISO"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-425a116f1cdso53378391cf.0
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702576886; x=1703181686; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LL5XMoKKfyj4lF/ccY1D6SLjeOwyNN/EZbhZdDGiOM=;
        b=mtR0cISOIHPaToaJnLu/9xm7QEHkrW41kabG++6ujR5RW5pQ7UXUAkpgV3vJU3ICRH
         wCHBqKYesIsHH/Wu794W2HL0wwha0OXJpN1s0R6UJmpyBRXruZu1pTS7yiZPsAjEbVMl
         qryOIsq28AhbNY6tqijaZ2Rl3qe4NoBP/0cZPxKwTFflNHafYQcxp5E4XmVVFOaFm+Lc
         G7bXpouAoCvPMvGBj2MgN2NZ0R0N/mOxi257Ho28rtLDYPhCLEKeIyEEGWePHsIPQFDI
         yqkUPajWNr1oYxq+OG7OltjoAK0sR6eFTjLPst6ilYwEFwaFzYt2O3JnO0ztZQPG7P7e
         7Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576886; x=1703181686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LL5XMoKKfyj4lF/ccY1D6SLjeOwyNN/EZbhZdDGiOM=;
        b=Xx4ctBwMiNRUiJ+7QDPZHZU9FUOL3oD7IXp4tRK+BNXIv1VhVeDyrGz6h3NeTkbRk+
         hrE4bdtSZP+X9cm5XqEzwqNSKRbaF+sJSQ5NlsSwIX3+tRgGni3QDjenZ38Ho87U3e1/
         SHvKZMMBoE18P7Dc8z21lAV/fj0E/OmRt4DwM36Ms+g1JQhnpPszdxK+wfzQO+cPPHVq
         RqQzeuNlVFEljgp4NjZYeza+lmynAIIQhU0VuD1D41vWlItkedrZWqzfOX5ERyug0eD4
         0GPks2JFi8EoNoKzoy2BL0BrDENYLXwjdBsRd62LbP7IUm6XHW0cspbRS+nh1K6hh22d
         6s7A==
X-Gm-Message-State: AOJu0YwEKlXEbYRICr3dcxBp/GwNPB8hbWUYt5zi+VquTFu0ANY/ShrD
	hcHXKySQpcF7qbWpzYShaHvVNpaekog=
X-Google-Smtp-Source: AGHT+IHt0LwcbXUGg/+ryL9m1mskrbj4I4Q4XC/fHREk8xrn4CaJ0Sd+qWsrlZHyBFNLDmXPOgIPWg==
X-Received: by 2002:a05:622a:1001:b0:425:4043:189b with SMTP id d1-20020a05622a100100b004254043189bmr14896442qte.78.1702576886227;
        Thu, 14 Dec 2023 10:01:26 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o8-20020ac85548000000b004257bf9a394sm5949511qtr.14.2023.12.14.10.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:01:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] knownnetworks: network: support updating known network settings
Date: Thu, 14 Dec 2023 10:01:07 -0800
Message-Id: <20231214180110.130991-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214180110.130991-1-prestwoj@gmail.com>
References: <20231214180110.130991-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a known network is modified on disk the settings are not
reloaded by network. Only disconnecting/reconnecting to the network
would update the settings. This poses an issue to DPP since its
creating or updating a known network after configuration then trying
to connect. The connection itself works fine since the PSK/passphrase
is set to the network object directly, but any additional settings
are not updated.

To fix this add a new UPDATED known network event. This is then
handled from within network and all settings read from disk are
applied to the network object.
---
 src/knownnetworks.c |   4 ++
 src/knownnetworks.h |   1 +
 src/network.c       | 104 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index d4d50a6f..04ce74ec 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -468,6 +468,10 @@ void known_network_update(struct network_info *network,
 	known_network_set_autoconnect(network, new->is_autoconnectable);
 
 	memcpy(&network->config, new, sizeof(struct network_config));
+
+	WATCHLIST_NOTIFY(&known_network_watches,
+				known_networks_watch_func_t,
+				KNOWN_NETWORKS_EVENT_UPDATED, network);
 }
 
 bool known_networks_foreach(known_networks_foreach_func_t function,
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index 0a5c9e25..e8ffac0b 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -35,6 +35,7 @@ struct network_info;
 enum known_networks_event {
 	KNOWN_NETWORKS_EVENT_ADDED,
 	KNOWN_NETWORKS_EVENT_REMOVED,
+	KNOWN_NETWORKS_EVENT_UPDATED,
 };
 
 struct network_info_ops {
diff --git a/src/network.c b/src/network.c
index 41c5460b..bd3671ca 100644
--- a/src/network.c
+++ b/src/network.c
@@ -730,6 +730,73 @@ static void network_settings_save(struct network *network,
 		network_settings_save_sae_pt_ecc(settings, network->sae_pt_20);
 }
 
+static bool network_settings_update(struct network *network,
+					struct l_settings *new)
+{
+	bool have_transition_disable;
+	uint8_t transition_disable = 0;
+	unsigned int i;
+	size_t psk_len;
+	_auto_(l_strv_free) char **list = NULL;
+	_auto_(l_free) uint8_t *psk = NULL;
+	_auto_(l_free) char *passphrase = NULL;
+
+	if (l_settings_get_bool(new, NET_TRANSITION_DISABLE,
+				&have_transition_disable) &&
+				have_transition_disable) {
+		list = l_settings_get_string_list(new,
+					NET_TRANSITION_DISABLE_MODES, ' ');
+
+		for (i = 0; list[i]; i++) {
+			if (!strcmp(list[i], "personal"))
+				set_bit(&transition_disable, 0);
+			else if (!strcmp(list[i], "enterprise"))
+				set_bit(&transition_disable, 1);
+			else if (!strcmp(list[i], "open"))
+				set_bit(&transition_disable, 2);
+		}
+
+		have_transition_disable = true;
+	} else
+		have_transition_disable = false;
+
+	if (network->security != SECURITY_PSK)
+		goto apply;
+
+	psk = l_settings_get_bytes(network->settings, "Security",
+					"PreSharedKey", &psk_len);
+	if (psk && psk_len != 32) {
+		l_warn("updated [Security].PreSharedKey value is invalid!");
+		return false;
+	}
+
+	passphrase = l_settings_get_string(network->settings,
+						"Security", "Passphrase");
+	if (passphrase && !crypto_passphrase_is_valid(passphrase)) {
+		l_warn("updated [Security].Passphrase value is invalid!");
+		return false;
+	}
+
+apply:
+	network_settings_close(network);
+	network->settings = new;
+
+	network->have_transition_disable = have_transition_disable;
+	network->transition_disable = transition_disable;
+
+	if (psk)
+		network->psk = l_steal_ptr(psk);
+
+	if (passphrase) {
+		network->passphrase = l_strdup(passphrase);
+
+		network_settings_load_pt_ecc(network, 19, &network->sae_pt_19);
+		network_settings_load_pt_ecc(network, 20, &network->sae_pt_20);
+	}
+
+	return true;
+}
+
 void network_sync_settings(struct network *network)
 {
 	struct network_info *info = network->info;
@@ -1966,17 +2033,32 @@ static void network_update_hotspot(struct network *network, void *user_data)
 	match_hotspot_network(info, network);
 }
 
-static void match_known_network(struct station *station, void *user_data)
+static void match_known_network(struct station *station, void *user_data,
+				bool new)
 {
 	struct network_info *info = user_data;
 	struct network *network;
 
 	if (!info->is_hotspot) {
+		struct l_settings *settings;
 		network = station_network_find(station, info->ssid, info->type);
 		if (!network)
 			return;
 
-		network_set_info(network, info);
+		/* New networks should load settings upon connecting */
+		if (new) {
+			network_set_info(network, info);
+			return;
+		}
+
+		settings = network_info_open_settings(info);
+
+		if (!settings || !network_settings_update(network, settings)) {
+			l_warn("Failed to apply new/updated settings (%s)",
+					info->ssid);
+			l_settings_free(settings);
+		}
+
 		return;
 	}
 
@@ -1984,17 +2066,33 @@ static void match_known_network(struct station *station, void *user_data)
 	station_network_foreach(station, network_update_hotspot, info);
 }
 
+static void add_known_network(struct station *station, void *user_data)
+{
+	match_known_network(station, (struct network_info *)user_data, true);
+}
+
+static void update_known_network(struct station *station, void *user_data)
+{
+	match_known_network(station, (struct network_info *)user_data, false);
+}
+
 static void known_networks_changed(enum known_networks_event event,
 					const struct network_info *info,
 					void *user_data)
 {
 	switch (event) {
 	case KNOWN_NETWORKS_EVENT_ADDED:
-		station_foreach(match_known_network, (void *) info);
+		station_foreach(add_known_network, (void *) info);
 
 		/* Syncs frequencies of newly known network */
 		known_network_frequency_sync((struct network_info *)info);
 		break;
+	case KNOWN_NETWORKS_EVENT_UPDATED:
+		station_foreach(update_known_network, (void *) info);
+
+		/* Syncs frequencies of updated known network */
+		known_network_frequency_sync((struct network_info *)info);
+		break;
 	case KNOWN_NETWORKS_EVENT_REMOVED:
 		station_foreach(emit_known_network_removed, (void *) info);
 		break;
-- 
2.34.1

