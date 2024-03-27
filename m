Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A921C12FB18
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552817; cv=none; b=CKksKDMvGeCNebj66EpHghul0Ke7pgjk4XjBSkeQ/X/GAXTnttpGDuymUTR0cUNAI5WfSWaiHUdmkaT6LYl3s3hfd9fQ32wOw/AQbTrQpto+1dqAMM19GYxKCjnyhVgAF1yviX3CdOtu5IlyNGU0ychCdXn1/kvRiBIufcWSnlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552817; c=relaxed/simple;
	bh=yQi6FfMuUCzHLSM65lRQStCk9TVGUr2kieEcJqftLaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KeMpGRhFbAHIWpaCjtrIl+Mhzk8LVnAKQ0b8C7g4A+4ZwhKErKP8kOinJOyCc5TWnSXgESQm3LTNHIASAc32Q7KiRZhsW5Ci5U9VuM9QaWlqLR1DTh+JO9I1aQ2cDs2C8u3nr4GWP6aa40hNJusct100RekeSJEd04Bhtwf0Ass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpOQwI8V; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpOQwI8V"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6963cf14771so56810416d6.3
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552813; x=1712157613; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZcqpiDFd4jrZd1DF6gcjTOmyC++EjqhfcHKBrpnkaM=;
        b=kpOQwI8VpNrYVY+RbF1GR830p7YqFCFB1Jb+qA21XKlLIvk9UsosD5jeLliPX8RjIE
         5DNVwTWI50T6dOPzQhnZZY958fNKvnc4yf/mVABXE0gtV4FljkeAT7aO3AJjcvWrBFbq
         Oua0mfYly2noGJD2E7HOa3z6OD/LB7xs9/5DpxyyAyyOcn1dOhl+6gkpnvIyZVztMJVN
         TSydIZvMLrXIskCtVUlFYnth905RkHCfmK2HgK/vrfPPOBn49SH5y/mDg/p/PpSzJju7
         vqw1GfIYrqQBrcU88abqbnhjQsboYI8VQJwAJWH1SMbCmf5ub/p+iSWH9Yo9xp3oyJ9P
         jt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552813; x=1712157613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZcqpiDFd4jrZd1DF6gcjTOmyC++EjqhfcHKBrpnkaM=;
        b=p43H0XeJImB3R2SalxOqL+uNhxvgcU3nHqF/pBolibHHjRcy/UmCYUlKlJPCJ3lr9J
         jLnZ2rXKpjqxt3wWhSMkD7pF1G1YbJLZzcbVRYELFkgMJOORVrVwJRDhdLTgwb6IWDDE
         13aPJkz9QlXwvWNwngaiLkdO2nvTm2BDQH0kpeJBd0S8br6J7Ss+feAWbatxfZMdUWbt
         TPR/pbtuh4q9TcE0x4lfKlNse0sqh0zlr79bOGJVdWO6EzMQeSIDmDDOSspabSQsAcFr
         Ba4U43RYi9tdl739QOzcv9Gk2l2lOBhR9HgOj9N8XsiDzT0LMwB8LfuxQiDYaeGzkhvt
         fFrA==
X-Gm-Message-State: AOJu0YwdFUcekO5NUafmlPmjBQKTvAqVwNgSxi9Sl6MuheXASEjf6bHB
	6vP1qgGVdcB6K/ij3GEht3gVsWgHFIcCacynOKDRuPBEjDFBH8gTGE1Ci5+y
X-Google-Smtp-Source: AGHT+IE3wA9AWNIxtu6eNhBOkKmptyPKHqelZ6CTk+bM7ojdpYfQmYIrK/FpV+iSJsjr56B0P+OvsA==
X-Received: by 2002:a05:6214:cac:b0:691:43ce:b76f with SMTP id s12-20020a0562140cac00b0069143ceb76fmr3478991qvs.64.1711552813101;
        Wed, 27 Mar 2024 08:20:13 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 7-20020a056214202700b006968ce99b7esm3520782qvf.34.2024.03.27.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:20:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 9/9] dpp: use common state machine
Date: Wed, 27 Mar 2024 08:19:57 -0700
Message-Id: <20240327151957.1446149-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327151957.1446149-1-prestwoj@gmail.com>
References: <20240327151957.1446149-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Begins using the common state machine within dpp-common.c. All
the message flow/handling is now taken care of by the SM. The
dpp.c module now only handles a specific set of functions
required by 802.11 encapsulation (and DBus):

 - Encapsulating and writing out frames for the SM.
 - Decapsulating and reading frames into the SM
 - Offchannel management; setting/unsetting the write handler as
   the offchannel work is ready or timed out.
 - DBus API.

