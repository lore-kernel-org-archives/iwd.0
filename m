Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680E3D8133
	for <iwd@lists.linux.dev>; Wed,  5 Aug 2026 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937910; cv=none; b=BSqqVJJaBmENuISF4VfTpj9aaYuSmYdGxVVmrNVYg83YTEtkqZ0UiV+jrHxflbcu+BZRz40kj2TGSQ3ZyvO5ij7T2n94olL7SGEtKxfLJuS707/dCYxLRGLrPtdHFOR0WVfSvVfbB69ONn04ygEhvvyFD4wKXKjXcYUS+kAs9Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937910; c=relaxed/simple;
	bh=BWXARvP518Yu3MB1DFFyRk1NDalxkXv7LVUmOFcrTcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0dbVvcTaE8qyt8o9b+NmMv8IVes2omzVFHSFS4q/MkHOKeOoCyZr4wn9K8P6brj827tQdkZ3Slpula5FOcsQp1sQrsf64M+drODI7W1tV9JsDouKrW7O52Ogkr14ncAjvXKPymR9c2DixINomFxQAlRHC7qcjX7OK1nbGS98Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BJAd4euF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BJAd4euF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785937906;
	bh=BWXARvP518Yu3MB1DFFyRk1NDalxkXv7LVUmOFcrTcU=;
	h=From:To:Cc:Subject:Date:From;
	b=BJAd4euFOSe5Ta3rjElJqeMw85LR968KF7Ff3Ii6k5RHQDbHkzc2hmphShnkwp2lx
	 2KjMKgJtY8JFxat7W+gFVCkDFlwNFKdIluD95Nqa7PHOmqOKoFaWnxLVfq3tJyvimg
	 oI5AvkrhWn05yN0AvwHNhvRwpNut8HC/H+2Mrom1Mjg7uHiNH5IB9gnrMDstIvJd0O
	 rf+Iggyj5mCNhMSRg2+88esZlWtg08l+FH+bxU5M46IH8aY8tY4awR6M5cj2aEEjN9
	 xv9m9v4uwHUzm+pCL/FX5avJoWtO95DLgI4Cwlawd9Kos8Svrh331z9uWffH2NiBWB
	 9m99970oH0P7Q==
Received: from vignesh-thinkpad.. (unknown [100.64.0.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AEE7517E025E;
	Wed, 05 Aug 2026 15:51:45 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: iwd@lists.linux.dev
Cc: andrew.zaborowski@intel.com,
	bgalvani@redhat.com,
	ludovico.denittis@collabora.com
Subject: [PATCH] station: register BSS before adding to ESS
Date: Wed,  5 Aug 2026 19:21:37 +0530
Message-ID: <20260805135139.2957946-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The network points to its BSSes through ExtendedServiceSet, but a
BSS does not point back to the network. So the BSS object should be
published on D-Bus first, then added to the network's list. Doing it
the other way round briefly exposes a BSS path on D-Bus before the
object it points to exists.
---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 8fcf8c70..8b9ca565 100644
--- a/src/station.c
+++ b/src/station.c
@@ -646,8 +646,9 @@ static struct network *station_add_seen_bss(struct station *station,
 			network_get_ssid(network), security_to_str(security));
 	}
 
+	/* Publish the BasicServiceSet object before it's referenced in ExtendedServiceSet. */
+	station_register_bss(network, bss);
 	network_bss_add(network, bss);
-	station_register_bss(network, bss);
 
 	return network;
 }
-- 
2.47.3

