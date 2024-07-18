Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0AD13212D
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303126; cv=none; b=qs5xCJcIt0Qsf9dFe+GSe6w6WNSlgNPA74iAQnCZ3vgtK6Je+AZSoBflyoisv0S/ZMcwtVXcocs7QOeWJpyIjEYq4vCQOKRSG8Bd+rtq6kgWiujfnBE08lc7FU7yYYq1ORhEcfOLWhplTzJhomhfa6VhrrlCg/RICH6tI3E6krI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303126; c=relaxed/simple;
	bh=uxyi1LybGNHO7jQgU8Nek9BiwsBMQOdVAAFWWa8RhEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYIcQYa6dcEMvoW7erKFObzc13/BXdX/H51Bja3tE6RmuVf2RrJZsHsAPFASWcysArNQnU9tR/oBlZ+mtilJTVZARXph39VEM5qLTCx/3dmAnEvmuoOSjD4tZV7uG2hFTgJvlDwB0Cp8rGWlRhYiX7WW4sS0ksWU5wzRF5ucfd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1K0CZKO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1K0CZKO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b78c3670d0so4266946d6.1
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303123; x=1721907923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5P6LbPCO10338QjJWBDL6Cm++KD9oA/T0WxmZtO828=;
        b=L1K0CZKOIO6TGCeuWPjl9yHjlO0+GGNW2j99O/hDIAOgtg//mOI65sq0M3BxFsI7sw
         hYK47U3Ax3FSKKzAzCoLcZ2s71XXLN6fyTKmb1OZ8WBGjpokK65+jRBKub9UtTjjX2hv
         aWOtOYbW6VJ97v8ItIdC/cJrwJ3unnsQ+eqAVjGUAvzbwaBqnM98BsUhJj1XaSyasxdH
         SVOASxfoLVOz5kH7QlH/lP31RnzZ5TsURRzEJYlhQOoiK4DKUyh2pNN7CnVvhAeJTN7H
         vGPWNf2TSpnXg3BKgWzMvi/yTh0OdhvTl/Oc10dIAfGe7pL2jpECGazFHPh5InCjpHNI
         oOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303123; x=1721907923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5P6LbPCO10338QjJWBDL6Cm++KD9oA/T0WxmZtO828=;
        b=wu9zI/LKPF09EBnY9HFWF4zFdO9cWpD7RQ7ASg3VobjAOAF7QRhxc2faYUM7W86Mtu
         Frsbhe+6HUNBwlN1vWJ8X8LapHHeWFPkGuCHdpaQzfXPlNtsx/PjuOrcjaCkmykUENAX
         +1oqG7vbWXcGcQFdYXwTJ+W6yw8DRPe9hQX23E+mCCwzOqfYnPhlJOp7Fj5ke/J5eeXK
         l8p8lvhGs1uZ8GmnoXk6iBPcFkY0WRN2PAmMMBom2S+bEhq2wJn8QfvWC8aesuayV+Vu
         Gl+nE5qPgtaSMbW1Eyxvy7aps7Y3PYedz93YumwV7qLfIAbcZmLc1pxsJJVng70xArAA
         KuUg==
X-Gm-Message-State: AOJu0Yx3SiCfoJtXt0m1BgMP+HlwFYBfBHbIQiFLnhWxSzWGbP+lhrEw
	GXsv0jT6K46XOqsX5sDcZWG9GXtRCqBZcXLnXqw2QOD6YJ/xMcw8s/8wsA==
X-Google-Smtp-Source: AGHT+IGNeeGEBOgfEbBSGQyE73628CyO7AkdyAUhA1mrXQCOgzLFx5wYjqJX/tU9L+6bHKmHDubqLA==
X-Received: by 2002:a05:6214:19c3:b0:6b5:e24b:bb0a with SMTP id 6a1803df08f44-6b78e38ae18mr60877316d6.58.1721303123145;
        Thu, 18 Jul 2024 04:45:23 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 04/11] station: update logic for handshake failure
Date: Thu, 18 Jul 2024 04:45:07 -0700
Message-Id: <20240718114514.2916258-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718114514.2916258-1-prestwoj@gmail.com>
References: <20240718114514.2916258-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After adding the NETDEV_RESULT_DISCONNECTED enum, handshake failures
initiated by the AP come in via this result so the existing logic
to call network_connect_failed() was broken. We could still get a
handshake failure generated internally, so that has been preserved
(via NETDEV_RESULT_HANDSHAKE_FAILED) but a check for a 4-way
handshake timeout reason code was also added.
---
 src/station.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index abbfc3dd..62b05c35 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3368,7 +3368,13 @@ static void station_connect_cb(struct netdev *netdev, enum netdev_result result,
 	continue_autoconnect = station->state == STATION_STATE_CONNECTING_AUTO;
 
 	if (station->state == STATION_STATE_CONNECTING) {
-		bool during_eapol = result == NETDEV_RESULT_HANDSHAKE_FAILED;
+		/*
+		 * Either a handshake failure (generated internally) or a 4-way
+		 * handshake timeout should trigger the PSK to be asked for
+		 * again. Set during_eapol accordingly.
+		 */
+		bool during_eapol = result == NETDEV_RESULT_HANDSHAKE_FAILED ||
+			reason == MMPDU_REASON_CODE_4WAY_HANDSHAKE_TIMEOUT;
 		network_connect_failed(station->connected_network,
 								during_eapol);
 	}
-- 
2.34.1

