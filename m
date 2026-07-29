Received: from sewfire.sew-eurodrive.com (sewfire.sew-eurodrive.com [194.180.1.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DD477E55
	for <iwd@lists.linux.dev>; Wed, 29 Jul 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325708; cv=none; b=ZiN1kDraHKLcq2/hBDVO/JjnjjndVgcLYK+lRFP04xPYMDjqiYTaIXnmo3pQkABnBtBik0b9nYWfixWQkxH4jsNwdRDKi/IZjrJBxtrH+h4ZkPh05Yg5Imv/+p41BjkGLanpaPM1i2NCeSvbFBPc2sCAvnBBqq/QJxBDYM7k+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325708; c=relaxed/simple;
	bh=4Vupk6si3pYTKLYIL7RF3VUW0UVS7daRN5Dk2DuxdKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/vmjZr8b8HEcV0eU/S4I5cBTSES170BI/hrNC2/Q6v1tQwLlW2wDGxAbmzaVhh9Md7RBOdkIxIYHGJD2Kn3IR8Qks3/8mzaL0pDifPuqi/qXcBzp1iGBxtOX9SJg9pWpbLdmZn8jdVl6st4jyi7uuIeo+AJoh1mD5/6gEUz5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=ZPNlYOxL; arc=none smtp.client-ip=194.180.1.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="ZPNlYOxL"
Received: from pps.filterd (sewfire.sew-eurodrive.com [127.0.0.1])
	by sewfire.sew-eurodrive.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBYIxI005225
	for <iwd@lists.linux.dev>; Wed, 29 Jul 2026 13:42:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sew-eurodrive.de; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to; s=sew1; bh=DEYVj0
	FBmclhqgFj6p5h0/oTaIsrU2N2ymR2s/p5IRw=; b=ZPNlYOxLQloqHbJEHvRS7l
	p6/SSaaYf02Ua/H6SpLR9QwhVQCob107JKX35El2FGdSlk0xcy+V9AB6bTS6abGw
	6GgTq20hz5r37ddOQM6dCUyWJre++GUAAzMThn7aM3pbgTx3Eqs/VSWSLVaU6n7k
	kwlWyUjwVNcgY7xX+R1p0FPHK+dfZ4VoysPslAkU2C7FKewzxlLaVJjqDJ71Hrne
	FaOBPWrtfDQmc6dLcl0CCM6Fo1hHmZ6x2LarD2IEh29HEPiNp2iXp3PgThMfAMmM
	CvFRKwVSZvvQMuBGjLxx45k2JBMgXvyyc71BOZGnG8SbOonYpkUlblYfkwOO3XPA
	==
X-PGP-Universal: processed;
	by brudepgp2.de.eu.sew on Wed, 29 Jul 2026 13:42:26 +0200
From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>
To: <prestwoj@gmail.com>
CC: <iwd@lists.linux.dev>, Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH v4] src/station.c: fix of segv in station_roam_scan_notify when performing repeated roam scan at legacy roaming after FT-TO
Date: Wed, 29 Jul 2026 13:42:15 +0200
Message-ID: <20260729114215.1883-1-dierk.modrow@sew-eurodrive.de>
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
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01

---
Hello James,

here is my modified patch for the topic 'fix of SEGV in station_roam_scan_n=
otify
 when performing repeated roam scan at legacy roaming after ft_auth-/ft_rea=
ssoc-timeout
 when using mwifiex / NXP 88W9098 driver'
 As suggested I added only one "L_WARN_ON(!hs)"-query on method station_roa=
m_scan and two
 debug traces at methods station_try_next_transition & station_roam_scan_no=
tify. So we
 could detect if handshake might be reset to NULL unexpectedly in meantime.
 I will do tests with this variant and come back to you later with results.

 Best regards!

 src/station.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/station.c b/src/station.c
index 8fcf8c70..8d6ebb0b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2764,6 +2764,10 @@ static bool station_try_next_transition(struct stati=
on *station,
        /* Reset AP roam flag, at this point the roaming behaves the same *=
/
        station->ap_directed_roaming =3D false;

+       /* ### START: check if hs is unexpectedly set to NULL here ### */
+       l_debug("handshake pointer: %p", hs);
+       /* ### END ### */
+
        /* Can we use Fast Transition? */
        if (station_can_fast_transition(station, hs, bss) && !no_ft)
                return station_fast_transition(station, bss);
@@ -2909,6 +2913,10 @@ static bool station_roam_scan_notify(int err, struct=
 l_queue *bss_list,
                return false;
        }

+       /* ### START: check if hs is unexpectedly set to NULL here ### */
+       l_debug("handshake pointer: %p", hs);
+       /* ### END ### */
+
        /*
         * Do not call station_set_scan_results because this may have been
         * a partial scan.  We could at most update the current networks' B=
SS
@@ -3041,6 +3049,7 @@ static void station_roam_scan_destroy(void *userdata)
 static int station_roam_scan(struct station *station,
                                struct scan_freq_set *freq_set)
 {
+       struct handshake_state *hs;
        struct scan_parameters params =3D { .freqs =3D freq_set, .flush =3D=
 true };
        _auto_(scan_freq_set_free) struct scan_freq_set *allowed =3D
                                        station_get_allowed_freqs(station);
@@ -3049,6 +3058,12 @@ static int station_roam_scan(struct station *station=
,
                return -ENOTSUP;

        l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
+
+       /* ### START: check if hs is unexpectedly set to NULL here ### */
+       hs =3D netdev_get_handshake(station->netdev);
+       if (L_WARN_ON(!hs))
+               return -ENOTSUP;
+       /* ### END ### */

        if (station->connected_network) {
                const char *ssid =3D network_get_ssid(station->connected_ne=
twork);
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