The dpp.c module can now create its minimal dpp object on init and
the dpp_sm object lifetime follows the protocol. When DPP is
started dpp.c will set any options required for the configuration,
role, inititor vs responder, etc. DPP can then be started within
the SM, and any offchannel work should be queued. The basic flow
after that is quite simple:

 - If using offchannel the write handler must be set or unset as
   needed when frames can/can't be sent out. Offchannel frequencies
   are tracked by dpp.c, including presence/PKEX exchange frequency
   iteration.
 - Receved frames should be validated minimally: Prefix should be
   some type of DPP frame, and the source should be either a
   broadcast or from the expected peer (if known).
 - Received frames should be stripped of the mpdu header and
   category byte.
 - If the SM calls into the write handler the frame should be
   encapsulated with a mpdu header and category byte, then sent.
 - Upon receiving DPP events:
     DPP_EVENT_FAILED:
         The SM should be destroyed

     DPP_EVENT_PEER_ACCEPTED
         The MAC for the last message received should be tracked
         and only messages from the MAC should be passed to the SM
         going forward.

     DPP_EVENT_CHANNEL_SWITCH
         The channel should be switched to a new one, as communicated
         by the authentication request

     DPP_EVENT_PKEX_KEY_REQUESTED
         The PKEX key should be obtained and set into the SM using
         dpp_sm_set_pkex_key().

     DPP_EVENT_SUCCESS
         DPP completed. As an enrollee the configuration can now be
         obtained. The SM should be destroyed.
---
 src/dpp.c | 496 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 353 insertions(+), 143 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 31d0ef28..cd7facbf 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -54,6 +54,7 @@
 #include "src/handshake.h"
 #include "src/nl80211util.h"
 #include "src/knownnetworks.h"
+#include "src/dpp-common.h"
 
 #define DPP_FRAME_MAX_RETRIES 5
 #define DPP_FRAME_RETRY_TIMEOUT 1
@@ -67,20 +68,6 @@ static uint32_t unicast_watch;
 
 static uint8_t dpp_prefix[] = { 0x04, 0x09, 0x50, 0x6f, 0x9a, 0x1a, 0x01 };
 
