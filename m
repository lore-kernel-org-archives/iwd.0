Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCB3D1CB5
	for <iwd@lists.linux.dev>; Mon,  9 Mar 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070598; cv=none; b=CsKcivG3ii2LKGvMHjHTPhSnAaUhjLjaS5d/v5FArCia3Pr9LnInQfxfSx2gapsMXIGsr/jmoBPfiKZ3eJsIv4+JtIh/YaIaoeBzsWo6dlqReYmXczeYBGxuHmeu+bwaPDOvJ2f65Q/nfGY0iGR4GrWyQkMfqctzhYGSzQa+woU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070598; c=relaxed/simple;
	bh=KlcoMpB6lG0dff8DR49v/qKK9DFfcMZMxjkThSm/v4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qltH1V5FwnvZcwfJtkdXP+bT+8nJJWBAfDABNUlc/h4KpPh2Z/VpoN+o69P2+UQXxeVB3pzkGMDcvq6jnuBoswV/2GnFREqjxWfdjyjZQrn3kEELPF8UZlYMX3aFuOYFVvD3idgkpgNqGWVZJOJaQ/6yNfhtjm3ZXtIuqpZK6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT9WM5VE; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT9WM5VE"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509134ab2d2so13103261cf.0
        for <iwd@lists.linux.dev>; Mon, 09 Mar 2026 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070596; x=1773675396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp40bbvJ8hG2xf+xBnXYTOEpBlzUQ1N414T2repOCeg=;
        b=OT9WM5VEiqDn9sroroJ4N0UZDzlKyxNBoJtc7XW1qeoQQJkaSk4fuaLBqSCF5MOiRc
         L4lpyS5WlvukPlVXPyxD1roggBAINRFCJrpXdTmL7hoJ6lRASGHFpAqEqTOiHBC79pI4
         nbCyE+aL8M/uOT9J7FiP7INaLNZFpptRSUeOxpH8oKXOqgoL2SIwThGoCZjlVhmoqAyD
         TBcqvd/j+XGEn67Gx8bxFGQm2NAcLJkHJLONeZuygZMEAQndGng6BCkTDcIy6TpViy50
         tsmTfZr15R1XGxyOjn9UNgJ2FCBgLcFm/7VALuo0fKT/l4fKNas+PD0p0X+/JHGUoWIX
         L5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070596; x=1773675396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xp40bbvJ8hG2xf+xBnXYTOEpBlzUQ1N414T2repOCeg=;
        b=McQpQDzj8KVreg1bWTzjJ+REbqQY0laIYNU8IVZpXPqSFEY5sqsPXa4VbSA3Mm4Ea1
         oHQNbDTXCVL/rG11g63meXSv2IgAI4xHz50QoEb7Z++hAdJmnA/vaKAWBpj3zkjoiuDj
         BaUsV56oiSAHWNpXTXn3o3D49Y0QwwxIe78oAL8i9SdXShxSpjP2g77gCSWwR1liOYpw
         p52jm9NLa8GALwZUVP42oWtGzrSVb4RA1/xv9m/a+Zl8DerZr+BBoXuLeieEMHKPD1cr
         djypxqcFHqKCqddSmrwbRlUGxCSxiPpu9AE2AC+TRMOi/QVpMWNmdlFzUi02jpvFcvXF
         IbvA==
X-Gm-Message-State: AOJu0YzHRM6JymSBxMuxHDMoAwyvJLyM726dkfvBgqzrIs0to4LEDKb3
	HaPRDxjRQx3jYlKlBzROqfYya28NF/hYPIlF/0ZlDt9v/MIZqMYaBRTbsRwOcA==
X-Gm-Gg: ATEYQzwe2nMI9vm2YRTZPJShgMuOgeUflctkCi/B35oKbp3SKXMZTEmj69cWE0WuwQM
	2574f0aE5eGpKzWSCnnJL2HeNk7Himl42W9jaGLxRWGmCLsW2kj4TgTJwMS/phHBbeQRIKds0YO
	e0DAFHHi3KcLUe9cotHSsABUSqcUnCvILPFgJwtINI7DpmQTCyznVkkpk1tV9JMCRg7CeGVJfuC
	8D7e91/P4xKQL2j7MIYGlcTJeVmyzEMWBc1HJla8rcGvp+ab0BdTH2eCfDYEMx4lfOlTiRHjF0Z
	IbhHn3mMigSeTuduApu1LFD6bxSdCa5rE9T2ZgLxcKSqfEBWYEO8SgMfcJHD3IyBQ5ynv49ACk6
	0vnyZjI83OQeoohjsPdpuHvWcL+9VPC42YhFFd0TY+a7XDlV+J/AWiLxfpIu1KH42bBYma8MqpP
	0+uOppyOkwshlrOXSs9A9QevkogPJcmWcVAF1tcQy5GvMGxpVith2qxQR+xK40iQC+
X-Received: by 2002:a05:6214:f07:b0:899:edde:c4d8 with SMTP id 6a1803df08f44-89a30a37fe8mr169022076d6.17.1773070596257;
        Mon, 09 Mar 2026 08:36:36 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c21650sm151716d6.39.2026.03.09.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:36:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] auto-t: Add test to roam back to BSS with existing PMKSA
Date: Mon,  9 Mar 2026 08:36:28 -0700
Message-Id: <20260309153629.2012710-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309153629.2012710-1-prestwoj@gmail.com>
References: <20260309153629.2012710-1-prestwoj@gmail.com>
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

