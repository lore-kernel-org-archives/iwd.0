Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4EC6167D
	for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350024; cv=none; b=qtaEP8DdLhJ8sNVdk+DPJlqg5pe1Nr2ym7KUgz2MAPIm2npgAyNlgFOV0yAhzy94Z3Wkl1ZC1a58KznAxK1CzvXpMPjNPDLu0ogQ7eI38sw40elSMo9Ca5OQGJv+HS1TD1AZN1rQR326BLfZymBd4n/kV3P++N2wiqYV6hAsBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350024; c=relaxed/simple;
	bh=RyRQuBH1LxzpSV56XjuyxRfcocsO2kVbhhqeZ0VSBvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ErI6o5jGoK8DM3BaHqD5I9lusZcFQVD+kTcOG3XEgYEI4LHbtk9eVSUQbJ6pNXOdsXhkdbl/yJyhYFUixa3bO7DU1pP3oik3BZa0Da+JEBy4f05kzYYdZkQEcpvbT58x2ZG1HirpF9vEaYQebAPumPIErx0huJoI4HOnMSDVeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNpfCePK; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNpfCePK"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7882dd2b1c9so9735185a.1
        for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710350021; x=1710954821; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hmvr3guvtsSvUSiUxFQItOc7jCBwPLc/JfCKLcCWcU=;
        b=kNpfCePK+HGb0Uc5Dixn/H916ZuhwtVtN1rA7G40sKKNqn3vYK3N5wjC7QnbHyfRrT
         O+Fa+v7Jl6bw/mb/iqQtkiYCEyVQ8P933IADRNjIgBCRMFNNgv0Oq+A9+p01Ga3IQCAg
         ivDl5WEiHLVdXxvrV2X298cO45lZyxAbAVGubxlJdKOpP1HceMv3fbErawRqczAjjKks
         Ptc26laYC8Nzly5uXpFHQmBLWp2kqfJJWdlwY5CApNWuW1DckNVF6Tksy/c5tyQaVnud
         WeZ1ProgPmsnxcrXfzJLqxh+Zn5feLOeOze5AAghmqYseEiOH5+gkl71+STcwFyCb6sW
         6D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350021; x=1710954821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Hmvr3guvtsSvUSiUxFQItOc7jCBwPLc/JfCKLcCWcU=;
        b=nM9cDCip6PQkmIeXhzUdIYMF0BCpIajTzNpiWqRxIgmC+zdmuPraOM4bZXaacqj8xk
         z0C71LtvAl4UWFxJL3Z3g/VdKpKHjGszXdfoBHZNzVc1eXP0UL3JwEf6E/HlGFaJDd3I
         PVxxSLifJSSh3+QcShnPb2NH8DLMMYztQzQRVqoXkxCOKKdqxCNp41N+vEIeX5fWJho4
         IVVW790BsL6WRFN7mLj4J1Xo/+1Z7bt0it/0BFVL8+msMcdJKkPgU3jgZ7ypdR+km7aJ
         wbvHwCXL5mz++fWXDLuyD+tFJHK6lyx7QsiQYv+i+wwqRizohtzS5uZwrRSS/GNWz/qt
         Z+PQ==
X-Gm-Message-State: AOJu0Yxieqa0mF0l118r6/6aU6GboVREN8JTqKHy8TWsU+8JiWNP4Daz
	HZbQV7XssOYwO6IbWPoSNTKoJuwShqaC0Q2h2CXGsWbYWjVR0DPTV05GH4Hn
X-Google-Smtp-Source: AGHT+IHmdCk+sO6T2qjvC7w6AuDzNyEATeExgfoA/x8a17uJTaqt73J/vE8P1y/H3EwUFlHAKLMdTA==
X-Received: by 2002:a05:620a:17a5:b0:788:79d3:4029 with SMTP id ay37-20020a05620a17a500b0078879d34029mr716997qkb.33.1710350020666;
        Wed, 13 Mar 2024 10:13:40 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id i4-20020ae9ee04000000b007882e204d45sm4927136qkg.37.2024.03.13.10.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:13:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 5/5] dpp-common: Skeleton for common DPP module
Date: Wed, 13 Mar 2024 10:13:11 -0700
Message-Id: <20240313171311.695830-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313171311.695830-1-prestwoj@gmail.com>
References: <20240313171311.695830-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to expand the features for DPP e.g. TCP or a DPP controller
the state machine needs to be both transport agnostic and buildable
for other apps outside of IWD-core.

