Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE392C0F9B
	for <iwd@lists.linux.dev>; Fri, 15 Aug 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271577; cv=none; b=YjTfmM31g+QALAEA99aUNp0tH3S3k+/S68NEY/saBMQVvha8iErFa1IABlRemXSqyWZNDqac0qP3W/jhDyhN7XyEvuZvqwpljqIikLfR9u4rTyQuAakUjI/W9hdB6wLtNfbpZHxv4wbG2mNe6fPgIjjFoo84Tf/cF88jPmcTkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271577; c=relaxed/simple;
	bh=tbPUkGJRieFx6HYTLStHRw9sYHFxMDRRpRARaAMzb7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5jO+C3THjpgBcDNGaZHVl3ZTANFRifO9gO1pYqdPlMFmqGjJgiEEYXtd9emk6wscOolw2uzwdeOgApD7P0XjvptDWSBXs3aEsJbn5oThUC/F54hZb9K3yVrvqWXUc2oc+aLV7K9RCOG6ddoPhg0z15XSmLBdxlYf+NqADsEq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4lXXB82; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4lXXB82"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e8706491ecso286973285a.2
        for <iwd@lists.linux.dev>; Fri, 15 Aug 2025 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271573; x=1755876373; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joTqw23/544zNX8jSvCrAOUBdlkgPYQNs+YHQaZ1nDc=;
        b=B4lXXB82hCYlPu6uP6f6K6fmaA3wQcSaSrEwU3FJz6cp2DH3K5uxFvbO1XinxhHKC1
         /qckpbU7z2/iS7LuhsDa4YqUfRAVdJSqMJyu8TwmAg2nus6QL+6THLoaVi3jtFW7t48h
         ZiHCk376l4CbUgNohovZ3okmZ2v9LHlH/Yx7jofxIx5qKpQwV589i2I3ybSk75pFLcEe
         BBXAVrJEtbLSkY6mmYZ975Tw2uVXU+JY2a2wr3HBHvLkORxmRE9r/qQ8dtWo4xNDMrrQ
         rhp3bt7JGItpmRd14xF0njsX66waBkRt6TQQZPtDLm0gLf9FP+qUqt2eIQ11m2TFF0Ki
         0jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271573; x=1755876373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joTqw23/544zNX8jSvCrAOUBdlkgPYQNs+YHQaZ1nDc=;
        b=wj2d4mertBChKyqLLhurS2fSI4W8zrnxnFNoVOt6bMXo+O7W2bIPg2kl91V8WKxufF
         QuFXAaVvN1/DgcOUPJ6OmXss/El4o6lrkGZpXWpn4ZYVjRSzWpFoGqihLwaXd0Q34VO5
         poL5FN86E1tlbumjIDFWpz/1DBCuvUtfIJt6pAJsHThUxWyf12UxjexOoncD2p4cntqj
         Po/t7eSi2GJXhkCkt+RwqyZYKdc2xbXfPxpBd5mfgeuWlElsVsCvkRKU48MVkc9v5NUE
         a98bO295VyqB/hJ++SDuu5au+btJ6lHEUVqy1OV9/tIF2IvLe7Lgv1ei2D5jeidRqpWm
         9ygA==
X-Gm-Message-State: AOJu0YwURixQNWYbUcyW0CV0QfbtIChNb3UyPfSQ2gRyxzuKa1j4Zr2G
	NZgrbHhJxs4h3KyhFicrW+zI6y1rq8CgaZ0cTAFyjQGYTpsik7kuGh7F+qXZbg==
