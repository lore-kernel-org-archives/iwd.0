Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041CAD25
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 18:57:03 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3016935pjc.5
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp1BGhVJzEx7DePCQh8Vsl7tKsOqyWaWsMrBR8pr5Ek=;
        b=aqDUV+m5zz8NDd3VZScq5qtu5Qf5JDafxX4bk9MDCwhMprVROOuxRwhAaD9WsmDISL
         HsGpym2eS33Ve6YB3f6/qYca8jvOE6GHiV4hm4wZxPWChVUY92faDiU/HB5y9ZCVinfc
         wwhAoBlJ9OKzjCz7h7BLIsWX60FgkH7EPUSqfqTblmA1ZelnwVxFxu2blKA8qTyeDqKF
         LHgBk1lm+t/naoeSNZkQp4xACl4cc2Wjza1jIYQBqB3ur1aL5vdaLXK8wl4LAinGflq7
         Jqf5DkCx50rQgw9ck9UKy6q5c2CSDs8dpaSBfxXUIeWUsEWMDn211JeCCeIHjR1Hnje4
         T7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp1BGhVJzEx7DePCQh8Vsl7tKsOqyWaWsMrBR8pr5Ek=;
        b=U5guhAqjP4YiggOXP4G3S5VpLHNA3jwUJZcTaw3rQgdSRoczYGUvdf84nVCqErj58x
         MUYcYLw0yLPfApAsDBP0q26zisFt4T2ieol+Dh3Hp3ZAK73kMCmK8GyYDeVBRu72bBYu
         HsVQ6cWAg5SIp7AFeSUVwZXr1QugOVbOaVuvpZhjNGkycHH4+yuNu0H/f3EUVuIbFwU6
         8xT4WlaxVwexZx0XKGa8Mje+1FLtvg479JL+B2fhmGgknlOYCL/mHvpLaHLyYHEtIYTf
         z9LqkuN/9/pm/8BqeaMN34P4PQYOIbRj10A95z+qQBoNEdlg372Mf3Sc/44NVBwN0+cv
         vWYA==
X-Gm-Message-State: ACrzQf3HZlXNHDD9uBUauqD94DEvRFdUOSDA5Wl+2rSfR0BOJ5uUDD3v
	eR4dGru992me8dfrd94jUtvhxZ2lh5I=
X-Google-Smtp-Source: AMsMyM7pT3q2ea0YMZWhoTH+SmcGBJcmF+TAMXRJplDSGDdyR5HhgQhmLcYyJaFzTX0s5qY4phYfPA==
X-Received: by 2002:a17:902:ef95:b0:186:8376:2084 with SMTP id iz21-20020a170902ef9500b0018683762084mr26787727plb.48.1666810622876;
        Wed, 26 Oct 2022 11:57:02 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001869efb722csm3209420plw.215.2022.10.26.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:57:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] eapol: add TKIP support in AP mode
Date: Wed, 26 Oct 2022 11:56:56 -0700
Message-Id: <20221026185656.489888-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221026185656.489888-1-prestwoj@gmail.com>
References: <20221026185656.489888-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Though TKIP is deprecated and insecure its trivial to support it in
AP mode as we already do in station. This is only to allow AP mode
for old hardware that may only support TKIP. If the hardware supports
any higher level cipher that will be chosen automatically.
---
 src/eapol.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 44ffb220..4a1abd28 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -390,11 +390,31 @@ static int eapol_encrypt_key_data(const uint8_t *kek, uint8_t *key_data,
 				size_t key_data_len,
 				struct eapol_key *out_frame, size_t mic_len)
 {
+	uint8_t key[32];
+	bool ret;
+
 	switch (out_frame->key_descriptor_version) {
 	case EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_MD5_ARC4:
-		/* Not supported */
-		return -ENOTSUP;
+		/*
+		 * Not following the spec to generate the IV. The spec outlines
+		 * a procedure where a 32 byte buffer is held and incremented
+		 * each time nonces are created, and the IV comes from this
+		 * buffer. In the end randomizing the IV every time should be
+		 * just as good. This is how we handle the GTK in AP mode.
+		 */
+		l_getrandom(out_frame->eapol_key_iv, 16);
+
+		memcpy(key, out_frame->eapol_key_iv, 16);
+		memcpy(key + 16, kek, 16);
 
+		ret = arc4_skip(key, 32, 256, key_data, key_data_len,
+				EAPOL_KEY_DATA(out_frame, mic_len));
+		explicit_bzero(key, sizeof(key));
+
+		if (!ret)
+			return -ENOTSUP;
+
+		break;
 	case EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_SHA1_AES:
 	case EAPOL_KEY_DESCRIPTOR_VERSION_AES_128_CMAC_AES:
 		if (key_data_len < 16 || key_data_len % 8)
-- 
2.34.3

