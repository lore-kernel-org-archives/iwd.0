Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F63BB690
	for <iwd@lists.linux.dev>; Wed,  8 Jul 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491467; cv=none; b=TOdwuP94aukwt45m27wXT8lIvhdy6eWNVNoW2cqjvR7AJRwmbHF98DbxpA57dR9C7aBwhAEFa3xJ659+XaFEUcMqHzig+JZ46IDCGectJlB0fJcORHUs8tImhLQPEa1mi++AsHhO4sYaTqAu4hz88IjQkcMtsBn2qB3ylF52EB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491467; c=relaxed/simple;
	bh=TgdTs0JcXzV9M09sz9/8BXMcGZTNqAXnBqRs+fH7/FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtcBbP3NqA6uQlS7LDvH05FF0IVOOzabI6KeBZQdN67X4723n9yBCaFEQy0g6kwJfGLDBqeDpf3+GZsWhXqIXauKIYeq+Bdf3KvPiJ8psvXG5v6aTcSIonGccXv9VyG93NsrF/UZgNRl5DiTuUDDNXMcIQJxoGmf1+0W+yD0Arc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPySNANj; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPySNANj"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so1009985e9.0
        for <iwd@lists.linux.dev>; Tue, 07 Jul 2026 23:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783491464; x=1784096264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1Rhk6mDftoLt05CaNbmxmTUVIA/0cydkVhBP04/4y8=;
        b=EPySNANjS/USMDXYa8eayaBoGrcTwUKc8RYH7/QLrKMeExaZ7/hcN8bY5i+efx9DTe
         QWeRGd7HPlj8Oj5BUTSYW/XiwreJmaw5quIYCQe6TwpXZmCCVuIUSj9rtoKT0kwFhBjC
         cbSlvXnGoIEJ1fiaX5QQ2DxpxE4p84FBqCDxt24NCVYXFatpBJ+eRxj/OBVjP2okD9+U
         ul0rG73BSUqrNKiL+plwE1w8e8ClKTgI1fEBFgMZ9LnnEuwdvdvKeMu8ZweA305r+9ra
         IqzrvAcWdZuXmuwcI0WjYCAVGNLMTDtrf4yggsQ+xugTE/o6KGROdL9lDM55RtAsIsTm
         utsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491464; x=1784096264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1Rhk6mDftoLt05CaNbmxmTUVIA/0cydkVhBP04/4y8=;
        b=jcmSP8LClk6ddHwP9Nu1SI2LMA4cHAYUo3r6jk27AxkCjeWq1p0dKfoogW8y9+Xoz7
         ozX/fczeS2ev1M2mmv/W5s6uVSyWNKE2tCTv8WtHhnKkt3Zk9Pm49t0U3ro48oIAx5RH
         dsNokj3UxI2UkCX7Z4qFTHgFH9+1arWVe/d3BHo75R6DNEDyNWVH65jZsfpgbx4roeX+
         fmBlCUlDa6iSuUfyzMPfO3t0OhEa0N0WEHP9ANsvwCWcpcS3UYlR7RXv8zN4SpGFMZKt
         csYafSsK/vFd2p2nBzc59ZTIMM6nj2j1BF1ngJxVaIbAnMoT+SPmtgYPVh02Xhk0siA2
         6EhQ==
X-Gm-Message-State: AOJu0YyV7ejXiMmbiu17/tXg2JFF5T/6W29VV/PGLXhnU1jclCX77ijf
	2LLVycRjU3ebDVPv02w/gZJANjZMrq7BwGszJzkD/a3cMRpJpNfMB6Y6Zkw2CNW6SxLI3cVt
X-Gm-Gg: AfdE7cn3pRx0eN6YSMznn3a7Z34jdo7FygNDgzmXPpPJ51ihRe3bzMU/tdLffiOs2Yq
	DDfEy+tgxz8njTdsIeRgeCfdnIUyO1LcpoDLGavz+XjS6aNW8nMH0XsyTdweh5L5yBVMdB9CBp2
	Axp6C6h0HemV5SR9Z2oYFU9N8dmtwohtaGveDco4weiaW9Trw+c0k0SSHr6TJ7O8sKC6IYB0XWi
	xeKKEmwRTPInSczzffcs/Qdh24hA8S81SdqvqNVr38v6lN0pkdL5gscXQa989ZAuY5R7an8Jqjq
	/l2lLbpflfxYUmi0J/Ztdf7+Jklm7gM15etbtlXGk0Yvf1SV0CNsdET2uhphHRYdA1tvezimYEl
	8dUcothn2lB3B7PjJ+J1x0QVBVCjNmiSdUhdpI7qNDzx9OgL+rzMehBFYnYLh08ltRIozz+XXIf
	x3/xuyfYJEW8/NJXnv7FNQ47CvcNUpl3PcEkgUew==
