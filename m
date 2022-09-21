Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23842565
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:03 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id c24so7076992plo.3
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KGa+4Gl3fSVAVfZRcBondV3LMOOzu2nMeFKwUrj6CVo=;
        b=nTZbgdbPe49zW+YVDFN0to3yjbWb/y/ZZLhqRbrCrkP0nceZrLO1ZhtW6+SE2oaKAO
         iJ4UORvSlDZFqGLf9GqucJ8dwbaxcZWhM9aoyDyHF52RgrXw+/a3678jmAcvJtSY7UfA
         sveXzkVvn5I5ffZ1Zq9b1dSqekvRo8W9lE4AOr1PJA4L0pODuGoJIqgzWH5WjAoQ0+Xc
         dUCYDJUZx2QgwtA2WBqxcVYtfN7apTFdKHYyxnU+7HP9+eLeB1YUkTfINbnr2OACoYtB
         PaGmWyXCvj0/NaTVz3Y9cD7fC8e6+cHpZvRdRyu3hlYhu6AQZywuEszrOLvygJjdE2vr
         P9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KGa+4Gl3fSVAVfZRcBondV3LMOOzu2nMeFKwUrj6CVo=;
        b=quSwBRTZDKedaHUb0EwrtG8sVJc0hHd2JZAa+IwFvOa0aJ4E3NjthM3tP4WMMeQ7Pd
         01YSG9fMRBnJUIvmROi8nmc4qFEoYBd/5eXL549iNAVJxs3sjuCeZF7Vl4HSrQitN60Y
         Fb7m5Pnd9HZDBXCV9lS4Bz/5qdgXPTWBXevwW5FPvs+nfuSBJ8EeZYFdgAwBzqV9pB0D
         dTiBjo/rsnz7PqMog5dyRGDj1tqOZd8zWMqTZ3uMoeaaYjYxGtIjGg4mPAtSi8cH6SvB
         Zzk+pqu2MhjWusxrIvnhJ9hwnhk2OHHRni43cqslNa65Ks2Zv5lhRTK9ZpWwYp05ua36
         whPg==
X-Gm-Message-State: ACrzQf3wIuFAdbJ99xnlafN9Zwj1v9XFN0NM2xnqT3U83t5lhflhFy45
	V3Ktuqq7pVr4rMF0/KHHR8z0u8I9JN4=
X-Google-Smtp-Source: AMsMyM7DlKnVi7zvTXUx6SCgyeN2KXVkmEqvXmCp0ITaHEGrSlVsVP+irNFJKIPyVTG+A5ekOIa0PQ==
X-Received: by 2002:a17:90a:6ac5:b0:200:3216:d5fd with SMTP id b5-20020a17090a6ac500b002003216d5fdmr353298pjm.191.1663799523193;
        Wed, 21 Sep 2022 15:32:03 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 05/15] ft: netdev: prep for FT isolation into ft.c
Date: Wed, 21 Sep 2022 15:31:48 -0700
Message-Id: <20220921223158.704658-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
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
 src/ft.c     | 312 ++++++++++++++++++++++++++++++++++++++++++++++++---
 src/ft.h     |  22 +++-
 src/netdev.c |  28 +++--
 3 files changed, 329 insertions(+), 33 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 2285a86f..5f37b29a 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -33,6 +33,30 @@
 #include "src/mpdu.h"
 #include "src/auth-proto.h"
 #include "src/band.h"
