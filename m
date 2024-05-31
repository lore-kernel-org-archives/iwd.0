Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055E158A37
	for <iwd@lists.linux.dev>; Fri, 31 May 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159030; cv=none; b=l2zfoBX5YSRX1yCUXN0HSKqwjtG2hsYdZvHEb7HTj3XM1zxa5V+k8hKjBNVoYRUogTFMjS+oDNNTT6Hl7ixXRnNuIy7t19gMKgyjE63IYdMhBIKrBDqzvVIrPQ2EtaOKlt3jeY9eMxLJyAxDDK37wN32oH+tansnZFoJA4E/IG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159030; c=relaxed/simple;
	bh=sxfCV+SQC3OLCwAtTq+iZNjaT2E/3UEjG01Xhe0twII=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=nxL8s8Y9vDeL5WQB5T6EZJ7qm6j+uqpRtluH5hh3tRXMRpBUgcyLyHO00zUs42mpdlUpoIC8eVQvbBmnV5V61pOHWv5ZZRHQRx/yCWbxycO7NDAPzDO1Zpk4s9pTg+/NNnf0GpjhLJHS8z1AA48jTnC1gcbE+cEzjnl804N+O4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peeters.gent; spf=pass smtp.mailfrom=peeters.gent; dkim=pass (2048-bit key) header.d=peeters.gent header.i=@peeters.gent header.b=puzQBHEI; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peeters.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peeters.gent
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peeters.gent header.i=@peeters.gent header.b="puzQBHEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peeters.gent;
	s=protonmail2; t=1717159018; x=1717418218;
	bh=sxfCV+SQC3OLCwAtTq+iZNjaT2E/3UEjG01Xhe0twII=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=puzQBHEIxX2+cw3Sh4sk9N40pdpDuWSodGJ+RIaZNfvHpk/B+lh5JmETxQf9GHBXK
	 OWudx4Mj4XTxOyRo4vqD9mRral27wCX8YBmllIyaRPObHLVtukOZbYSl/LoQDMl/Nf
	 QpW00r8ac5Kkt8bdmJEqwxASSQtek5SVEAU3b7Yaga+RPpNA16AbcGqivULRsJqPfx
	 mD2TOcGXAwDsADhljQ8WN8UwNm+T9Z0nKtFg1M79IwuTDGoEIKpYsZtRkiOlM8PhoJ
	 FPa9KNCqaePNtYj9wfcT0WkyvVOFrZKHGVTuOr5k2ngACxxxZnJ0SYFmDaLFWwRvWU
	 Wom13A8MXBV9w==
Date: Fri, 31 May 2024 12:36:51 +0000
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Laura Peeters <laura@peeters.gent>
Subject: [PATCH] eap-tls: Allow tls_msg_len to be zero
Message-ID: <1Nzi5TXKeegCbYp_JtW0ImxohaCclZWDu-VPAdUpguYP81MxtYr5g6PFwORmGDoOQ7fYErD-uJENgsCmZiHFVr-u0DwrHrFP1EvPGNgSkVg=@peeters.gent>
Feedback-ID: 91347878:user:proton
X-Pm-Message-ID: f61e9bc1a3d1cbc951ff2ae7127b0ece6d0638de
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

EAP-TTLS Start packets are empty by default, but can still be sent with
the L flag set. When attempting to reassemble a message we should not
fail if the length of the message is 0, and just treat it as any other
unfragmented message with the L flag set.
---
 src/eap-tls-common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 9c9f68a0..0374845e 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -500,10 +500,9 @@ static int eap_tls_init_request_assembly(struct eap_st=
ate *eap,
 =09tls_msg_len =3D l_get_be32(pkt);
 =09len -=3D 4;
=20
-=09if (!tls_msg_len || tls_msg_len > EAP_TLS_PDU_MAX_LEN) {
-=09=09l_warn("%s: Fragmented pkt size is outside of allowed"
-=09=09=09=09" boundaries [1, %u]", eap_get_method_name(eap),
-=09=09=09=09=09=09=09EAP_TLS_PDU_MAX_LEN);
+=09if (tls_msg_len > EAP_TLS_PDU_MAX_LEN) {
+=09=09l_warn("%s: Fragmented pkt size is larger than %u.",
+=09=09=09=09eap_get_method_name(eap), EAP_TLS_PDU_MAX_LEN);
=20
 =09=09return -EINVAL;
 =09}
--=20
2.45.1

