Received: from sewfire.sew-eurodrive.com (sewfire.sew-eurodrive.com [194.180.1.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E439B943
	for <iwd@lists.linux.dev>; Mon, 13 Jul 2026 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942076; cv=none; b=K1gpHGaDv0H9FhzVr8z2OdZAXgukFTyipbKh5fi04XHUTfJ0mH3h/qoLtFIsKL+pI4+//vBIY88557BK8o+1aXPHHRDSK8puTFCGBUPZsg3WaxBrDKzUy60tfbXOiQV7vsyWqi0X848ieM0MBhk9EVcotZQaWEV7Ju9eKJ1hpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942076; c=relaxed/simple;
	bh=qyNKS2N0Hu7j/HBpn54I8RAww4dgqgKiKF+WVZMH0ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I1mvaI3+LTcEQ3KeQbF0YWSp7MSNPRQrPEw/2LfJDb5gCOkV+Hl1zkGsX1nXSuAlgy68ifPQ4HyTJVrFvINJrI2nmMmaypBFXTYM0LUQ1fne7XeZ3fRtPiBvvVLatyKdvDq11Ei9Pt/732Qq1/2SWVip4MlrvXkd2ZUPU7LqDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=R6wm/D9h; arc=none smtp.client-ip=194.180.1.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="R6wm/D9h"
Received: from pps.filterd (sewfire.sew-eurodrive.com [127.0.0.1])
	by sewfire.sew-eurodrive.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBNHdK025653
	for <iwd@lists.linux.dev>; Mon, 13 Jul 2026 13:23:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sew-eurodrive.de; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to; s=sew1; bh=vorn1K
	nj7OrIOCx6s0/FqqEf4tBNqHXJnk44jNUi2Vs=; b=R6wm/D9hSFCqxiyIlk6dZJ
	9EjJVJQgbFuO8OGfpguTMGzwKXkYZTHYWV3wSGh2r0W7gx0df+8PRdn6hnZrIMip
	50H3fBRF/4VW0MRvRSXvVnMlBf7oNkUdDk2eJ0BPrTkQjyKefxWYYcHZo+Rdruz0
	AmHEaZzHr/wxtywBJ30Ep+95vZ3kuwukIsi4qSGRhpkdlwhmwOY3hkj9Eba98XR9
	l16F+j1EJvtlrXpVMD/SELqjzg0OYhRXijDrGmmqmgMVt8u3UfAyrKzDaopMw/Vd
	f3eBREqTDc29fuZYgX+fH61fsJ8tvtk2aFXm67mR8dKHJRSMVjG2PwrOjR/IQroA
	==
X-PGP-Universal: processed;
	by brudepgp2.de.eu.sew on Mon, 13 Jul 2026 13:23:34 +0200
From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>
To: <iwd@lists.linux.dev>
CC: DEMODDIE <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH 1/2] src/eapol.c: fix of SEGV in eapol_rx_packets at receipt of EAPOL M1 msg at legacy roaming after ft_auth-/ft_reassoc-timeout when using mwifiex / NXP 88W9098 driver
Date: Mon, 13 Jul 2026 13:22:41 +0200
Message-ID: <20260713112242.965-1-dierk.modrow@sew-eurodrive.de>
X-Mailer: git-send-email 2.53.0.windows.2
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
 src/eapol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index 372549c6..c2dc4e4c 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2824,6 +2824,10 @@ void eapol_register(struct eapol_sm *sm)

        l_queue_push_head(state_machines, sm);

+       /* workaround against SEGV on fct. eapol_rx_packet by avoiding for =
two different eapol_frame_watches with different ids, but same eapol_sm ptr=
 */
+       if ((sm->watch_id > 0) && eapol_frame_watch_remove(sm->watch_id)) {
+               l_debug("existing frame_watch for sm=3D%p with id=3D%u succ=
essfully removed", sm, sm->watch_id);
+       }
        sm->watch_id =3D eapol_frame_watch_add(sm->handshake->ifindex,
                                                rx_handler, sm);
        sm->protocol_version =3D sm->handshake->proto_version;
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
