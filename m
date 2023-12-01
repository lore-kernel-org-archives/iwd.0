Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E35384
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDKdut2X"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58d3c9badf5so996849eaf.1
        for <iwd@lists.linux.dev>; Thu, 30 Nov 2023 20:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403272; x=1702008072; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0ObB9cs7ZSZzFHH4EJDzZR47P3cvts9XS1f2MUt2Ao=;
        b=PDKdut2XDnSrVlw0d5ArIbBLTnlN8ma/yM5zkw1ESkyffBYVMkgeIkL7DbnNFe3FzS
         Gym4gWJ8f7WCiDUsg5QQMmHtut7AF6/Wirc2UyVPa7pA9QQlG2xJPDFXWV4m7otO3WkZ
         zSbbNsJhdDj8jex5aWVsVkXQ8S3MrmamDU5Q/nkpSpQZZ9Nj6eS9HOd4l3MPXK+Dy6T7
         /XszKC0JmYpkOi5nrb1WX5LTb2fjNk23AKrg8zK+uMd6vFi/5nqdAUAgbW7xUmuQZA0M
         ErukQBLhWjWHStt4N0pnQhT9S+ilwU3XVDb/eeRbdqDPnvXl/yl7vbleiQtOoAYaPS1P
         atzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403272; x=1702008072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0ObB9cs7ZSZzFHH4EJDzZR47P3cvts9XS1f2MUt2Ao=;
        b=W5BNKpA+Ip8aMVBUFvKpKUfp1xNh8Xc3NsLE5LNpvwBj+RYwaEYwQ2cKjPVtGOrkq5
         Vrxb8PeV4/8l1APVTJl1GQ8nK5svfOA4gkH/YxIXflkgX96x6WUBOdvG/ffZbLcujZys
         Mjq85rMU2Pm/zgpR9DTY7zU7Zc5CX+hQK+TBtArGjTGpzTY6klPK34zInkEBwK7t7JjX
         7zT/p7gsbwp8jbFyfcnA6NVUA4DxIQBUTsujQE/GHS9F3Rtat3iZDyiLAa+Obj7Yl298
         i0oAVU7dT+dZaIlwkhwOOPUwzKM7WdvDyCNkMGUmITyKrDkXlPuBPwLSwG52uWvmKoNh
         q95g==
X-Gm-Message-State: AOJu0YyUDB/ZjSGoCNtVCAKfIy64TpFqTiQnXe4pTXDOui7mYl6Lkmoa
	djRBA35+q+JKgA3pFHtLGbA5C/26xM8=
X-Google-Smtp-Source: AGHT+IGnXxO7Zzbzg4KUt4W9p20GerdfYSatdG3/pjlzfSzhIHchrvOMbPMD0s8PqTHiHdZ5uH94kg==
X-Received: by 2002:a05:6820:626:b0:58d:7320:1ba0 with SMTP id e38-20020a056820062600b0058d73201ba0mr1826402oow.0.1701403272057;
        Thu, 30 Nov 2023 20:01:12 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o3-20020a4ad143000000b0058ab906ae38sm404005oor.2.2023.11.30.20.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:01:11 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/7] netdev: iov_ie_append: Support iovecs with multiple IEs
Date: Thu, 30 Nov 2023 22:00:04 -0600
Message-ID: <20231201040020.161143-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201040020.161143-1-denkenz@gmail.com>
References: <20231201040020.161143-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iov_ie_append assumed that a single IE was being added and thus the
length of the IE could be extracted directly from the element.  However,
iov_ie_append was used on buffers which could contain multiple IEs
concatenated together, for example in handshake_state::vendor_ies.  Most
of the time this was safe since vendor_ies was NULL or contained a
single element, but would result in incorrect behavior in the general
case.  Fix that by changing iov_ie_append signature to take an explicit
length argument and have the caller specify whether the element is a
single IE or multiple.

