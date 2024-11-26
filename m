Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BC1DED57
	for <iwd@lists.linux.dev>; Tue, 26 Nov 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649080; cv=none; b=CWHJieox3xyUTU3586awCkeOFaFpQgjXhD9mgSMDnKMO7FJILLr6ZkJceP8zMyzaO+kkUMA+i0vzbGqyP5ezEV4HhqSaftfCZIBjzdejRE+5SdN5Ak2kMf81cc6S/qvP3QylA0DJldPzb2CZR+0KfF3WKxcFeCl8hyga1HRXtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649080; c=relaxed/simple;
	bh=Rfjjn5JKqCvtXTbA8mkml0BW+fAW9kBBthrLjyhb8Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dDsKX57rMl56D2TE4ipvTPFsepa9Gg+fR9yb1SseydscVHwWwCdgufBJYAAPgFp30hzQ28RC10IA8hDsKsFvw82ar22d/z9wze+91TcwV3jn/4u38IEgi8EH9LtKEi87FVlEZolLmel6YqvnODGZgTDKxfURWiKCZXaevMPSV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmIfftvM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmIfftvM"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b66d08d529so8751985a.1
        for <iwd@lists.linux.dev>; Tue, 26 Nov 2024 11:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732649078; x=1733253878; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0hWodLANkMesHJ/+U+BRulwa8dp2Sn+I+336S9M1E0=;
        b=FmIfftvMM3qvTw5KsdqFWu+Lc8vrquJPmyzIDFbt3yWo+KpNNBY625eqUMD30XWbzI
         6smBujoPyMCZhulExTVhHYzwdbM74h82xI0b56zwiw9aeQ/DLdU5rUDJachkb+Heh47b
         PypxqbKK7OWNJeytegRqO5D3XtVcvA9YhDabGQK/GdW4s2T2jdDzOQKZLO4M7bxXJU2X
         iSSzc0L+PuAek8mTdiva0dz2XT065pNcQk0Ccq3B5muCPvMEk/5HgA9pGPoUPIrWPkHV
         Fy3EQEvfmduONEYWV//fbIX6DwrFz5BHJ6DvTYfeyv7p9Km/JIj65CqSY2qbVZnX2Jij
         e1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732649078; x=1733253878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0hWodLANkMesHJ/+U+BRulwa8dp2Sn+I+336S9M1E0=;
        b=nGgTAgw1KbEZdKC7INUwXtNU0JTEABulHHrOjDIxXdNScjcr5YUXIfVvD72vAdXkzE
         dDluRjJ/6e6btDYjV2Y91dJW5JA5n45zhhuWZJPB9YtWW5RY7f7jDgQTaYPKJWXkKeif
         OPEJU7VFmzbApPAtgHBidEA3LV5wJ+VdRd7ZaH1nNGdyWt09K+DU823wqrYkJMLIxRbG
         2XOR34UWq3M6e9OmI5AfVz3TRyT/LbgKeFLYufxuRdD6zZrpYuzHrRTB5Q1Vp2LvByGa
         yMytA+/0WLmNXLsW+DmAYNjad3F5rQwbfrmSDzt6uLXpShSIAW9ixWauy+ZYZiP1yYjS
         AGBQ==
X-Gm-Message-State: AOJu0YyikvdAo+5X8lpSMM+W7nx/jSa7dUz441Efw5wOVw1UqZjXXXDR
	4sM83xU6dmxWparTeRdSLbTK+smDQED0vl6mhu/ElHFkXnFhvuhu8wVM8A==
X-Gm-Gg: ASbGncuCvUHPj6Oe8SjlMPAOT5qO5jJbt9BhZE39peD3IcJbNWcMYLui+RC3+poygXN
	cOgpZFFptNEdLhfmEYLl2gpkkQAbZZFDX/wpzrd+B1EWz1IAfg8zpA+Uz+B5mjhnO+v+egvIcAs
	aUXxwnqTBcOHKNSu3vrPun7BHQFZ5u/0qZJ6RphUkLY88rU0eQXezGvXQXddxhDxwNsbI6XoYFI
	t1MugzmN+HLgBN1TkkXE0ykZ4mSrXgIRF4xYGmKvpT6FbgE/cGGne2WPJmLPhFzxt8qQwZJv1DO
	agwaIxO6
X-Google-Smtp-Source: AGHT+IHFoH5R9I0zRov+QVKGgy0eOaDvh3gin/M6o52KbBE5S7S+Bg03Fv4pQrOV+KVLSyk6ZLntpg==
X-Received: by 2002:a05:620a:2447:b0:7b3:5c6d:9625 with SMTP id af79cd13be357-7b67c4ce0dfmr71669185a.16.1732649077765;
        Tue, 26 Nov 2024 11:24:37 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b667dd0aadsm270183385a.97.2024.11.26.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 11:24:37 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] wiphy: add info print for MulticastRxDisabled quirk
Date: Tue, 26 Nov 2024 11:24:33 -0800
Message-Id: <20241126192433.102300-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was forgotten in the prior patch set. It does not change any
behavior but just adds this to the driver flags debug print when
IWD starts up.
---
 src/wiphy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 5e958d65..3d761251 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1371,6 +1371,9 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
 		if (wiphy->driver_flags & OWE_DISABLE)
 			flags = l_strv_append(flags, "OweDisable");
 
+		if (wiphy->driver_flags & MULTICAST_RX_DISABLE)
+			flags = l_strv_append(flags, "MulticastRxDisable");
+
 		joined = l_strjoinv(flags, ' ');
 
 		l_info("\tDriver Flags: %s", joined);
-- 
2.34.1

