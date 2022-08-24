Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE122F59
	for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 22:55:27 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id m15so10490405pjj.3
        for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9u5Xl3fef5oPcANgkE5tljtsJ5eLwZ8JxIbsPz9x8kc=;
        b=DaYaNhKvFczTGGFki8kSmpmhA1W/VwDpNhZGLXlx4gpuiI6zJ4vlI6mYVgbic7LnqX
         u1kWThTiTKlhdbqis1RKplK0h3lbNRe+KWgE8FceVKzOPVz1DdDCqTLVt88cFHUmR8tJ
         PDUda+0uaAqw9mnb74afJU2wZE6RF536JzCi0X/PxQY0CbrHQgyZM1tzZ3lD1qdm+YbL
         VNrKoEAdw4bFCH6pZBldQw45FrWXgvfUXAe50iy4/QIx0NoCERSHLya+5he7UBJoBxpj
         vphSspYzW8y66JARrr46S34dvHai7doIupM7f9mZeC8naabNkZHQMMgESGn+VLwohy+L
         VAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9u5Xl3fef5oPcANgkE5tljtsJ5eLwZ8JxIbsPz9x8kc=;
        b=PnHHUfWrplsUEnUnr/ivsJhUgz2WA5uDL5ejGheTMc1m8PiaIb93JsANazSVcRaCE8
         Gi0/IdnRpELTmIwCWOh99bKml56dV8aaBIvZ/WSwEtVQlUsoy+YucFF1TJz8p6E+dKrh
         Xrfrd3oDhc3L1FZKVfLPbkQ3SzxSzNplsTrPUZNZrRgdcAYFxYbC2dQmoMCRmhULoxWd
         wxNZUWYLB4GLgMWHguQFkH86j49qVa+ufNCBDmkK8oksDrRYa69jWfqnVnb6nhITr0/b
         XshLyBZr+s5C2MnAeDtfpW8nlK+eT+Heej7Uj15Wm/21dm5aASJjsBwtxEsBOxdBaynr
         vD9w==
X-Gm-Message-State: ACgBeo3LKZBTVpg71MaPjKiot5kci5g8IsdezK4HxxBBJGYpMXeO2T8f
	qOWTBCPlTEN3y8ie7GbYHjnbQvQ47cU=
X-Google-Smtp-Source: AA6agR7Re49U6z4WYq57EyzSey6DwF8HUn0tRbfavB5znxzy1yvzLINWE6atte2oJeR2elYhNYHgWA==
X-Received: by 2002:a17:902:f64f:b0:172:a790:320a with SMTP id m15-20020a170902f64f00b00172a790320amr916191plg.149.1661381727079;
        Wed, 24 Aug 2022 15:55:27 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b0016bcc35000asm6228682plb.302.2022.08.24.15.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:55:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/9] ft: netdev: prep for FT isolation into ft.c
Date: Wed, 24 Aug 2022 15:55:14 -0700
Message-Id: <20220824225518.2558698-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220824225518.2558698-1-prestwoj@gmail.com>
References: <20220824225518.2558698-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently netdev handles caching FT auth information and uses FT
parsers/auth-proto to manage the protocol. This sets up to remove
this state machine from netdev and isolate it into ft.c.

This does not break the existing auth-proto (hence the slight
modifications, which will be removed soon).

Eventually the auth-proto will be removed from FT entirely, replaced
just by an FT state machine, similar to how EAPoL works (netdev hooks
to TX/RX frames).
---
 src/ft.c     | 337 +++++++++++++++++++++++++++++++++++++++++++++++++--
 src/ft.h     |  20 ++-
 src/netdev.c |  47 ++++---
 3 files changed, 377 insertions(+), 27 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 7ae78476..2c9c92e6 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -33,6 +33,33 @@
 #include "src/mpdu.h"
 #include "src/auth-proto.h"
 #include "src/band.h"
