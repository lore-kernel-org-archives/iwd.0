Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785392BFC85
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892287; cv=none; b=ZqKBTDi8ABwg+HXwxj2/qbQ7grjcRRBn7zIA2h8Xs0kYLSjoF2rEDFb4u0X8oWX4NyNS1nP3dq1FeE5Q/LNDXa/lDpex4UJYTjKTZsgz+VPDDHNRxACm6jra+WEVxCfgQVd2j9Ydr+V1SFbaKFTbVDG4+OGZccIuQm/rAPGMLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892287; c=relaxed/simple;
	bh=VdzgCiInbQvgeyk+dPJ2fuWNio2CH6Onek+mv4UYNDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5jT/bwTLtuDsd3nTxSbOv0K8GI1Szrhy45E11vDyT2xY42r0ws60mXo3sI6S8BvKW8xS1x2FdjJJXVjy8yRfoenL/XvMZgdsgvUpxQm4aW92hnimBKWKEMtaX68tdyMs4AH1J3kq8nZwycQ487Zxwmers+vvi1nmBZtBwWwI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY4h6SuT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY4h6SuT"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b134a5b217so27143461cf.1
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892285; x=1756497085; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwPJo79YclLXXb3JrrFiah18q0K43y5yBEPFlUFff+0=;
        b=DY4h6SuTj3yFb5H6OoXHr9iR2JAGSEATyvjkiLdTmHPyMFr8LseWOXwGFboEXo5AGt
         LCu86ZRhqiyHz2yarjtaN0+mxy8SJZKEDMZMgNY3daCctY1+jgAYaQKI38vNdaA5oXDk
         PcJj37baG3KoS5Y5+IIg2XmSKscaTIi3Vw1y8VzRam38OCD0O6K0pzzxKgh5hxbgGlvU
         DlnfSoX60LpYK30nyZCRqGzc91Vl/19CcrCtBMWe2DVir6vFVpBOYCmzg4mM0cg5nPbv
         noVhh1Zb5SPnPebgUR9uz3v1AjN5i0+ZTjnxeHwgDuY4tRdW6fB3+a8aYe1P+2gE0RMn
         5UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892285; x=1756497085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwPJo79YclLXXb3JrrFiah18q0K43y5yBEPFlUFff+0=;
        b=THjyFER393FUEwKTcqCh6vAp01SepbV3Q5HgFDhg15fk5GUwc1nYRUKAXa5CiQJshf
         dKBe4u4TBi61EjOiL9epppXRqMqE+ZkJVGxlVNHil6i0ZBSBafz6CsRIIyKHWqV6Pnux
         /mzM2OjzHIgiRt8lZXKhmBZtQjhCbhsANXx+UaXkLZC2Lfs+ljFXFTAPH7zcoWt0TDbh
         UqsBj8NkMh3ai3FwGTxAv5T1SuzCSnYcOfBpNZfrwuMH0q33RQ1oL46ycDa7daEl9pzM
         Teavt8D0npuiTrw1RVNkug213QlG2eD/fNc/d8NMIO/xtJwZK3tnJIaa0duEJdO15JRk
         T4Pg==
X-Gm-Message-State: AOJu0Yy6oy2TZLUo5G4sKeGbX/N0+3MXONves/ZBdodcLNWm5JB2lRZA
	5sYMiCIrJbwMJY21/aUjIyrMj9Xbb0NyzZYPapdhoC1S1dZ/QCc/9GZqu7a+Dw==
X-Gm-Gg: ASbGncuWnrNZay7f3/ZzZrvsfLPLPv9NOnTp6EDBN5TROHelRYyQgNl5nJEmkh8gR6V
	z/jUvGv+dWrd2o3o4kVNL6PCygv6HyNxDzV3sjZVyXDGMHJ2DVZTHeK0dVv6ln4nHQKpSK1oVSf
	gw/Aqtp7FlQoB3H4eXaW739u5r66yp3vS0rnjXHwnoLBXx0njZEtwbh3wxWRTBqhHSSXTvRZqoo
	uWAxJ5KphWNIcgkgpTv5gfZzSEXREpveI0me17QD2e8SdBLFQgGcPW6l78iXxGbFJXPX8FCeKlH
	vv+IibCJbUra4zTO8xIMjeGlIEHwIrb0JYTc58+jPWFp2eAbiHhPExLmzOBaYTd2Vi/NKOrZSSX
	gGNtj/daejyDsJz6+0b/UaSpM4o4V0Dv3
X-Google-Smtp-Source: AGHT+IHDblO2j1/nvS4WYJUVIBGDC+Io/pSQzKBPqV5UAy5Shz1Tru3A74LARA++BrpQ7682m/KUSw==
X-Received: by 2002:a05:622a:50f:b0:4b2:9b6b:2e87 with SMTP id d75a77b69052e-4b2aaa5659dmr53993941cf.37.1755892285040;
        Fri, 22 Aug 2025 12:51:25 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/15] wiphy: add comments around the driver quirks
Date: Fri, 22 Aug 2025 12:51:05 -0700
Message-Id: <20250822195118.271122-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/wiphy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index c7f2805e..b6774f69 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -69,11 +69,23 @@ static uint32_t work_ids;
 static unsigned int wiphy_dump_id;
 
 enum driver_flag {
+	/* Force the use of the default interface created by the kernel */
 	DEFAULT_IF = 0x1,
+	/*
+	 * Force the use of the PAE socket rather than control port, even if
+	 * control port is supported
+	 */
 	FORCE_PAE = 0x2,
+	/* Disable power save on the adapter during initialization */
 	POWER_SAVE_DISABLE = 0x4,
+	/* Don't use OWE when connecting to open networks */
 	OWE_DISABLE = 0x8,
+	/* Disables multicast RX frame registration */
 	MULTICAST_RX_DISABLE = 0x10,
+	/*
+	 * Don't use SAE (WPA3) when connecting to hybrid networks. This will
+	 * prevent IWD from connecting to WPA3-only networks
+	 */
 	SAE_DISABLE = 0x20,
 	/* Disables use of the NL80211_SCAN_FLAG_COLOCATED_6GHZ flag in scans */
 	COLOCATED_SCAN_DISABLE = 0x40,
-- 
2.34.1

