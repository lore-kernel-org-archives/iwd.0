Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE974D11D
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMmHNWDb"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1fa26074783so3012669fac.1
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791219; x=1702396019; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwHB6rld5MqIXNWFkkHhofRzbjrhYrincS7mibtpAuc=;
        b=FMmHNWDbY2wptpf+TMShz+0JoqVVEC/QY9ZiFAw8UI7By8uMBuREeIV5IId8uftbqC
         ZlhczDBOa/IjHENL6fNMCSArmgkF7QVvB7NDlj41AGzigFLXm2NpoXECRL1Dr7DXZtQu
         TzP0NYmpzd389NoL3rae7zNdS/v0U3zxW+wlSAS21Dy7IKxfSS3W7qaZ0hnuAD6Tni9F
         8obgNirnlix02ZiHReFocmmur+0oY/cvLHRDdp0Etnxj5iABnHvyp9h+TePbv0ATKYt4
         rjUin48C+alcpex30qV3xfZoSXtAOm1dUpdibVYqCT+VOxorUXQbk7jGMoEqvOYWHGuH
         Dr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791219; x=1702396019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwHB6rld5MqIXNWFkkHhofRzbjrhYrincS7mibtpAuc=;
        b=rhkS+9gKbjCe5M9SrVelJWeuZisr1K5V5YhyKWxDBJYcumlp0qrnYtNA0V1wOkl5QI
         AiMS7DmZBAA6dML7tW1nq+BU85GdxBJ0b1IAvxwKwIOq71HyzsZNjteQKW80ofzGz8qV
         Kvmz/JELveOPdLoYtYcBl0f9zAIZW9gnKiJEnFppK8ME12nT1+RnAO/zOAwV0ysJ7089
         Q1r8LmtFEbFoMd3HEPleToa4dYlQ/nFRorgPLdXh3TzNXflo2+YApgkovGLBTSFJXRCK
         Hy9d8WI3cjeYhhqv2YolsMCJDClrHOeWKArRGafC9GKqH7ymjezTp54Nf+8E9Gj+ND20
         /oXg==
X-Gm-Message-State: AOJu0YwiVRtDauqAgSkQLW8AM4Ru+AhaQtw5QK2HczImiK2XuIOC6Wjh
	5VvnkuRGgCzwUObVIMbKmH7J+uu1wwA=
X-Google-Smtp-Source: AGHT+IHWew8u+Bxj/gsAC6cJAbp1mizDOpD3qpUYGRLr14ytrYuc2G/Li8KRst1UaiKPAycOHH4cQQ==
X-Received: by 2002:a05:6870:3d90:b0:1fa:db5f:419c with SMTP id lm16-20020a0568703d9000b001fadb5f419cmr8136320oab.59.1701791219190;
        Tue, 05 Dec 2023 07:46:59 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:46:58 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/10] sae: include password identifier IE in commit
Date: Tue,  5 Dec 2023 07:46:42 -0800
Message-Id: <20231205154647.1778389-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205154647.1778389-1-prestwoj@gmail.com>
References: <20231205154647.1778389-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include the IE if a password identifier is being used. This is only
supported by H2E as required by 802.11.
---
 src/sae.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/sae.c b/src/sae.c
index 336954b4..da00e4da 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -637,6 +637,14 @@ old_commit:
 		ie_tlv_builder_set_data(&builder, sm->token, sm->token_len);
 	}
 
+	if (sm->sae_type == CRYPTO_SAE_HASH_TO_ELEMENT &&
+					sm->handshake->password_identifier) {
+		ie_tlv_builder_next(&builder, IE_TYPE_PASSWORD_IDENTIFIER);
+		ie_tlv_builder_set_data(&builder,
+				sm->handshake->password_identifier,
+				strlen(sm->handshake->password_identifier));
+	}
+
 	ie_tlv_builder_finalize(&builder, &len);
 
 	return ptr - commit + len;
-- 
2.34.1