+#include "src/scan.h"
+#include "src/frame-xchg.h"
+#include "src/util.h"
+#include "src/netdev.h"
+#include "src/module.h"
+
+static ft_tx_action_func_t tx_action = NULL;
+static ft_tx_associate_func_t tx_assoc = NULL;
+static struct l_queue *sm_list = NULL;
+
+struct ft_info {
+	uint8_t spa[6];
+	uint8_t aa[6];
+	uint8_t snonce[32];
+	uint8_t mde[3];
+	uint8_t *fte;
+	uint8_t *authenticator_ie;
+
+	struct ie_ft_info ft_info;
+
+	bool parsed : 1;
+};
+
+struct ft_info_finder {
+	const uint8_t *spa;
+	const uint8_t *aa;
+};
 
 struct ft_sm {
 	struct auth_proto ap;
@@ -45,8 +72,24 @@ struct ft_sm {
 	void *user_data;
 
 	bool over_ds : 1;
+
+	uint8_t prev_bssid[6];
+	struct l_queue *ft_auths;
 };
 
+static bool match_ifindex(const void *a, const void *data)
+{
+	const struct ft_sm *sm = a;
+	uint32_t ifindex = L_PTR_TO_UINT(data);
+
+	return sm->hs->ifindex == ifindex;
+}
+
+static struct ft_sm *ft_sm_find(uint32_t ifindex)
+{
+	return l_queue_find(sm_list, match_ifindex, L_UINT_TO_PTR(ifindex));
+}
+
 /*
  * Calculate the MIC field of the FTE and write it directly to that FTE,
  * assuming it was all zeros before.  See 12.8.4 and 12.8.5.
@@ -286,7 +329,7 @@ static int ft_tx_reassociate(struct ft_sm *ft)
 		iov_elems += 1;
 	}
 
-	return ft->tx_assoc(iov, iov_elems, ft->user_data);
+	return tx_assoc(ft->hs->ifindex, ft->prev_bssid, iov, iov_elems);
 
 error:
 	return -EINVAL;
@@ -328,7 +371,7 @@ static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
 	return true;
 }
 
-static int ft_parse_ies(struct handshake_state *hs,
+static int parse_ies(struct handshake_state *hs,
 			const uint8_t *authenticator_ie,
 			const uint8_t *ies, size_t ies_len,
 			const uint8_t **mde_out,
@@ -460,7 +503,7 @@ bool ft_over_ds_parse_action_ies(struct ft_ds_info *info,
 	const uint8_t *fte = NULL;
 	bool is_rsn = hs->supplicant_ie != NULL;
 
-	if (ft_parse_ies(hs, info->authenticator_ie, ies, ies_len,
+	if (parse_ies(hs, info->authenticator_ie, ies, ies_len,
 				&mde, &fte) < 0)
 		return false;
 
@@ -492,7 +535,7 @@ static int ft_process_ies(struct handshake_state *hs, const uint8_t *ies,
 	if (!ies)
 		goto ft_error;
 
-	if (ft_parse_ies(hs, hs->authenticator_ie, ies, ies_len,
+	if (parse_ies(hs, hs->authenticator_ie, ies, ies_len,
 				&mde, &fte) < 0)
 		goto ft_error;
 
@@ -634,10 +677,9 @@ auth_error:
 	return (int)status_code;
 }
 
-static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
-				size_t frame_len)
+int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 {
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
+	struct ft_sm *ft = ft_sm_find(ifindex);
 	struct handshake_state *hs = ft->hs;
 	uint32_t kck_len = handshake_state_get_kck_len(hs);
 	const uint8_t *rsne = NULL;
@@ -651,6 +693,9 @@ static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
 					&mde, &fte))
 		return -EBADMSG;
 
+	if (out_status != 0)
+		return (int)out_status;
+
 	/*
 	 * During a transition in an RSN, check for an RSNE containing the
 	 * PMK-R1-Name and the remaining fields same as in the advertised
@@ -771,6 +816,14 @@ static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
 	return 0;
 }
 
+static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
+				size_t frame_len)
+{
+	struct ft_sm *sm = l_container_of(ap, struct ft_sm, ap);
+
+	return __ft_rx_associate(sm->hs->ifindex, frame, frame_len);
+}
+
 static int ft_rx_oci(struct auth_proto *ap)
 {
 	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
@@ -778,10 +831,12 @@ static int ft_rx_oci(struct auth_proto *ap)
 	return ft_tx_reassociate(ft);
 }
 
-static void ft_sm_free(struct auth_proto *ap)
+static void ft_auth_proto_free(struct auth_proto *ap)
 {
 	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
 
+	l_queue_remove(sm_list, ft);
+
 	l_free(ft);
 }
 
@@ -899,9 +954,13 @@ struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 	ft->ap.rx_authenticate = ft_rx_authenticate;
 	ft->ap.rx_associate = ft_rx_associate;
 	ft->ap.start = ft_start;
-	ft->ap.free = ft_sm_free;
+	ft->ap.free = ft_auth_proto_free;
 	ft->ap.rx_oci = ft_rx_oci;
 
+	memcpy(ft->prev_bssid, hs->aa, 6);
+
+	l_queue_push_tail(sm_list, ft);
+
 	return &ft->ap;
 }
 
@@ -918,7 +977,265 @@ struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
 
 	ft->ap.rx_associate = ft_rx_associate;
 	ft->ap.start = ft_over_ds_start;
-	ft->ap.free = ft_sm_free;
+	ft->ap.free = ft_auth_proto_free;
+
+	memcpy(ft->prev_bssid, hs->aa, 6);
+
+	l_queue_push_tail(sm_list, ft);
 
 	return &ft->ap;
 }
+
+void __ft_set_tx_action_func(ft_tx_action_func_t func)
+{
+	tx_action = func;
+}
+
+void __ft_set_tx_associate_func(ft_tx_associate_func_t func)
+{
+	tx_assoc = func;
+}
+
+static bool match_ft_info(const void *a, const void *b)
+{
+	const struct ft_info *info = a;
+	const struct ft_info_finder *finder = b;
+
+	if (memcmp(info->spa, finder->spa, 6))
+		return false;
+	if (memcmp(info->aa, finder->aa, 6))
+		return false;
+
+	return true;
+}
+
+static bool ft_parse_ies(struct ft_info *info, struct handshake_state *hs,
+			const uint8_t *ies, size_t ies_len)
+{
+	const uint8_t *mde = NULL;
+	const uint8_t *fte = NULL;
+	bool is_rsn = hs->supplicant_ie != NULL;
+
+	if (parse_ies(hs, info->authenticator_ie, ies, ies_len,
+				&mde, &fte) < 0)
+		return false;
+
+	if (!mde_equal(info->mde, mde))
+		goto ft_error;
+
+	if (is_rsn) {
+		if (!ft_parse_fte(hs, info->snonce, fte, &info->ft_info))
+			goto ft_error;
+
+		info->fte = l_memdup(fte, fte[1] + 2);
+	} else if (fte)
+		goto ft_error;
+
+	return true;
+
+ft_error:
+	return false;
+}
+
+static void ft_action_response_cb(const struct mmpdu_header *hdr,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
+{
+	struct ft_sm *sm = user_data;
+	struct ft_info *info;
+	int ret;
+	const uint8_t *aa;
+	const uint8_t *spa;
+	const uint8_t *ies;
+	size_t ies_len;
+	struct ft_info_finder finder;
+
+	ret = ft_over_ds_parse_action_response(body, body_len, &spa, &aa,
+						&ies, &ies_len);
+	if (ret != 0)
+		return;
+
+	finder.spa = spa;
+	finder.aa = aa;
+
+	info = l_queue_find(sm->ft_auths, match_ft_info, &finder);
+	if (!info)
+		return;
+
+	if (!ft_parse_ies(info, sm->hs, ies, ies_len))
+		goto ft_error;
+
+	info->parsed = true;
+
+	return;
+
+ft_error:
+	l_debug("FT-over-DS authenticate to "MAC" failed", MAC_STR(info->aa));
+}
+
+static struct ft_info *ft_info_new(struct handshake_state *hs,
+					const struct scan_bss *target_bss)
+{
+	struct ft_info *info = l_new(struct ft_info, 1);
+
+	memcpy(info->spa, hs->spa, 6);
+	memcpy(info->aa, target_bss->addr, 6);
+	memcpy(info->mde, target_bss->mde, sizeof(info->mde));
+
+	if (target_bss->rsne)
+		info->authenticator_ie = l_memdup(target_bss->rsne,
+						target_bss->rsne[1] + 2);
+
+	l_getrandom(info->snonce, 32);
+
+	return info;
+}
+
+static void ft_info_destroy(void *data)
+{
+	struct ft_info *info = data;
+
+	if (info->fte)
+		l_free(info->fte);
+
+	if (info->authenticator_ie)
+		l_free(info->authenticator_ie);
+
+	l_free(info);
+}
+
+static void ft_prepare_handshake(struct ft_info *info,
+					struct handshake_state *hs)
+{
+	if (!hs->supplicant_ie)
+		return;
+
+	memcpy(hs->snonce, info->snonce, sizeof(hs->snonce));
+
+	handshake_state_set_fte(hs, info->fte);
+
+	handshake_state_set_anonce(hs, info->ft_info.anonce);
+
+	handshake_state_set_kh_ids(hs, info->ft_info.r0khid,
+						info->ft_info.r0khid_len,
+						info->ft_info.r1khid);
+
+	handshake_state_derive_ptk(hs);
+}
+
+static const uint8_t action_ft_response_prefix[] =  { 0x06, 0x02 };
+
+struct ft_sm *ft_sm_new(struct handshake_state *hs)
+{
+	struct ft_sm *sm = l_new(struct ft_sm, 1);
+	struct netdev *netdev = netdev_find(hs->ifindex);
+
+	sm->hs = hs;
+	sm->ft_auths = l_queue_new();
+	sm->over_ds = hs->mde[4] & 1;
+	memcpy(sm->prev_bssid, hs->aa, 6);
+
+	if (sm->over_ds)
+		frame_watch_add(netdev_get_wdev_id(netdev), FRAME_GROUP_FT,
+			0x00d0, action_ft_response_prefix,
+			sizeof(action_ft_response_prefix),
+			ft_action_response_cb, sm, NULL);
+
+	l_queue_push_tail(sm_list, sm);
+
+	return sm;
+}
+
+void ft_sm_free(struct ft_sm *sm)
+{
+	struct netdev *netdev = netdev_find(sm->hs->ifindex);
+
+	if (sm->over_ds)
+		frame_watch_group_remove(netdev_get_wdev_id(netdev),
+					FRAME_GROUP_FT);
+
+	l_queue_destroy(sm->ft_auths, ft_info_destroy);
+
+	l_queue_remove(sm_list, sm);
+
+	l_free(sm);
+}
+
+int ft_action(struct ft_sm *sm, const struct scan_bss *target)
+{
+	struct ft_info *info;
+	uint8_t ft_req[14];
+	struct iovec iov[5];
+	uint8_t ies[512];
+	size_t len;
+	int ret = -EINVAL;
+
+	info = ft_info_new(sm->hs, target);
+
+	ft_req[0] = 6; /* FT category */
+	ft_req[1] = 1; /* FT Request action */
+	memcpy(ft_req + 2, info->spa, 6);
+	memcpy(ft_req + 8, info->aa, 6);
+
+	if (!ft_build_authenticate_ies(sm->hs, info->snonce, ies, &len))
+		goto failed;
+
+	iov[0].iov_base = ft_req;
+	iov[0].iov_len = sizeof(ft_req);
+
+	iov[1].iov_base = ies;
+	iov[1].iov_len = len;
+
+	ret = tx_action(sm->hs->ifindex, sm->hs->aa, iov, 2);
+	if (ret < 0)
+		goto failed;
+
+	l_queue_push_tail(sm->ft_auths, info);
+
+	return 0;
+
+failed:
+	l_free(info);
+	return ret;
+}
+
+int ft_associate(struct ft_sm *sm, const uint8_t *addr)
+{
+	struct ft_info *info;
+	struct ft_info_finder finder;
+
+	finder.spa = sm->hs->spa;
+	finder.aa = addr;
+
+	info = l_queue_find(sm->ft_auths, match_ft_info, &finder);
+	/*
+	 * TODO: Since FT-over-DS is done early, before the time of roaming, it
+	 *       may end up that a completely new BSS is the best candidate and
+	 *       we haven't yet authenticated. We could actually authenticate
+	 *       at this point, but for now just assume the caller will choose
+	 *       a different BSS.
+	 */
+	if (!info)
+		return -ENOENT;
+
+	ft_prepare_handshake(info, sm->hs);
+
+	return ft_tx_reassociate(sm);
+}
+
+static int ft_init(void)
+{
+	sm_list = l_queue_new();
+
+	return 0;
+}
+
+static void ft_exit(void)
+{
+	if (!l_queue_isempty(sm_list))
+		l_warn("stale FT state machines found!");
+
+	l_queue_destroy(sm_list, (l_queue_destroy_func_t)ft_sm_free);
+}
+
+IWD_MODULE(ft, ft_init, ft_exit);
diff --git a/src/ft.h b/src/ft.h
index dd56da23..6e0f4271 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -21,11 +21,16 @@
  */
 
 struct handshake_state;
