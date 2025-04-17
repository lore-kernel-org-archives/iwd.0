Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB2251785
	for <iwd@lists.linux.dev>; Thu, 17 Apr 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906570; cv=none; b=COvvlYbyixDZIji8sjt0v3UNGi6nhjvLMJA+rD6prOuuUdUPkt/Zdl1fZgnEf2cDk2eT5inPi/PtUhq11fgC2HIlH7P7M1lvJbhpBViyYEtE5g620LlzYVHqFB7Cix4cRfVIYJqCxeOHkrrHTRMWH38WTV32AevNspEXW/1ecdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906570; c=relaxed/simple;
	bh=hbQbZliPbDaGxkOjRTKxoAX0x4CDQ9WKVXw3tFSALHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pU+lkGuGjws2E2jrdJ71llSF4Akfqc5k+tzC39MhWZyO+hQ+fs9axq6lZ+C/41VU7a+XId5IVAPQwhJTBZQ8+myHlfM7BG6ekwx1PecjXAFf8TUsugaV4hGJLSzlMNInJRxzy3BKBsYRZbIkYL8Y5Imf1LUc1GcExqgVcE3aj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AReIrjM/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AReIrjM/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so13086165ad.2
        for <iwd@lists.linux.dev>; Thu, 17 Apr 2025 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744906568; x=1745511368; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7HfBizHWPqUPTSdmjoWcN7UbOVA69F22jlnPJacIbo=;
        b=AReIrjM/ImOpG3vYkQOKYgqBftzmV+U8+4vtEx5gbOWwRYyNETaze+7y9kKzIfVD+L
         gV1xJkNVuuxmlPcQv3NS6GmqqZZz8Q3kmimONE4FXoZrujjTCYLXO6Bb0Nx6vOCOulgN
         3F4ekFe/sUNWHKcYbKsPhztJX32gJu9RuznlHguOuwKmGfqjq4XAcEWQhgBTJrc8AVRj
         uRIFbFIP/qJjPlbECOpN2xBgHXxAfewhaXIm5m1gAL2DxG4xkTgiz1JfbSesnsTkEnGt
         Zpdrm6NWAgjxKxjus7SwJmXwRz4dlJC8BhqKsa/yXdV5rd/RGhSFyVmoC81TyechJ82x
         dFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744906568; x=1745511368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7HfBizHWPqUPTSdmjoWcN7UbOVA69F22jlnPJacIbo=;
        b=U9a60Zwr4g1CrlW5Nn2iE0C5Fgy89rIKO7pxVMIDjOFoT25F1OPuXHtWz4SfqWpQz0
         PcNy06bzgfyZOavncPQWU7AWjfjagzRdVennPXvU0nW5C0cJ2+bTjkl0MpPPn6oNIgJe
         +e3C5gSEOQNTRBWGdt/jmpJraiQdEB1hovPhHTdvECcYLOtaDBU+HXbcpedvhoNZ9qCF
         e4e3u0SNijfKlWzp44BDsh7m5bp6r+h2nxWDMMX2223sH2IPnmQ/Y9J5xLZUR1GVQn+i
         iaJy/HjxeFfAjDKHpF65CS8z/70W5mBDspFC4gG5+Urv3RBAdH1esECmgj2XGHJu9lNa
         bnlA==
X-Gm-Message-State: AOJu0YyxfBoobCnadjp/Yr110sEn50Run1cq4dwt+gqMCSDAXarHvUAM
	SZHpN0xawVouMGoZ7w0Q5ck23YuPCRerQk3UwI5CCp50f/8pTgvJweE/Ig==
X-Gm-Gg: ASbGnctEa4LQ6r/OosbhV+E94RCKGlSz+8w7zGraFH3PLRZQyhwKmq7St5IMFdieMbW
	P69Nn9crE563NoehXug0CLmxHbE9iDl3zXpfURqiAKe+KFuNTYKxEw6zgfqEa+sYPHXNihD8FFf
	Tt7CSz5Pg+dfn8BsI11M+ag/jqVDqw0SQ2mK0KCaqMTE8W8Pq/3KH9YdlrtER0QgazygasFutZ2
	VFevX5BnxtTeTMatzztfR1mX3X9oACUrIDEXGWLrtG7iYEVZZn/8x3MVQaatgwLHbso79VfakBs
	QVXN4myJ6PrQ3x1tjGv8FN3wnHtAGQUaH/8f9sNshtSWG+Y99Ec=
X-Google-Smtp-Source: AGHT+IGj/uvKpknNQO6XQPWzdnA7X7H1GfxbpPHz/ATIJDv58gExvZoIkCIoFZ/YzrDLNXfV8gP+Tw==
X-Received: by 2002:a17:902:e88e:b0:216:410d:4c53 with SMTP id d9443c01a7336-22c51fca097mr1432475ad.41.1744906568112;
        Thu, 17 Apr 2025 09:16:08 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e4622sm25441b3a.67.2025.04.17.09.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:16:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix setting an empty affinities list
Date: Thu, 17 Apr 2025 09:16:01 -0700
Message-Id: <20250417161601.249876-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A prior patch broke this by checking the return of
l_dbus_message_iter_next_entry. This was really subtle but the logic
actually relied on _not_ checking that return in order to handle
empty lists.

Instead of reverting the logic was adapted/commented to make it more
clear what the API expects from DBus. If list contains at least one
value the first element path will get set, if it contains zero
values "new_path" will be set to NULL which will then cause the
list to be cleared later on.

This both fixes the regression, and makes it clear that a zero
element list is supported and handled.
---
 src/station.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index 14c93671..d8016c2a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4815,7 +4815,7 @@ static struct l_dbus_message *station_property_set_affinities(
 	struct l_dbus_message_iter array;
 	const char *sender = l_dbus_message_get_sender(message);
 	char *old_path = l_queue_peek_head(station->affinities);
-	const char *new_path = NULL;
+	const char *new_path;
 	struct scan_bss *new_bss = NULL;
 	struct scan_bss *old_bss = NULL;
 	bool lower_threshold = false;
@@ -4835,11 +4835,15 @@ static struct l_dbus_message *station_property_set_affinities(
 	if (!l_dbus_message_iter_get_variant(new_value, "ao", &array))
 		return dbus_error_invalid_args(message);
 
-	/* Get first entry, there should be only one */
+	/* Get first entry, or if an empty array set the path to NULL */
 	if (!l_dbus_message_iter_next_entry(&array, &new_path))
-		return dbus_error_invalid_args(message);
+		new_path = NULL;
 
-	if (l_dbus_message_iter_next_entry(&array, &new_path))
+	/*
+	 * Only allowing single values for now. If there is more than a single
+	 * value, fail
+	 */
+	if (new_path && l_dbus_message_iter_next_entry(&array, &new_path))
 		return dbus_error_invalid_args(message);
 
 	old_path = l_queue_peek_head(station->affinities);
-- 
2.34.1

