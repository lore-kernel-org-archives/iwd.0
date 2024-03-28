Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A93FB8D
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665589; cv=none; b=SSr7ga2rt1cF1ue9aomZuEcO/WknsWWFqLfhsb+CK+qVPJABf7yqf7hcPJfY5kYGZmkG9wkYGu8MJlwP0okVVlo2q106XHYmD9WKFRdbfirkTBj3pI5zFIuUyIz4186EnWxUN4WTFJHtB5HzsggZHB+q5NToSb7r0OqC7Tq+kFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665589; c=relaxed/simple;
	bh=fXMIX0dnv+w56jqOJXCAAU209h6yN4DGabMDgIqRi6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/fYP54rX0O8Zw5kJUfiosvKmINZCGP/ZuQjk0or0ZrL8De8/tuvOMMmofgBtZcb8xApjlTv6/O6ct+WkUh5lZcfDBTEcqSHQnJJ7zxEO9Mj5+vy6WPC/9UtkVqrRGU0/IlwaH3XhiZmLpYa6FkZtjc8gG0ykNZaJB7ZMCSnnzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QpKonrrl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QpKonrrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711665580;
	bh=fXMIX0dnv+w56jqOJXCAAU209h6yN4DGabMDgIqRi6I=;
	h=From:To:Cc:Subject:Date:From;
	b=QpKonrrlD4DZLVnKLg103wLDzeHeBbFUQ90n4BbKhIzF0yA8bKLQVavqihPmLE/ll
	 xG3SchMxhcRCHNajZUCN51hGyYq9P3/qYsUNdKMPASxTtUH6I2uVnAm+EIYgWr0V7V
	 9oQS47HGt4bZ++7ZTpxT5Cy+anrbpMqeC4jgBfhUqYtF+NKhiRI+jiXpguMLZv4ONZ
	 2TGcLKii2Mqb3T0na8HuCt++5NxtaBQ2Mnpfyx9oWY1q5EcPMXlzsVCihNyQ6FQlpR
	 kHCU5DRrSGV2Pn8/QLpZtgBZh7NUlD8/Wbfbxt9EgTed/RvffJcvMsaEu2zhXDvu9v
	 1dag/yJNYPF9w==
Received: from kirby.atomupd.steamos.gitlab.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jwhiting)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB8FA378209C;
	Thu, 28 Mar 2024 22:39:39 +0000 (UTC)
From: jeremy.whiting@collabora.com
To: iwd@lists.linux.dev
Cc: ed.smith@collabora.com,
	alvaro.soliverez@collabora.com
Subject: [PATCH v4] Register EAPOL frame listeners earlier
Date: Thu, 28 Mar 2024 16:39:31 -0600
Message-ID: <20240328223931.814213-1-jeremy.whiting@collabora.com>
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
 src/netdev.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 09fac959..f146d906 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2896,6 +2896,15 @@ static bool kernel_will_retry_auth(uint16_t status_code,
 	return false;
 }
 
+static void netdev_ensure_eapol_registered(struct netdev *netdev)
+{
+	if (L_WARN_ON(netdev->sm))
+		return;
+
+	netdev->sm = eapol_sm_new(netdev->handshake);
+	eapol_register(netdev->sm);
+}
+
 static void netdev_authenticate_event(struct l_genl_msg *msg,
 							struct netdev *netdev)
 {
@@ -2982,7 +2991,12 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 						NULL, netdev->user_data);
 
 		/* We have sent another CMD_AUTHENTICATE / CMD_ASSOCIATE */
-		if (ret == 0 || ret == -EAGAIN)
+		if (ret == 0) {
+			netdev_ensure_eapol_registered(netdev);
+			return;
+		}
+
+		if (ret == -EAGAIN)
 			return;
 
 		retry = kernel_will_retry_auth(status_code,
@@ -3099,9 +3113,6 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 			netdev->ap = NULL;
 		}
 
-		netdev->sm = eapol_sm_new(netdev->handshake);
-		eapol_register(netdev->sm);
-
 		/* Just in case this was a retry */
 		netdev->ignore_connect_event = false;
 
@@ -4279,6 +4290,8 @@ int netdev_ft_reassociate(struct netdev *netdev,
 	if (netdev->sm) {
 		eapol_sm_free(netdev->sm);
 		netdev->sm = NULL;
+
+		netdev_ensure_eapol_registered(netdev);
 	}
 
 	msg = netdev_build_cmd_associate_common(netdev);
-- 
2.44.0