+struct scan_bss;
+
+typedef int (*ft_tx_action_func_t)(uint32_t ifindex, const uint8_t *dest,
+					struct iovec *iov, size_t iov_len);
 
 typedef void (*ft_tx_authenticate_func_t)(struct iovec *iov, size_t iov_len,
 					void *user_data);
-typedef int (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_len,
-					void *user_data);
+typedef int (*ft_tx_associate_func_t)(uint32_t ifindex,
+					const uint8_t *prev_bssid,
+					struct iovec *ie_iov, size_t iov_len);
 typedef int (*ft_get_oci)(void *user_data);
 
 typedef void (*ft_ds_free_func_t)(void *user_data);
@@ -71,3 +76,14 @@ struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
 
 bool ft_over_ds_prepare_handshake(struct ft_ds_info *info,
 					struct handshake_state *hs);
+
+void __ft_set_tx_action_func(ft_tx_action_func_t func);
+void __ft_set_tx_associate_func(ft_tx_associate_func_t func);
+int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame,
+			size_t frame_len);
+
+struct ft_sm *ft_sm_new(struct handshake_state *hs);
+void ft_sm_free(struct ft_sm *sm);
+
+int ft_action(struct ft_sm *sm, const struct scan_bss *target);
+int ft_associate(struct ft_sm *sm, const uint8_t *addr);
diff --git a/src/netdev.c b/src/netdev.c
index 36e9fc26..7a1dbc0f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4360,6 +4360,25 @@ static uint32_t netdev_send_action_frame(struct netdev *netdev,
 						user_data);
 }
 
