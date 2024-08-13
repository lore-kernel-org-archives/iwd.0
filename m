Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0E1A0730
	for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564612; cv=none; b=VXNBkuIahLgkszdPRcGhcD88e8soUiUgaCK3vWTcohQib9c1iYA0fx/f3Oq1oNyDo3en64Nq9R2jfx3W9HkBPNS47ZDGj3aK0nSnFXenDNG8Rfaa0z1ntH59KtYw1pVitrmJfWfZmiYbmKYtxG7gsSJ0AG9YBvtf5jcIcZzg0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564612; c=relaxed/simple;
	bh=3ACyH0wBcHI5aXAjWAcnc1ZlymMSvIai99xD4di9yuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VR65CJLDyQhFerP5q0dxaICiXmkQ6JYeYugozhHBzz/8G1xURaetlY+VScsdpn3aPeZcwb07VE5Pw+mpVXVnKtQ9CdZtvEKtLMpXrsiQWAHltWWvfDsy/UbUDejG3jtIGhVJUVde6+GPu72qtRZazmBHg8dtKAO+8sPHH17f5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf/fg2w6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf/fg2w6"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44ff50affc5so30433411cf.1
        for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564609; x=1724169409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lU2YFi0z6iWwdFzjptg9xLGk32SzO7YL037hOMc5X4=;
        b=Yf/fg2w6qnSnHTZQg1Qvihgk2Al3T/3+e6Cm6qd0n7oLgx3E4X0jYKVDtBVJfCnpHL
         /TJgetn6H5GKzhrbUBvm/NP9QzO2wND143+v6VCgFMc3LPBVnGDZc8b3Zq/9AJNHqt9y
         QcJGy4pQRXe5H4b7n2DlwmopWp4SwdiCnmaLECaDDzFqaNHyDNvMNETjyltBoY0p3DuS
         oXndUUAdnRJyr4ff4fRQPy9n5U+FkT7u+TnEu+t9Qz/GPsKvmRf+pdHqfQhH0+8u1np6
         J1rj2Sw9n8GfbBx9oFktX1Ox9+mJP7RgV/UFM1PVsPgFT6qKNDDmaHxhRl3uSSINXWBL
         Fq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564609; x=1724169409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lU2YFi0z6iWwdFzjptg9xLGk32SzO7YL037hOMc5X4=;
        b=oeRLk1wAwexUHMrzqpYvrL/+qsrXbRr4MHn+fFqFHvsS+NoxgGCWq9LinPkRYgvihu
         ndp3Ttj5ERwWG05X+WIPpronKwAWL+HRmVf+860KXpI6QbTTPWlfXtfru0vGbdsdsH/e
         XLhb3vHNhKWB/TC4ymf/dJ8gAnmyP93EfKWWNQ4FvSvNSfVKAseKAiqd6ehH55zpjuY9
         XYyyRaKve8D0XE5p/tVP8OJ3DKPZz/d93cYGvam61brYArUoUJeRJiksjBpoY52Ci/CO
         YPiXlMuWX+z1iQS7V9KI1PeEg0SHyDGoot/psJHGNaFr/JHefXyowpUJfOpFEtkViIBu
         bosg==
X-Gm-Message-State: AOJu0YytAFyYu7ePWGoQUL5S5FOjhhMjqEZOdE7/cz3EtOT1gAUSjMtA
	8Yx9j+q2Am+fYE9OpIHWxQGhk/gB/Cb8fEipCztFkHKsD+dfcRLqF2l9Fg==
X-Google-Smtp-Source: AGHT+IFIt5Vvu77AAELJyWWug78/En1dS9PqXkZ79rgOPHg5eL10E+IaOqs1/mbCIGbAn/gg4U8CcA==
X-Received: by 2002:a05:6214:4a89:b0:6b5:4249:7c4 with SMTP id 6a1803df08f44-6bf4f66d7a1mr37815246d6.2.1723564609050;
        Tue, 13 Aug 2024 08:56:49 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca2024sm35825706d6.72.2024.08.13.08.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/9] netdev: store signal threshold in netdev object, not globally
Date: Tue, 13 Aug 2024 08:56:31 -0700
Message-Id: <20240813155638.74987-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813155638.74987-1-prestwoj@gmail.com>
References: <20240813155638.74987-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prepares for the ability to toggle between two signal
thresholds in netdev. Since each netdev may not need/want the
same threshold store it in the netdev object rather than globally.
---
 src/netdev.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 494e46a5..a9648fbc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -172,6 +172,9 @@ struct netdev {
 
 	struct netdev_ext_key_info *ext_key_info;
 
+	int low_signal_threshold;
+	int low_signal_threshold_5ghz;
+
 	bool connected : 1;
 	bool associated : 1;
 	bool operational : 1;
@@ -206,6 +209,9 @@ static struct l_genl_family *nl80211;
 static struct l_queue *netdev_list;
 static struct watchlist netdev_watches;
 static bool mac_per_ssid;
+/* Threshold RSSI for roaming to trigger, configurable in main.conf */
+static int LOW_SIGNAL_THRESHOLD;
+static int LOW_SIGNAL_THRESHOLD_5GHZ;
 
 static unsigned int iov_ie_append(struct iovec *iov,
 					unsigned int n_iov, unsigned int c,
@@ -1058,10 +1064,6 @@ struct netdev *netdev_find(int ifindex)
 	return l_queue_find(netdev_list, netdev_match, L_UINT_TO_PTR(ifindex));
 }
 
-/* Threshold RSSI for roaming to trigger, configurable in main.conf */
-static int LOW_SIGNAL_THRESHOLD;
-static int LOW_SIGNAL_THRESHOLD_5GHZ;
-
 static void netdev_cqm_event_rssi_threshold(struct netdev *netdev,
 						uint32_t rssi_event)
 {
@@ -1089,8 +1091,9 @@ static void netdev_cqm_event_rssi_value(struct netdev *netdev, int rssi_val)
 {
 	bool new_rssi_low;
 	uint8_t prev_rssi_level_idx = netdev->cur_rssi_level_idx;
-	int threshold = netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
-						LOW_SIGNAL_THRESHOLD;
+	int threshold = netdev->frequency > 4000 ?
+					netdev->low_signal_threshold_5ghz :
+					netdev->low_signal_threshold;
 
 	if (!netdev->connected)
 		return;
@@ -3585,8 +3588,9 @@ static struct l_genl_msg *netdev_build_cmd_cqm_rssi_update(
 	uint32_t hyst = 5;
 	int thold_count;
 	int32_t thold_list[levels_num + 2];
-	int threshold = netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
-						LOW_SIGNAL_THRESHOLD;
+	int threshold = netdev->frequency > 4000 ?
+					netdev->low_signal_threshold_5ghz :
+					netdev->low_signal_threshold;
 
 	if (levels_num == 0) {
 		thold_list[0] = threshold;
@@ -6163,6 +6167,8 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 	l_strlcpy(netdev->name, ifname, IFNAMSIZ);
 	netdev->wiphy = wiphy;
 	netdev->pae_over_nl80211 = pae_io == NULL;
+	netdev->low_signal_threshold = LOW_SIGNAL_THRESHOLD;
+	netdev->low_signal_threshold_5ghz = LOW_SIGNAL_THRESHOLD_5GHZ;
 
 	if (set_mac)
 		memcpy(netdev->set_mac_once, set_mac, 6);
-- 
2.34.1

