Received: from mailer.sew-eurodrive.com (mailer.sew-eurodrive.com [194.180.1.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0B1A239A
	for <iwd@lists.linux.dev>; Thu, 30 Jul 2026 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403793; cv=none; b=WKJzpwML3m+T5ntIyH3BQEBKpqS4VXW+NyqrbxpkaFhPNGGBtOAYmbxwRzAgb1gYOYC5yZNUMWJtBhVes8oU+IMgPQXlxM/kRPZ6uT5vvOadOKNBRKg3q8Ns/6UBgRp710SadQSYYo+gdYt96yLsTPo46FWvb/M9kPf3ROmA3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403793; c=relaxed/simple;
	bh=CDzlcsLRID5wmWBjpdPyYroPONiItopk/N4DEqfR9Ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwYfhWiagdF/HuYurX1S/kuxCSM96XF4Y74DOH5/EU2jmT4sdsxLdgqyW9kK3LBTuXdCkHHVxM3mB7CRsuYa0DJJhLGp1vt90LK/sUz+29QvoDmtf7UCjJAsNbBXV64TeZ8IXlOObUFmN2qspptxS8SMt+S2SkcFASaa70kExyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=DFP+3smK; arc=none smtp.client-ip=194.180.1.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="DFP+3smK"
Received: from pps.filterd (mailer.sew-eurodrive.com [127.0.0.1])
	by mailer.sew-eurodrive.com (8.18.1.7/8.18.1.7) with ESMTP id 66U9J7dQ026792
	for <iwd@lists.linux.dev>; Thu, 30 Jul 2026 11:20:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sew-eurodrive.de; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to; s=sew1; bh=j2uu4z
	JDpEjKb9EBHInEudlpFCErn2fhfaQR1FujVZ4=; b=DFP+3smKsnco9OXMfITJ53
	8WEZBATbXlnej0wNX7owUO2K/93oYkHHiRKRv6YRZvdyGFvyEMbi4B6PAORS79zV
	1UuDg9fIcwrIpdZSFxpGqB/xE3Kk48WJ+s3GKlk4iYM/z6sYYiKel6zSA47wgn/l
	vkgR90AthK6j+Qt+pOmUv4DAnOdfUj4jV5x+Jiq506ASEl6O2+ZdELLn82ICuAMt
	p35Y+WYCms7yQG9ENKL82QTy3R5Wg7i3AF7qCoIkyqi6p4NYWnwzhkr1YxYs4UmC
	WTP2bOldp3ZaWZVe+I3eSG2n8Vf/CRx+aNJSQr/fhI/B33A8gI6VZ28HmuV1Gxhg
	==
X-PGP-Universal: processed;
	by brudepgp2.de.eu.sew on Thu, 30 Jul 2026 11:20:12 +0200
From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>
To: <prestwoj@gmail.com>
CC: <iwd@lists.linux.dev>, Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH v4] src/station.c: fix of segv in station_roam_scan_notify when performing repeated roam scan at legacy roaming after FT-TO
Date: Thu, 30 Jul 2026 11:20:00 +0200
Message-ID: <20260730092001.2145-1-dierk.modrow@sew-eurodrive.de>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ClientProxiedBy: debrumsx22.de.eu.sew (10.2.251.141) To debrumsx07.de.eu.sew
 (10.2.251.157)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01

---
Hello James,

here is my modified patch for the topic 'fix of SEGV in station_roam_scan_n=
otify  when performing
repeated roam scan at legacy roaming after ft_auth-/ft_reassoc-timeout  whe=
n using mwifiex / NXP
88W9098 driver'
 As suggested I added only one "L_WARN_ON(!hs)"-query on method station_roa=
m_scan and two  debug
traces at methods station_try_next_transition & station_roam_scan_notify. S=
o we  could detect if
handshake might be reset to NULL unexpectedly in meantime.
 I will do tests with this variant and come back to you later with results.

 Best regards!
 src/station.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/station.c b/src/station.c
index 8fcf8c70..b5a680e6 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2764,6 +2764,8 @@ static bool station_try_next_transition(struct statio=
n *station,
        /* Reset AP roam flag, at this point the roaming behaves the same *=
/
        station->ap_directed_roaming =3D false;

+       l_debug("handshake pointer: %p", hs);
+
        /* Can we use Fast Transition? */
        if (station_can_fast_transition(station, hs, bss) && !no_ft)
                return station_fast_transition(station, bss);
@@ -2909,6 +2911,8 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,
                return false;
        }

+       l_debug("handshake pointer: %p", hs);
+
        /*
         * Do not call station_set_scan_results because this may have been
         * a partial scan.  We could at most update the current networks' B=
SS
@@ -3041,6 +3045,7 @@ static void station_roam_scan_destroy(void *userdata)
 static int station_roam_scan(struct station *station,
                                struct scan_freq_set *freq_set)
 {
+       struct handshake_state *hs;
        struct scan_parameters params =3D { .freqs =3D freq_set, .flush =3D=
 true };
        _auto_(scan_freq_set_free) struct scan_freq_set *allowed =3D
                                        station_get_allowed_freqs(station);
@@ -3048,6 +3053,10 @@ static int station_roam_scan(struct station *station=
,
        if (L_WARN_ON(!allowed))
                return -ENOTSUP;

+       hs =3D netdev_get_handshake(station->netdev);
+       if (L_WARN_ON(!hs))
+               return -ENOTSUP;
+
        l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));

        if (station->connected_network) {
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
