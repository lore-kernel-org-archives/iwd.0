Received: from sewfire.sew-eurodrive.com (sewfire.sew-eurodrive.com [194.180.1.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE243431E3
	for <iwd@lists.linux.dev>; Mon, 13 Jul 2026 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942542; cv=none; b=Ua4W2PsBsYOBZJKc9/jyD+F4vtCSGXXsCCzWUk8uXfoNVm3160pTlb4pTGGTDwmbAHtj1HKHsjxDxqd6pqhPl61ULl7EgwV5FTJYnqUC4bpLdsKsf2Ez1ZZ/+kib5vTc5J77kCbGjXWy7ry9WJo1kb7hunxMlNmLeFDACdUvonM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942542; c=relaxed/simple;
	bh=qyNKS2N0Hu7j/HBpn54I8RAww4dgqgKiKF+WVZMH0ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nbFNvME/TukVQWZtIIy2Obbi59c38yER+C7r9vadSYM2nbWFNFrdUH4mXH+dl5S1l51VUKRO33LX4qirnDw2yBsLZGTk9MT7Ook0Z8HihZj6PMs5DMk6xC26cTVYq/pXuiZTxqnuxrMLCvVClco1LnFvEmUuqY2XiYxxbC9RvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=qBKaCbgC; arc=none smtp.client-ip=194.180.1.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="qBKaCbgC"
Received: from pps.filterd (sewfire.sew-eurodrive.com [127.0.0.1])
	by sewfire.sew-eurodrive.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBXWIL004738
	for <iwd@lists.linux.dev>; Mon, 13 Jul 2026 13:35:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sew-eurodrive.de; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to; s=sew1; bh=vorn1K
	nj7OrIOCx6s0/FqqEf4tBNqHXJnk44jNUi2Vs=; b=qBKaCbgCThCDx+syX/xV2P
	qUhTvcPYB0xh8aSJQP7FJrnpshrAV9M0ZKS6WmHWR7NevNtQkpIpPRTF5LtwUaoK
	+l+IC7mKHsmn41AAvPcZ7dQjQ9nVyMnisoxtm9y5N6ZLkakNVaeV02ae+EXkoAim
	3C3Np2yOOPiNBvDX2KZOsbe3sbsGJ8ybYaIgConId5K++VH0sDWPc82FjBEbKxWb
	dwP4A2aTPtMWmjZqMXDqIHGmeDTzVAx5unqL84ZSNPZ4PhGtv4g9+8tDlPKGt4cE
	JEpCXpqE1D1MY0Ud4Wkz8HPTIIbrLnRJSVsVCgSqw9Lxr1x/I2KPLp9hec96Xleg
	==
X-PGP-Universal: processed;
	by brudepgp1.de.eu.sew on Mon, 13 Jul 2026 13:35:38 +0200
From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>
To: <iwd@lists.linux.dev>
CC: DEMODDIE <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH 1/2] src/eapol.c: fix of SEGV in eapol_rx_packets at receipt of EAPOL M1 msg at legacy roaming after ft_auth-/ft_reassoc-timeout when using mwifiex / NXP 88W9098 driver
Date: Mon, 13 Jul 2026 13:35:05 +0200
Message-ID: <20260713113506.1081-1-dierk.modrow@sew-eurodrive.de>
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
