Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C862165EA
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824842; cv=none; b=OAbQ/sIWtQYODOnKMaPFAiejCqyiFw2MlOf322Fm7WtdY+39x6a6DELZZx4xWYPcAEFwMHKRZKnORKrmXEv1Mqoe14d1GeQMgER+D9pDVYot1c0mr1Pw+HUqftsficEtVZrB+vEMKxv63f0rwBHhzUBxWxRjejY6ncfFJlEidcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824842; c=relaxed/simple;
	bh=oBzeziN2idI1P5bMHJlVTwu6D4azvlgYjt11hQpyoLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=maXxt0pUnzQkCmQIWrkOo8Xda5Azu00O2XRnQ+K1sfE84/mweP9GjdhoTk/kbt4xKv32HaaSGHFKrskw/IpGZDqbBYAo+YOlCAE/KkCpfnJO8E+EA57kRrLan/GbSJoIRFzI5i8onPW7RqojKXIT2APpRjvlBQA0ehKp/t3XbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5TC28no; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5TC28no"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30384072398so6286856a91.0
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824840; x=1745429640; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLTO7mXlpo63F3LfZdTawKrqCpXAcXAhs8MiRtlcupQ=;
        b=J5TC28noJ/gVuYlOrY8uRsGZlnetxwI9O6YCPFsTFYufBAMkcMms7CuiwWkFJCr6fe
         XWnCq4SCoiVEhQELJKQ/c8BmjS1Rb4wWfQ0WmrdfuY23HSZgrbZhv1FjwEhChBFXE/le
         xGNYr7+WsT4CwFH7T2jK+Ygb3jJBcQZX5Vj/Pbge8IhqVLb+7SkCIqSY5nKJt5pZPZ78
         IiyTYUWRtka1kbf8Z97Wh5azccQZa5NBfm7BYi9uSHKHpUF8LMA+1E2Cdjf+TUi4eGpv
         mZgIgRv3E48QOsK5so/aeUPV6Z0OgXyPETCNqjz0SorGH5CiVuhRjI1c5tDXn6G5FyU8
         DYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824840; x=1745429640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLTO7mXlpo63F3LfZdTawKrqCpXAcXAhs8MiRtlcupQ=;
        b=ApfByoH65yxjTvlckCFzks4xWISHTbkz136JJrfHzw+HMhZe6YFMgGLShumWN4Fr6i
         MLHjjzX/re45iUE5mnukWgwU9e+hhjg9NkdgzFY9xH82ZLyRFki6m3SvfN3iLnmeFeBa
         dZ3EShGe1f0IZZngxsXGsA8Rd+xM7jX3vSd1iGPA0M76CpJWhmyctWehcbcvwHGTt7er
         jLIUUI9PyLHgxvuP3sDZTJ0IjjtqPrWeNpJDjQ/Pi0+w7t4mWHd/iZNqco+Um2vSrXJd
         2b3UuIRkzz2UCwoaqPMSZOV57OWwLZytmKwg7sV4dCiKR9C4ibcUHLxhXoZHwk43oJkR
         Uq1w==
X-Gm-Message-State: AOJu0YyjoLjQN8xq20BWYpDXGoVmQ37vaeAwmDR4wSUSVPGXm0cVfyJy
	1IXL0BCqSfweU9VDaNFAnuJYqGtg4nyA1wSSLsoIy+iUbnFRr7BL1MVpvg==
X-Gm-Gg: ASbGncslnurAxnq0hJmT5zuUued9TPive2g8TyziDM573hYYd2bmUZ2DHU5KayD/DKA
	4juLYQTjqnWkKYxmZ0V3NJ3cnOz9m12NJHCH9dweNGCjriaD5fkFIcUlOigMeX5rjBhmDnanmL5
	7SZxZFyXz5RbRoGuumpFVOkJFZRh/Ul4JlLhEQnG4O18gume6wtkin8z1yj8UvMr0tzOuo87Lcs
	Zlf2fTRdurcFBS6kbdnSagwaEJWsihX2JwL8SAXqYfxR8muF1/wTI7aMm7THQzjC0pZcWez+0yJ
	19omqa5UdhKk5Q8j9DMt1dPvCiI5wfzLZL9PY+Di4ZqMPXCwfPo=
X-Google-Smtp-Source: AGHT+IF0Mk/E7qIIneicdPf2FS3cPs5cEiAKBbUVBbYYPg+ZRRhhpExo/vHjsxf+Q4ANGWYkPvDlgw==
X-Received: by 2002:a17:90b:4b92:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-30863f2c4f1mr4498800a91.15.1744824839612;
        Wed, 16 Apr 2025 10:33:59 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm17093055ad.83.2025.04.16.10.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:33:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/9] storage: add length check in __storage_decrypt
Date: Wed, 16 Apr 2025 10:33:42 -0700
Message-Id: <20250416173345.136025-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416173345.136025-1-prestwoj@gmail.com>
References: <20250416173345.136025-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length of EncryptedSecurity was assumed to be at least 16 bytes
and anything less would underflow the length to l_malloc.

Fixes: 01cd8587 ("storage: implement network profile encryption")
---
 src/storage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/storage.c b/src/storage.c
index 843581fd..2115a879 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -500,6 +500,13 @@ int __storage_decrypt(struct l_settings *settings, const char *ssid,
 		return 0;
 	}
 
+	/*
+	 * It should likely be far larger than this, but that will get caught
+	 * later when reloading the decrypted data.
+	 */
+	if (elen < 16)
+		return -EBADMSG;
+
 	/*
 	 * AES-SIV automatically verifies the IV (16 bytes) and returns only
 	 * the decrypted data portion. We add one here for the NULL terminator
-- 
2.34.1

