Received: from mx1.sew-eurodrive.com (mx1.sew-eurodrive.com [194.180.1.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E0429CFA
	for <iwd@lists.linux.dev>; Fri, 31 Jul 2026 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506754; cv=none; b=QKVarJnuHfNsnOY1gtR4HyHbAUAyniFstj1T08jggoCj/Jbd+xYshPOgfH9suF0uv09m9U4SfwCx3EgwAcv9XxrDyl4xB5mTGjLSwYohscyMmjYoMigjBPPfI9Ncp8IDp1N8SYBIb8xNAq9j7xDwMoW/qKSuz8pcGXUTLwJZGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506754; c=relaxed/simple;
	bh=woTdC44N0yK0SQJYBfCoyvGqxcbiq3B5OBy/flJAhhg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ICRwVhzCkyves+c8WAWgoVATCpytPfS43vAOUXrc+VEIerj66e/NDhrvL4hxbf3pyKkwf+LYTwWPrCoiQPCpwJyjAFrbCNN2Q4LGLA/RDfONNW8LZmzU4pdrX7fpdxoG4M3KwQNLuy/g+oJe3FYnBfzvjITVhYsuTkkg3bRMJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=lG2P9Oa9; arc=none smtp.client-ip=194.180.1.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="lG2P9Oa9"
Received: from pps.filterd (mx1.sew-eurodrive.com [127.0.0.1])
	by mx1.sew-eurodrive.com (8.18.1.7/8.18.1.7) with ESMTP id 66VE4Dip011265
	for <iwd@lists.linux.dev>; Fri, 31 Jul 2026 16:04:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sew-eurodrive.de; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to; s=sew1; bh=lzEb7o
	EPk/kqQDgmbf+h4+fEs8lEX4MLgZQzKJCswJM=; b=lG2P9Oa98YNAQlAnxrCbgf
	Vxoqid5szG3W8WJ/sD06iUAQ0U7D+gUEJYLVTBOMP04uohlX4kgNoVHVJ4s+ElEC
	pS6hAxRaO3izoTLj3eQe3Z8uLCog0yijxNsha44zOR6KQ5ZI0LdoY2cyqPAtDYXQ
	UKftQ6e8c/sPzJn5kyI2Yh57tAQgAHdeQjSGFsbMJBUXFaJNXyXJYEMryJURz8zG
	rxGqltkv+C08QQzFih+RCC7+7g+ImTxelLtNDbM3BgFp2TC+J/HjEFF4qhhwtK54
	tT/hYJXoj+pbtCLztc+bvGfkuFCqi6yskptlGcvZa7gyK/bnhL9zMErVsrl8kIXQ
	==
X-PGP-Universal: processed;
	by brudepgp1.de.eu.sew on Fri, 31 Jul 2026 16:04:26 +0200
From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>
To: <iwd@lists.linux.dev>
CC: <denkenz@gmail.com>, Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH v4] src/eapol.c: fix of SEGV in eapol_rx_packets at receipt of EAPOL M1 msg at legacy roaming after ft_auth-/ft_reassoc-timeout when using mwifiex / NXP 88W9098 driver
Date: Fri, 31 Jul 2026 16:03:22 +0200
Message-ID: <20260731140322.1823-1-dierk.modrow@sew-eurodrive.de>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ClientProxiedBy: debrumsx23.de.eu.sew (10.2.251.142) To debrumsx07.de.eu.sew
 (10.2.251.157)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01

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
