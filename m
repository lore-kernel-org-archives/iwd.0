Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED323AB9C
	for <iwd@lists.linux.dev>; Mon, 18 Aug 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527450; cv=none; b=Cp7LzXBjo45zpOc4glQnD1tBWdEiK4x4EH2nqMOoGtB60ROK6QPRTG2aqItzHuAkqOcogAHwMvYeQHA4B13UNpPsmNB9rS1K8GVyYslHxakEJi2m6Q6tlZhv9ShXba3qxLFmvhBYeCx8EAMVjS7o6EB/1Ct5tyW+FS1L/eEiLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527450; c=relaxed/simple;
	bh=QG65SD9NCMoN2Iqr9StNwvND1a13nFTVDcc0BXZQxgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evqgX7ugsVGRO5mfH+f/CpTmsUt3h2U6CAfcV2OtoJcyD3MMO/XOKb0Y8JHKFJfhl08uVsmqw6YCRupxXq9BXCZR+WSgWoU0b54ySGWw2FgTmGM2MIc6w08Mhg9B2uJiHanVL8k9LRQFyfPsjyLLdeOZpPQz1lyoiUrWi4qvM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcMS140w; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcMS140w"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b10957f506so55775331cf.0
        for <iwd@lists.linux.dev>; Mon, 18 Aug 2025 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755527447; x=1756132247; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAUIJ/24ryE/tigy7sFsLW0T8h5AYRjRgYhsELwF3SU=;
        b=XcMS140wQAMuXz6zOWSZhk+QJ0INEkPaW8HJd3wla+z/ewQKcpc3+0YRJhqPMv2f3m
         bN3NuSpVyJDZeLNKYGmqHXL2ugEblNv4EgPxJDTpDVrv78qXK1OaSqHq5awNUmoBlDXZ
         UFO30h4w5v0OZ0N0lQepQ1pWFD5AvknfwYTsMLELF4Uk1w8rovglIvnNp9d2u34rhSmn
         +BCQMUVNSshlh1NsuF/Jnsqhmpi2g6rbgUWGnF0CYtwjZocP3qG5E0AUgsYCebqeKY0K
         qPPiKhSGFvpdIVjzwem6OADephhaOzGSBL97YXSvJ+jNAJCmdUU12iy17ZVHU+29LDqM
         gvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527447; x=1756132247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAUIJ/24ryE/tigy7sFsLW0T8h5AYRjRgYhsELwF3SU=;
        b=h62NY+UNTsyl0laMs9zvwoMIuVbOr0vFDe/f/JClD3H4sh+zC0ZpXGi9aktpmtkMaR
         hqQc/fcDj1iUexgJkmE2X3H3tLGXTiIoQJpjPHWCr/ln8qVnfQnwJNOejkFU3BUewv1/
         b4+EUYWwFtrDmCbAFcsgl1z2fAORSln+C2H+stL1FD2ccNhGlgiFY8awWSLB1+XN1CXH
         pPmPxGpShZnSvSPA1p7RQMIGoFBymyag/I2XwGFAV+wWU2Wvr+KMXcoXd4anGB/EWywf
         PKxPjVbRVWdzDJjO0nvp2/dkIGzNlHSRzdqLok8NX4+Q5FLq5nXNee2qNSXl2k0Ppf4m
         RPbw==
X-Gm-Message-State: AOJu0YwcrKF8az7xHJ9+JfaP80nPFcKEKdsKY8Le0kthPG2/Y8QuXI4q
	GhmdPWSbF6HYxC2/lzbMEbemg2wkDJiOqqw6rttBjs3RwpmQfoTYzyYe3YoPiw==
