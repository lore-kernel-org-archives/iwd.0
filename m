Received: from mx1.sew-eurodrive.com (mx1.sew-eurodrive.com [194.180.1.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D38405F7
	for <iwd@lists.linux.dev>; Tue,  7 Jul 2026 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409438; cv=none; b=XJk2H4zI0jlo7k99KDyVAiQE/hA48k5C1g6odTrkufAI5sdllV84SwjkAkddsljweCVXlA1TqVI2BM1crI5rbfu+5dAmSBqSJ4Etv9FBzEN1In6ZhYM8ErosNCNqTFptd9D6F9n5l9BkBRqQawBu7owDfpX+5spnntfFP9oUbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409438; c=relaxed/simple;
	bh=P5V+hBmQHpkpjwgt6E4siu06vNLwcnzG7njHCqrGnj8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gmNRzzqmJ4o1TSKBJFzZsauFfVilPfNCHZz3kfNez8lJEd2kqnUhi11LpA9+PY1oRjmwLT6xHPp+VtrDaI6TuhMAAhOzdu5BydOa40GcP7lf12RLxCjgVYl9JftMh/SWHfoV04X9mQo0TqisIdYyFIFYn/4D2gkCLm7O/5/PFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=dLNHX5bI; arc=none smtp.client-ip=194.180.1.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="dLNHX5bI"
Received: from pps.filterd (mx1.sew-eurodrive.com [127.0.0.1])
	by mx1.sew-eurodrive.com (8.18.1.7/8.18.1.7) with ESMTP id 6677NG1n029107
	for <iwd@lists.linux.dev>; Tue, 7 Jul 2026 09:23:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sew-eurodrive.de; h=content-transfer-encoding:content-type:date
	:from:message-id:mime-version:subject:to; s=sew1; bh=R3LSA+SMqmS
	gAIBkzJevSUW75ooIWSgoiwbwqBvXJEw=; b=dLNHX5bIO3Jzcm1GWyWlx0RbISU
	YZa2+blaYrLBZKvfZcc/VyZn5qDw0PwV11OftED+6GIBnoJnsCR/4F6IyyNAWN5R
	PAvctOq+OkqVmZk7drAPNPpJ84/j5dPkG8RVpRn142MQpTGFXTGkDpJtlZG4TM4C
	OVPJkkLjsz/jKYKb9TfoBdCfwiAgtqhPs86UsBtToVx4mUNTOJxcCS6vvSs7117C
	9ecbJofs9veXfrMrctWXdM+HH5gJI0QyNGbpQtNY9P/tb/jpUxjF/meMrP8ebtoD
	NFYZS4VBy1Mtpa/mixKz9dikBmfK9RiBBzJnvto/ZLXr5Pks7MvD0/Impgg==
X-PGP-Universal: processed;
	by brudepgp2.de.eu.sew on Tue, 07 Jul 2026 09:23:22 +0200
From: <Dierk.Modrow@sew-eurodrive.de>
To: <iwd@lists.linux.dev>
Subject: IWD bugfixes for SEGVs at corner cases after failed ft_handover with
 NXP-driver/firmware 
Thread-Topic: IWD bugfixes for SEGVs at corner cases after failed ft_handover
 with NXP-driver/firmware 
Thread-Index: Ad0N4W0nnfMx4keLTZSIjIhQvZzy5w==
Importance: high
X-Priority: 1
Date: Tue, 7 Jul 2026 07:23:20 +0000
Message-ID: <9691ad32fbf24897a1ea37fe38857604@sew-eurodrive.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01

From 0addb322ae01a8b9120882c061a328a99d36cad2 Mon Sep 17 00:00:00 2001
From: DEMODDIE <dierk.modrow@sew-eurodrive.de>
Date: Thu, 2 Jul 2026 08:36:52 +0200
Subject: [PATCH] Three bugfixes for iwd SEGVs at receipt of EAPOL M1 msg wi=
th
 legacy roaming and repeated roam scan after ft_auth-/ft_reassoc-timeout
 occurred: src/eapol.c: next try for a fix of SEGV fault at eapol_rx_packet=
s
 when using mwifiex / NXP 88W9098 driver src/station.c: potential bugfix in
 station_roam_scan_notify to avoid NULL-Ptr access to var hs src/station.c:
 next try to fix a SEGV after auth timeout at FT roaming

---
 src/eapol.c   |  4 ++++
 src/station.c | 12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index aba47d6e5..5f8fcea55 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2827,6 +2827,10 @@ void eapol_register(struct eapol_sm *sm)
 eapol_rx_auth_packet : eapol_rx_packet;

 l_queue_push_head(state_machines, sm);
+/* workaround against SEGV on fct. eapol_rx_packet by avoiding for two dif=
ferent eapol_frame_watches with different ids, but same eapol_sm ptr */
+if ((sm->watch_id > 0) && eapol_frame_watch_remove(sm->watch_id)) {
+l_debug("existing frame_watch for sm=3D%p with id=3D%u successfully remove=
d", sm, sm->watch_id);
+}

 sm->watch_id =3D eapol_frame_watch_add(sm->handshake->ifindex,
 rx_handler, sm);
diff --git a/src/station.c b/src/station.c
index 8c342ceb7..e2a68e225 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2369,7 +2369,7 @@ static bool station_can_fast_transition(struct statio=
n *station,
 {
 uint16_t mdid;

-if (!hs->mde)
+if (!hs || !hs->mde)
 return false;

 if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
@@ -3050,7 +3050,7 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,

 orig_security =3D network_get_security(network);

-if (hs->mde)
+if (hs && hs->mde)
 ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
 &mdid, NULL, NULL);

@@ -3070,7 +3070,7 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,
 cur_bss_rank =3D bss->rank;
 #endif

-if (hs->mde && bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid)
+if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid)
 cur_bss_rank *=3D RANK_FT_FACTOR;

 cur_bss_group_rank =3D evaluate_bss_group_rank(bss->addr,
@@ -3134,8 +3134,8 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,
 }

 /* Skip result if it is not part of the ESS */
-if (bss->ssid_len !=3D hs->ssid_len ||
-memcmp(bss->ssid, hs->ssid, hs->ssid_len))
+if (hs && (bss->ssid_len !=3D hs->ssid_len ||
+memcmp(bss->ssid, hs->ssid, hs->ssid_len)))
 goto next;

 if (scan_bss_get_security(bss, &security) < 0)
@@ -3153,7 +3153,7 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,

 rank =3D bss->rank;

-if (hs->mde && bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid)
+if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid)
 rank *=3D RANK_FT_FACTOR;

 group_rank =3D evaluate_bss_group_rank(bss->addr, bss->frequency,
--
2.53.0.windows.2


Mit freundlichen Gr=FC=DFen,
Dipl.-Ing. Dierk Modrow
Entwicklungsingenieur
Development Electronics -
Industrial Controller & Communication 2 (DE-AT-ICC2)

SEW-EURODRIVE GmbH & Co KG
Ernst-Blickle-Str. 42
76646 Bruchsal

T:+49 7251 75-5123
F:+49 7251 75-505123
dierk.modrow@sew-eurodrive.de










________________________________


SEW-EURODRIVE GmbH & Co KG
Kommanditgesellschaft, Sitz: Bruchsal, RG Mannheim HRA 230970
Komplement=E4rin: SEW-EURODRIVE Verwaltungs-GmbH, Sitz: Bruchsal, RG Mannhe=
im HRB 230207

Gesch=E4ftsf=FChrender Gesellschafter: J=FCrgen Blickle
Gesch=E4ftsf=FChrung: J=FCrgen Blickle (Vorsitzender), Dr. J=F6rg Hermes, D=
r. Hans Krattenmacher, Michael Luz, Christian Mayer, Dr. Markus W=F6pperman=
n
