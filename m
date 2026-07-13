Received: from mx2.sew-eurodrive.com (mx2.sew-eurodrive.com [194.180.1.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B338D40D
	for <iwd@lists.linux.dev>; Mon, 13 Jul 2026 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942977; cv=none; b=iMn4ELbav+YKYgqZaC4GZtw1tm/tmtu/LNhqtNfspJzTZCwPKFBlcI/L7Eo3tUJEFJz6zNuPlr0MeDCv3XFuVYhjxW3v126IUOfPx+V00EnBqfNMfZDdqUaDXEHtWvH/cizSZi50uAufgv2bbLx30EqMniTzEYbTj2Qup4KQ+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942977; c=relaxed/simple;
	bh=qyNKS2N0Hu7j/HBpn54I8RAww4dgqgKiKF+WVZMH0ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cpyfLz1UUoNHNFOKxO9QaekXt7a7lTJX5VF4Po2tbzqIrpoKQF84IfidCbRgnhNK1nN/nyxWwLvsIwrRsgToLWwy7i3XZe7rt36VWrcEgzXTcD7IE1vRiP/pfivrOozmKdKripuidJec+zTqU2nFI222kbUJ2ydTUGu1EYHckJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=pT0Ae4Zz; arc=none smtp.client-ip=194.180.1.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="pT0Ae4Zz"
Received: from pps.filterd (mx2.sew-eurodrive.com [127.0.0.1])
	by mx2.sew-eurodrive.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBSSgI001746
	for <iwd@lists.linux.dev>; Mon, 13 Jul 2026 13:29:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sew-eurodrive.de; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to; s=sew1; bh=vorn1K
	nj7OrIOCx6s0/FqqEf4tBNqHXJnk44jNUi2Vs=; b=pT0Ae4ZzLdNYMLvMK76CEh
	kK1OIXDUDZpHqsnmk7F5bWgQtoYPfSzGTFeprcSV/ySZMtMSyDNcQoaYDJQLO2BD
	7nVAz6fMJT7G5pQxzKgX3tDAVxtUvyB+m+BMXHKv/bUKkE2FSsnP7k7PDGznTntm
	FRGcWefaxpwPyzs5L+jMSIZsLC3C3O9NOPnXGXpQGmy4B8NFTK1QMr7WdYEg/qb8
	LG/FashvgdorIatvOYHQlQwmNhnfqLBA/8Ley2S35kqTErZXBIMb5raQIc/8HaNO
	BpSpx2a3PVLssDo9oI7U5GqARwvB4T7JZdDb1brcDW0NXxoYlQ05wGAvCt16/UWA
	==
X-PGP-Universal: processed;
	by brudepgp1.de.eu.sew on Mon, 13 Jul 2026 13:29:37 +0200
From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>
To: <iwd@lists.linux.dev>
CC: DEMODDIE <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH 1/2] src/eapol.c: fix of SEGV in eapol_rx_packets at receipt of EAPOL M1 msg at legacy roaming after ft_auth-/ft_reassoc-timeout when using mwifiex / NXP 88W9098 driver
Date: Mon, 13 Jul 2026 13:29:24 +0200
Message-ID: <20260713112926.1030-1-dierk.modrow@sew-eurodrive.de>
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
