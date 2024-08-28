Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B41ABEA9
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873078; cv=none; b=SsribpRaMJwSeT9Zw0Za7QuJY5X27QKmnuHWh9Mp3o5tzGeNAUsbAuR6aFJwI0VqOkLFDLrooFvJ4JTXcuneUaHVSWY3zifzzVH5tybO3gBp5HbcJm8lmYyoh73Pm9TWWIz739Ec7U7Oh7KEA7IN9SWWzrzkmei431fXhZuhzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873078; c=relaxed/simple;
	bh=NIfjGt2bpC2A6vEZMyAy4JdMJbSFpPFhCXk8SaX+deE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOdNmSt8k1slDKJJLK/SidvuMGICJJEXziGyIpTHJwL1+W8c0Sv/KWIx1k37Q65ArReL7XfuoQeFG3o4ElhviS03hZ9SRy6BAl+/ntfKQOOYX8ScKl1t9yilrTEH58vdu6m5oNiiGOmT8wVPS1k9cXo6pqWpJ9aMk6t6e3KlWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS7Xyc3k; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS7Xyc3k"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-715cdc7a153so781216b3a.0
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 12:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724873076; x=1725477876; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tryyBdZ446X/A40KPsC+AsZfsXC92MsVqd9qgR4Y1BI=;
        b=XS7Xyc3kx1lyJB2E9tO9WKy5hPrsLCHTST43owaAlBWXNBhQ/ghIXjXn/EWCkM1Llh
         Wmb/1g5FttUGxaRoj9RTmLgRPBwqMs3wvCzEDFbhbZwywuGxrqn4XEdew5eJznHX+j2I
         09CNvcBV3E0n+TQfnv0KjjGA7h5lLjovj8wCce9uZzdl5jXQVS5bf6Ef4dawWm9tMlZP
         22bSyZfPPorw+WgkB04ePdOg75xR9WVqoH8IHJadZCiqpBaHU+b69ranDoPCgQI0cdbI
         lE9fTZvOOzI76WTbYwEGcEFOeNd0WAmGumJKqcU7Y2qtq6uSB6Ya/ySHzp76BbJV1kEw
         5Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724873076; x=1725477876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tryyBdZ446X/A40KPsC+AsZfsXC92MsVqd9qgR4Y1BI=;
        b=K0Y7NnAabgxInUbhIN4oNXfJDOpufpZ3w18MxVIPDBhur5Cst4sPByJhmS0DRPX+os
         9FlnIKx+dZsZ82bspM3gnh2rpuhFqMMxhIoAM6dflLMLbzJg2s0ZD9n2oTuEM76oklPW
         6az8J5ShLqE/3y8YD011ItI4LzHhvhn4h5gg3LSU9MeBPfN8eAm2cKgdv2AVDkAljo3h
         uOVx/jVmyVit3VZAuMw+d1MiPoyPpC0cxNWPvEeE+Y/2j+uERdS1trICNAdt4CE71NI5
         3tT2ib4Mw4t9U6ix10z9T97Mjl8IIPWxJ97eytTPmfD1lI4sBtm19upW5YpO9NRAW5zh
         eMtg==
X-Gm-Message-State: AOJu0YzH40Lh3HxsNEdTKxbkhCd032tpFp3M+QDC4+tRe8KV/GaKp9BN
	k/UD/W5tZfMU6XA8HNLT0SA+wUsezG6eM+ut+jGdqgM/h+M33NeacPZAqg==
X-Google-Smtp-Source: AGHT+IHyFKrrWT68xBFO1hW+2O9IMW2J3fJWLMPKJvizoimSW8euDc0I2HxoJureWNAYcPQ4LdoDnA==
X-Received: by 2002:a05:6a00:8785:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-715e0fbe611mr251452b3a.8.1724873075700;
        Wed, 28 Aug 2024 12:24:35 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm11081635a12.16.2024.08.28.12.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:24:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 2/6] dbus: add PermissionDenied DBus error
Date: Wed, 28 Aug 2024 12:24:24 -0700
Message-Id: <20240828192428.902761-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828192428.902761-1-prestwoj@gmail.com>
References: <20240828192428.902761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dbus.c | 6 ++++++
 src/dbus.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/src/dbus.c b/src/dbus.c
index 32de1e1a..b3799b55 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -134,6 +134,12 @@ struct l_dbus_message *dbus_error_not_hidden(struct l_dbus_message *msg)
 					"Not hidden");
 }
 
+struct l_dbus_message *dbus_error_permission_denied(struct l_dbus_message *msg)
+{
+	return l_dbus_message_new_error(msg, IWD_SERVICE ".PermissionDenied",
+					"Permission Denied");
+}
+
 struct l_dbus_message *dbus_error_from_errno(int err,
 						struct l_dbus_message *msg)
 {
diff --git a/src/dbus.h b/src/dbus.h
index 14814b5d..6d7074bf 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -82,6 +82,7 @@ struct l_dbus_message *dbus_error_service_set_overlap(
 struct l_dbus_message *dbus_error_already_provisioned(
 						struct l_dbus_message *msg);
 struct l_dbus_message *dbus_error_not_hidden(struct l_dbus_message *msg);
+struct l_dbus_message *dbus_error_permission_denied(struct l_dbus_message *msg);
 
 struct l_dbus_message *dbus_error_from_errno(int err,
 						struct l_dbus_message *msg);
-- 
2.34.1

