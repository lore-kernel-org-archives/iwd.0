Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD124BC06
	for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477910; cv=none; b=THgfLVHg6atf4ZIFVaylAvQsFixn/z3Y/BtNCcs/SEqBdkttV5nhRCU5KiP6A1Txuk+yF5kdezpTo5pZHkswMe3i5iRF6ZlRvvxTNr1aOsroGXHr05ofA682C2LDLWGyKnR1H4Y1XqjC4kTqa/2keKu/H0gCepTZnq8C1a41WHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477910; c=relaxed/simple;
	bh=qnHfjnEhNCvmH3lCVzSLl2jnSlRGXIWMgbnsl55h1Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSfBzq52Ys1UXCIQ83t1SXX8EAmlNNTqV5zb2uJQETk1kUK26UY1lBQ8q3GIuqfeNiJQBU3Rkr96ski2ykwg1tcUqTdindP7W9R0OYEIbuXDnWykcUh27sg/OZ0zz5TglbgOvxl5+0GH2vmwi1uP7jkGSCZGBTYDnWL0yLEz398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifympxfq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifympxfq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f2339dcfdso20471875ad.1
        for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 12:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739477908; x=1740082708; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMOMBL6Fvv0BI1/LgeVHPzVHWQ0ObEUKMn93HcW3ug0=;
        b=IfympxfqpczSHhv3WhHx0jrkkhhYf1fATLLLfXJ1MzAhQb1Nujxb3RhVaFsfGJV+ZB
         B3N9G6igQnv/Ke06jjYoDYMf4IWFP/rZKA/ws40QbitK15mvaGaY8DYnGPd1BhclkblR
         3o4fuk/I26EogOM+kUw0pUfFfICrCY+q5NFlvsXQflBwzebitWImcSaSNsMZ8BIaC4Qs
         aMaegIsUoXif3Y5iHACFYvJD3hhJwUUpmHQ8nFgZU3jZ003uZBz/elsxY8EfzW8bjm/N
         /7bzrY4irfZy8SRKestP3ctA2Zz6dp/MJXTLvBoALYdr0EZcm7LqR7+h1uCR9tDHK1bU
         T7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477908; x=1740082708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMOMBL6Fvv0BI1/LgeVHPzVHWQ0ObEUKMn93HcW3ug0=;
        b=thj3KU9tNGsWIVR9hGfoNUoYtHIj83+eGWGAprOaDPxLtWZZB2I+2+JvkkslxJJPL+
         /IBBvtWUkIAQdz9/fEHjqThugPVSgdqe4RvqNozFrbTlZvYk9HHQMbf+Mj3ZB9giTVHo
         srhSwmeSG5bmka+7+YCxtl5Frh84eoqo46eGM5easS8gN66TrLPcIcOC3owu0LV4CzcU
         xAhZv/syObRMvvohiUWqJW16p2+oIoFPR8rWRCUL1HggWCaozfBN8Q4THQaKE30ORXx/
         pCosBeXvJNDBBUVd/gEWX550Cz5VAP5t0hoOQt70ebu+IMpXQex2CQvosN6y9Gk+fHbb
         Xiew==
X-Gm-Message-State: AOJu0YxQF/f7ZoZidwJKxZiJyvALT0pprqkwuNiVo6QyjMXgP6Pxr4fO
	IRFZ144WNzDIqrCw6fWF+GUs4FvpjQb89mblI5ommJAtRfaYtsMPu7ZbGQ==
X-Gm-Gg: ASbGnctOGtsGlwaLb5ksI8pxtAYwISLnpCpxFTLhfQ4eqIZu23lnK1MWmmP00Zbt5JW
	pV5Gu7nGBrsYWfKbdbENOny6wrya6121JVnS0r0UMdifAhgaG0iI/5h7HNHAedsebAimwE981OE
	mwopw1SHcEi+CmHfQMoQpNwo74Qg71GFTkAfPOqiNoVfuwgGmB+dX3RlDoXTCwgGN113XQtDS3w
	ycig0MrR5mTTeegBpKZMyjQmKP+6ICh+55V7IcASOYZ/kRr8/DRYOWtpb4GheWSspIp/j8o2Shq
	FSYlP3VHbiadiJ6/2c9HCCenRw==
X-Google-Smtp-Source: AGHT+IGXSvRoaGdcSlqJHutKY5khcDMya1AqH4zrCNcAERs0VSZ0hxOV6dpzZwCgdaVfNqD9uIVvkg==
X-Received: by 2002:a17:902:f64d:b0:21f:3d0d:2408 with SMTP id d9443c01a7336-220d35053abmr65632795ad.10.1739477908520;
        Thu, 13 Feb 2025 12:18:28 -0800 (PST)
Received: from localhost.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm16419455ad.148.2025.02.13.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:18:28 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/5] handshake: use pmksa_cache_free
Date: Thu, 13 Feb 2025 12:18:15 -0800
Message-Id: <20250213201816.230112-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213201816.230112-1-prestwoj@gmail.com>
References: <20250213201816.230112-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/handshake.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index bee31beb..c469e6fa 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -1239,7 +1239,7 @@ static struct pmksa *handshake_state_steal_pmksa(struct handshake_state *s)
 		s->have_pmksa = false;
 
 		if (l_time_after(now, pmksa->expiration)) {
-			l_free(pmksa);
+			pmksa_cache_free(pmksa);
 			pmksa = NULL;
 		}
 
@@ -1280,7 +1280,7 @@ void handshake_state_cache_pmksa(struct handshake_state *s)
 	l_debug("Caching PMKSA for "MAC, MAC_STR(s->aa));
 
 	if (L_WARN_ON(pmksa_cache_put(pmksa) < 0))
-		l_free(pmksa);
+		pmksa_cache_free(pmksa);
 }
 
 bool handshake_state_remove_pmksa(struct handshake_state *s)
@@ -1294,7 +1294,7 @@ bool handshake_state_remove_pmksa(struct handshake_state *s)
 	if (!pmksa)
 		return false;
 
-	l_free(pmksa);
+	pmksa_cache_free(pmksa);
 
 	return true;
 }
-- 
2.34.1

