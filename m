Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0401F158D83
	for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320807; cv=none; b=OVHt0XPHpL2GPF/PYFKvPKlrhNpAkDmUI4KmlY1qWMRXcjHN/8XMJtBboyfhNLgldoK06OUy65y8fffQ2ONr5T+ijEKKp03ok4wfNgnArXKcc9U+msoTrCpMKZvX/zdE02XiECa7ST9JPhOGYMUXr1JtTKe+l8TlnKYWQFeO+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320807; c=relaxed/simple;
	bh=mmDYjklFIcTpoXWV1x2wKiibrB1RgOqL5slrdzlkXfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eH696CKkPCHH/Z2elPreCI4WXj+kn/GzQLIocqN2EbDTyKyj46QpEabxtlAPPa+ghZLXSZokWp885lq8Nqk6EBI7wULs6xOb18oREmA/m6NcWDjAs1COB1GMS2KcX8eDUKN9J1FH18VLrk0VeC33Hh+ogEHl+2cu0VmG08vCXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii46frjy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii46frjy"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fa78306796so2897505ad.3
        for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719320805; x=1719925605; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7h9S36rr+40OVRYfR1Fp8I++VRUBzsZIRE2k7h2nxo=;
        b=Ii46frjynbOki8Mr6mV8lHpxLuy7uh9vtzvSBDgJMIQjd305eBWrdU8U16BtWdsPqF
         msAg0L651/zA9pF1q+YiXeKL3facfRcQ4BBd2v8KIbAQRm0KssMj9zoACEBHNe8LY02Y
         wf5R4UbbNWGW3IeR5oKqRiXoTBAiiBEjg4a6Q4Gd2zb8iustxxtC+v6E72gcRDV18bOY
         IgqUn1OA4G0ExND33khd/yiXMuuAWlf3wbwGJ6t96pa9E6rjioIHF+qQvYlsPSP43Arp
         WHFGVIGnpZBBYin6Hg/tDBNPHGDu5Po43Cfi10t8AV5P2s4tUNOI4tJq/xHkOIzXjU9U
         sn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320805; x=1719925605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7h9S36rr+40OVRYfR1Fp8I++VRUBzsZIRE2k7h2nxo=;
        b=LkhxF3MRxKmJGGhJFg3UAT9gL+04514k4xq0PPsuPR6rhM6nf+wgzXPTfaRZAU22ik
         HFhcdhqfKM/z3U1OvCLYw0IL2Iv1yYMWX/8zimSqzTk+5wSA1IgxeAgJG77d0pxb7TaJ
         kcbxJfq6Z4P2XgqMQcqxisojWF4yVeCYDgEPYKLe/N4YcCnEU84gq4z/vNAuZrOgr7aP
         B6aef69Z5Peyxrfny4Cno1c87kpCAIJGiodf3dvOb1yiz6l6PTHpC4Y+1P4brZNvUvD1
         sQfJBz5/YV5D7m3JiwR1mObrEPvCR9AgHW1nTHfVhtxNNmVMKhkrtvgmPPMe+r7f0S6T
         Vl4Q==
X-Gm-Message-State: AOJu0Yzu+qoQVzDXprgp4TxqQvXldiM//lUfMPgsUgcr9S2X95BaywYJ
	XDSfxqmmKZVfOTW3OZPykK0R4fXV+pVKTgZZvUg4SkRBY1T/o2SNQVW+AA==
X-Google-Smtp-Source: AGHT+IG2//kHF0/MYl0n+4H78cDjp6vOF7l4bZ5Hl1qnXRtYTasW5i73W/RxDeUCJ/FBNZqL7lwGgw==
X-Received: by 2002:a17:902:d50b:b0:1f8:67e4:3979 with SMTP id d9443c01a7336-1fa1d6533bcmr102004525ad.47.1719320804847;
        Tue, 25 Jun 2024 06:06:44 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5bf2sm80778305ad.189.2024.06.25.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:06:44 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] station: add auth/assoc debug events
Date: Tue, 25 Jun 2024 06:06:21 -0700
Message-Id: <20240625130624.385553-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625130624.385553-1-prestwoj@gmail.com>
References: <20240625130624.385553-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These will be useful to trigger behavior around authentication and
association.
---
 src/station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 2e5febee..1e8846b4 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3486,10 +3486,10 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 
 	switch (event) {
 	case NETDEV_EVENT_AUTHENTICATING:
-		l_debug("Authenticating");
+		station_debug_event(station, "authenticating");
 		break;
 	case NETDEV_EVENT_ASSOCIATING:
-		l_debug("Associating");
+		station_debug_event(station, "associating");
 		break;
 	case NETDEV_EVENT_DISCONNECT_BY_AP:
 	case NETDEV_EVENT_DISCONNECT_BY_SME:
-- 
2.34.1