Fixes: 7e9971661bcb ("netdev: Append any vendor IEs from the handshake")
---
 src/netdev.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 208a15b94507..eb408447224c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -209,7 +209,7 @@ static bool mac_per_ssid;
 
 static unsigned int iov_ie_append(struct iovec *iov,
 					unsigned int n_iov, unsigned int c,
-					const uint8_t *ie)
+					const uint8_t *ie, size_t len)
 {
 	if (L_WARN_ON(c >= n_iov))
 		return n_iov;
@@ -218,7 +218,7 @@ static unsigned int iov_ie_append(struct iovec *iov,
 		return c;
 
 	iov[c].iov_base = (void *) ie;
-	iov[c].iov_len = ie[1] + 2;
+	iov[c].iov_len = len;
 
 	return c + 1u;
 }
@@ -286,19 +286,22 @@ static unsigned int netdev_populate_common_ies(struct netdev *netdev,
 
 	extended_capabilities = wiphy_get_extended_capabilities(netdev->wiphy,
 								netdev->type);
-	c_iov = iov_ie_append(iov, n_iov, c_iov, extended_capabilities);
+	c_iov = iov_ie_append(iov, n_iov, c_iov, extended_capabilities,
+				IE_LEN(extended_capabilities));
 
 	rm_enabled_capabilities =
 		wiphy_get_rm_enabled_capabilities(netdev->wiphy);
-	c_iov = iov_ie_append(iov, n_iov, c_iov, rm_enabled_capabilities);
+	c_iov = iov_ie_append(iov, n_iov, c_iov, rm_enabled_capabilities,
+				IE_LEN(rm_enabled_capabilities));
 
 	if (rm_enabled_capabilities)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_USE_RRM, 0, NULL);
 
-	c_iov = iov_ie_append(iov, n_iov, c_iov, hs->vendor_ies);
+	c_iov = iov_ie_append(iov, n_iov, c_iov,
+				hs->vendor_ies, hs->vendor_ies_len);
 
-	if (hs->fils_ip_req_ie)
-		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->fils_ip_req_ie);
+	c_iov = iov_ie_append(iov, n_iov, c_iov, hs->fils_ip_req_ie,
+				IE_LEN(hs->fils_ip_req_ie));
 
 	return c_iov;
 }
@@ -2502,7 +2505,8 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 
 	if (is_rsn) {
 		nl80211_append_rsn_attributes(msg, hs);
-		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie);
+		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie,
+					IE_LEN(hs->supplicant_ie));
 	}
 
 	if (is_rsn || hs->settings_8021x) {
@@ -2517,10 +2521,10 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 
 	if (netdev->owe_sm) {
 		owe_build_dh_ie(netdev->owe_sm, owe_dh_ie, &dh_ie_len);
-		c_iov = iov_ie_append(iov, n_iov, c_iov, owe_dh_ie);
+		c_iov = iov_ie_append(iov, n_iov, c_iov, owe_dh_ie, dh_ie_len);
 	}
 
-	c_iov = iov_ie_append(iov, n_iov, c_iov, hs->mde);
+	c_iov = iov_ie_append(iov, n_iov, c_iov, hs->mde, IE_LEN(hs->mde));
 	c_iov = netdev_populate_common_ies(netdev, hs, msg, iov, n_iov, c_iov);
 
 	mpdu_sort_ies(subtype, iov, c_iov);
@@ -3267,9 +3271,11 @@ static void netdev_sae_tx_associate(void *user_data)
 
 	msg = netdev_build_cmd_associate_common(netdev);
 
-	n_used = iov_ie_append(iov, n_iov, n_used, hs->supplicant_ie);
-	n_used = iov_ie_append(iov, n_iov, n_used, hs->mde);
-	n_used = iov_ie_append(iov, n_iov, n_used, hs->supplicant_rsnxe);
+	n_used = iov_ie_append(iov, n_iov, n_used, hs->supplicant_ie,
+						IE_LEN(hs->supplicant_ie));
+	n_used = iov_ie_append(iov, n_iov, n_used, hs->mde, IE_LEN(hs->mde));
+	n_used = iov_ie_append(iov, n_iov, n_used, hs->supplicant_rsnxe,
+					IE_LEN(hs->supplicant_rsnxe));
 	n_used = netdev_populate_common_ies(netdev, hs, msg,
 							iov, n_iov, n_used);
 	mpdu_sort_ies(subtype, iov, n_used);
-- 
2.43.0