+#include "src/scan.h"
+#include "src/util.h"
+#include "src/netdev.h"
+#include "src/module.h"
+
+static ft_tx_frame_func_t tx_frame = NULL;
+static ft_tx_associate_func_t tx_assoc = NULL;
+static struct l_queue *info_list = NULL;
+
+struct ft_info {
+	uint32_t ifindex;
+	uint8_t spa[6];
+	uint8_t aa[6];
+	uint8_t snonce[32];
+	uint8_t mde[3];
+	uint8_t *fte;
+	uint8_t *authenticator_ie;
+	uint8_t prev_bssid[6];
+	uint32_t frequency;
+
+	struct ie_ft_info ft_info;
+
+	bool parsed : 1;
+};
 
 struct ft_sm {
 	struct auth_proto ap;
@@ -45,6 +69,9 @@ struct ft_sm {
 	void *user_data;
 
 	bool over_ds : 1;
+
+	uint8_t prev_bssid[6];
+	struct l_queue *ft_auths;
 };
 
 /*
@@ -202,11 +229,13 @@ static bool ft_parse_associate_resp_frame(const uint8_t *frame, size_t frame_len
 	return true;
 }
 
-static int ft_tx_reassociate(struct ft_sm *ft)
+static int ft_tx_reassociate(uint32_t ifindex, uint32_t freq,
+				const uint8_t *prev_bssid)
 {
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
 	struct iovec iov[3];
 	int iov_elems = 0;
-	struct handshake_state *hs = ft->hs;
 	uint32_t kck_len = handshake_state_get_kck_len(hs);
 	bool is_rsn = hs->supplicant_ie != NULL;
 	uint8_t *rsne = NULL;
@@ -233,9 +262,8 @@ static int ft_tx_reassociate(struct ft_sm *ft)
 		rsn_info.num_pmkids = 1;
 		rsn_info.pmkids = hs->pmk_r1_name;
 
-		/* Always set OCVC false for FT-over-DS */
-		if (ft->over_ds)
-			rsn_info.ocvc = false;
+		/* Always set OCVC false for FT for now */
+		rsn_info.ocvc = false;
 
 		rsne = alloca(256);
 		ie_build_rsne(&rsn_info, rsne);
@@ -306,7 +334,7 @@ static int ft_tx_reassociate(struct ft_sm *ft)
 		iov_elems += 1;
 	}
 
-	return ft->tx_assoc(iov, iov_elems, ft->user_data);
+	return tx_assoc(ifindex, freq, prev_bssid, iov, iov_elems);
 
 error:
 	return -EINVAL;
@@ -348,7 +376,7 @@ static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
 	return true;
 }
 
