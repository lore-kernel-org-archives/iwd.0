Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4C1B21B5
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547193; cv=none; b=s/PHxipWvYwE+5BpGkKmvR7ChWOXzoEMuIXKuFvep1Zsrdt2/IMy81POX8ofQy20FCphwsdwT81r9sJaAVwt2LRFfMNyCnKL3ptMGL1v/S1rWzEsKyhtpA4OGwIFOT3dS9JA8nFIQ2U/bvR/Qeujv5hIbZqzvl/cmvp/4N60uZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547193; c=relaxed/simple;
	bh=+UEpCRih6j2aTuGKq6/22ZcuMoXLtUQwKeK5WSdrf7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nyouYUHupEqa1GLijEQ3dp50/roPPxodFPWYMc3gEX5AuhuDjoR3+6TPFiBXkKfKi4vMds64fYy9WIgl/KDaENysuc5ACvOy2iA0e6Ug+QjmiOaqNhD6wibOsstl9DElo6VKAv7E9BGmCiVjlBJ39wBQPPie3eoNUc48+AMm88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrC/Ui/a; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrC/Ui/a"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4669eecd88dso2720631cf.0
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732547191; x=1733151991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fFrJDAMUyrgQNE5F6mYZPxOkSEe90ITMyZgCx6NFDQ=;
        b=XrC/Ui/aDW6k2RhQo0p4472xfmIG6++OrkNHYn7tnKkC0S779enZgjAGzrVNAdZWTl
         MlAHZ8T6cEn+KOQdQuGONNeoU6SxHx9xp1Oq29iVkEAg/CTh+GlWiOp+YEv3ime5LwCC
         yB/ftTfaaMLwsYbjhSYYEi3xifI4tRhYoWchEo7uAi//ete5rZ2cID+nvPugv0XynPM0
         IZOEOIky8ji++32zknx+oGcywlY1ifUbaRKPgaat+8yNYJpj8u91O9H9N1akKixWU7nb
         32XdaVrCzG4swa5x+cmXNjRXZwbLxEXJelP0oh5vBz2csZvHMRQbYfbHWxa9I2QEEV5F
         XpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547191; x=1733151991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fFrJDAMUyrgQNE5F6mYZPxOkSEe90ITMyZgCx6NFDQ=;
        b=XL4DVmzLVVnVAAx9DJH322qpz3S6dG+1rSi0KBBIIhfsT/rGj7Ys4ZC9XRkDmq9uTs
         JaSrXem03PFZofxOHIbSWglkWYj2/xIzI4K5+MyfPC1sMEW5OcTxsFLJLcxoAhE9Tk9K
         3u99xlzqOnPWrNwKUvfLz5zaqOkULan6Ev51rzv/dSJ03FObKW14Zc0wvxu0BZxhulXJ
         b/KfPyfOiIbXjd1h7qbWph1BlIC+YtA6djAxRJmDwLCIZ6zBSSwnc1SdKy9sByrQb9Ls
         9B8BT+tONQhRgJ6KtNShAbkGALrRM67xTM3MBNk52NngDc/bG475R0blh+UTGTydWwoQ
         VMWA==
X-Gm-Message-State: AOJu0YzpusHYS8ygn4KSQy8OWbLCbckv8dZUtai+3PevhzeePvT6K30O
	E6DyyNg+LVRnrgY742XaOTmZ2Rd8f4HoQbg+xXsfs8z10bQand5oSZK79Q==
X-Gm-Gg: ASbGncvADa3noX7k4OZevVqd0rx29jvYSxgjXENE7f2ZT+krQjoG7uZP+lOLSHaBUTp
	WTPufw5r/AQ8r21XXPcfej0reE9dR1nv811XUPIDHPqAlh1WaHcOKIxhNUQ9t2PVJZx8dzvzDHX
	vebvU9Ck5O3pUk/t7yCy6ye7l1CrwAZ/ou1gfdBntnuPepMV6rDZWWuLq9PdnK+Qi2d1UupaN2t
	Pbx1KNvDGPOvT0wFaWe7iWNQiMX23hPElSAsiFKmZBUqCrlekEywvsEwb5s
X-Google-Smtp-Source: AGHT+IE6rE9CDTRWseZQM6/zUiGT+e9po6ZwiqiJSvbdeg1wDTph/LU+HB85MtApzHtEtRrozZlIAA==
X-Received: by 2002:a05:6214:767:b0:6d4:25c4:e763 with SMTP id 6a1803df08f44-6d450e6d997mr223886816d6.5.1732547191059;
        Mon, 25 Nov 2024 07:06:31 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451ab5cc3sm43569136d6.66.2024.11.25.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:06:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] doc: document [DriverQuirks].MulticastRxDisable
Date: Mon, 25 Nov 2024 07:06:23 -0800
Message-Id: <20241125150623.1014890-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125150623.1014890-1-prestwoj@gmail.com>
References: <20241125150623.1014890-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 1cb4b05d..c031b8dc 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -454,6 +454,12 @@ are buggy or just don't behave similar enough to the majority of other drivers.
 
        If a driver in user matches one in this list power save will be disabled.
 
+   * - MulticastRxDisable
+     - Values: comma-separated list of drivers or glob matches
+
+       If a driver in use matches one in this list, multicast RX will be
+       disabled.
+
 SEE ALSO
 ========
 
-- 
2.34.1

