Received: from sewfire.sew-eurodrive.com (sewfire.sew-eurodrive.com [194.180.1.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4738B7C3
	for <iwd@lists.linux.dev>; Mon, 13 Jul 2026 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942542; cv=none; b=TydOyOFLCwaGSMFQDc5dL+LskoXM+GDsDkdpRKQAr4j3f2nmPXsMvA+Vk0WgExMk1dARgjWyO8FIXzu7Cp8bi1iC4W9bgaqL4R24Tlo/kbftVKR4JlYX2CfXfXzBRn43LRdMi0gducDDZWmll65fDykL0Fhgfkd/qoliOQ1r6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942542; c=relaxed/simple;
	bh=YQcuuXPkb4IpfHRLM5o5gdQhSHDj3rsVapv2ol5nnSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0u3eEKlGvXfjPB6xShsOjBxSBg4z45uk9ujZ0F3/skl63cPQ+3zO8Bphq7Suu3WnCZDdd1zS77pi6itSqb7eD9PYW4sEhh/K3QeX5WEuWDKqvqUdcUUSgbUEZ+I9EYwUn7FCtZF4/DUIpS3M3heH/Kl5i2Pr5G+XvFz3Si+tRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=RO3wO1Pr; arc=none smtp.client-ip=194.180.1.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="RO3wO1Pr"
Received: from pps.filterd (sewfire.sew-eurodrive.com [127.0.0.1])
	by sewfire.sew-eurodrive.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBXM8w004722
	for <iwd@lists.linux.dev>; Mon, 13 Jul 2026 13:35:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sew-eurodrive.de; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to; s=sew1; bh=/Hyz+S8EP1g87aHsczanp+kHwgWcpeZMXz5bFOfy
	CAc=; b=RO3wO1PrnGYVYEcGfbYwFIE6tHWdS50WXCfWlcnBN22X520dUxo//ZIk
	ZoniXsM4wpy+up6MEy5Ct9T+kGUCULs6Qg/yVblBFp/nrTUPUnmfWKJz6YV6cXlQ
	dLE6wIlF+pObBZHz95Hriq3ai77zO8hkEAZ4f7aP/45EKfrpUd555pZWZBbuX8Fj
	NLXtD5nyzms5Q0tmfffeYpZc+8xo5NoxNlZzDvXKZlUxu5R0TcmyZNQz/42eAegF
	Wlsd2wMzbEgApwxjs4q0eCCLxlSXUksZPDtS2+K6xEfwXHEpXLcgXjt8WKF3xe//
	zgFIyUINByXIXc7mBXh7XLcSvixAFg==
X-PGP-Universal: processed;
	by brudepgp1.de.eu.sew on Mon, 13 Jul 2026 13:35:38 +0200
From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>
To: <iwd@lists.linux.dev>
CC: DEMODDIE <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH 2/2] src/station.c: fix of SEGV in station_roam_scan_notify when performing repeated roam scan at legacy roaming after ft_auth-/ft_reassoc-timeout when using mwifiex / NXP 88W9098 driver
Date: Mon, 13 Jul 2026 13:35:06 +0200
Message-ID: <20260713113506.1081-2-dierk.modrow@sew-eurodrive.de>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20260713113506.1081-1-dierk.modrow@sew-eurodrive.de>
References: <20260713113506.1081-1-dierk.modrow@sew-eurodrive.de>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ClientProxiedBy: debrumsx21.de.eu.sew (10.2.251.140) To debrumsx07.de.eu.sew
 (10.2.251.157)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01

From: DEMODDIE <dierk.modrow@sew-eurodrive.de>

---
 src/station.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/station.c b/src/station.c
index 8fcf8c70..077e510e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2253,7 +2253,7 @@ static bool station_can_fast_transition(struct statio=
n *station,
 {
        uint16_t mdid;

-       if (!hs->mde)
+       if (!hs || !hs->mde)
                return false;

        if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
@@ -2917,7 +2917,7 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,

        orig_security =3D network_get_security(network);

-       if (hs->mde)
+       if (hs && hs->mde)
                ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
                                                        &mdid, NULL, NULL);

@@ -2930,7 +2930,7 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,
        if (bss && !station->ap_directed_roaming) {
                double cur_bss_rank =3D bss->rank;

-               if (hs->mde && bss->mde_present && l_get_le16(bss->mde) =3D=
=3D mdid)
+               if (hs && hs->mde && bss->mde_present && l_get_le16(bss->md=
e) =3D=3D mdid)
                        cur_bss_rank *=3D RANK_FT_FACTOR;

                cur_bss_group_rank =3D evaluate_bss_group_rank(bss->addr,
@@ -2967,8 +2967,8 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,
                        goto next;

                /* Skip result if it is not part of the ESS */
-               if (bss->ssid_len !=3D hs->ssid_len ||
-                               memcmp(bss->ssid, hs->ssid, hs->ssid_len))
+               if (hs && (bss->ssid_len !=3D hs->ssid_len ||
+                               memcmp(bss->ssid, hs->ssid, hs->ssid_len)))
                        goto next;

                if (scan_bss_get_security(bss, &security) < 0)
@@ -2986,7 +2986,7 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,

                rank =3D bss->rank;

-               if (hs->mde && bss->mde_present && l_get_le16(bss->mde) =3D=
=3D mdid)
+               if (hs && hs->mde && bss->mde_present && l_get_le16(bss->md=
e) =3D=3D mdid)
                        rank *=3D RANK_FT_FACTOR;

                group_rank =3D evaluate_bss_group_rank(bss->addr, bss->freq=
uency,
--
2.53.0.windows.2


________________________________


SEW-EURODRIVE GmbH & Co KG
Kommanditgesellschaft, Sitz: Bruchsal, RG Mannheim HRA 230970
Komplement=E4rin: SEW-EURODRIVE Verwaltungs-GmbH, Sitz: Bruchsal, RG Mannhe=
im HRB 230207

Gesch=E4ftsf=FChrender Gesellschafter: J=FCrgen Blickle
Gesch=E4ftsf=FChrung: J=FCrgen Blickle (Vorsitzender), Dr. J=F6rg Hermes, D=
r. Hans Krattenmacher, Michael Luz, Christian Mayer, Dr. Markus W=F6pperman=
n