-enum dpp_state {
-	DPP_STATE_NOTHING,
-	DPP_STATE_PRESENCE,
-	DPP_STATE_PKEX_EXCHANGE,
-	DPP_STATE_PKEX_COMMIT_REVEAL,
-	DPP_STATE_AUTHENTICATING,
-	DPP_STATE_CONFIGURING,
-};
-
-enum dpp_capability {
-	DPP_CAPABILITY_ENROLLEE = 0x01,
-	DPP_CAPABILITY_CONFIGURATOR = 0x02,
-};
-
 enum dpp_interface {
 	DPP_INTERFACE_UNBOUND,
 	DPP_INTERFACE_DPP,
@@ -95,6 +82,7 @@ struct pkex_agent {
 };
 
 struct dpp {
+	struct dpp_sm *sm;
 	struct netdev *netdev;
 	char *uri;
 	uint8_t role;
@@ -104,10 +92,10 @@ struct dpp {
 
 	uint64_t wdev_id;
 
+	/* Could probably do away with storing these here */
 	struct l_ecc_scalar *boot_private;
 	struct l_ecc_point *boot_public;
 
-	enum dpp_state state;
 	enum dpp_interface interface;
 
 	struct pkex_agent *agent;
@@ -121,18 +109,17 @@ struct dpp {
 	size_t freqs_idx;
 	uint32_t dwell;
 	uint32_t current_freq;
-	uint32_t new_freq;
 	struct scan_freq_set *presence_list;
 	uint32_t max_roc;
 
 	uint32_t offchannel_id;
 
 	uint8_t peer_addr[6];
+	bool peer_accepted;
 
 	/* Timeout of either auth/config protocol */
 	struct l_timeout *timeout;
 
-	struct dpp_configuration *config;
 	uint32_t connect_scan_id;
 	uint64_t frame_cookie;
 	uint8_t frame_retry;
@@ -140,19 +127,12 @@ struct dpp {
 	size_t frame_size;
 	struct l_timeout *retry_timeout;
 
-	struct l_dbus_message *pending;
-
 	struct l_idle *connect_idle;
 
-	/* PKEX-specific values */
-	char *pkex_id;
-	char *pkex_key;
-
 	uint32_t pkex_scan_id;
 
 	bool mcast_support : 1;
 	bool roc_started : 1;
-	bool channel_switch : 1;
 };
 
 static const char *dpp_role_to_string(enum dpp_capability role)
@@ -173,8 +153,7 @@ static bool dpp_pkex_get_started(struct l_dbus *dbus,
 				void *user_data)
 {
 	struct dpp *dpp = user_data;
-	bool started = (dpp->state != DPP_STATE_NOTHING &&
-			dpp->interface == DPP_INTERFACE_PKEX);
+	bool started = (dpp->sm && dpp->interface == DPP_INTERFACE_PKEX);
 
 	l_dbus_message_builder_append_basic(builder, 'b', &started);
 
@@ -189,8 +168,7 @@ static bool dpp_pkex_get_role(struct l_dbus *dbus,
 	struct dpp *dpp = user_data;
 	const char *role;
 
-	if (dpp->state == DPP_STATE_NOTHING ||
-				dpp->interface != DPP_INTERFACE_PKEX)
+	if (!dpp->sm || dpp->interface != DPP_INTERFACE_PKEX)
 		return false;
 
 	role = dpp_role_to_string(dpp->role);
@@ -207,8 +185,7 @@ static bool dpp_get_started(struct l_dbus *dbus,
 				void *user_data)
 {
 	struct dpp *dpp = user_data;
-	bool started = (dpp->state != DPP_STATE_NOTHING &&
-			dpp->interface == DPP_INTERFACE_DPP);
+	bool started = (dpp->sm && dpp->interface == DPP_INTERFACE_DPP);
 
 	l_dbus_message_builder_append_basic(builder, 'b', &started);
 
@@ -223,8 +200,7 @@ static bool dpp_get_role(struct l_dbus *dbus,
 	struct dpp *dpp = user_data;
 	const char *role;
 
-	if (dpp->state == DPP_STATE_NOTHING ||
-				dpp->interface != DPP_INTERFACE_DPP)
+	if (!dpp->sm || dpp->interface != DPP_INTERFACE_DPP)
 		return false;
 
 	role = dpp_role_to_string(dpp->role);
@@ -242,8 +218,7 @@ static bool dpp_get_uri(struct l_dbus *dbus,
 {
 	struct dpp *dpp = user_data;
 
-	if (dpp->state == DPP_STATE_NOTHING ||
-				dpp->interface != DPP_INTERFACE_DPP)
+	if (!dpp->sm || dpp->interface != DPP_INTERFACE_DPP)
 		return false;
 
 	l_dbus_message_builder_append_basic(builder, 's', dpp->uri);
@@ -380,11 +355,6 @@ static void dpp_reset(struct dpp *dpp)
 		dpp->timeout = NULL;
 	}
 
-	if (dpp->config) {
-		dpp_configuration_free(dpp->config);
-		dpp->config = NULL;
-	}
-
 	if (dpp->connect_scan_id) {
 		scan_cancel(dpp->wdev_id, dpp->connect_scan_id);
 		dpp->connect_scan_id = 0;
@@ -410,7 +380,6 @@ static void dpp_reset(struct dpp *dpp)
 		dpp->connect_idle = NULL;
 	}
 
-	dpp->new_freq = 0;
 	dpp->frame_retry = 0;
 	dpp->frame_cookie = 0;
 
@@ -419,6 +388,11 @@ static void dpp_reset(struct dpp *dpp)
 	dpp_property_changed_notify(dpp);
 
 	dpp->interface = DPP_INTERFACE_UNBOUND;
+
+	if (dpp->sm) {
+		dpp_sm_free(dpp->sm);
+		dpp->sm = NULL;
+	}
 }
 
 static void dpp_free(struct dpp *dpp)
@@ -510,7 +484,27 @@ static void dpp_frame_retry(struct dpp *dpp)
 	dpp->frame_pending = NULL;
 }
 
-static void dpp_write_config(struct dpp_configuration *config,
+static size_t dpp_build_mpdu_header(const uint8_t *src,
+					const uint8_t *dest, uint8_t *buf)
+{
+	struct mmpdu_header *hdr = (struct mmpdu_header *)buf;
+	uint8_t *body;
+
+	hdr->fc.protocol_version = 0;
+	hdr->fc.type = MPDU_TYPE_MANAGEMENT;
+	hdr->fc.subtype = MPDU_MANAGEMENT_SUBTYPE_ACTION;
+	memcpy(hdr->address_1, dest, 6);
+	memcpy(hdr->address_2, src, 6);
+	memcpy(hdr->address_3, broadcast, 6);
+
+	body = buf + mmpdu_header_len(hdr);
+	/* Category: Public */
+	*body++ = 0x04;
+
+	return body - buf;
+}
+
+static void dpp_write_config(const struct dpp_configuration *config,
 				struct network *network)
 {
 	_auto_(l_settings_free) struct l_settings *settings = l_settings_new();
@@ -555,9 +549,13 @@ static void dpp_start_connect(struct l_idle *idle, void *user_data)
 	struct scan_bss *bss;
 	struct network *network;
 	int ret;
+	const struct dpp_configuration *config;
 
-	network = station_network_find(station, dpp->config->ssid,
-					SECURITY_PSK);
+	config = dpp_sm_get_configuration(dpp->sm);
+	if (L_WARN_ON(!config))
+		return;
+
+	network = station_network_find(station, config->ssid, SECURITY_PSK);
 
 	dpp_reset(dpp);
 
@@ -618,7 +616,8 @@ static void dpp_known_network_watch(enum known_networks_event event,
 					void *user_data)
 {
 	struct dpp *dpp = user_data;
-
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	const struct dpp_configuration *config;
 	/*
 	 * Check the following
 	 *  - DPP is enrolling
@@ -628,16 +627,23 @@ static void dpp_known_network_watch(enum known_networks_event event,
 	 *    immediately modified after DPP synced it).
 	 *  - DPP didn't start a scan for the network.
 	 */
+	if (!dpp->sm)
+		return;
+
+	config = dpp_sm_get_configuration(dpp->sm);
+
 	if (dpp->role != DPP_CAPABILITY_ENROLLEE)
 		return;
-	if (!dpp->config)
+	if (!config)
 		return;
-	if (strcmp(info->ssid, dpp->config->ssid))
+	if (strcmp(info->ssid, config->ssid))
 		return;
 	if (dpp->connect_idle)
 		return;
 	if (dpp->connect_scan_id)
 		return;
+	if (!station || station_get_connected_network(station))
+		return;
 
 	switch (event) {
 	case KNOWN_NETWORKS_EVENT_ADDED:
@@ -663,54 +669,40 @@ static void dpp_handle_config_frame(const struct mmpdu_header *frame,
 					int rssi, void *user_data)
 {
 	struct dpp *dpp = user_data;
-	struct dpp_configuration *config = NULL;
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
-	struct network *network = NULL;
-	struct scan_bss *bss = NULL;
 
-	dpp_write_config(config, network);
+	if (!dpp->sm)
+		return;
 
-	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
+	dpp_handle_rx(dpp->sm, body + 1, body_len - 1);
+}
 
-	if (network && bss) {
-		l_debug("delaying connect until settings are synced");
-		dpp->config = config;
-		return;
-	} else if (station) {
-		struct scan_parameters params = {0};
+static void dpp_tx_frame(const uint8_t *data, size_t len,
+				void *user_data)
+{
+	struct dpp *dpp = user_data;
+	struct iovec iov[2];
+	uint8_t hdr[36];
 
-		params.ssid = (void *) config->ssid;
-		params.ssid_len = config->ssid_len;
+	memset(hdr, 0, sizeof(hdr));
 
-		l_debug("Scanning for %s", config->ssid);
+	iov[0].iov_len = dpp_build_mpdu_header(netdev_get_address(dpp->netdev),
+						dpp->peer_addr, hdr);
+	iov[0].iov_base = hdr;
 
-		dpp->connect_scan_id = scan_active_full(dpp->wdev_id, &params,
-						dpp_scan_triggered,
-						dpp_scan_results, dpp,
-						dpp_scan_destroy);
-		if (dpp->connect_scan_id) {
-			dpp->config = config;
-			return;
-		}
-	}
+	iov[1].iov_base = (void *)data;
+	iov[1].iov_len = len;
 
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 
 static void dpp_roc_started(void *user_data)
 {
 	struct dpp *dpp = user_data;
 
-	/*
-	 * - If a configurator, nothing to do but wait for a request
-	 *   (unless multicast frame registration is unsupported in which case
-	 *   send an authenticate request now)
-	 * - If in the presence state continue sending announcements.
-	 * - If authenticating, and this is a result of a channel switch send
-	 *   the authenticate response now.
-	 */
-
 	dpp->roc_started = true;
 
+	dpp_sm_set_write_handler(dpp->sm, dpp_tx_frame);
+
 	/*
 	 * The retry timer indicates a frame was not acked in which case we
 	 * should not change any state or send any frames until that expires.
@@ -733,6 +725,8 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 	dpp->offchannel_id = 0;
 	dpp->roc_started = false;
 
+	dpp_sm_set_write_handler(dpp->sm, NULL);
+
 	/*
 	 * If cancelled this is likely due to netdev going down or from Stop().
 	 * Otherwise there was some other problem which is probably not
@@ -790,6 +784,8 @@ static void dpp_start_offchannel(struct dpp *dpp, uint32_t freq)
 	if (dpp->offchannel_id)
 		offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 
+	l_debug("starting offchannel on frequency %u, dwell=%u", freq, dpp->dwell);
+
 	dpp->offchannel_id = id;
 }
 
@@ -797,23 +793,16 @@ static void dpp_handle_frame(struct dpp *dpp,
 				const struct mmpdu_header *frame,
 				const void *body, size_t body_len)
 {
-	const uint8_t *ptr;
+	if (!dpp->sm)
+		return;
 
-	/*
-	 * Both handlers offset by 8 bytes to reach the beginning of the DPP
-	 * attributes. Easier checking this in one place, which also covers the
-	 * frame type byte.
-	 */
-	if (body_len < 8)
+	/* Frame from a different device after DPP has already started */
+	if (dpp->peer_accepted && memcmp(dpp->peer_addr, frame->address_2, 6))
 		return;
 
-	ptr = body + 7;
+	memcpy(dpp->peer_addr, frame->address_2, 6);
 
-	switch (*ptr) {
-	default:
-		l_debug("Unhandled DPP frame %u", *ptr);
-		break;
-	}
+	dpp_handle_rx(dpp->sm, body + 1, body_len - 1);
 }
 
 static bool match_wdev(const void *a, const void *b)
@@ -851,6 +840,7 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 	bool ack = false;
 	struct iovec iov;
 	uint8_t cmd = l_genl_msg_get_command(msg);
+	enum dpp_state state;
 
 	if (cmd != NL80211_CMD_FRAME_TX_STATUS)
 		return;
@@ -863,16 +853,17 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 		return;
 
 	dpp = l_queue_find(dpp_list, match_wdev, &wdev_id);
-	if (!dpp)
+	if (!dpp || !dpp->sm)
 		return;
 
+	state = dpp_sm_get_state(dpp->sm);
+
 	/*
 	 * Don't retransmit for presence or PKEX exchange if an enrollee, both
 	 * are broadcast frames which don't expect an ack.
 	 */
-	if (dpp->state == DPP_STATE_NOTHING ||
-			dpp->state == DPP_STATE_PRESENCE ||
-			(dpp->state == DPP_STATE_PKEX_EXCHANGE &&
+	if (state == DPP_STATE_PRESENCE ||
+			(state == DPP_STATE_PKEX_EXCHANGE &&
 			dpp->role == DPP_CAPABILITY_ENROLLEE))
 		return;
 
@@ -886,20 +877,6 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 	if (!ack)
 		goto retransmit;
 
-	/*
-	 * Special handling for a channel transition when acting as a
-	 * configurator. The auth request was sent offchannel so we need to
-	 * wait for the ACK before going back to the connected channel.
-	 */
-	if (dpp->channel_switch) {
-		if (dpp->offchannel_id) {
-			offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
-			dpp->offchannel_id = 0;
-		}
-
-		dpp->channel_switch = false;
-	}
-
 	return;
 
 retransmit:
@@ -1035,7 +1012,7 @@ static void dpp_station_state_watch(enum station_state state, void *user_data)
 {
 	struct dpp *dpp = user_data;
 
-	if (dpp->state == DPP_STATE_NOTHING)
+	if (!dpp->sm)
 		return;
 
 	switch (state) {
@@ -1089,17 +1066,20 @@ static void dpp_create(struct netdev *netdev)
 	uint8_t dpp_conf_request_prefix[] = { 0x04, 0x0a };
 	uint64_t wdev_id = netdev_get_wdev_id(netdev);
 	struct station *station = station_find(netdev_get_ifindex(netdev));
+	const struct l_ecc_curve *curve = l_ecc_curve_from_ike_group(19);
 
 	dpp->netdev = netdev;
-	dpp->state = DPP_STATE_NOTHING;
 	dpp->interface = DPP_INTERFACE_UNBOUND;
 	dpp->wdev_id = wdev_id;
-
 	dpp->max_roc = wiphy_get_max_roc_duration(wiphy_find_by_wdev(wdev_id));
 	dpp->mcast_support = wiphy_has_ext_feature(
 				wiphy_find_by_wdev(dpp->wdev_id),
 				NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 
+	/* TODO: Support a user-provided key pair */
+	l_ecdh_generate_key_pair(curve, &dpp->boot_private,
+					&dpp->boot_public);
+
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
@@ -1212,6 +1192,175 @@ static void dpp_start_presence(struct dpp *dpp, uint32_t *limit_freqs,
 	dpp_start_offchannel(dpp, dpp->current_freq);
 }
 
+static void dpp_event_success(struct dpp *dpp)
+{
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	struct network *network = NULL;
+	struct scan_bss *bss = NULL;
+	const struct dpp_configuration *config;
+
+	config = dpp_sm_get_configuration(dpp->sm);
+	if (L_WARN_ON(!config))
+		goto reset;
+
+	/*
+	 * We should have a station device, but if not DPP can write the
+	 * credentials out and be done
+	 */
+	if (station) {
+		network = station_network_find(station, config->ssid,
+						SECURITY_PSK);
+		if (network)
+			bss = network_bss_select(network, true);
+	}
+
+	dpp_write_config(config, network);
+
+	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
+	dpp->offchannel_id = 0;
+
+	if (network && bss) {
+		l_debug("delaying connect until settings are synced");
+		return;
+	} else if (station) {
+		struct scan_parameters params = {0};
+
+		params.ssid = (void *) config->ssid;
+		params.ssid_len = config->ssid_len;
+
+		l_debug("Scanning for %s", config->ssid);
+
+		dpp->connect_scan_id = scan_active_full(dpp->wdev_id, &params,
+						dpp_scan_triggered,
+						dpp_scan_results, dpp,
+						dpp_scan_destroy);
+		if (dpp->connect_scan_id)
+			return;
+	}
+
+reset:
+	dpp_reset(dpp);
+}
+
+static void dpp_event_channel_switch(struct dpp *dpp,
+					const uint8_t *attr)
+{
+	uint32_t freq;
+
+	freq = oci_to_frequency(attr[0], attr[1]);
+
+	if (freq == dpp->current_freq)
+		return;
+
+	dpp->current_freq = freq;
+
+	dpp_start_offchannel(dpp, dpp->current_freq);
+
+	/*
+	 * The common code will attempt to write after this, so ensure that
+	 * gets delayed until we are on the right channel
+	 */
+	dpp_sm_set_write_handler(dpp->sm, NULL);
+}
+
+static void dpp_pkex_agent_reply(struct l_dbus_message *message,
+					void *user_data)
+{
+	struct dpp *dpp = user_data;
+	const char *error, *text;
+	const char *code;
+
+	dpp->agent->pending_id = 0;
+
+	l_debug("SharedCodeAgent %s path %s replied", dpp->agent->owner,
+			dpp->agent->path);
+
+	if (l_dbus_message_get_error(message, &error, &text)) {
+		l_error("RequestSharedCode() returned %s(\"%s\")",
+				error, text);
+		return;
+	}
+
+	if (!l_dbus_message_get_arguments(message, "s", &code)) {
+		l_debug("Invalid arguments, check SharedCodeAgent!");
+		return;
+	}
+
+	dpp_sm_set_pkex_key(dpp->sm, code);
+}
+
+static bool dpp_event_pkex_key_requested(struct dpp *dpp,
+					const char *identifier)
+{
+	struct l_dbus_message *msg;
+
+	if (!dpp->agent)
+		return false;
+
+	if (L_WARN_ON(dpp->agent->pending_id))
+		return false;
+
+	msg = l_dbus_message_new_method_call(dbus_get_bus(),
+						dpp->agent->owner,
+						dpp->agent->path,
+						IWD_SHARED_CODE_AGENT_INTERFACE,
+						"RequestSharedCode");
+	l_dbus_message_set_arguments(msg, "s", identifier);
+
+	dpp->agent->pending_id = l_dbus_send_with_reply(dbus_get_bus(),
+							msg,
+							dpp_pkex_agent_reply,
+							dpp, NULL);
+	return dpp->agent->pending_id != 0;
+}
+
+static void dpp_event_peer_accepted(struct dpp *dpp)
+{
+	dpp->peer_accepted = true;
+
+	if (dpp_sm_get_state(dpp->sm) != DPP_STATE_PKEX_EXCHANGE)
+		return;
+
+	dpp_sm_set_pkex_peer_mac(dpp->sm, dpp->peer_addr);
+
+	/*
+	 * PKEX dictates a 200ms timeout waiting for the exchange
+	 * response. After this there is no time requirement for the
+	 * remainder of the protocol. Increase the dwell time so we
+	 * have the best chance of receiving frames since we will now
+	 * remain on a single frequency.
+	 */
+	if (dpp->role == DPP_CAPABILITY_ENROLLEE)
+		dpp->dwell = (dpp->max_roc < 2000) ? dpp->max_roc : 2000;
+}
+
+static void dpp_event(enum dpp_event event, const void *event_data,
+			void *user_data)
+{
+	struct dpp *dpp = user_data;
+
+	switch (event) {
+	case DPP_EVENT_PEER_ACCEPTED:
+		dpp_event_peer_accepted(dpp);
+		break;
+	case DPP_EVENT_CHANNEL_SWITCH:
+		dpp_event_channel_switch(dpp, event_data);
+		break;
+	case DPP_EVENT_PKEX_KEY_REQUESTED:
+		dpp_event_pkex_key_requested(dpp, event_data);
+		break;
+	case DPP_EVENT_FAILED:
+		dpp_reset(dpp);
+		break;
+	case DPP_EVENT_SUCCESS:
+		if (dpp->role == DPP_CAPABILITY_ENROLLEE)
+			dpp_event_success(dpp);
+		else
+			dpp_reset(dpp);
+		break;
+	}
+}
+
 static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
@@ -1219,9 +1368,11 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	struct dpp *dpp = user_data;
 	uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	struct l_dbus_message *reply;
+	const uint8_t *own_asn1;
+	size_t own_asn1_len;
 
-	if (dpp->state != DPP_STATE_NOTHING ||
-				dpp->interface != DPP_INTERFACE_UNBOUND)
+	if (dpp->sm || dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
 	/*
@@ -1234,14 +1385,23 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	} else if (!station)
 		l_debug("No station device, continuing anyways...");
 
-	dpp->state = DPP_STATE_PRESENCE;
+	dpp->sm = dpp_sm_new(dpp_event, dpp->boot_public,
+				dpp->boot_private, dpp);
+
+	dpp_sm_set_role(dpp->sm, DPP_CAPABILITY_ENROLLEE);
+	dpp_sm_start_responder(dpp->sm);
+
+	own_asn1 = dpp_sm_get_own_asn1(dpp->sm, &own_asn1_len);
+
+	dpp->uri = dpp_generate_uri(own_asn1, own_asn1_len, 2,
+					netdev_get_address(dpp->netdev), &freq,
+					1, NULL, NULL);
+
 	dpp->role = DPP_CAPABILITY_ENROLLEE;
 	dpp->interface = DPP_INTERFACE_DPP;
 
 	l_debug("DPP Start Enrollee: %s", dpp->uri);
 
-	dpp->pending = l_dbus_message_ref(message);
-
 	/*
 	 * Going off spec here. Select a single channel to send presence
 	 * announcements on. This will be advertised in the URI. The full
@@ -1251,7 +1411,13 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 
 	dpp_property_changed_notify(dpp);
 
-	return NULL;
+	memcpy(dpp->peer_addr, broadcast, 6);
+
+	reply = l_dbus_message_new_method_return(message);
+
+	l_dbus_message_set_arguments(reply, "s", dpp->uri);
+
+	return reply;
 }
 
 /*
@@ -1284,12 +1450,16 @@ static bool dpp_configurator_start_presence(struct dpp *dpp, const char *uri)
 		return false;
 	}
 
-	if (!l_memeqzero(info->mac, 6))
+	if (!l_memeqzero(info->mac, 6)) {
 		memcpy(dpp->peer_addr, info->mac, 6);
+		/* Set now so we restrict to only frames from this MAC */
+		dpp->peer_accepted = true;
+	}
 
 	if (info->freqs)
 		freqs = scan_freq_set_to_fixed_array(info->freqs, &freqs_len);
 
+	dpp_sm_set_peer_bootstrap(dpp->sm, info->boot_public);
 	dpp_free_uri_info(info);
 
 	dpp_start_presence(dpp, freqs, freqs_len);
@@ -1311,6 +1481,9 @@ static struct l_dbus_message *dpp_start_configurator_common(
 	struct l_settings *settings;
 	struct handshake_state *hs = netdev_get_handshake(dpp->netdev);
 	const char *uri;
+	struct dpp_configuration *config;
+	const uint8_t *own_asn1;
+	size_t own_asn1_len;
 
 	/*
 	 * For now limit the configurator to only configuring enrollees to the
@@ -1331,11 +1504,11 @@ static struct l_dbus_message *dpp_start_configurator_common(
 	if (network_get_security(network) != SECURITY_PSK)
 		return dbus_error_not_supported(message);
 
-	if (dpp->state != DPP_STATE_NOTHING ||
-				dpp->interface != DPP_INTERFACE_UNBOUND)
+	if (dpp->sm || dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	dpp->state = DPP_STATE_PRESENCE;
+	dpp->sm = dpp_sm_new(dpp_event, dpp->boot_public,
+				dpp->boot_private, dpp);
 
 	if (!responder) {
 		if (!l_dbus_message_get_arguments(message, "s", &uri))
@@ -1345,26 +1518,47 @@ static struct l_dbus_message *dpp_start_configurator_common(
 			return dbus_error_invalid_args(message);
 
 		if (!dpp->mcast_support)
-			dpp->state = DPP_STATE_AUTHENTICATING;
-
-		dpp->new_freq = bss->frequency;
+			dpp_sm_set_skip_presence(dpp->sm, true);
 	} else
 		dpp->current_freq = bss->frequency;
 
-	dpp->role = DPP_CAPABILITY_CONFIGURATOR;
-	dpp->interface = DPP_INTERFACE_DPP;
-	dpp->config = dpp_configuration_new(settings,
-						network_get_ssid(network),
+	config = dpp_configuration_new(settings, network_get_ssid(network),
 						hs->akm_suite);
 
+	dpp_sm_set_configuration(dpp->sm, config);
+	dpp_sm_set_role(dpp->sm, DPP_CAPABILITY_CONFIGURATOR);
+
+	own_asn1 = dpp_sm_get_own_asn1(dpp->sm, &own_asn1_len);
+
+	dpp->uri = dpp_generate_uri(own_asn1, own_asn1_len, 2,
+					netdev_get_address(dpp->netdev),
+					&bss->frequency, 1, NULL, NULL);
+	dpp->interface = DPP_INTERFACE_DPP;
+
+	dpp->dwell = (dpp->max_roc < 2000) ? dpp->max_roc : 2000;
+
 	dpp_property_changed_notify(dpp);
 
+	dpp->role = DPP_CAPABILITY_CONFIGURATOR;
+
+	memcpy(dpp->peer_addr, broadcast, 6);
+
 	l_debug("DPP Start Configurator: %s", dpp->uri);
 
 	reply = l_dbus_message_new_method_return(message);
 
 	l_dbus_message_set_arguments(reply, "s", dpp->uri);
 
+	/*
+	 * Configurators acting as responders are always on channel so
+	 * the writes can be done at any point.
+	 */
+	if (responder) {
+		dpp_sm_set_write_handler(dpp->sm, dpp_tx_frame);
+		dpp_sm_start_responder(dpp->sm);
+	} else
+		dpp_sm_start_initiator(dpp->sm);
+
 	return reply;
 }
 
@@ -1480,10 +1674,12 @@ static bool dpp_pkex_scan_notify(int err, struct l_queue *bss_list,
 start:
 	dpp->current_freq = dpp->freqs[0];
 
-	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
+	l_debug("PKEX start enrollee");
 
 	dpp_start_offchannel(dpp, dpp->current_freq);
 
+	dpp_sm_pkex_start_initiator(dpp->sm);
+
 	return false;
 
 failed:
@@ -1503,14 +1699,20 @@ static bool dpp_start_pkex_enrollee(struct dpp *dpp, const char *key,
 {
 	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
 
+	dpp->sm = dpp_sm_new(dpp_event, dpp->boot_public,
+				dpp->boot_private, dpp);
+
 	if (identifier)
-		dpp->pkex_id = l_strdup(identifier);
+		dpp_sm_set_pkex_identifier(dpp->sm, identifier);
+
+	dpp_sm_set_pkex_key(dpp->sm, key);
+	dpp_sm_set_pkex_own_mac(dpp->sm, netdev_get_address(dpp->netdev));
+	dpp_sm_set_role(dpp->sm, DPP_CAPABILITY_ENROLLEE);
 
-	dpp->pkex_key = l_strdup(key);
 	memcpy(dpp->peer_addr, broadcast, 6);
 	dpp->role = DPP_CAPABILITY_ENROLLEE;
-	dpp->state = DPP_STATE_PKEX_EXCHANGE;
 	dpp->interface = DPP_INTERFACE_PKEX;
+
 	/*
 	 * In theory a driver could support a lesser duration than 200ms. This
 	 * complicates things since we would need to tack on additional
@@ -1596,8 +1798,7 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 
 	l_debug("");
 
-	if (dpp->state != DPP_STATE_NOTHING ||
-				dpp->interface != DPP_INTERFACE_UNBOUND)
+	if (dpp->sm || dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
 	if (station && station_get_connected_network(station))
@@ -1651,9 +1852,9 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp *dpp,
 	struct network *network = station_get_connected_network(station);
 	struct scan_bss *bss = station_get_connected_bss(station);
 	const struct l_settings *settings;
+	struct dpp_configuration *config;
 
-	if (dpp->state != DPP_STATE_NOTHING ||
-				dpp->interface != DPP_INTERFACE_UNBOUND)
+	if (dpp->sm || dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
 	if (!dpp->mcast_support) {
@@ -1671,30 +1872,39 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp *dpp,
 		return dbus_error_not_configured(message);
 	}
 
+	dpp->sm = dpp_sm_new(dpp_event, dpp->boot_public,
+				dpp->boot_private, dpp);
+
 	if (identifier)
-		dpp->pkex_id = l_strdup(identifier);
+		dpp_sm_set_pkex_identifier(dpp->sm, identifier);
 
 	if (key)
-		dpp->pkex_key = l_strdup(key);
+		dpp_sm_set_pkex_key(dpp->sm, key);
 
 	if (agent_path)
 		dpp_create_agent(dpp, agent_path, message);
 
 	dpp->role = DPP_CAPABILITY_CONFIGURATOR;
-	dpp->state = DPP_STATE_PKEX_EXCHANGE;
 	dpp->interface = DPP_INTERFACE_PKEX;
 	dpp->current_freq = bss->frequency;
-	dpp->config = dpp_configuration_new(network_get_settings(network),
+	config = dpp_configuration_new(network_get_settings(network),
 						network_get_ssid(network),
 						hs->akm_suite);
 
+	dpp_sm_set_role(dpp->sm, DPP_CAPABILITY_CONFIGURATOR);
+	dpp_sm_set_configuration(dpp->sm, config);
+	dpp_sm_set_pkex_own_mac(dpp->sm, netdev_get_address(dpp->netdev));
+	dpp_sm_set_write_handler(dpp->sm, dpp_tx_frame);
+
 	dpp_property_changed_notify(dpp);
 
-	if (dpp->pkex_key)
+	if (key)
 		l_debug("Starting PKEX configurator for single enrollee");
 	else
 		l_debug("Starting PKEX configurator with agent");
 
+	dpp_sm_pkex_start_responder(dpp->sm);
+
 	return l_dbus_message_new_method_return(message);
 }
 
-- 
2.34.1

