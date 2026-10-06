Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80B191F91
	for <iwd@lists.linux.dev>; Tue,  6 Oct 2026 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292678; cv=none; b=YS0V+xQL0+MdbUt5+Cq9Dxp0FaxZjRStGeLIO12kvuivJRHISmvs2H0dnM9V6z0TRIVzrfIRs2e3wlrguMZxmqU85YkV2KFyRdwC85YbifC2pDXgodYeaBBHsUJoprTb2LivWoMG4PA26NZEoOXKcTwfoPGPmdQxxiUJOlK+9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292678; c=relaxed/simple;
	bh=OLIPFWcoryts7Z3w8Bb3hYs7/R0Nyvrv6CNEP/WVshI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7W+lYrFev5LsaXfZvnmLHFS8VcEMzhgF6Oi/1eL+41U6p1XC+PgAVR+9loqn+uagAcl8zWGqaFNlqAGfCacPd3wqZDJldisdLAewJPgBlpYExECdxFGt/yQOqhZaXaxkKpdxcMZuF3S+zr6Baw/PqjrwJKajijWdD/v6D0zkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mWvLN4NB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mWvLN4NB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1791292668;
	bh=OLIPFWcoryts7Z3w8Bb3hYs7/R0Nyvrv6CNEP/WVshI=;
	h=From:To:Cc:Subject:Date:From;
	b=mWvLN4NBKnGyhp27C4QEYFrjK+YDoA0fJP0F+kjixLQnqZiaWqDXHvwlFjhjod+xn
	 HTZNkp7yBJjAYz6sGc2RW8TrCdHZ+rI2ejYuIdtqB6wxYoB4Flzx5/UeIMe3sxZVq0
	 CAihYcBe7yFXv31/P1iy5/2Idp845rClKBaa8AvESHjwoGd6GsWsKcOA58uDxzF8FE
	 HwROxaHqRtDHw0UMpl0ZS2ZIXLRuynaOUgxtYgsgf2JAX5ZUsnTMzNFQjQuoiaKUF3
	 n0BnbV2eBGshbDqEWmtOW/pK+cXAZQiC+BkNVRaZilmBzckCd4rAea4zKSpyOpvGan
	 RY9T+Jic0PFpQ==
Received: from vignesh-thinkpad.. (unknown [100.64.0.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C22BE17E01C2;
	Tue, 06 Oct 2026 15:17:47 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: iwd@lists.linux.dev
Cc: bgalvani@redhat.com,
	ludovico.denittis@collabora.com
Subject: [PATCH] network: report WPA3-SAE networks as sae in Network.Type
Date: Tue,  6 Oct 2026 18:47:38 +0530
Message-ID: <20261006131740.1965490-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iwd reports both WPA2-PSK and WPA3-SAE networks as psk in Network.Type.
NetworkManager relies on this property to pick key-mgmt, so it saves
WPA3-SAE networks with key-mgmt=wpa-psk instead of key-mgmt=sae.

Report sae for WPA3-SAE networks to fix this issue.
---
 src/network.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index a5a2375a..12165176 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1842,9 +1842,13 @@ static bool network_property_get_type(struct l_dbus *dbus,
 {
 	struct network *network = user_data;
 	enum security security = network_get_security(network);
+	const char *type = security_to_str(security);
+	struct scan_bss *bss = l_queue_peek_head(network->bss_list);
 
-	l_dbus_message_builder_append_basic(builder, 's',
-						security_to_str(security));
+	if (bss && bss_is_sae(bss))
+		type = "sae";
+
+	l_dbus_message_builder_append_basic(builder, 's', type);
 
 	return true;
 }
-- 
2.47.3