X-Gm-Gg: ASbGncsycj8jvYvQx2kFwRHBImUI79ZuRJ0K67c4Z59QwyJ2UlKMyGZ0nAd8LQPzuLy
	dKjRRHyA+bogBJMxwv9q6bfhF0OIY+MoS55MK/aoa/ZsRebL9U/MOfcWdGs/rdXvfvst0PK2kMN
	cMV1zIq38HT1LK3+yRiA6FEmBwQndLhwOxS9jTTLkgiIW++Rjw0FFFVY0OQBU9eVJFq+LwRr7U/
	xptDAkloCTZ0pkhoA7oUWJfhEcwkJU8c2/nEft1E7dmg3tRB72f+JCZX8mzI6MeuteIDK7/U4Gs
	lF1eYwECgIIns2ZFKjpV0Xgi2DRt2wTbMkvW6FAfKP4d+q7F67vjgY2sXc5RbVsum2ViG4bEGlK
	kZmDMH1Sjw9Lu+aG/S3CXfrlrVjlXyzIf
X-Google-Smtp-Source: AGHT+IFTsiPaqeuOMpk2C2JiCc1A5C0/1zYC7+mQwnBjoUfvV7XYvn+gKRA9IH4YpugnVBSfLIa27A==
X-Received: by 2002:ac8:5e47:0:b0:4ab:722e:3b39 with SMTP id d75a77b69052e-4b11d14addcmr141650941cf.1.1755527446690;
        Mon, 18 Aug 2025 07:30:46 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5aeaasm52781531cf.19.2025.08.18.07.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:30:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] netdev: disconnect rather than deauth in FT association failure
Date: Mon, 18 Aug 2025 07:30:39 -0700
Message-Id: <20250818143041.283887-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818143041.283887-1-prestwoj@gmail.com>
References: <20250818143041.283887-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After CSA IE parsing was added to the kernel this opened up the
possibility that associations could be rejected locally based on
the contents of this CSA IE in the AP's beacons. Overall, it was
always possible for a local rejection but this case was never
considered by IWD. The CSA-based rejection is something that can
and does happen out in the wild.

When this association rejection happens it desync's IWD and the
kernel's state:

1. IWD begins an FT roam. Authenticates successfully, then proceeds
   to calling netdev_ft_reassociate().
2. Immediately IWD transitions to a ft-roaming state and waits for
   an association response.
3. CMD_ASSOCIATE is rejected by the kernel in the ACK which IWD
   handles by sending a deauthenticate command to the kernel (since
   we have a valid authentication to the new BSS).
4. Due to a bug IWD uses the target BSSID to deauthenticate which
   the kernel rejects since it has no knowledge of this auth. This
   error is not handled or logged.
5. IWD proceeds, assuming its deauthenticated, and transitions to a
   disconnected state. The kernel remains "connected" which of course
   prevents any future connections.

A simple fix for this is to address the bug (4) in IWD that deauths
using the current BSS roam target. This is actually legacy behavior
from back when IWD used CMD_AUTHENTICATE. Today the kernel is unaware
that IWD authenticated so a deauth is not going to be effective.
Instead we can issue a CMD_DISCONNECT. This is somewhat of a large
hammer, but since the handshake and internal state has already been
modified to use the new target BSS we cannot go back and maintain the
existing connect (though it is _possible_, see the TODO in the
patch).
---
 src/netdev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index ca8bfea0..d896c907 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2993,13 +2993,26 @@ static void netdev_cmd_ft_reassociate_cb(struct l_genl_msg *msg,
 						void *user_data)
 {
 	struct netdev *netdev = user_data;
+	int err = l_genl_msg_get_error(msg);
 
 	netdev->connect_cmd_id = 0;
 
-	if (l_genl_msg_get_error(msg) >= 0)
+	l_debug("%d", err);
+
+	if (err >= 0)
 		return;
 
-	netdev_deauth_and_fail_connection(netdev,
+	/*
+	 * TODO: It is possible to not trigger a disconnect here and maintain
+	 *       the current connection. The issue is that IWD has already
+	 *       modified the handshake and we've lost all reference to the old
+	 *       BSS keys.
+	 *
+	 *       This could be remedied in the future by creating an entirely
+	 *       new handshake_state object for the association and only when
+	 *       the ack indicates success do we clear out the old object.
+	 */
+	netdev_disconnect_and_fail_connection(netdev,
 					NETDEV_RESULT_ASSOCIATION_FAILED,
 					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
-- 
2.34.1