X-Received: by 2002:a05:600c:4e48:b0:493:e6f7:ad9d with SMTP id 5b1f17b1804b1-493e6f7af7emr3765855e9.35.1783491463523;
        Tue, 07 Jul 2026 23:17:43 -0700 (PDT)
Received: from localhost.localdomain ([2a10:4440:fff:d1a0:d061:31d3:932f:b75a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a58853sm29291465e9.1.2026.07.07.23.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:17:43 -0700 (PDT)
From: dierk.modrow.opensource@gmail.com
To: iwd@lists.linux.dev
Cc: DEMODDIE <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH] Three bugfixes for iwd SEGVs at receipt of EAPOL M1 msg with legacy roaming and repeated roam scan after ft_auth-/ft_reassoc-timeout occurred:
Date: Wed,  8 Jul 2026 08:16:51 +0200
Message-ID: <20260708061651.299-1-dierk.modrow.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: DEMODDIE <dierk.modrow@sew-eurodrive.de>

  src/eapol.c: next try for a fix of SEGV fault at eapol_rx_packets when using mwifiex / NXP 88W9098 driver
  src/station.c: potential bugfix in station_roam_scan_notify to avoid NULL-Ptr access to var hs
  src/station.c: next try to fix a SEGV after auth timeout at FT roaming
---
 src/eapol.c   |  4 ++++
 src/station.c | 12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 372549c6..c2dc4e4c 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2824,6 +2824,10 @@ void eapol_register(struct eapol_sm *sm)
 
 	l_queue_push_head(state_machines, sm);
 
+	/* workaround against SEGV on fct. eapol_rx_packet by avoiding for two different eapol_frame_watches with different ids, but same eapol_sm ptr */
+	if ((sm->watch_id > 0) && eapol_frame_watch_remove(sm->watch_id)) {
+		l_debug("existing frame_watch for sm=%p with id=%u successfully removed", sm, sm->watch_id);
+	}
 	sm->watch_id = eapol_frame_watch_add(sm->handshake->ifindex,
 						rx_handler, sm);
 	sm->protocol_version = sm->handshake->proto_version;
diff --git a/src/station.c b/src/station.c
index 8fcf8c70..077e510e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2253,7 +2253,7 @@ static bool station_can_fast_transition(struct station *station,
 {
 	uint16_t mdid;
 
-	if (!hs->mde)
+	if (!hs || !hs->mde)
 		return false;
 
 	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
@@ -2917,7 +2917,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 
 	orig_security = network_get_security(network);
 
-	if (hs->mde)
+	if (hs && hs->mde)
 		ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
 							&mdid, NULL, NULL);
 
@@ -2930,7 +2930,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	if (bss && !station->ap_directed_roaming) {
 		double cur_bss_rank = bss->rank;
 
-		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
+		if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			cur_bss_rank *= RANK_FT_FACTOR;
 
 		cur_bss_group_rank = evaluate_bss_group_rank(bss->addr,
@@ -2967,8 +2967,8 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 			goto next;
 
 		/* Skip result if it is not part of the ESS */
-		if (bss->ssid_len != hs->ssid_len ||
-				memcmp(bss->ssid, hs->ssid, hs->ssid_len))
+		if (hs && (bss->ssid_len != hs->ssid_len ||
+				memcmp(bss->ssid, hs->ssid, hs->ssid_len)))
 			goto next;
 
 		if (scan_bss_get_security(bss, &security) < 0)
@@ -2986,7 +2986,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 
 		rank = bss->rank;
 
-		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
+		if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			rank *= RANK_FT_FACTOR;
 
 		group_rank = evaluate_bss_group_rank(bss->addr, bss->frequency,
-- 
2.53.0.windows.2