X-Gm-Gg: ASbGncsm2WSdh1m9RayizA+gfg/O0A7Twti/RrxmzrrXx38i53yEkY9EpG2+yQHPUtP
	Gph3ndjRylpdWmt7mQN/IM6bxloAZ6fgMeAjZtzZTM5uivVZypsGmDTl1kna66tOgAJw0WxNHnv
	a1hzWCXowstUlH59zponbFFYntwqpqQwXAanSz8PWTjAYijhsVvpCgKj3C5jSHqdlcAc40/gg/y
	GYufnNHs9A/LHgMA+KkFqgCjU3W6X0r1Dt6CNmamFsHg7OrABWf7lMK9VgxE9MgGy29M/YN2Zje
	DyH5iP8PUJovv28R6n4nBE10rT255xRCFHN48Fuxsu/7ad5S17UoYTeWZIbRpixocB2g6A1mNRq
	za7tcORW44TOCBznjEGUoDOvkF8+672PW
X-Google-Smtp-Source: AGHT+IEoER3N++GCNWYEwoH8WMdrMCS7HLhx6Fzc76dKJD6Xq5WoVzR14aoNZN+sUs06ehxBcGgOsQ==
X-Received: by 2002:a05:620a:4083:b0:7e8:2cc9:a05c with SMTP id af79cd13be357-7e87dffbed8mr367732385a.12.1755271572792;
        Fri, 15 Aug 2025 08:26:12 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de0d731sm10393851cf.40.2025.08.15.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:26:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] station: transition to ft-roaming on NETDEV_EVENT_ASSOCIATING
Date: Fri, 15 Aug 2025 08:26:03 -0700
Message-Id: <20250815152604.175977-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815152604.175977-1-prestwoj@gmail.com>
References: <20250815152604.175977-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the station portion of a 2 part patch (netdev being the
other piece).

After CSA IE parsing was added to the kernel this opened up the
possibility that associations could be rejected locally based on
the contents of this CSA IE in the AP's beacons. Overall, it was
always possible for a local rejection but this case was never
considered by IWD. The CSA-based rejection is something that can
and does happen out in the wild.

When this association rejection happens it desync's IWD and the
kernel's state:

1. IWD begins an FT roam. Authenticates successfully, then proceeds
   to calling netdev_ft_reassociate().
2. Immediately IWD transitions to a ft-roaming state and waits for
   an association response.
3. CMD_ASSOCIATE is rejected by the kernel in the ACK which IWD
   handles by sending a deauthenticate command to the kernel (since
   we have a valid authentication to the new BSS).
4. Due to a bug IWD uses the target BSSID to deauthenticate which
   the kernel rejects since it has no knowledge of this auth. This
   error is not handled or logged.
5. IWD proceeds, assuming its deauthenticated, and transitions to a
   disconnected state. The kernel remains "connected" which of course
   prevents any future connections.

This patch addresses IWD's recovery behavior when the kernel rejects
a CMD_ASSOCIATION (for any reason, not just CSA-rejection)

 - Now IWD will not change state until netdev signals that
   CMD_ASSOCIATE was accepted (in subsequent patch). This signal will
   come via the NETDEV_EVENT_ASSOCIATING event. If this event arrives,
   and IWD is still in a "preparing_roam" state, we can proceed to
   ft-roaming.
 - If station_reassociate_cb() is called with a failure result but
   IWD is still in a "preparing_roam" state the connection to the
   current AP is assumed to be maintained and IWD can proceed to
   trying more BSS's. Otherwise this indicates a failed roam.

Notes:
 - The station_ft_work_ready() callback did need to be reworked to
   keep the target roam_bss in the list when FT-Association is
   started. This required modifying some of the other paths to pop
   and free the roam_bss rather than doing that by default.
---
 src/station.c | 61 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/src/station.c b/src/station.c
index d4bfe0e6..cc6cbe8b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2477,6 +2477,8 @@ delayed_retry:
 	station_roam_retry(station);
 }
 
