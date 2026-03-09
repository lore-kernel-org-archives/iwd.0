Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEE53D9045
	for <iwd@lists.linux.dev>; Mon,  9 Mar 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070600; cv=none; b=Ml1w9jiddXDKUQlH4QmmypAP7W7F6dfKJ/kslyJDI+WcsTZRIdJT6A2RtC+9trjbDYFdFhv8koNopxCpE0Hf5WXgTCwN0Rw0qy4BVB6gRcTgQICVvG1QwZIQXfpzqdOAIVYyERi9ZXxXj+sVlQmx8V6oj+URnoy3CHYrWsRO29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070600; c=relaxed/simple;
	bh=HQJ+NfiWeXICyRX9anbONUTBR2J0Ce9nXvBZl+O2I/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9IQ/qXYO5ki/vtJ0DenuZmg0renZpI0LqAzpFLOxDQE0/6b78D7Im7YiZ/yeND+UwHOdScNAXQikTiyouRtVy4CdqQpH87XcU/ETCz5G9IjBAl0E8whKpLO5QAmvwWkgusuZQp+pGFFFRYbP7J/1B6MaHkvupWgC33bnHw4gHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McYtdheY; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McYtdheY"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89a000f5adeso145348556d6.3
        for <iwd@lists.linux.dev>; Mon, 09 Mar 2026 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070597; x=1773675397; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOTB3Ob+U7+LLw0n4+Z3KDfkLUaNPKW6rK+zrYEl6LY=;
        b=McYtdheYNH1DnxhN/bBHX00DKcvusfPYk2WZHIDo77svC2wNcN5sc8VOgpqhfHLTtU
         9Cwf9sMpTDR2eTYEI0cL4ap4XrXVZm04Bfeuss4kbOxPpxSOoSsVq1Vr+YIO7UXX08/x
         WfQE5wpe+ggC3MSGrkvqQdQG1M9JIyrVEV0Nd0rEKBHZkrm9ial3Lj5Dg4x2aveI07Kd
         CvIVIEbu6B6ZocJ/EqIFeP7q2gl+dt26ETYJBKGKxgXZ7LtwiRg8rrUAx0XldEFJtUgs
         dCrPEDs7CIS3fhOpi8f43jnfOtNBM9dBvVtBPbaFxr97TuK2b2AQsR9epJpO79jazW+S
         QklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070597; x=1773675397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOTB3Ob+U7+LLw0n4+Z3KDfkLUaNPKW6rK+zrYEl6LY=;
        b=por36H+yF37JEmByFcMOp+OOlwJkGYuRY0A7pBhtgMzB4jW95Ci6CQmgUzcf8Z7zml
         7sCecqojCkeAv+cjt369oB47YPihRpjw5N8ABaHzsyODEXzKMWS9/uU7/wJRqx9FaISC
         WER7fpAmIYW0wavL3qqyW1cyqOOpCF3WfSUJFDuvIsnAjCprYKL80WjMvbl1N0YXf8JE
         GLE1mmq6AHyNMJJOlEdKa7ljfxc5JWnhWmGfVCYGjlXK68crnS7AW+olK7Olgg4/aH8n
         tdCryTssYz0E+zPH4aCXRh9zPW8yTM+K3Z4ObpFEiR1vk7EyMlPaRV20BYwvn/MkYHDJ
         W2jQ==
X-Gm-Message-State: AOJu0YzDwRXXY3GzSbliti/Lsgsdx+JFETbxksm8xwqbsF1uBxKXXlPp
	KTzopiN4rtFym7Rv9MQKgi6KSb5cfT0C1sF80uh0e6RiwKL0XcAsf+AdYng+/A==
X-Gm-Gg: ATEYQzwo6JEs/K/RMOBQvlayD7zTPgxxfhYwrmTkpgAPDqogOsQi8KZOYS4fSiUtrPo
	KLJoOS3rWE3zBpQkRptEQMBqb5McF9BhiPpXcMqzdj+xp+yvNhm7fUfu1cwhNNlQSWRU1Fz4iiU
	1YQ1gGpCIHkmcaW/PseLILOoQLchWIlhHwQ2tbu8u8qVaSeRAx6NPAx9ExO6sgG3qjuHsXRN8St
	DdhGECmNl5kcPntulYgHDFYAybYswhd9xCAnKjq1YeUhq1SYj8TnJkYmZr52P/By2ZWWebcvbfp
	Zjivd4jdz5vxqimzqWiHdaA/x++7nhf62LwpnyWXqVWoXOO4VS8FIH5a2p8sYOvKjZ2Igxg1B+i
	s3gMICvlrtkK+O9kyl2O3VsAHpEqBZIBFevEkU7fQUW1k5v8JdIf0ed7pzPlv0mo27r29KXpX4d
	Hz3SL06S3KtVNijTDzrfPVHsfr3TA6skBJZ64iP+a/ORrA1CaIWJLJFFGdQ47yZPKOMyArV7aSo
	Ws=
X-Received: by 2002:a05:6214:2467:b0:899:fcce:b1f7 with SMTP id 6a1803df08f44-89a30acd555mr183415196d6.45.1773070597474;
        Mon, 09 Mar 2026 08:36:37 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c21650sm151716d6.39.2026.03.09.08.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:36:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] handshake: check expiration propery in set_pmksa()
Date: Mon,  9 Mar 2026 08:36:29 -0700
Message-Id: <20260309153629.2012710-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309153629.2012710-1-prestwoj@gmail.com>
References: <20260309153629.2012710-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing check was only looking at s->expiration and if it was
zero or non-zero. If a PMKSA exists for a BSS the expiration will
be non-zero, but that shouldn't preclude us from setting that into
the handshake.

Instead check if the PMKSA is actually expired, and only then
return false.
---
 src/handshake.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index ef1a8220..5e864af3 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -1227,8 +1227,9 @@ done:
 bool handshake_state_set_pmksa(struct handshake_state *s,
 					struct pmksa *pmksa)
 {
-	/* checks for both expiration || pmksa being set */
-	if (s->expiration)
+	uint64_t now = l_time_now();
+
+	if (s->expiration && l_time_after(now, s->expiration))
 		return false;
 
 	s->pmksa = pmksa;
-- 
2.34.1

