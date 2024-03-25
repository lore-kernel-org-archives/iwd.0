Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74D6E5E1
	for <iwd@lists.linux.dev>; Mon, 25 Mar 2024 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410094; cv=none; b=ZtKzZShgTOp8ca3gqyCw3/T8mXp23fyXlETmhD51ovRi1fkJRowVlpDtHkVabATkRP8NHbzOAb61FPBfMQDBVeMV52fePbbRZBco3W4kSZ1s5t8yTbt2UM65aTTUe7RLVSqwq1OFkEZXNN/qTDVVRusCJnEyGM6Sr7MM7h7s85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410094; c=relaxed/simple;
	bh=xpm6nNh4lQY2AmqmZHD6l+lt6ja4q82ToHmAsBebC9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYQh/VtP8cZCPoim/jDRbqZTdXUFumIjJcTFjmf/H3JwuHc8X9vX6TD+eCrEquEpRqhpRf3LNuqWd8n+0Iird0MZ4uyT5mhcas9AzoQaPuO5lQTTRAwpFvX40hCuXXnqmIvPNe3WRijHjxmTb5exnuFkPmc5bFZNbqciluLZb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DvMF9X8E; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DvMF9X8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711410091;
	bh=xpm6nNh4lQY2AmqmZHD6l+lt6ja4q82ToHmAsBebC9o=;
	h=From:To:Cc:Subject:Date:From;
	b=DvMF9X8Eo0rTN2bVuum0lc8OkztqyTqo10jvcQo7nx6MQ53p44kzgF7J5Wa29esWI
	 DHrmbgfuMNgu+v0i/BoTcmAR7h6z29weh2SH4+hGmknnAszDsE6OMcwLuGBmolZxsJ
	 iTnz3NxFGJhi64KhTeFk4il6sej7xyrs/mfcUuPDxIdmKZBOntYARWoubcd/YVsG7A
	 H6MkmZOjKkGluthscxX+Bm3OO+Xj/Er3dpp4Rcnysts2biRDUugWf0EAuftMznfhQu
	 JQJI7ORNS98noOmCxLP8SA3ryAH0apOAPzQNR00VGHPLuKwNGjHe1wM+nbzHTR9N5F
	 NJxTVmWNIMTXw==
Received: from kirby.atomupd.steamos.gitlab.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jwhiting)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1F03037820BB;
	Mon, 25 Mar 2024 23:41:29 +0000 (UTC)
From: jeremy.whiting@collabora.com
To: iwd@lists.linux.dev
Cc: ed.smith@collabora.com,
	alvaro.soliverez@collabora.com
Subject: [PATCH] Register EAPOL frame listeners earlier
Date: Mon, 25 Mar 2024 17:41:26 -0600
Message-ID: <20240325234126.510777-1-jeremy.whiting@collabora.com>
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
 src/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 09fac959..d6dc7004 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3011,6 +3011,11 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 		}
 	}
 
+	if (!netdev->sm) {
+		netdev->sm = eapol_sm_new(netdev->handshake);
+		eapol_register(netdev->sm);
+	}
+
 auth_error:
 	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
 				status_code);
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

