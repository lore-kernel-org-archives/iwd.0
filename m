Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129D1E494
	for <iwd@lists.linux.dev>; Tue, 26 Mar 2024 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494723; cv=none; b=tGl5PtQrAgyG5kX1Rgg11FhDWDFYbQe7Ea5FFeV7oZNCHPWpAdFs9JQldDIsmYLtbl8WKZn7l/SLbEnPGnstxQVE+tBf1W0F600n88leFy8rvlriRqwjwRUrudXCvf+WlQhHtZCjZFtK8dGqY9p68Prt1zBnVNQpaCZFf/M9Gos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494723; c=relaxed/simple;
	bh=CjZDfNQrzeGkOKcKM5mH9XnIau6AHUCFYtkEXsAmV+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlOQ/cGResYUOORydf6ptoDJ1M1zPxZLtFvCcHQrZOgZ1hy0o3+zuqPyIO2SzdAxSAEdftNBW0xY8RuhgN3Oou0SgBnTTZOw7f8tyFSpO0guCs5Mp0dPJOEI932HbmQbt3KB1N2SMX8ck/qZQbOH6657wWVpaPwIT18aAYGd6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mzh0Sh/3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mzh0Sh/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711494717;
	bh=CjZDfNQrzeGkOKcKM5mH9XnIau6AHUCFYtkEXsAmV+0=;
	h=From:To:Cc:Subject:Date:From;
	b=Mzh0Sh/3EXVYhiFJlrcGeotdZeQIpbeSrv2G6lpR1aeOBHecn7uhLGeqYza/YCfYj
	 HUOWkMAgXvUMUp7vipD0q0u9b2c7FK07mFSVBvYs+T4cfFaGkxmYxDe44IW1tVHWGj
	 J5bTpWFhFxUNzf1by9P8qa7JPfUXBe8Mib4NuDxylGHL94COYw/h+Bpahc14mA6Oo6
	 XZQj6YP5lIz8AGkGqAepGXzcEpDKUPF5ax3P803jCPLT5/cFPpSJbj6oPuGmkhgK1W
	 d8M9gOMgVJ/a1bwrcVhkR2COLrikmPYp42uRlb9huNq3hYo2QgwD7Ba8Nk6/ijjPbi
	 53f/FXXOOwbxw==
Received: from kirby.atomupd.steamos.gitlab.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jwhiting)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 72058378020D;
	Tue, 26 Mar 2024 23:11:56 +0000 (UTC)
From: jeremy.whiting@collabora.com
To: iwd@lists.linux.dev
Cc: ed.smith@collabora.com,
	alvaro.soliverez@collabora.com
Subject: [PATCH] Register EAPOL frame listeners earlier
Date: Tue, 26 Mar 2024 17:11:51 -0600
Message-ID: <20240326231151.607163-1-jeremy.whiting@collabora.com>
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
 src/netdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 09fac959..fc84c398 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2982,8 +2982,13 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 						NULL, netdev->user_data);
 
 		/* We have sent another CMD_AUTHENTICATE / CMD_ASSOCIATE */
-		if (ret == 0 || ret == -EAGAIN)
+		if (ret == 0 || ret == -EAGAIN) {
+			if (!netdev->sm) {
+				netdev->sm = eapol_sm_new(netdev->handshake);
+				eapol_register(netdev->sm);
+			}
 			return;
+		}
 
 		retry = kernel_will_retry_auth(status_code,
 				L_CPU_TO_LE16(auth->algorithm),
@@ -3099,9 +3104,6 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 			netdev->ap = NULL;
 		}
 
-		netdev->sm = eapol_sm_new(netdev->handshake);
-		eapol_register(netdev->sm);
-
 		/* Just in case this was a retry */
 		netdev->ignore_connect_event = false;
 
-- 
2.44.0

