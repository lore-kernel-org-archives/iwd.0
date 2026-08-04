Received: from mx1.sew-eurodrive.com (mx1.sew-eurodrive.com [194.180.1.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF93DDB11
	for <iwd@lists.linux.dev>; Tue,  4 Aug 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848135; cv=none; b=GEejkryHJcWLY7Ki66pyyjNE2FNdhfK44RvIm5ZwZMi2F4rqtCV6QIX3+NzyVsJfZHRW09TVdHQgFdLL3Zj4NX/vfjR1oaiJykpwBYV7N1IzGjpu1MuPap3pkIDu9AblttRxCQvD60FNtWxv0r74xR+g/kfEjdkOhxMd3x0B7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848135; c=relaxed/simple;
	bh=woTdC44N0yK0SQJYBfCoyvGqxcbiq3B5OBy/flJAhhg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LFe/ZTjr2u5hEGT+br5+3D/QXU+onC6+P5W0M5J5TywtgwvaW3Bj7jfK816mIsNhFGfoEXJZfvsnhWPFykdKuo2QQRmeXn0OGs02bjVPxiMtzaYWlznVmhdaIJgbF8dIThbNyHKPFgOk/z8DaV6+qJ6oKyNWsGIO4noDS2xGBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=WdLvkE5h; arc=none smtp.client-ip=194.180.1.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="WdLvkE5h"
Received: from pps.filterd (mx1.sew-eurodrive.com [127.0.0.1])
	by mx1.sew-eurodrive.com (8.18.1.7/8.18.1.7) with ESMTP id 674CnCeZ030637
	for <iwd@lists.linux.dev>; Tue, 4 Aug 2026 14:55:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sew-eurodrive.de; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to; s=sew1; bh=lzEb7o
	EPk/kqQDgmbf+h4+fEs8lEX4MLgZQzKJCswJM=; b=WdLvkE5h03PtfcFGYLwUUX
	QWSo7H/sG9HAzfRIiRlg6Z2vxTGt5g3LNkzXUEmJABPTIZo0vXj/GEgzw9tLIXC2
	L7l63hhXd7EEzgYTZH/blHWeZzRk1OKIquiyWjylSwETvkP/vvv7gfSavLmEjZyt
	/QcRffbLFnJLPzEJW8GhqIv7klFmO9q0JT+uMNAe8iXAQf/SN7aNP+jYoebfuMVJ
	KoTLIwj5ddH+8uhw7HpSTln3VgiVNutAH5PsfnxvsJcJySVBAcN0y7r7RXPIIlXD
	36xUaDHnHhQtpfRfN/hkpSpHc+kekLfYIgjmtNxo7X8QaGaLMXYA7tvudio1/AUg
	==
X-PGP-Universal: processed;
	by brudepgp2.de.eu.sew on Tue, 04 Aug 2026 14:55:23 +0200
From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>
To: <iwd@lists.linux.dev>
CC: <prestwoj@gmail.com>, Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH v5] src/eapol.c: fix of SEGV in eapol_rx_packets at receipt of EAPOL M1 msg at legacy roaming after ft_auth-/ft_reassoc-timeout when using mwifiex / NXP 88W9098 driver
Date: Tue, 4 Aug 2026 14:55:05 +0200
Message-ID: <20260804125505.2126-1-dierk.modrow@sew-eurodrive.de>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01

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