+static void station_transition_start(struct station *station);
+
 static void station_reassociate_cb(struct netdev *netdev,
 					enum netdev_result result,
 					void *event_data,
@@ -2487,13 +2489,25 @@ static void station_reassociate_cb(struct netdev *netdev,
 	l_debug("%u, result: %d", netdev_get_ifindex(station->netdev), result);
 
 	if (station->state != STATION_STATE_ROAMING &&
-			station->state != STATION_STATE_FT_ROAMING)
+			station->state != STATION_STATE_FT_ROAMING &&
+			!station->preparing_roam)
 		return;
 
 	if (result == NETDEV_RESULT_OK)
 		station_roamed(station);
-	else
-		station_roam_failed(station);
+	else {
+		/*
+		 * If we are still in a preparing_roam state this means that
+		 * the CMD_ASSOCIATE was rejected in the ACK. This rejection is
+		 * recoverable since the kernel should not have changed any
+		 * internal state. We can pop the current and try another BSS.
+		 */
+		if (station->preparing_roam) {
+			l_free(l_queue_pop_head(station->roam_bss_list));
+			station_transition_start(station);
+		} else
+			station_roam_failed(station);
+	}
 }
 
 static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
@@ -2606,13 +2620,10 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 	station->hs = handshake_state_ref(new_hs);
 }
 
-static void station_transition_start(struct station *station);
-
 static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 {
 	struct station *station = l_container_of(item, struct station, ft_work);
-	_auto_(l_free) struct roam_bss *rbss = l_queue_pop_head(
-							station->roam_bss_list);
+	struct roam_bss *rbss = l_queue_peek_head(station->roam_bss_list);
 	struct scan_bss *bss;
 	int ret;
 
@@ -2637,6 +2648,11 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 		l_debug("Re-inserting BSS "MAC" using reassociation, rank: %u",
 					MAC_STR(rbss->addr), rbss->rank);
 
+		/*
+		 * Pop off the roam bss, then re-insert as there isn't a
+		 * guarantee that it will end up back at the head
+		 */
+		l_queue_pop_head(station->roam_bss_list);
 		l_queue_insert(station->roam_bss_list, rbss,
 				roam_bss_rank_compare, NULL);
 
@@ -2645,13 +2661,14 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 					MMPDU_STATUS_CODE_INVALID_PMKID);
 
 		station_transition_start(station);
-		l_steal_ptr(rbss);
 		break;
 	case -ENOENT:
 		station_debug_event(station, "ft-roam-failed");
 		iwd_notice(IWD_NOTICE_FT_ROAM_FAILED,
 				"status: authentication timeout");
 try_next:
+		l_queue_pop_head(station->roam_bss_list);
+		l_free(rbss);
 		station_transition_start(station);
 		break;
 	case 0:
@@ -2662,10 +2679,6 @@ try_next:
 		if (ret < 0)
 			goto disassociate;
 
-		station->connected_bss = bss;
-		station->preparing_roam = false;
-		station_enter_state(station, STATION_STATE_FT_ROAMING);
-
 		break;
 	case -EINVAL:
 		/*
@@ -3901,6 +3914,8 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 					void *event_data, void *user_data)
 {
 	struct station *station = user_data;
+	_auto_(l_free) struct roam_bss *rbss = NULL;
+	struct scan_bss *bss;
 
 	switch (event) {
 	case NETDEV_EVENT_AUTHENTICATING:
@@ -3908,6 +3923,28 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 		break;
 	case NETDEV_EVENT_ASSOCIATING:
 		station_debug_event(station, "associating");
+
+		if (!station->preparing_roam)
+			break;
+
+		/* Both !rbss and !bss should NEVER happen */
+		rbss = l_queue_pop_head(station->roam_bss_list);
+		if (L_WARN_ON(!rbss)) {
+			station_roam_failed(station);
+			return;
+		}
+
+		bss = network_bss_find_by_addr(station->connected_network,
+						rbss->addr);
+		if (L_WARN_ON(!bss)) {
+			station_roam_failed(station);
+			return;
+		}
+
+		station->connected_bss = bss;
+		station->preparing_roam = false;
+		station_enter_state(station, STATION_STATE_FT_ROAMING);
+
 		break;
 	case NETDEV_EVENT_DISCONNECT_BY_AP:
 	case NETDEV_EVENT_DISCONNECT_BY_SME:
-- 
2.34.1