To do this the core DPP state machine is being moved into a common
module. The consumers of the common SM will create a dpp_sm object
for each protocol run, and destroy it afterwards. The SM will take
a write callback, event callback, the boostrapping keys, and expose
a read handler:

 - The write callback will be called by the SM whenever there is a
   frame to be sent out. In order to support 802.11 encapsulation
   dpp_sm_set_write_handler can be used to notify the SM that writes
   are allowed or disallowed (by passing NULL). This is done to
   allow the 802.11 encapsulating module to prepare any offchannel
   requests before sending out frames.
 - The event callback is called by the SM whenever there are events
   requiring some handling by the encapsulating protocol, or when
   DPP has succeeded or failed.
 - The read handler can be called by the encapsulating protocol
   in order to RX frames to the SM.

Making the SM common will allow both pure-802.11 DPP and
DPP-over-TCP to utilize the same state machine. In addition a
DPP-controller can now be implemented using the common SM but be
entirely standalone from IWD.
---
 src/dpp-common.c | 517 +++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-common.h | 109 ++++++++++
 2 files changed, 626 insertions(+)
 create mode 100644 src/dpp-common.c
 create mode 100644 src/dpp-common.h

diff --git a/src/dpp-common.c b/src/dpp-common.c
new file mode 100644
index 00000000..af0645df
--- /dev/null
+++ b/src/dpp-common.c
@@ -0,0 +1,517 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2024  Locus Robotics
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+
+#include <ell/ell.h>
+
+#include "linux/nl80211.h"
+
+#include "src/missing.h"
+#include "src/dbus.h"
+#include "src/netdev.h"
+#include "src/module.h"
+#include "src/dpp-util.h"
+#include "src/band.h"
+#include "src/frame-xchg.h"
+#include "src/offchannel.h"
+#include "src/wiphy.h"
+#include "src/ie.h"
+#include "src/iwd.h"
+#include "src/util.h"
+#include "src/crypto.h"
+#include "src/mpdu.h"
+#include "ell/useful.h"
+#include "src/common.h"
+#include "src/json.h"
+#include "src/storage.h"
+#include "src/station.h"
+#include "src/scan.h"
+#include "src/network.h"
+#include "src/handshake.h"
+#include "src/nl80211util.h"
+#include "src/knownnetworks.h"
+#include "src/dpp-common.h"
+
+#define DPP_HDR_LEN			6
+#define DPP_ACTION_VENDOR_SPECIFIC	0x09
+#define DPP_ACTION_GAS_REQUEST		0x0a
+#define DPP_ACTION_GAS_RESPONSE		0x0b
+#define DPP_AUTH_PROTO_TIMEOUT		10
+#define DPP_PKEX_PROTO_TIMEOUT		120
+
+struct dpp_sm {
+	char *uri;
+	uint8_t role;
+
+	uint8_t *own_asn1;
+	size_t own_asn1_len;
+	uint8_t *peer_asn1;
+	size_t peer_asn1_len;
+	uint8_t own_boot_hash[32];
+	uint8_t peer_boot_hash[32];
+	uint8_t own_chirp_hash[32];
+	const struct l_ecc_curve *curve;
+	size_t key_len;
+	size_t nonce_len;
+	struct l_ecc_scalar *boot_private;
+	struct l_ecc_point *boot_public;
+	struct l_ecc_point *peer_boot_public;
+
+	enum dpp_state state;
+
+	uint8_t r_nonce[32];
+	uint8_t i_nonce[32];
+	uint8_t e_nonce[32];
+
+	struct l_ecc_scalar *m;
+	uint64_t ke[L_ECC_MAX_DIGITS];
+	uint64_t k1[L_ECC_MAX_DIGITS];
+	uint64_t k2[L_ECC_MAX_DIGITS];
+	uint64_t auth_tag[L_ECC_MAX_DIGITS];
+
+	struct l_ecc_scalar *proto_private;
+	struct l_ecc_point *own_proto_public;
+
+	struct l_ecc_point *peer_proto_public;
+
+	uint8_t diag_token;
+
+	/* Timeout of auth/config/PKEX protocols */
+	uint64_t proto_timeout;
+	struct l_timeout *timeout;
+
+	struct dpp_configuration *config;
+
+	/* PKEX-specific values */
+	char *pkex_id;
+	char *pkex_key;
+	uint8_t pkex_version;
+	struct l_ecc_point *peer_encr_key;
+	struct l_ecc_point *pkex_m;
+	/* Ephemeral key Y' or X' for enrollee or configurator */
+	struct l_ecc_point *y_or_x;
+	/* Ephemeral key pair y/Y or x/X */
+	struct l_ecc_point *pkex_public;
+	struct l_ecc_scalar *pkex_private;
+	uint8_t z[L_ECC_SCALAR_MAX_BYTES];
+	size_t z_len;
+	uint8_t u[L_ECC_SCALAR_MAX_BYTES];
+	size_t u_len;
+	uint8_t pkex_own_mac[6];
+	uint8_t pkex_peer_mac[6];
+	/* Set to either own/peer mac depending on configuration */
+	const uint8_t *mac_initiator;
+	const uint8_t *mac_responder;
+
+	/*
+	 * Since the authenticate frame may request a channel switch we do need
+	 * to expose this detail within the common code.
+	 */
+	uint8_t channel[2];
+
+	uint8_t *frame_pending;
+	size_t frame_len;
+	dpp_write_cb_t write;
+	dpp_event_cb_t event_cb;
+	void *user_data;
+
+	bool skip_presence : 1;
+	bool mutual_auth : 1;
+	bool initiator : 1;
+};
+
+static void dpp_failed(struct dpp_sm *dpp)
+{
+	if (dpp->event_cb)
+		dpp->event_cb(DPP_EVENT_FAILED, NULL, dpp->user_data);
+}
+
+static void dpp_protocol_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	l_debug("DPP timed out");
+
+	dpp_failed(dpp);
+}
+
+static void dpp_reset_protocol_timer(struct dpp_sm *dpp, uint64_t time)
+{
+	if (dpp->timeout)
+		l_timeout_modify(dpp->timeout, time);
+	else
+		dpp->timeout = l_timeout_create(time, dpp_protocol_timeout,
+						dpp, NULL);
+}
+
+struct dpp_sm *dpp_sm_new(dpp_event_cb_t event,
+				const struct l_ecc_point *boot_public,
+				const struct l_ecc_scalar *boot_private,
+				void *user_data)
+{
+	struct dpp_sm *dpp = l_new(struct dpp_sm, 1);
+
+	dpp->state = DPP_STATE_NOTHING;
+	dpp->curve = l_ecc_point_get_curve(boot_public);
+	dpp->key_len = l_ecc_curve_get_scalar_bytes(dpp->curve);
+	dpp->nonce_len = dpp_nonce_len_from_key_len(dpp->key_len);
+	dpp->boot_public = l_ecc_point_clone(boot_public);
+	dpp->boot_private = l_ecc_scalar_clone(boot_private);
+	dpp->own_asn1 = dpp_point_to_asn1(dpp->boot_public, &dpp->own_asn1_len);
+	dpp->event_cb = event;
+	dpp->user_data = user_data;
+
+	dpp_hash(L_CHECKSUM_SHA256, dpp->own_boot_hash, 1, dpp->own_asn1,
+			dpp->own_asn1_len);
+	dpp_hash(L_CHECKSUM_SHA256, dpp->own_chirp_hash, 2, "chirp",
+			strlen("chirp"), dpp->own_asn1, dpp->own_asn1_len);
+
+	return dpp;
+}
+
+void dpp_sm_set_write_handler(struct dpp_sm *dpp, dpp_write_cb_t write)
+{
+	dpp->write = write;
+
+	if (!dpp->write)
+		return;
+
+	/* Handle writing frame */
+}
+
+static void dpp_free_auth_data(struct dpp_sm *dpp)
+{
+	if (dpp->own_proto_public) {
+		l_ecc_point_free(dpp->own_proto_public);
+		dpp->own_proto_public = NULL;
+	}
+
+	if (dpp->proto_private) {
+		l_ecc_scalar_free(dpp->proto_private);
+		dpp->proto_private = NULL;
+	}
+
+	if (dpp->peer_proto_public) {
+		l_ecc_point_free(dpp->peer_proto_public);
+		dpp->peer_proto_public = NULL;
+	}
+
+	if (dpp->peer_boot_public) {
+		l_ecc_point_free(dpp->peer_boot_public);
+		dpp->peer_boot_public = NULL;
+	}
+
+	if (dpp->m) {
+		l_ecc_scalar_free(dpp->m);
+		dpp->m = NULL;
+	}
+
+	if (dpp->pkex_m) {
+		l_ecc_point_free(dpp->pkex_m);
+		dpp->pkex_m = NULL;
+	}
+
+	if (dpp->y_or_x) {
+		l_ecc_point_free(dpp->y_or_x);
+		dpp->y_or_x = NULL;
+	}
+
+	if (dpp->pkex_public) {
+		l_ecc_point_free(dpp->pkex_public);
+		dpp->pkex_public = NULL;
+	}
+
+	if (dpp->pkex_private) {
+		l_ecc_scalar_free(dpp->pkex_private);
+		dpp->pkex_private = NULL;
+	}
+}
+
+static void dpp_free_pending_pkex_data(struct dpp_sm *dpp)
+{
+	if (dpp->pkex_id) {
+		l_free(dpp->pkex_id);
+		dpp->pkex_id = NULL;
+	}
+
+	if (dpp->pkex_key) {
+		l_free(dpp->pkex_key);
+		dpp->pkex_key = NULL;
+	}
+
+	if (dpp->peer_encr_key) {
+		l_ecc_point_free(dpp->peer_encr_key);
+		dpp->peer_encr_key = NULL;
+	}
+}
+
+void dpp_sm_free(struct dpp_sm *dpp)
+{
+	if (dpp->boot_public) {
+		l_ecc_point_free(dpp->boot_public);
+		dpp->boot_public = NULL;
+	}
+
+	if (dpp->boot_private) {
+		l_ecc_scalar_free(dpp->boot_private);
+		dpp->boot_private = NULL;
+	}
+
+	if (dpp->timeout) {
+		l_timeout_remove(dpp->timeout);
+		dpp->timeout = NULL;
+	}
+
+	if (dpp->config) {
+		dpp_configuration_free(dpp->config);
+		dpp->config = NULL;
+	}
+
+	if (dpp->peer_asn1) {
+		l_free(dpp->peer_asn1);
+		dpp->peer_asn1 = NULL;
+	}
+
+	if (dpp->own_asn1) {
+		l_free(dpp->own_asn1);
+		dpp->own_asn1 = NULL;
+	}
+
+	if (dpp->frame_pending) {
+		l_free(dpp->frame_pending);
+		dpp->frame_pending = NULL;
+	}
+
+	dpp->state = DPP_STATE_NOTHING;
+	dpp->pkex_version = 0;
+
+	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
+	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
+	explicit_bzero(dpp->e_nonce, dpp->nonce_len);
+	explicit_bzero(dpp->ke, dpp->key_len);
+	explicit_bzero(dpp->k1, dpp->key_len);
+	explicit_bzero(dpp->k2, dpp->key_len);
+	explicit_bzero(dpp->auth_tag, dpp->key_len);
+	explicit_bzero(dpp->z, dpp->key_len);
+	explicit_bzero(dpp->u, dpp->u_len);
+
+	dpp_free_pending_pkex_data(dpp);
+
+	dpp_free_auth_data(dpp);
+
+	l_free(dpp);
+}
+
+void dpp_sm_set_peer_bootstrap(struct dpp_sm *dpp,
+					struct l_ecc_point *public)
+{
+	dpp->peer_boot_public = public;
+	dpp->peer_asn1 = dpp_point_to_asn1(public, &dpp->peer_asn1_len);
+
+	dpp_hash(L_CHECKSUM_SHA256, dpp->peer_boot_hash, 1, dpp->peer_asn1,
+			dpp->peer_asn1_len);
+}
+
+const uint8_t *dpp_sm_get_own_asn1(struct dpp_sm *dpp, size_t *len)
+{
+	*len = dpp->own_asn1_len;
+
+	return dpp->own_asn1;
+}
+
+void dpp_sm_set_configuration(struct dpp_sm *dpp,
+					struct dpp_configuration *config)
+{
+	dpp->config = config;
+}
+
+const struct dpp_configuration *dpp_sm_get_configuration(struct dpp_sm *dpp)
+{
+	return dpp->config;
+}
+
+void dpp_sm_set_skip_presence(struct dpp_sm *dpp, bool skip)
+{
+	dpp->skip_presence = skip;
+}
+
+void dpp_sm_set_channel(struct dpp_sm *dpp, uint8_t oper_class, uint8_t channel)
+{
+	dpp->channel[0] = oper_class;
+	dpp->channel[1] = channel;
+}
+
+enum dpp_state dpp_sm_get_state(struct dpp_sm *dpp)
+{
+	return dpp->state;
+}
+
+bool dpp_sm_start_initiator(struct dpp_sm *dpp)
+{
+	if (L_WARN_ON(!dpp->peer_boot_public))
+		return false;
+
+	dpp->initiator = true;
+
+	/* Generate the keys for this protocol run */
+	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
+					&dpp->own_proto_public);
+
+	l_getrandom(dpp->i_nonce, dpp->nonce_len);
+
+	dpp->m = dpp_derive_k1(dpp->peer_boot_public,
+				dpp->proto_private, dpp->k1);
+
+	if (dpp->config)
+		dpp->role = DPP_CAPABILITY_CONFIGURATOR;
+	else
+		dpp->role = DPP_CAPABILITY_ENROLLEE;
+
+	dpp->state = DPP_STATE_PRESENCE;
+
+	return true;
+}
+
+bool dpp_sm_start_responder(struct dpp_sm *dpp)
+{
+	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
+					&dpp->own_proto_public);
+	dpp->initiator = false;
+
+	if (dpp->config)
+		dpp->role = DPP_CAPABILITY_CONFIGURATOR;
+	else
+		dpp->role = DPP_CAPABILITY_ENROLLEE;
+
+	dpp->state = DPP_STATE_PRESENCE;
+
+	return true;
+}
+
+void dpp_sm_set_pkex_identifier(struct dpp_sm *dpp, const char *identifier)
+{
+	dpp->pkex_id = l_strdup(identifier);
+}
+
+void dpp_sm_set_pkex_key(struct dpp_sm *dpp, const char *key)
+{
+	dpp->pkex_key = l_strdup(key);
+}
+
+void dpp_sm_set_pkex_own_mac(struct dpp_sm *dpp, const uint8_t *mac)
+{
+	memcpy(dpp->pkex_own_mac, mac, 6);
+}
+
+void dpp_sm_set_pkex_peer_mac(struct dpp_sm *dpp, const uint8_t *mac)
+{
+	memcpy(dpp->pkex_peer_mac, mac, 6);
+
+	if (dpp->initiator) {
+		dpp->mac_responder = dpp->pkex_peer_mac;
+		dpp->mac_initiator = dpp->pkex_own_mac;
+	} else {
+		dpp->mac_initiator = dpp->pkex_peer_mac;
+		dpp->mac_responder = dpp->pkex_own_mac;
+	}
+}
+
+bool dpp_sm_pkex_start_initiator(struct dpp_sm *dpp)
+{
+	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
+
+	if (!dpp->pkex_key)
+		return false;
+
+	dpp->role = dpp->config ? DPP_CAPABILITY_CONFIGURATOR :
+					DPP_CAPABILITY_ENROLLEE;
+
+	/*
+	 * "DPP R2 devices are expected to use PKEXv1 by default"
+	 *
+	 * TODO: Support setting version (v2 required for TCP encapsulation)
+	 */
+	dpp->pkex_version = 1;
+
+	if (!l_ecdh_generate_key_pair(dpp->curve, &dpp->pkex_private,
+					&dpp->pkex_public))
+		return false;
+
+	/*
+	 * "If Qi is the point-at-infinity, the code shall be deleted and the
+	 * user should be notified to provision a new code"
+	 */
+	qi = dpp_derive_qi(dpp->curve, dpp->pkex_key, dpp->pkex_id,
+				dpp->pkex_own_mac);
+	if (!qi || l_ecc_point_is_infinity(qi)) {
+		l_debug("Cannot derive Qi, provision a new code");
+		goto failed;
+	}
+
+	dpp->pkex_m = l_ecc_point_new(dpp->curve);
+
+	if (!l_ecc_point_add(dpp->pkex_m, dpp->pkex_public, qi))
+		goto failed;
+
+	dpp->initiator = true;
+
+	dpp->mac_initiator = dpp->pkex_own_mac;
+	/* Won't know until we receive a response */
+	dpp->mac_responder = NULL;
+
+	dpp_reset_protocol_timer(dpp, DPP_AUTH_PROTO_TIMEOUT);
+
+	/* Send exchange request */
+
+	return true;
+
+failed:
+	return false;
+}
+
+bool dpp_sm_pkex_start_responder(struct dpp_sm *dpp)
+{
+	dpp->initiator = false;
+
+	dpp->mac_responder = dpp->pkex_own_mac;
+	/* Won't know until we receive the first frame */
+	dpp->mac_initiator = NULL;
+
+	dpp->role = dpp->config ? DPP_CAPABILITY_CONFIGURATOR :
+					DPP_CAPABILITY_ENROLLEE;
+	dpp->state = DPP_STATE_PKEX_EXCHANGE;
+	dpp->pkex_version = 1;
+
+	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
+
+	return true;
+}
+
+void dpp_handle_rx(struct dpp_sm *dpp, const uint8_t *data, size_t len)
+{
+	/* Handle frame */
+}
diff --git a/src/dpp-common.h b/src/dpp-common.h
new file mode 100644
index 00000000..19ec45ac
--- /dev/null
+++ b/src/dpp-common.h
@@ -0,0 +1,109 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2024  Locus Robotics
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct dpp_sm;
+struct l_ecc_point;
+struct l_ecc_scalar;
+
+enum dpp_state {
+	DPP_STATE_NOTHING,
+	DPP_STATE_PRESENCE,
+	DPP_STATE_PKEX_EXCHANGE,
+	DPP_STATE_PKEX_COMMIT_REVEAL,
+	DPP_STATE_AUTHENTICATING,
+	DPP_STATE_CONFIGURING,
+};
+
+enum dpp_capability {
+	DPP_CAPABILITY_ENROLLEE = 0x01,
+	DPP_CAPABILITY_CONFIGURATOR = 0x02,
+};
+
+enum dpp_event {
+	/*
+	 * PEER_ACCEPTED indicates an initial DPP frame has been received and
+	 * accepted. This could be either a PKEX or an auth frame when DPP is
+	 * running as either a configurator or enrollee. This should be
+	 * used by the encapsulating protocol to note the peer address (MAC
+	 * or IP) and from then on only accept frames from this peer until DPP
+	 * has completed.
+	 */
+	DPP_EVENT_PEER_ACCEPTED,
+	/*
+	 * The authenticate request frame included a channel attribute. The
+	 * encapsulating protocol must switch to this channel to continue the
+	 * protocol (only applicable to 802.11 encapsulation). Event data is
+	 * two bytes: [oper_class, channel]
+	 */
+	DPP_EVENT_CHANNEL_SWITCH,
+	/*
+	 * A key corresponding to an identifier (set in event_data) is now
+	 * required. The encapsulating protocol must retrieve the key and
+	 * notify using dpp_sm_set_pkex_key().
+	 */
+	DPP_EVENT_PKEX_KEY_REQUESTED,
+	DPP_EVENT_SUCCESS,
+	DPP_EVENT_FAILED,
+};
+
+typedef void (*dpp_event_cb_t)(enum dpp_event event, const void *event_data,
+				void *user_data);
+
+typedef void (*dpp_write_cb_t)(const uint8_t *data, size_t len,
+				void *user_data);
+
+struct dpp_sm *dpp_sm_new(dpp_event_cb_t event,
+				const struct l_ecc_point *boot_public,
+				const struct l_ecc_scalar *boot_private,
+				void *user_data);
+
+void dpp_sm_free(struct dpp_sm *dpp);
+
+void dpp_handle_rx(struct dpp_sm *dpp, const uint8_t *data, size_t len);
+void dpp_sm_set_write_handler(struct dpp_sm *dpp, dpp_write_cb_t write);
+
+void dpp_sm_set_peer_bootstrap(struct dpp_sm *dpp,
+					struct l_ecc_point *public);
+void dpp_sm_set_own_bootstrap(struct dpp_sm *dpp, struct l_ecc_point *public,
+					struct l_ecc_scalar *private);
+const uint8_t *dpp_sm_get_own_asn1(struct dpp_sm *dpp, size_t *len);
+
+void dpp_sm_set_configuration(struct dpp_sm *dpp,
+					struct dpp_configuration *config);
+const struct dpp_configuration *dpp_sm_get_configuration(struct dpp_sm *dpp);
+
+void dpp_sm_set_skip_presence(struct dpp_sm *dpp, bool skip);
+
+void dpp_sm_set_channel(struct dpp_sm *dpp, uint8_t oper_class,
+			uint8_t channel);
+enum dpp_state dpp_sm_get_state(struct dpp_sm *dpp);
+
+bool dpp_sm_start_initiator(struct dpp_sm *dpp);
+bool dpp_sm_start_responder(struct dpp_sm *dpp);
+
+void dpp_sm_set_pkex_identifier(struct dpp_sm *dpp, const char *identifier);
+void dpp_sm_set_pkex_key(struct dpp_sm *dpp, const char *key);
+void dpp_sm_set_pkex_own_mac(struct dpp_sm *dpp, const uint8_t *mac);
+void dpp_sm_set_pkex_peer_mac(struct dpp_sm *dpp, const uint8_t *mac);
+
+bool dpp_sm_pkex_start_initiator(struct dpp_sm *dpp);
+bool dpp_sm_pkex_start_responder(struct dpp_sm *dpp);
-- 
2.34.1

