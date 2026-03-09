Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A13A641C
	for <iwd@lists.linux.dev>; Mon,  9 Mar 2026 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070596; cv=none; b=J9f6R755lF9Z21IQYCVZ1O62zOqTuLz6TlG2v2PtNpgSe2KTAdtR2tNugIH0dN00sXjDhABg34Vn4LDkIWp4Lefe8hYlaPsMQj3JepEuxWrrrpJew3Xe6VLuMygnmTZSG1ZUpMyiwsbGiPZ21XXDUGxtkpThYru2BL19T9+nnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070596; c=relaxed/simple;
	bh=Q70J3c3//s17FJz5v3+tfPZ8jjjZhqzuedGijSM3Xvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bln/w8jlTbzMYRH+8XOWrYfkpzj5koIVxMS282aRn5y5vTPzxdqBfD1KX2/RFM03bYsQMJi3n22ImqeX6xxhcosCFsrYpecklAI9loVzyomgGaeilz6dQshNHHnf8inoX6zZnS0JaRol2GwqgwHOLD/vOpG0P/I7EQOZbwLGhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd0ZQXGM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd0ZQXGM"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899eabc5292so85323746d6.0
        for <iwd@lists.linux.dev>; Mon, 09 Mar 2026 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070594; x=1773675394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvydNfxy586Cv93Ha3UJbF0jrh+65SFUXm99O0e5MHs=;
        b=bd0ZQXGMQTeetOEBsEwOqxoVwOaMSEXwnp0j7i7Yb2Gxr0WRxllFgTQ/jOjXpzeXrf
         eszIybVrcIjvfwNry0Yv/+26JCrPfGxocCNM3Fd7KhFeRlo4r4wMuYExzatqQgFXlY6O
         m6NaGKft0ZJLTenMLHfzxXbcNKH+Axgo6W9USyTxyx2xb+TQQl/R0RJu5jmd3WEDXDQJ
         XETdWL2oKQkr/17Gq2ka2DEm7TNv+CVpyIjrsOmFFEdUwZUqBoIFpOjAj1cy5ZUyHLbh
         33mQ0t3N2VT1hbvvTV2vNs/ZThs87ya7q3H2wkovtE98JorM85hd7+0tCKHIJm+SjPpX
         dUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070594; x=1773675394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvydNfxy586Cv93Ha3UJbF0jrh+65SFUXm99O0e5MHs=;
        b=VVJ4B9De5jcDCpRWgZGmy+YkBS4Qlqk+FiiG8pPfxZbR1lvg+oynp8f/+BwW4p4/iR
         J4p+rnXlLdfKkKEBCA4JlJYkOBcGoMW96SIgiEtWHN06WSi5L9QZ/bLV25ttSZUn2Fqm
         PbUMEbzZXkV+q0ztnRN/hK2xnhtzkaekmsuOOr4rhmsyeSOVdA9MKtRdUHB3yKsglUpd
         qnQxe1AUZtmNDAUM/na6FQDtV+XTIiNleFnXXDt++1WDZbgLLNLrluYTwh+DoLFdSOec
         2TpU4+N9vtFSvUG/qQraWjs7yktCfmaFFxATKMVymzt6YSc84wz+5qOvab1rxqotm5lW
         3OqA==
X-Gm-Message-State: AOJu0YxIMHSuoe0Mtn2uZeRk+o1s1xcqKp4sM9ThIXBEis4VYLbfERAf
	6kf7hVC2BxvImJki+oHaZ/h2Jn+TAUR8cbXY4zq3Y5vPQWztk25BxoGHNbY8eg==
X-Gm-Gg: ATEYQzxMQdD3V7kiU0Dai6S/r0/7brrxJRg7pH9re4EOZoaeCB8GSTl0wkwH8XwTRGu
	r7G8KWcDaZJM6Rwf0UtDrgT1p53Z1VBpzG5A8ibSL+//eGWbQ9+K/sfl4QjQKzrwC1NGCxCIsLx
	9GqZMe2qWLtI2chx0fK6E6vsOvVPQC1SKnD0KD8MF1uPDw1HdjPtNPJOIXjzF2d7IIYhD8v5mvb
	EEyRfnjPxdeO5ZTsBLTzVXELFuwMTzAft2ETe8RUEIntZC+G04PFZPScA50F+GFFIJxjlxA2XeI
	YBX+uGCIS2FHjY8/e2+/wHWXKZ6dIH+NPHKAM16NkWyXzwv+p23LdpyIAETlydEYIDLOnTHwDpG
	iWMyEZnLe4tqACDUbavtZkNrcDRniPhfHIi0b9mZqP4DJuwx81M2VEqPk2hev9t7+VCb/mlbBEO
	PjBZ7QIPvZQdnRu4wdZSQFwxRViJSLltS1bxyiV5YodsG+jXig0XhuvUrnFj+n1zF9
X-Received: by 2002:a05:6214:528e:b0:899:e814:825f with SMTP id 6a1803df08f44-89a30b14965mr167592876d6.59.1773070593733;
        Mon, 09 Mar 2026 08:36:33 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c21650sm151716d6.39.2026.03.09.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:36:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] station: check return of handshake_state_set_pmksa
Date: Mon,  9 Mar 2026 08:36:26 -0700
Message-Id: <20260309153629.2012710-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If this fails num_pmkids and pmkids would get set, but to an
uninitialized buffer. This would then fail to build the handshake
object later when copying the PMKID.
---
 src/station.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 50997f5f..6c9e8d13 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1378,9 +1378,13 @@ build_ie:
 					bss->ssid, bss->ssid_len,
 					info.akm_suites);
 		if (pmksa) {
-			handshake_state_set_pmksa(hs, pmksa);
-			info.num_pmkids = 1;
-			info.pmkids = hs->pmksa->pmkid;
+			if (!handshake_state_set_pmksa(hs, pmksa)) {
+				l_warn("failed to set PMKSA to handshake");
+				pmksa_cache_free(pmksa);
+			} else {
+				info.num_pmkids = 1;
+				info.pmkids = hs->pmksa->pmkid;
+			}
 		}
 	}
 
-- 
2.34.1

