Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8712A144
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565375; cv=none; b=PF4NsBwFRZL1Q+fXOmfBywIADM9puRVuaoni/2DJdI+mnQBpmvmS8KsnKI/SDWwgANsVGx1nRqUuuazVoFn48I5StaaYfClOu39Rij2NVLYmLwwHHNaA9D4AFToQJbED+2d12W6WG6MohmPmtlDHwfGG5tascqHIuqODtOcUAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565375; c=relaxed/simple;
	bh=lytv7W8v/5SrM8zSjTMhoBW6ADGRhAJXI/k/BZSwYQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpJ1ZOpvPAZ/z5zF2p33zzlTjWHWVeTw/T+taNgdtUK6KqWiS433cqasI7GZ1aQv8tTr6XkKgT0LiO3JBkIoaGNRfUPgQ9+Yyzxp7ThyAfn6w3uf+wCX20nDj6MRCP0Lv9sSURRpu45moWLuy9w6qWj1RuHV8Yzqooh3J3Xmwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lWpFlVGf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lWpFlVGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711565372;
	bh=lytv7W8v/5SrM8zSjTMhoBW6ADGRhAJXI/k/BZSwYQo=;
	h=From:To:Cc:Subject:Date:From;
	b=lWpFlVGf6P0h7jjJXln6FDbcGM/nH51hArm9nSOvE7Pi7ZF+JRuhxYo9MQoSLTizn
	 6Vaf4Vyogw6Jj4PnqRdvnYMTOWcPWbIreAYy2+dlpZO/pBgtlUhDpnY8iVQJBpWXDK
	 NK/St+y6BKFby8tcDHfLS2+dZVIJXNIHx/axcEvfACBMeGdQqLHtvz9h+Gi0j4EGhK
	 YKfY1v8+MLlqPRi+NT9yU5hxniYaoDsLSQ4vigqvsEQYitjn2IyxF1InCLe4AstcFd
	 zsZ2tC26x2JldmAhsv2TkAxgTGEJwT9ZJN8E9bmh/uN3H1YHuwnRLzGXt9naCQHH22
	 jSMHZHuHnfU9w==
Received: from kirby.atomupd.steamos.gitlab.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jwhiting)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7967C3782112;
	Wed, 27 Mar 2024 18:49:31 +0000 (UTC)
From: jeremy.whiting@collabora.com
To: iwd@lists.linux.dev
Cc: ed.smith@collabora.com,
	alvaro.soliverez@collabora.com
Subject: [PATCH] Register EAPOL frame listeners earlier
Date: Wed, 27 Mar 2024 12:49:27 -0600
Message-ID: <20240327184927.677804-1-jeremy.whiting@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ed Smith <ed.smith@collabora.com>

If we register the main EAPOL frame listener as late as the associate
event, it may not observe ptk_1_of_4. This defeats handling for early
messages in eapol_rx_packet, which only sees messages once it has been
registered.

If we move registration to the authenticate event, then the EAPOL
frame listeners should observe all messages, without any possible
races. Note that the messages are not actually processed until
eapol_start() is called, and we haven't moved that call site. All
that's changing here is how early EAPOL messages can be observed.
---
 src/netdev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 09fac959..886a85f5 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2896,6 +2896,14 @@ static bool kernel_will_retry_auth(uint16_t status_code,
 	return false;
 }
 
+static void netdev_ensure_registered(struct netdev *netdev)
+{
+	if (!netdev->sm) {
+		netdev->sm = eapol_sm_new(netdev->handshake);
+		eapol_register(netdev->sm);
+	}
+}
+
 static void netdev_authenticate_event(struct l_genl_msg *msg,
 							struct netdev *netdev)
 {
@@ -2982,8 +2990,10 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 						NULL, netdev->user_data);
 
 		/* We have sent another CMD_AUTHENTICATE / CMD_ASSOCIATE */
-		if (ret == 0 || ret == -EAGAIN)
+		if (ret == 0 || ret == -EAGAIN) {
+			netdev_ensure_registered(netdev);
 			return;
+		}
 
 		retry = kernel_will_retry_auth(status_code,
 				L_CPU_TO_LE16(auth->algorithm),
@@ -3099,9 +3109,6 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 			netdev->ap = NULL;
 		}
 
-		netdev->sm = eapol_sm_new(netdev->handshake);
-		eapol_register(netdev->sm);
-
 		/* Just in case this was a retry */
 		netdev->ignore_connect_event = false;
 
@@ -4279,6 +4286,8 @@ int netdev_ft_reassociate(struct netdev *netdev,
 	if (netdev->sm) {
 		eapol_sm_free(netdev->sm);
 		netdev->sm = NULL;
+
+		netdev_ensure_registered(netdev);
 	}
 
 	msg = netdev_build_cmd_associate_common(netdev);
-- 
2.44.0

