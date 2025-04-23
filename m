Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044819F48D
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416504; cv=none; b=s69MifSp381pkMJsK8rvOPv0AGQnAM2B2/9FA6TZD3gyRt9p1coNXccm4xf6ws9zPJtf4AkzE3Xydwxn8IkMCMcmaaIVXaT1/HRjP5mUkZThE2J9spxnwt3zhviy5OmD2/XsSz05FL8K7Nhjbo+77TMHYcr1XS1T9E0x2dAUSlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416504; c=relaxed/simple;
	bh=wb5ZUjffKnKDgADGxtweGT90kJ/p60VjFoXLBRHIeGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z3nk22DuZp/dz7SyX89e0jfu11fFv9YlHhWNwv3Z8x3Vcg8STlcxRao989A38zaVYfVirdh012yv6rZUsOXvdb2//e0dNZaZkZwYSPGQEFqK/5JLg8qc3lfXF10k77NH2GDn/ws2B+W0hfenY/47mLFWeLEEv9mH21wmjqNCurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzQR3dOf; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzQR3dOf"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8fb83e137so55826806d6.0
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745416502; x=1746021302; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhPDLGXSWxC4ip5NIjAQB1d7WHbEyq0OV6CfeamvjfA=;
        b=mzQR3dOfdxZOfy029UND8ouxCgv80uUmF+DuZhVAzo07tk6jSsFaHCXY36Br9i4qIG
         +3OCrsd/aB99vI7W2jx46HVkYth24q766leSylciD63LWuSAOzyMCKNlnBN4Bmpsly23
         Dgc1CNjPVUFaeuJa+itqrm6q7iCVWckGucGasfNFW+oJFiviV+zAQLnJIjRtX9SfuK04
         s8XSMs3C0R0rFHeSzDE/bx6RkdOwvA9ZeTbin/bDg+FsSI/s6GNHR0Ir5lVOoGSk4oly
         ukYXELDaSZJSuR/Os1ITHL6Uy4JExOAp1M0q+DafCrjzDI9HIMyQiKkJlE5o4PGdkFYM
         vMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416502; x=1746021302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhPDLGXSWxC4ip5NIjAQB1d7WHbEyq0OV6CfeamvjfA=;
        b=QR2+U6s/oNy3uQIhTJQ7CFaC82xbcY2eXHuOqZuas4aomzlPJZHNXQUC+g+hygeQOu
         1p2E060S+eyKzhqHsBPC9ePJ6I3vS7j24gXCO3sSufpniUNUqcAzJOo2tVn6KvZLtwL/
         LnUa2SmCgqU0zsBPSvw3jjvGnqQDPeT+eZts5G1b6I9cRxftQQN5+z1xC3HPU2KLpEy7
         xUKEdT4oCYRmTOpzVHAaqsEESEwkKSJYhro1EjJwS95IfQ2iOuMx6znL0MAKTrrkC2r9
         VhB5UzqNjr15y6LBOVoNb9o0TBtr7Vj1dn6qvuxR975NX0BOEL8H6wXYhCYqWOxuePsq
         +4hg==
X-Gm-Message-State: AOJu0YyVcaIWkw3GtVOiYJLdtm88pWlejHOtVbfcbfygqebE2+y8enbL
	t7lBa7hb5QRkRSK9BmEDytmUN2fMXn77M/QyQMqrNRcZwNPbVc6/PIHZZQ==
X-Gm-Gg: ASbGncvt79PSuO6KYO6McEmb8W5ZhQaFzzKn18i3cADuLhO0xkT/Gf6fh2XriQBAW1c
	dLzdnpFos4lZgjxbNGElJHbr15KyjIAoBsVU9Dt7Lpv+6bRn2NGSgwii/Jort+hZI/N/pI6cHwH
	M0Xyjcj004Ao0vvcn4SvM1KU8HRYnl9BkhW4ft79FYkPxPCOlrWeN7ClzcFSrcfRaYbSfMScrZT
	f8/xmgVTfXSu30xDEPPrm1dWyql7eL6p922bsLAAY7NrVy49X7wSoe3UKOXauZhX9wK4WOoqO3u
	UF8H7PF0WnqytFeDiNPGdJVzwNRZ9X3SfsoSldg=
X-Google-Smtp-Source: AGHT+IHTAVGsuV62QYI8pRmq9zajwLEn4WNUwsLZgmv9UwfHzX7ZB8IeJV3pygbAP6GD4O0XSldfIw==
X-Received: by 2002:ad4:5dc9:0:b0:6e6:698f:cafd with SMTP id 6a1803df08f44-6f2c469a80bmr327392006d6.37.1745416501535;
        Wed, 23 Apr 2025 06:55:01 -0700 (PDT)
Received: from LOCLAP699.. ([50.170.153.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b32741sm70733576d6.62.2025.04.23.06.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:55:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] network: Add SignalStrength/Frequency properties to BSS interface
Date: Wed, 23 Apr 2025 09:54:54 -0400
Message-Id: <20250423135458.11337-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds SignalStrength and Frequencies properties to the
BSS interface, which will provide more information for individual
BSS's.
---
 src/network.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/src/network.c b/src/network.c
index 4602a110..2443d4c5 100644
--- a/src/network.c
+++ b/src/network.c
@@ -2194,10 +2194,39 @@ static bool network_bss_property_get_address(struct l_dbus *dbus,
 	return true;
 }
 
+static bool network_bss_property_get_signal(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct scan_bss *bss = user_data;
+	int16_t signal = bss->signal_strength / 100;
+
+	l_dbus_message_builder_append_basic(builder, 'n', &signal);
+
+	return true;
+}
+
+static bool network_bss_property_get_freq(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct scan_bss *bss = user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'u', &bss->frequency);
+
+	return true;
+}
+
 static void setup_bss_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_property(interface, "Address", 0, "s",
 					network_bss_property_get_address, NULL);
+	l_dbus_interface_property(interface, "SignalStrength", 0, "n",
+					network_bss_property_get_signal, NULL);
+	l_dbus_interface_property(interface, "Frequency", 0, "u",
+					network_bss_property_get_freq, NULL);
 }
 
 static int network_init(void)
-- 
2.34.1