-static int ft_parse_ies(struct handshake_state *hs,
+static int parse_ies(struct handshake_state *hs,
 			const uint8_t *authenticator_ie,
 			const uint8_t *ies, size_t ies_len,
 			const uint8_t **mde_out,
@@ -480,7 +508,7 @@ bool ft_over_ds_parse_action_ies(struct ft_ds_info *info,
 	const uint8_t *fte = NULL;
 	bool is_rsn = hs->supplicant_ie != NULL;
 
-	if (ft_parse_ies(hs, info->authenticator_ie, ies, ies_len,
+	if (parse_ies(hs, info->authenticator_ie, ies, ies_len,
 				&mde, &fte) < 0)
 		return false;
 
@@ -512,7 +540,7 @@ static int ft_process_ies(struct handshake_state *hs, const uint8_t *ies,
 	if (!ies)
 		goto ft_error;
 
-	if (ft_parse_ies(hs, hs->authenticator_ie, ies, ies_len,
+	if (parse_ies(hs, hs->authenticator_ie, ies, ies_len,
 				&mde, &fte) < 0)
 		goto ft_error;
 
@@ -654,11 +682,10 @@ auth_error:
 	return (int)status_code;
 }
 
-static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
-				size_t frame_len)
+int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 {
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-	struct handshake_state *hs = ft->hs;
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
 	uint32_t kck_len = handshake_state_get_kck_len(hs);
 	const uint8_t *rsne = NULL;
 	const uint8_t *mde = NULL;
@@ -671,6 +698,9 @@ static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
 					&mde, &fte))
 		return -EBADMSG;
 
+	if (out_status != 0)
+		return (int)out_status;
+
 	/*
 	 * During a transition in an RSN, check for an RSNE containing the
 	 * PMK-R1-Name and the remaining fields same as in the advertised
@@ -785,17 +815,25 @@ static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
 						ft_info.igtk_ipn);
 		}
 
-		handshake_state_install_ptk(ft->hs);
+		handshake_state_install_ptk(hs);
 	}
 
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
 
-	return ft_tx_reassociate(ft);
+	return ft_tx_reassociate(ft->hs->ifindex, 0, ft->prev_bssid);
 }
 
 static void ft_sm_free(struct auth_proto *ap)
@@ -809,7 +847,7 @@ static bool ft_over_ds_start(struct auth_proto *ap)
 {
 	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
 
-	return ft_tx_reassociate(ft) == 0;
+	return ft_tx_reassociate(ft->hs->ifindex, 0, ft->prev_bssid) == 0;
 }
 
 bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
@@ -924,6 +962,8 @@ struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 	ft->ap.free = ft_sm_free;
 	ft->ap.rx_oci = ft_rx_oci;
 
+	memcpy(ft->prev_bssid, hs->aa, 6);
+
 	return &ft->ap;
 }
 
@@ -942,5 +982,245 @@ struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
 	ft->ap.start = ft_over_ds_start;
 	ft->ap.free = ft_sm_free;
 
+	memcpy(ft->prev_bssid, hs->aa, 6);
+
 	return &ft->ap;
 }
+
+void __ft_set_tx_frame_func(ft_tx_frame_func_t func)
+{
+	tx_frame = func;
+}
+
+void __ft_set_tx_associate_func(ft_tx_associate_func_t func)
+{
+	tx_assoc = func;
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
+static struct ft_info *ft_info_find(uint32_t ifindex, const uint8_t *aa)
+{
+	const struct l_queue_entry *e;
+
+	for (e = l_queue_get_entries(info_list); e; e = e->next) {
+		struct ft_info *info = e->data;
+
+		if (info->ifindex != ifindex)
+			continue;
+
+		if (aa && memcmp(info->aa, aa, 6))
+			continue;
+
+		return info;
+	}
+
+	return NULL;
+}
+
+void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
+	struct ft_info *info;
+	int ret;
+	const uint8_t *aa = NULL;
+	const uint8_t *spa = NULL;
+	const uint8_t *ies = NULL;
+	size_t ies_len = 0;
+
+	ret = ft_over_ds_parse_action_response(frame, frame_len, &spa, &aa,
+						&ies, &ies_len);
+	if (ret != 0)
+		return;
+
+	info = ft_info_find(ifindex, aa);
+	if (!info)
+		return;
+
+	if (!ft_parse_ies(info, hs, ies, ies_len))
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
+	info->ifindex = hs->ifindex;
+	memcpy(info->spa, hs->spa, 6);
+	memcpy(info->aa, target_bss->addr, 6);
+	memcpy(info->mde, target_bss->mde, sizeof(info->mde));
+	memcpy(info->prev_bssid, hs->aa, 6);
+
+	info->frequency = target_bss->frequency;
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
+int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
+	struct ft_info *info;
+	uint8_t ft_req[14];
+	struct iovec iov[5];
+	uint8_t ies[512];
+	size_t len;
+	int ret = -EINVAL;
+
+	info = ft_info_new(hs, target);
+
+	ft_req[0] = 6; /* FT category */
+	ft_req[1] = 1; /* FT Request action */
+	memcpy(ft_req + 2, info->spa, 6);
+	memcpy(ft_req + 8, info->aa, 6);
+
+	if (!ft_build_authenticate_ies(hs, hs->supplicant_ocvc, info->snonce,
+					ies, &len))
+		goto failed;
+
+	iov[0].iov_base = ft_req;
+	iov[0].iov_len = sizeof(ft_req);
+
+	iov[1].iov_base = ies;
+	iov[1].iov_len = len;
+
+	ret = tx_frame(hs->ifindex, 0x00d0, freq, hs->aa, iov, 2);
+	if (ret < 0)
+		goto failed;
+
+	l_queue_push_tail(info_list, info);
+
+	return 0;
+
+failed:
+	l_free(info);
+	return ret;
+}
+
+int ft_associate(uint32_t ifindex, const uint8_t *addr)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
+	struct ft_info *info;
+	int ret;
+
+	/*
+	 * TODO: Since FT-over-DS is done early, before the time of roaming, it
+	 *       may end up that a completely new BSS is the best candidate and
+	 *       we haven't yet authenticated. We could actually authenticate
+	 *       at this point, but for now just assume the caller will choose
+	 *       a different BSS.
+	 */
+	info = ft_info_find(ifindex, addr);
+	if (!info)
+		return -ENOENT;
+
+	ft_prepare_handshake(info, hs);
+
+	ret = ft_tx_reassociate(ifindex, info->frequency, info->prev_bssid);
+
+	/* After this no previous auths will be valid */
+	l_queue_clear(info_list, ft_info_destroy);
+
+	return ret;
+}
+
+void ft_reset(uint32_t ifindex)
+{
+	struct ft_info *info;
+
+	while ((info = ft_info_find(ifindex, NULL))) {
+		l_queue_remove(info_list, info);
+		ft_info_destroy(info);
+	}
+}
+
+static int ft_init(void)
+{
+	info_list = l_queue_new();
+
+	return 0;
+}
+
+static void ft_exit(void)
+{
+	if (!l_queue_isempty(info_list))
+		l_warn("stale FT info objects found!");
+
+	l_queue_destroy(info_list, ft_info_destroy);
+}
+
+IWD_MODULE(ft, ft_init, ft_exit);
diff --git a/src/ft.h b/src/ft.h
index f90fc1b2..2228c90b 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -21,11 +21,19 @@
  */
 
 struct handshake_state;
+struct scan_bss;
+
+typedef int (*ft_tx_frame_func_t)(uint32_t ifindex, uint16_t frame_type,
+					uint32_t frequency,
+					const uint8_t *dest, struct iovec *iov,
+					size_t iov_len);
 
 typedef void (*ft_tx_authenticate_func_t)(struct iovec *iov, size_t iov_len,
 					void *user_data);
-typedef int (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_len,
-					void *user_data);
+
+typedef int (*ft_tx_associate_func_t)(uint32_t ifindex, uint32_t freq,
+					const uint8_t *prev_bssid,
+					struct iovec *ie_iov, size_t iov_len);
 typedef int (*ft_get_oci)(void *user_data);
 
 typedef void (*ft_ds_free_func_t)(void *user_data);
@@ -71,3 +79,13 @@ struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
 
 bool ft_over_ds_prepare_handshake(struct ft_ds_info *info,
 					struct handshake_state *hs);
+
+void __ft_set_tx_frame_func(ft_tx_frame_func_t func);
+void __ft_set_tx_associate_func(ft_tx_associate_func_t func);
+int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame,
+			size_t frame_len);
+void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len);
+
+void ft_reset(uint32_t ifindex);
+int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target);
+int ft_associate(uint32_t ifindex, const uint8_t *addr);
diff --git a/src/netdev.c b/src/netdev.c
index 7f4101be..3510c0a6 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4409,11 +4409,11 @@ restore_snonce:
 					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