+static void netdev_ft_action_cb(struct l_genl_msg *msg, void *user_data)
+{
+	if (l_genl_msg_get_error(msg) < 0)
+		l_debug("Failed to send FT-Action");
+}
+
+static int netdev_tx_ft_action_frame(uint32_t ifindex, const uint8_t *dest,
+					struct iovec *iov, size_t iov_len)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+
+	if (!netdev_send_action_framev(netdev, dest, iov, iov_len,
+					netdev->frequency,
+					netdev_ft_action_cb, NULL))
+		return -EIO;
+
+	return 0;
+}
+
 static void netdev_cmd_authenticate_ft_cb(struct l_genl_msg *msg,
 						void *user_data)
 {
@@ -4402,11 +4421,10 @@ restore_snonce:
 					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
-static int netdev_ft_tx_associate(struct iovec *ft_iov, size_t n_ft_iov,
-					void *user_data)
+static int netdev_ft_tx_associate(uint32_t ifindex, const uint8_t *prev_bssid,
+					struct iovec *ft_iov, size_t n_ft_iov)
 {
-	struct netdev *netdev = user_data;
-	struct auth_proto *ap = netdev->ap;
+	struct netdev *netdev = netdev_find(ifindex);
 	struct handshake_state *hs = netdev->handshake;
 	struct l_genl_msg *msg;
 	struct iovec iov[64];
@@ -4427,7 +4445,7 @@ static int netdev_ft_tx_associate(struct iovec *ft_iov, size_t n_ft_iov,
 	mpdu_sort_ies(subtype, iov, c_iov);
 
 	l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, ETH_ALEN,
-				ap->prev_bssid);
+				prev_bssid);
 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, c_iov);
 
 	netdev->connect_cmd_id = l_genl_family_send(nl80211, msg,
@@ -4639,17 +4657,15 @@ int netdev_fast_transition(struct netdev *netdev,
 			l_get_le16(target_bss->mde))
 		return -EINVAL;
 
-	prepare_ft(netdev, target_bss);
-
-	handshake_state_new_snonce(netdev->handshake);
-
 	netdev->connect_cb = cb;
 
 	netdev->ap = ft_over_air_sm_new(netdev->handshake,
 					netdev_ft_tx_authenticate,
 					netdev_ft_tx_associate,
 					netdev_get_oci, netdev);
-	memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
+	prepare_ft(netdev, target_bss);
+
+	handshake_state_new_snonce(netdev->handshake);
 
 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
 				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
@@ -4681,16 +4697,14 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
 	if (!info || !info->parsed)
 		return -ENOENT;
 
-	prepare_ft(netdev, target_bss);
-
-	ft_over_ds_prepare_handshake(&info->super, netdev->handshake);
-
 	netdev->connect_cb = cb;
 
 	netdev->ap = ft_over_ds_sm_new(netdev->handshake,
 					netdev_ft_tx_associate,
 					netdev);
-	memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
+	prepare_ft(netdev, target_bss);
+
+	ft_over_ds_prepare_handshake(&info->super, netdev->handshake);
 
 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
 				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
@@ -6635,6 +6649,9 @@ static int netdev_init(void)
 	__eapol_set_tx_packet_func(netdev_control_port_frame);
 	__eapol_set_install_pmk_func(netdev_set_pmk);
 
+	__ft_set_tx_action_func(netdev_tx_ft_action_frame);
+	__ft_set_tx_associate_func(netdev_ft_tx_associate);
+
 	unicast_watch = l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
 						netdev_unicast_notify,
 						NULL, NULL);
-- 
2.34.3

