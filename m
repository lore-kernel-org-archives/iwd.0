Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F324A02
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:25:34 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id bh13so10120346pgb.4
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FRTmnoWaMEh6i6tK8CdUMeyxrxZWS7oNbKA9TsDqQIo=;
        b=cmMYYsGo5u3aztES40+0T3vH6eOxn6Es/Y/eB+AlzKa04thLK4Vw5bw1bz/SeSCgJx
         r4CpEddwWxWTlgHJHoOeT9du1rwEq3RF+G9eO4T9gs5yvF3QgB2noylr6OMWEgGTh5m9
         PMSF4Mjy2YHQE/2FRJOXn94xUIFzrNKEH79f0HWLW8xghY5396HNjBzua/x6hctdKOWn
         c0J9w6VZOxkSplIR3MkS6PAMs6KvjHc0Sh+m5Vr6Db7An5PHXTEy0xzeHHbicY7pMlx2
         eAyFYq3Ceyt2fu2AON0kVuyA2vo94GtKl5sxDkd5j7tNZiVhq9VwAXG/snCiw39rDe/z
         N89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FRTmnoWaMEh6i6tK8CdUMeyxrxZWS7oNbKA9TsDqQIo=;
        b=6pCDghKUHrNqJeCoE8ElraqqtRPBdPK19GkZsxZKgsDt9FhIcKfbdeykq6Hew9iY8r
         N7BF3omMql+E2N9zfbK1vRCjg8HonLOY5tJwbz4Oi2jGkYBki8gcaKMF8m6rtb9MEKjz
         tnnNhAVv7WB6zHd/ShwqYg9Zpvu6vLjzGLbaIH5Kp6+Oy+/HSNyIEEX3Zmx9k3DnHTpZ
         axpalw5cPKxK+cI+vWHQFUuP5CSunqTVUeVKb6eTSW10EL/JPOQh8gCVtCHkfP799f+b
         NZrilU+tEL8TIwT+PBFlvCoINgEA+5LbsM/EjpRd9r568Ax7mHs8EqYoyIK+u+Hj4pR/
         l9yw==
X-Gm-Message-State: ACgBeo2/Gy0osNoMocq99Z0MMqyiDTfr8Qujl1+dWKVEMindLeAvNKZL
	6eBIa+Uz/UWUrwaw1pe1KaIu6HCXZq4=
X-Google-Smtp-Source: AA6agR4snS54b8QH2TgUiIHsvjqh29Jl7OopvJHWfGIwG/CioSDNOXapQ7RY/7BRnvvdAqDugMH18w==
X-Received: by 2002:a63:60b:0:b0:42a:bcc4:e2ed with SMTP id 11-20020a63060b000000b0042abcc4e2edmr5047785pgg.409.1661192734324;
        Mon, 22 Aug 2022 11:25:34 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00172bd4c12b2sm1612024plk.224.2022.08.22.11.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/9] station: don't set OCVC for FT AKMs
Date: Mon, 22 Aug 2022 11:25:20 -0700
Message-Id: <20220822182525.2078312-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822182525.2078312-1-prestwoj@gmail.com>
References: <20220822182525.2078312-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using OCV in FT is now disabled, so if the AKM is FT don't set the
capability or AP's may reject FT attempts.
---
 src/station.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 33cea14a..601c3916 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1110,9 +1110,15 @@ build_ie:
 	 * seen that they do not include the OCI in the 4-way handshake yet
 	 * still advertise the capability. Because of this OCV is disabled if
 	 * any offload features are detected (since IWD prefers to use offload).
+	 *
+	 * TODO: For now OCV is disabled if the network is FT capable. This is
+	 *       being done until support in the kernel is added to
+	 *       automatically include the OCI element for the association
+	 *       request.
 	 */
 	info.ocvc = !disable_ocv && bss_info.ocvc && info.mfpc &&
-			!wiphy_can_offload(wiphy);
+			!wiphy_can_offload(wiphy) &&
+			!IE_AKM_IS_FT(info.akm_suites);
 
 	/*
 	 * IEEE 802.11-2020 9.4.2.24.4 states extended key IDs can only be used
-- 
2.34.3

