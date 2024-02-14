Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865613A272
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939541; cv=none; b=d16080FxcynwgRRbaJPnAERRb8FfImkZIi2gn41lf2kUNcaeKRKjwMqsZY+3WVLKfS4QOnt62BSSz8Zc/aR7cvaA3MqPfh0wQPFiogcGSLP2MDQ/ewROWug2lGh9II9UIYwY7f0p46fWN/jw/+FHNCUNwinzYhOB5AQthoxY0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939541; c=relaxed/simple;
	bh=VrUsBi7vvEmY9B3aShvVPIxonDCcFEZ6mQfimLd/1ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpnn7U4dmrgXLJIqn/RiyRfnC5ZCzuubfMtbqhTC3kmiKdPlss+cl0SH4cfHRUgxFv9VarGJCStMEQvhHFg7OXkS72obFtbU/dhxuchP6fxQ+t58b9wkvY+zs4JIn9r6ZFaw3EEh/rwNFLGZQz5ccHW67WF6IzImpe686PVCO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4vacAZM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4vacAZM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d73066880eso697345ad.3
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 11:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939539; x=1708544339; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwBYWyuNokiqudKDRORBvRUNZjblHmGp8dCISEwBfvM=;
        b=I4vacAZMGdq9lnq+PuldXJ1tFLsTZeR3q1H8GzAkdMYXJT40UIJDSH3uqH7MpzG98j
         Vhw80L3xPfOLuwet1719Fa3uiSoNFmq/0mSwx0F3epaOGhR1z+0qalSeRHXE+8MDZCvA
         zPuxu5flfPTLkzUUwDZVKkRbYN1GobV/bFc4KNc1YVVttSBHNtq21lCOsOmPsFLZQhUf
         yPneAwBDFX+SDNpmtDjq0YsIyVj/Vv41leW58QSFlIKE14d+DO8ruPenoSA0SBzUCknn
         UXazXHiXcn6gSsi7IykdGB/EOAn5iEeifFFqAVkEubSeCjWXwqW8rrj67wn+sHvO8yG2
         Mdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939539; x=1708544339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwBYWyuNokiqudKDRORBvRUNZjblHmGp8dCISEwBfvM=;
        b=uWkdtKkgiA43W3zh5uBRISaGdsxM5UA0gMGWW+DQOE4cZBoklusrWicl6FgL3opysK
         rPajpjLz9ogbVhzKUfsie/3pQ7zS9fd/DyvEn7HZTeBrKhU8TNtteBqZSPIBn3VEnhUy
         ANwiUckLEG0oyIj0s8GyGIQg31jSVKq71E/FAHLMLr2gjYCtAVTHW+CGNvNjFGvJ8Ctm
         snaTh2N1ypXTkWnzUo+yINlUuUqHoBzOBmgBYvtjvyZQRx1DhkEDxgEWP2vdFuE7lLT8
         s54oLEaDjtqnYXSlQDnBHYnhh/vpCQOpcKOoOglTEDb8DTJZ8IlLoCYRBNIawBJwOpWs
         STLA==
X-Gm-Message-State: AOJu0YzBlbSm3plRmgAkd9yHVnjssrESajm1y4DIpYQH1HyVUv4mMTqp
	GWtjcAaqBnCtNJrLXqghpQcLSj86IXKqBGsdcvUrhgxMmxsz3ncq7G4AXdNndQA=
X-Google-Smtp-Source: AGHT+IGCWG1O8BRpihQBw15/BgKHOsqmFF73Rpp9QyJqFTeb/8FHWSYi9Wdzhd12b/t8Iugtc44DKA==
X-Received: by 2002:a17:902:fe83:b0:1d9:8def:6942 with SMTP id x3-20020a170902fe8300b001d98def6942mr3376221plm.23.1707939538915;
        Wed, 14 Feb 2024 11:38:58 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d08200b001db53ccb856sm1761606plv.108.2024.02.14.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:38:58 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 5/5] doc: document use of l_log APIs
Date: Wed, 14 Feb 2024 11:37:43 -0800
Message-Id: <20240214193743.963349-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214193743.963349-1-prestwoj@gmail.com>
References: <20240214193743.963349-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of l_notice in IWD some guidelines need to be
set for l_info, l_warn, l_error, l_debug and l_notice.
---
 doc/coding-style.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index bf0535c5..fdd9e0e3 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -317,6 +317,30 @@ Functions that are static should not be forward-declared.  The only exception
 to this rule is if a circular dependency condition exists, and the forward
 declaration cannot be avoided.
 
+M18: Use appropriate logging levels
+===================================
+An appropriate log level should be used depending on the type of message
+being logged. Logging is done using the l_log APIs in ELL:
+
+l_info    Information that is expected during normal operation. l_info's use
+          should be very limited so non-debug logs are concise
+l_warn    An unexpected, but non-fatal condition ocurred
+l_error   An unexpected condition ocurred. These are generally fatal to the
+          current connection/protocol that is running but not generally to IWD's
+          overall operation.
+l_debug   General debugging. These can be used relatively freely but should
+          provide some piece of useful information.
+l_notice  Reserved for specific event-type notifications about IWD's internal
+          state. These are logs that are mean to be both human-readable and
+          parsed by tooling so they are required to be of a certain syntax. They
+          should start with "event: <name>" followed by comma separated key
+          value pairs containing the data of interest. Event names and their
+          arguments should be consistent across the code base, i.e. two events
+          called in different locations should have the same arguments.
+
+          For example:
+
+          l_notice("event: mycondition, arg1: value1, arg2: value2, ...");
 
 O1: Shorten the name
 ====================
-- 
2.34.1

