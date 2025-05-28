Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087DD2206A7
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463034; cv=none; b=P+tUmNXDRQ8ATe6ushgv57bucCJhS0m72zfCv+tWK/I6U1E2vIWFVpVv07TsNsI7FH4QlUEX9qomr3Co1l62uDSfdBDe3qsZLjox9kGZ74rSAYuz7B/gk+llgIHc3lcZGNMjP+53hjtMsmQGJyIp7J1FJq/ODUT6U5wIIAAErwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463034; c=relaxed/simple;
	bh=2TrErhcLt9kgxm3AxvST6pwOWwc+FN3+TH0TVpCL2zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1wzoV9Mqy1WEQciEIMhdgYW3wi1bMt7j3Ougyo/CKiTR+pZ7BZwjVPSeIoixuyMZjbVbzMWcZ8WaCfYGeNyCOZYeibwd7SskzYgMtLN5AzT+k3sUCCV2hwNqMK7uweM77htMy+vX7sK+l/6hUWFVzPE+Y4PB+Q1DtVE+H1NH2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXEeHSag; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXEeHSag"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6faacf5d5adso2719776d6.1
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748463032; x=1749067832; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgrU18b+d6yCDZndGDXfli/pL+Yxy5sx0jzWh14dfPg=;
        b=IXEeHSagyfMZEH7JqLNLfP32OUQ7YGTqgsAnEumzLNjOkSUIHtp5HqR9Uw2MIz137d
         tQNRBtqv/+rW24oPzERObXvgi5cYxD6Dke3oUtpErr56lGyxDMbdN89u+cQCXzteR4tS
         7fRiUc/I5Sml8CVGBCBb6jIggUKADMgoBACBbKCvfegxqhulerpvy1W2hLQTjKRWsBui
         jWqyTjYe6hHEdYg70AwRtgNM+NfcxYHhZ9pb2mYwcuf8nxE83t0X5C2CUV8IcXiy58d9
         yd3jdktbCoMC3SjfpNSDOkkQF3nvOwr4XACt3aZTWjWwjRpm2VRsgDH9wuoXt2q1598A
         Q0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463032; x=1749067832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgrU18b+d6yCDZndGDXfli/pL+Yxy5sx0jzWh14dfPg=;
        b=BfILaR6qEJ+er0EvuB2QAtiMS/cbu7mi+JqfXVmQj3QbhAHb+MMx0IoGo7GtmsGTmN
         6nvEZ7/UEdrFa3UpAY5Ul1aXY7hvk/zpFjD6nGAyTSOItS5dQVOJNH03Yr6aULHybAP8
         Cle+cyJJCc1qH9Hgfo807DlY+at7+dYPrQHS0trMcchxMKZv+lLwdhAm6XFaHXDZ8GsU
         yINUvHtKw23zTI/vYT5AzaE/gz8S7b9SuF/y08hFCI2bXRG8RTB6XT4ySg88mPLMDrDr
         zpIzoplxML2hrlOI0PtZP5Mlw3KRfoUvneR/ktCiPT0OokGO0Eo8YG9VD8U9eEW8Lqis
         +rAg==
X-Gm-Message-State: AOJu0Yxl94bx3mHDPSDYYpggnTU8QT9cxRbAuguQQiqFqcWSbga/IL0H
	D7mM/DYw2zR3RHFAxqF2vcPh1x2uCQQCcOHP+5OTxjMzN0IH6QzkHXYp8OPYCg==
X-Gm-Gg: ASbGncslvSB2cjVNwfLqpS5Ns2VBlIpVxj+Njqd02uv32sfDkUkG8Nz1o1cWcMRLip4
	v1T/RfJ8dnM03C4L2qc1xSISfs4H+n3mq4M0n6Qg57rihU+WN6DHaDtQ95PLLIdWhEfQdEliAZT
	3NbCil6LVHsO3aU6VSr8B1WG1mzUWj7dR43QxJyVYKmv4XRuiaJyEG0cy50bkrH5JCvU0dN4Etn
	SeeK+pZiiewzpGdjqogiysxhLDDwTNvR4zKMN/ugaXQ65y+nqc8wnldaLqSow2x8eesHXk4irnC
	jnHHs6t8UlcEgvUPHT20BkXq43833F81QJvpZcIJA0wRbf8rgW7pNu1MIKW2qA==
X-Google-Smtp-Source: AGHT+IFHD1hbwZPc30P/DgaOfvoF9NGWZRsAr/iIQ5fVkctDqfh7LKwwI/QufY0FuBTe2/Ht6Uh2yg==
X-Received: by 2002:a0c:f108:0:b0:6fa:bd77:3501 with SMTP id 6a1803df08f44-6fabd7736bbmr41320636d6.11.1748463031594;
        Wed, 28 May 2025 13:10:31 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2888asm10408126d6.45.2025.05.28.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:10:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/6] station: fix DBus reply for Connect() with netconfig
Date: Wed, 28 May 2025 13:10:22 -0700
Message-Id: <20250528201026.598221-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528201026.598221-1-prestwoj@gmail.com>
References: <20250528201026.598221-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When netconfig is enabled the DBus reply was being sent in
station_connect_ok(), before netconfig had even started. This would
result in a call to Connect() succeeding from a DBus perspective but
really netconfig still needed to complete before IWD transitioned
to a connected state.

Fixes: 72e7d3ceb83d ("station: Handle NETCONFIG_EVENT_FAILED")
---
 src/station.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

v2:
 * Broke this out into its own commit. I believe this is how the original
   change was supposed to operate i.e. send the reply only once fully
   connected.

diff --git a/src/station.c b/src/station.c
index 2b6a18f8..4180b7a4 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1795,6 +1795,13 @@ static void station_enter_state(struct station *station,
 		periodic_scan_stop(station);
 		break;
 	case STATION_STATE_CONNECTED:
+		if (station->connect_pending) {
+			struct l_dbus_message *reply =
+				l_dbus_message_new_method_return(
+						station->connect_pending);
+			dbus_pending_reply(&station->connect_pending, reply);
+		}
+
 		l_dbus_object_add_interface(dbus,
 					netdev_get_path(station->netdev),
 					IWD_STATION_DIAGNOSTIC_INTERFACE,
@@ -3581,13 +3588,6 @@ static void station_connect_ok(struct station *station)
 
 	l_debug("");
 
-	if (station->connect_pending) {
-		struct l_dbus_message *reply =
-			l_dbus_message_new_method_return(
-						station->connect_pending);
-		dbus_pending_reply(&station->connect_pending, reply);
-	}
-
 	/*
 	 * Get a neighbor report now so future roams can avoid waiting for
 	 * a report at that time
-- 
2.34.1