-static int netdev_ft_tx_associate(struct iovec *ft_iov, size_t n_ft_iov,
-					void *user_data)
+static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
+					const uint8_t *prev_bssid,
+					struct iovec *ft_iov, size_t n_ft_iov)
 {
-	struct netdev *netdev = user_data;
-	struct auth_proto *ap = netdev->ap;
+	struct netdev *netdev = netdev_find(ifindex);
 	struct handshake_state *hs = netdev->handshake;
 	struct l_genl_msg *msg;
 	struct iovec iov[64];
@@ -4434,7 +4434,7 @@ static int netdev_ft_tx_associate(struct iovec *ft_iov, size_t n_ft_iov,
 	mpdu_sort_ies(subtype, iov, c_iov);
 
 	l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, ETH_ALEN,
-				ap->prev_bssid);
+				prev_bssid);
 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, c_iov);
 
 	netdev->connect_cmd_id = l_genl_family_send(nl80211, msg,
@@ -4646,17 +4646,15 @@ int netdev_fast_transition(struct netdev *netdev,
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
@@ -4688,16 +4686,14 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
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
@@ -6643,6 +6639,8 @@ static int netdev_init(void)
 	__eapol_set_tx_packet_func(netdev_control_port_frame);
 	__eapol_set_install_pmk_func(netdev_set_pmk);
 
+	__ft_set_tx_associate_func(netdev_ft_tx_associate);
+
 	unicast_watch = l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
 						netdev_unicast_notify,
 						NULL, NULL);
-- 
2.34.3

