Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413B3EBF3A
	for <iwd@lists.linux.dev>; Mon,  9 Mar 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075478; cv=none; b=jIsCGwvGMRB2x4dd8z+IoiG8WM8oJQ5KXtgMk2wS/LJunBWu4JAcW0t9+o3uapDB6GQXk3kRVSe1EKuvoBwz/WFTj3CMODcSs8JgCwNV4q+NwD8tl0bZ8k01zGwpB4g+40ftZrk2o+XuuVwdhJAaeSB4DCNSQEDJodCjjJqC9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075478; c=relaxed/simple;
	bh=KlcoMpB6lG0dff8DR49v/qKK9DFfcMZMxjkThSm/v4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GpVQq75H9EAw9har9fDkwEdZmV6Mt8QjgBWj+QTfFtYq66zxe95BaG+BUHoEPb+6lDfNNaIB6um3X9GoWxHz8egjGJHDru9s0NbhhcedCYjEQ4iHMHrX0+lv2pIymADXG3qdemyKe3i8S6sbt1XId51cnT4GfGNAa6IKHf8qqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO6tw0AP; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO6tw0AP"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso96318216d6.0
        for <iwd@lists.linux.dev>; Mon, 09 Mar 2026 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075475; x=1773680275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp40bbvJ8hG2xf+xBnXYTOEpBlzUQ1N414T2repOCeg=;
        b=RO6tw0APwWr78F54gZDozqxVvTE6SHhAB2CHIXXjg7JQipUrb/WqP4N2hLKrE4mjc8
         B8kcY5Tk85NKuH81lfSi7EK57LKrEtfYqYCc7b2b/x5jzxyY+PnzSubSLuW+EfmZqEDv
         C+NrRvz182iDHdFhPdsgeQ4vrrxZNnc/tQlvEmk/RgR51TM7+24vx0AHiDWXBnc/yW4X
         46YVpa+V6TFmkKlyF710rk4fTlTgwDB8jpjuEr16PiyptuXgIAEum+B/UsCSm+C1iV9S
         /uKSOr60GGrz+xHbm4vRM8LGOvJHZ14ytCtyNxfWOqRwfjzj9NtMZo3d1j0gllopQAja
         BQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075475; x=1773680275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xp40bbvJ8hG2xf+xBnXYTOEpBlzUQ1N414T2repOCeg=;
        b=NBh3ELpnLFmATbZOMGQUSW937NiJQTtJHZmYoKQH+gDuxth6Wm4m/eLlvZbLgikY3N
         FePa9qVl45dK7Ni2URBvve3kLeLC6ziIC6xHAV3Sw6e0eSCTZTSn8hmznxgTXnemCPjT
         lyM40dg+CMsAzH5NezSVtR8yGIsFiMr5zNIL2tLSsZmvTEIa4r/Wy7rCQgmjsStrk9IC
         beNhjhVPy6pFfeylLBlA5FPBTgFt+8bCFUZqwzbqyQXQ95YYYPQxBhYTwwUDpVl3C++y
         qGHr8pfnHjMpUhIMwp8QzO0zUnxZtALpApRlMAEb0yLUaTjJx729ksBvWQKyzefnhbC6
         1tcQ==
X-Gm-Message-State: AOJu0Yw9VkpL0mHI1aWwV5npGTPKOdP13Xej0m3EG35kZoKqbFAOMBbf
	A7ROEBJmwo8Cw41HsBLqxDKp3GXHOcs8rrxQGRVMoNd29Mxu1ZUmuaET1aTaiw==
X-Gm-Gg: ATEYQzzFZ520o/EBFtYqKriGynv7o/xRiXp4/LvWVOBJRHWEbtp3HFi931Ls/TXTOoK
	fn93snm5XNv+e2GKQJKXLpWEOgdoaJVt8Sk3hkgdYcHcIP20zEO12zA/goln2xOvGXKsJzkv2mF
	otf63ktSVl0yez+TMxTBDBJaAAvv3oNGf7d8I7pui/6frmm4Vorr6kUpcKn4+ClljzJ2dbsruPp
	YEJkKi59uvQqOrZ7X5idZwRSi+bKGJ/e9rerJM1ADyRWhQpdox/EavkbnMbVY9tPX+g60nwyMUL
	FJpIEYZBW49PP8X74alQKe+89jJVmuF1YpQOPysaSRAE0bpJ48JgwxqsTwzUUUKop6wcChWRK8t
	HOaX9QN6G0GB/05VvdOOvVbQ98oxXHKpqkQ6nTccAM7/I31bikkKy/tFmu11zU1hfyt6jo0sgdQ
	IkYV6ecDouUGYDqTelhLlnSb0vq/yf2gspsRFNOlXQMUXCpb90XXWb1AkkJ5UAWqGe
X-Received: by 2002:a05:6214:248c:b0:89a:3013:bdfe with SMTP id 6a1803df08f44-89a30acb516mr180616556d6.35.1773075474589;
        Mon, 09 Mar 2026 09:57:54 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a4b079sm1704576d6.20.2026.03.09.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:57:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] auto-t: Add test to roam back to BSS with existing PMKSA
Date: Mon,  9 Mar 2026 09:57:45 -0700
Message-Id: <20260309165746.2073055-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309165746.2073055-1-prestwoj@gmail.com>
References: <20260309165746.2073055-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test exposes a bug where if a PMKSA already exists for a BSS
that we are roaming to IWD crashes due to a missing check in
station.c
---
 autotests/testSAE-roam/connection_test.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-roam/connection_test.py
index c813f00f..243178a4 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -109,6 +109,26 @@ class Test(unittest.TestCase):
 
         self.validate_connection(wd, True, check_used_pmksa=True)
 
+    def test_ft_roam_with_pmksa(self):
+        wd = IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-SAE SAE')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-SAE SAE')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[2].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[2].reload()
+        self.bss_hostapd[2].wait_for_event("AP-ENABLED")
+
+        device = wd.list_devices(1)[0]
+
+        self.connect(wd, device, self.bss_hostapd[0])
+
+        self.roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
+        self.roam(wd, device, self.bss_hostapd[1], self.bss_hostapd[0])
+
     def test_reassociate_roam_success(self):
         wd = IWD(True)
 
-- 
2.34.1

